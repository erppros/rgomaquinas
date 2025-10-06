#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOTVS.CH'


/*/{Protheus.doc} FB102PCP
Consulta dados de estrutura protheus
@type user function
@author Rogério Duarte
@since 23/10/2024
@version 1.0
/*/
User Function FB102PCP(cPesquisa,nOpc)

	//RpcSetType(3)
	//RpcSetEnv("01","0101",,,"PCP")

	Local aArea     := GetArea()

	Private aOriginalTree := {}
	Private oResponse := JsonObject():New()
	conout("FB102PCP - VARIAVEL - "+ValType( cPesquisa))
	Private &("o"+cPesquisa) := JsonObject():New()
	Private cCodAux   := ""
	Private aAuxPai := {}
	Private aAuxFilho := {}
	Private cPaiAux :=cPesquisa

	//nOpc := 1
	
	if nOpc == 1
		fRecursivo(cPesquisa,&("o"+cPesquisa))

	endif
	CONOUT("FB102PCP - JSON - ")
	
	oResponse := &("o"+cPesquisa)
	
	RestArea(aArea)
Return oResponse


Static Function fRecursivo(cCodPai,oObj)

	Local cQuery    := ""
	Local cAlias    := GetNextAlias()
	
	&("o"+cCodPai)  := oObj

	DBSELECTAREA("SB1")
	SB1->(DBSETORDER(1))

	If !Empty(cCodPai)
		CONOUT ("FB102PCP - CCODPAI - "+CCODPAI)
		cQuery:="SELECT * FROM  "+RETSQLTAB("SG1") +CRLF
		cQuery+="WHERE SG1.G1_COD = '"+cCodPai+"' "+CRLF
		cQuery+="AND "+Retsqldel("SG1")
		MPSysOpenQuery(cQuery,cAlias)

		
		If !(cAlias)->(EoF())
			While !(cAlias)->(EoF())
				&("o"+(cAlias)->G1_COMP) := JsonObject():New()
				AADD(aOriginalTree,{(cAlias)->G1_COD,(cAlias)->G1_COMP})
				CONOUT("FB102PCP - AADD - "+(cAlias)->G1_COD+"/"+(cAlias)->G1_COMP)
				if aScan(aOriginalTree,{|x| x[1]==(cAlias)->G1_COD})> 0 .AND. !EMPTY(cCodAux)
					cCodAux := (cAlias)->G1_COD
				endif
				if cCodAux <> alltrim((cAlias)->G1_COD)
					
					&("o"+cCodPai)["G1_COD"]	:=(cAlias)->G1_COD
					IF SB1->(MSSEEK(FWXFILIAL("SB1")+(cAlias)->G1_COD))
						&("o"+cCodPai)['B1_DESC']:=ALLTRIM(SB1->B1_DESC)
					EndIf
					&("o"+cCodPai)['G1_TRT']	:=(cAlias)->G1_TRT
					&("o"+cCodPai)['G1_QUANT']:=(cAlias)->G1_QUANT
					&("o"+cCodPai)['G1_INI']	:=(cAlias)->G1_INI
					&("o"+cCodPai)['G1_FIM']	:=(cAlias)->G1_FIM
					&("o"+cCodPai)['Componentes']:={}
					
					cCodAux := alltrim((cAlias)->G1_COD)
				else

					&("o"+(cAlias)->G1_COMP)['G1_COMP']:=(cAlias)->G1_COMP
					IF SB1->(MSSEEK(FWXFILIAL("SB1")+(cAlias)->G1_COMP))
						&("o"+(cAlias)->G1_COMP)['B1_DESC']:=ALLTRIM(SB1->B1_DESC)
					EndIf
					&("o"+(cAlias)->G1_COMP)['G1_TRT']	:=(cAlias)->G1_TRT
					&("o"+(cAlias)->G1_COMP)['G1_QUANT']:=(cAlias)->G1_QUANT
					&("o"+(cAlias)->G1_COMP)['G1_INI']	:=(cAlias)->G1_INI
					&("o"+(cAlias)->G1_COMP)['G1_FIM']	:=(cAlias)->G1_FIM
					&("o"+(cAlias)->G1_COMP)['Componentes']:= {}
					AADD( &("o"+cCodPai)['Componentes'], &("o"+(cAlias)->G1_COMP) )
					cCodAux := alltrim((cAlias)->G1_COMP)
				endif

				IF EMPTY(&("o"+(cAlias)->G1_COMP)['G1_COMP'])

					&("o"+(cAlias)->G1_COMP)['G1_COMP']:=(cAlias)->G1_COMP
					IF SB1->(MSSEEK(FWXFILIAL("SB1")+(cAlias)->G1_COMP))
						&("o"+(cAlias)->G1_COMP)['B1_DESC']:=ALLTRIM(SB1->B1_DESC)
					EndIf
					&("o"+(cAlias)->G1_COMP)['G1_TRT']	:=(cAlias)->G1_TRT
					&("o"+(cAlias)->G1_COMP)['G1_QUANT']  :=(cAlias)->G1_QUANT
					&("o"+(cAlias)->G1_COMP)['G1_INI']	:=(cAlias)->G1_INI
					&("o"+(cAlias)->G1_COMP)['G1_FIM']	:=(cAlias)->G1_FIM
					&("o"+(cAlias)->G1_COMP)['Componentes']:= {}
					cCodAux := alltrim((cAlias)->G1_COMP)

					AADD( &("o"+cCodPai)['Componentes'], &("o"+(cAlias)->G1_COMP) )
				endif
				fRecursivo((cAlias)->G1_COMP,&("o"+(cAlias)->G1_COMP))
				
				(cAlias)->(dbSkip())
			End
			(cAlias)->(dbCloseArea())
		Else
			
			cCodAux := cPaiAux
			(cAlias)->(dbCloseArea())
			Return
		EndIf
	Else
		Return
	EndIf
Return
