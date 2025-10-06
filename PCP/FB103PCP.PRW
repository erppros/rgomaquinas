#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} FB102PCP
Consulta dados de estrutura protheus
@type user function
@author Rogério Duarte
@since 23/10/2024
@version 1.0
/*/
User Function fb103pcp(cPesquisa,cCampos,nOpc,nTipo)

	// RpcSetType(3)
	//RpcSetEnv("01","0101",,,"PCP")
	Local aArea     := GetArea()
	Local aCampos   := StrTokArr( cCampos, "," )
	Local nX := 0

	Private aAux := {}
	Private oResponse := JsonObject():New()
	Private aOriginalTree := {}
	CONOUT("FB103PCP - "+CVALTOCHAR(nTipo))

	//nOpc := 1

	if nOpc == 1
		DBSelectArea("SG1")
		SG1->(DBSETORDER(1))

		For nX := 1 to len(aCampos)
			If !SG1->(FieldPos(aCampos[nX])) > 0
				oResponse[ aCampos[nX] ]  := EncodeUtf8("Campo "+aCampos[nX]+" não existe na SG1, verifique")
				RestArea(aArea)
				lSuccess:=.F.
				Return oResponse
			ENDIF
		Next
		if nTipo == 1
			CONOUT("FSIMPLES")
			fSimples(cPesquisa,cCampos)
		else
			CONOUT("FRECURSIVO")
			fRecursivo(cPesquisa,cCampos)
		endif
	endif

	oResponse := aAux
	RestArea(aArea)
Return oResponse


Static Function fRecursivo(cCodPai,cCampos)

	Local cQuery    := ""
	Local cAlias    := GetNextAlias()
	local oStructure := JsonObject():New()
	lOCAL nX:= 0
	Local aCampos   := StrTokArr( cCampos, "," )
	Local cRev:= (P200IniRev(cCodPai))

	If !Empty(cCodPai)

		cQuery:="SELECT "+cCampos+" FROM  "+RETSQLTAB("SG1") +CRLF
		cQuery+="WHERE SG1.G1_COD = '"+cCodPai+"' "+CRLF
		cQuery+="AND SG1.G1_REVFIM ='"+cRev+"' "+CRLF
		cQuery+="AND "+Retsqldel("SG1")
		MPSysOpenQuery(cQuery,cAlias)
		CONOUT(cQuery)


		If !(cAlias)->(EoF())
			While !(cAlias)->(EoF())
				AADD(aOriginalTree,{(cAlias)->G1_COD,(cAlias)->G1_COMP})
				For nX := 1 to len(aCampos)
					IF VALTYPE((cAlias)->&(aCampos[nX])) == "C"
						oStructure[ aCampos[nX] ]  := ALLTRIM((cAlias)->&(aCampos[nX]))
					ELSE
						oStructure[ aCampos[nX] ]  := (cAlias)->&(aCampos[nX])
					ENDIF
				Next
				//oStructure["G1_COD"] := ALLTRIM((cAlias)->G1_COD)
				//oStructure["G1_COMP"] := ALLTRIM((cAlias)->G1_COMP)
				//oStructure["G1_QUANT"] := (cAlias)->G1_QUANT

				aadd(aAux,oStructure)
				oStructure:=JsonObject():New()
				fRecursivo((cAlias)->G1_COMP,cCampos)

				(cAlias)->(dbSkip())
			End
			(cAlias)->(dbCloseArea())
		Else
			(cAlias)->(dbCloseArea())
			Return
		EndIf
	Else
		Return
	EndIf

Return

Static Function fSimples(cCodPai,cCampos)

	Local cQuery    := ""
	Local cAlias    := GetNextAlias()
	local oStructure := JsonObject():New()
	lOCAL nX:= 0
	Local aCampos   := StrTokArr( cCampos, "," )
	Local cRev:= (P200IniRev(cCodPai))

	If !Empty(cCodPai)

		cQuery:="SELECT "+cCampos+" FROM  "+RETSQLTAB("SG1") +CRLF
		cQuery+="WHERE SG1.G1_COD = '"+cCodPai+"' "+CRLF
		cQuery+="AND SG1.G1_REVFIM ='"+cRev+"' "+CRLF
		cQuery+="AND "+Retsqldel("SG1")
		MPSysOpenQuery(cQuery,cAlias)
		CONOUT(cQuery)

		If !(cAlias)->(EoF())
			While !(cAlias)->(EoF())

				For nX := 1 to len(aCampos)
					IF VALTYPE((cAlias)->&(aCampos[nX])) == "C"
						oStructure[ aCampos[nX] ]  := ALLTRIM((cAlias)->&(aCampos[nX]))
					ELSE
						oStructure[ aCampos[nX] ]  := (cAlias)->&(aCampos[nX])
					ENDIF
				Next
				
				aadd(aAux,oStructure)
				oStructure:=JsonObject():New()

				(cAlias)->(dbSkip())
			End
			(cAlias)->(dbCloseArea())
		Else
			(cAlias)->(dbCloseArea())
			Return
		EndIf
	Else
		Return
	EndIf

Return
