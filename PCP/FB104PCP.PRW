#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} fb104pcp
Consulta dados de produtos protheus
@type user function
@author Rogério Duarte
@since 29/10/2024
@version 1.0
/*/
User Function fb104pcp(cPesquisa,cCampos,nOpc)

	RpcSetType(3)
	RpcSetEnv("01","0101",,,"PCP")

	Local aArea     := GetArea()
	Local cQry      := ""
	LOCAL cAlias    := GetNextAlias()
	Local aAux := {}
	Local oResponse := JsonObject():New()
	Local oProduct  := JsonObject():New()
	Local aCampos   := StrTokArr( cCampos, "," )
	Local nX := 0
	Local nY := 0

	//cCampos:="B1_COD,B1_DESC,B1_TIPO,B1_UM,B1_LOCPAD,B1_GRUPO,B1_SEGUM,B1_CONV,B1_TIPCONV,B1_POSIPI,B1_ORIGEM"
	//aCampos:=StrTokArr( cCampos, "," )
	DBSelectArea("SB1")
	SB1->(DBSETORDER(1))
	For nX := 1 to len(aCampos)
		If !SB1->(FieldPos(aCampos[nX])) > 0
			oResponse[ aCampos[nX] ]  := EncodeUtf8("Campo "+aCampos[nX]+" não existe na SB1, verifique")
			RestArea(aArea)
			lSuccess := .F.
			Return oResponse
		ENDIF
	Next

	IF !"B1_COD" $ cCampos
		cCampos += ",B1_COD"
	ENDIF

	cQry += "SELECT "+cCampos+CRLF
	cQry += "FROM "+RETSQLTAB("SB1") + CRLF
	cqry += "WHERE" +RETSQLDEL("SB1")  + CRLF

	if nOpc == 1

		cQry += "AND B1_COD = '"+ALLTRIM(cPesquisa)+"' "+CRLF

	endif
	cQry += "ORDER BY B1_COD"

	MPSysOpenQuery(cQry,cAlias)

	if nOpc == 1 .AND. (cAlias)->(EOF())

		oProduct["FB104PCP"] := EncodeUtf8("Produto "+alltrim(cPesquisa)+ " não encontrado.")
		aadd(aAux,oProduct)
		lSuccess:= .F.
		oProduct:=JsonObject():New()

	Else
		//ABRO A AREA PARA VERIFICAR SE O CAMPO DIGITADO EXISTE NA SB1
		DBSelectArea("SB1")
		SB1->(DBSETORDER(1))

		If !(cAlias)->(EoF())
			While !(cAlias)->(EoF())

				For nX := 1 to len(aCampos)
					If SB1->(FieldPos(aCampos[nX])) > 0
						IF GETSX3CACHE(( aCampos[nX]),"X3_TIPO") == "M"
							SB1->(MSSEEK(FWXFILIAL("SB1")+(cAlias)->(B1_COD)))
							cMemo := SB1->&(aCampos[nX])
							nMemCount := MlCount(cMemo,140)
							cTxtMemo := ""

							For nY	:= 1 To nMemCount
								cTxtMemo += AllTrim( MemoLine(cMemo,140,nY) )
							Next nY

							oProduct[ aCampos[nX] ] := cTxtMemo
						ELSE
							oProduct[ aCampos[nX] ]  := (cAlias)->&(aCampos[nX])
						ENDIF

					ELSE
						oProduct[ aCampos[nX] ]  := EncodeUtf8("Campo "+aCampos[nX]+" não existe na SB1, verifique")
					ENDIF

				Next

				//oProduct["B1_COD"]      :=ALLTRIM((cAlias)->B1_COD)
				//oProduct["B1_DESC"]     :=ALLTRIM((cAlias)->B1_DESC)
				//oProduct["B1_TIPO"]     :=(cAlias)->B1_TIPO
				//oProduct["B1_UM"]       :=(cAlias)->B1_UM
				//oProduct["B1_LOCPAD"]   :=(cAlias)->B1_LOCPAD
				//oProduct["B1_GRUPO"]    :=(cAlias)->B1_GRUPO
				//oProduct["B1_SEGUM"]    :=(cAlias)->B1_SEGUM
				//oProduct["B1_CONV"]     :=(cAlias)->B1_CONV
				//oProduct["B1_TIPCONV"] :=(cAlias)->B1_POSIPI
				//oProduct["B1_ORIGEM"]   :=(cAlias)->B1_ORIGEM

				aadd(aAux,oProduct)
				oProduct:=JsonObject():New()

				(cAlias)->(DBSkip())
			end
		endif

	EndIf

	oResponse:=aAux
	RestArea(aArea)

Return oResponse
