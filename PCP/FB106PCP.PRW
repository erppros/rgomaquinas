#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"

/*/{Protheus.doc} FB106PCP
Grava Produto
@type function
@author Rogério Duarte  
@since 01/11/2024
@version 1.0
/*/
User Function FB106PCP(oJson)

	RpcSetType(3)
	RpcSetEnv("01","0101",,,"PCP")
	Local aArea := GetArea()
	lOCAL oResponse := JsonObject():New()

	Private lMsErroAuto := .F.
	//oJson:=JsonObject():New()
	//cJson:='[{"B1_COD": "7","B1_DESC": "TESTETOTVS DESCRICAO 2","B1_TIPO": "PA","B1_UM": "UN","B1_LOCPAD": "01","B1_GRUPO": "0002","B1_SEGUM": "  ","B1_CONV": 0,"B1_TIPCONV": "M","B1_POSIPI": "84385000  ","B1_ORIGEM": "0","B1_ZNARRAT": "TESTES DE TEXTO INCLUIDO\n\nTESTE ESPACO\n\n\nteste"}]'
	//cJson := '[{"G1_COD":"10063457","G1_COMP":"10063605","G1_QUANT":1},{"G1_COD":"10063605","G1_COMP":"456","G1_QUANT":0.1554},{"G1_COD":"10063457","G1_COMP":"10063477","G1_QUANT":10},{"G1_COD":"10063477","G1_COMP":"528","G1_QUANT":0.0248},{"G1_COD":"10063457","G1_COMP":"10063472","G1_QUANT":1},{"G1_COD":"10063472","G1_COMP":"456","G1_QUANT":0.0986},{"G1_COD":"10063457","G1_COMP":"10063471","G1_QUANT":1},{"G1_COD":"10063471","G1_COMP":"454","G1_QUANT":0.2586},{"G1_COD":"10063457","G1_COMP":"10063470","G1_QUANT":1},{"G1_COD":"10063470","G1_COMP":"454","G1_QUANT":0.2586},{"G1_COD":"10063457","G1_COMP":"10063467","G1_QUANT":2},{"G1_COD":"10063467","G1_COMP":"456","G1_QUANT":0.045},{"G1_COD":"10063457","G1_COMP":"10063466","G1_QUANT":1},{"G1_COD":"10063466","G1_COMP":"456","G1_QUANT":0.0986},{"G1_COD":"10063457","G1_COMP":"10063458","G1_QUANT":1},{"G1_COD":"10063458","G1_COMP":"454","G1_QUANT":4.8711},{"G1_COD":"10063457","G1_COMP":"10049505","G1_QUANT":1},{"G1_COD":"10049505","G1_COMP":"456","G1_QUANT":0.045},{"G1_COD":"10063457","G1_COMP":"10043100","G1_QUANT":1},{"G1_COD":"10043100","G1_COMP":"456","G1_QUANT":0.045},{"G1_COD":"10063457","G1_COMP":"10029256","G1_QUANT":2},{"G1_COD":"10029256","G1_COMP":"456","G1_QUANT":0.045},{"G1_COD":"10063457","G1_COMP":"10029246","G1_QUANT":1},{"G1_COD":"10029246","G1_COMP":"456","G1_QUANT":0.045},{"G1_COD":"10063457","G1_COMP":"10023443","G1_QUANT":2},{"G1_COD":"10023443","G1_COMP":"456","G1_QUANT":0.0609},{"G1_COD":"10063457","G1_COMP":"261212","G1_QUANT":4},{"G1_COD":"261212","G1_COMP":"454","G1_QUANT":0.0674},{"G1_COD":"10063457","G1_COMP":"486","G1_QUANT":50},{"G1_COD":"10063457","G1_COMP":"478","G1_QUANT":100}]'
	//cJson := '[{"G1_COD":"0000010","G1_COMP":"0000011","G1_QUANT":10.337},{"G1_COD":"0000010","G1_COMP":"0000012","G1_QUANT":1}]'
	//cError  := oJson:fromJson( cJson )
	DBSELECTAREA("SB1")
	SB1->(DBSETORDER(1))


	BEGIN TRANSACTION
		CONOUT("PRODUTO - "+ojson[1]["B1_COD"])
		IF SB1->(MSSEEK(FWXFILIAL("SB1")+PADR(alltrim(ojson[1]["B1_COD"]),TAMSX3("B1_COD")[1],"")))
			oResponse:=fExecAuto(oJson,4)
		Else
			oResponse:=fExecauto(oJson,3)
		EndIf

	END TRANSACTION


	SB1->(DBCLOSEAREA())

	RestArea(aArea)

Return oResponse


Static Function fExecAuto(oJson,nOpc)

	Local oResponse := JsonObject():New()
	
	Local aErro := {}
	Local cMessage := ""
	lOCAL oModel := nil
	Local nX := 0

	CONOUT("EXECAUTO - NOPC"+CVALTOCHAR(nOpc))

	oModel := FWLoadModel("MATA010")
	oModel:SetOperation(nOpc)
	oModel:Activate()
	//Pegando o model e setando os campos
	oSB1Mod := oModel:GetModel("SB1MASTER")
	if nOpc == 3
		CONOUT("B1_COD")
		oSB1Mod:SetValue("B1_COD"    , oJson[1]['B1_COD']      )
	EndIf

	aNames := oJson[1]:GetNames()
	For nX:=1 to len(aNames)
		IF aNames[nX] <> "B1_COD"
			oSB1Mod:SetValue(aNames[nX], oJson[1][aNames[nX]])	
		ENDIF

	Next nX
	//oSB1Mod:SetValue("B1_DESC"   , oJson[1]['B1_DESC']     	)
	//oSB1Mod:SetValue("B1_TIPO"   , oJson[1]['B1_TIPO']     	)
	//oSB1Mod:SetValue("B1_UM"     , oJson[1]['B1_UM']       	)
	//oSB1Mod:SetValue("B1_LOCPAD" , oJson[1]['B1_LOCPAD']    )
	//oSB1Mod:SetValue("B1_GRUPO"  , oJson[1]['B1_GRUPO']    	)
	//oSB1Mod:SetValue("B1_ORIGEM" , oJson[1]['B1_ORIGEM']    )
	//oSB1Mod:SetValue("B1_POSIPI" , oJson[1]['B1_POSIPI']    )
	//oSB1Mod:SetValue("B1_ZTIPDEN", oJson[1]['B1_ZTIPDEN']   )
	//oSB1Mod:SetValue("B1_ZDENS"  , oJson[1]['B1_ZDENS']    	)
	//oSB1Mod:SetValue("B1_ZNARRAT", oJson[1]['B1_ZNARRAT']   )
	

	//Setando o complemento do produto
	oSB5Mod := oModel:GetModel("SB5DETAIL")
	If oSB5Mod != Nil
		conout("FB106PCP - B5_CEME")
		oSB5Mod:SetValue("B5_CEME"   , oJson[1]['B1_DESC']     )
	EndIf

	//Se conseguir validar as informações
	If oModel:VldData()

		//Tenta realizar o Commit
		If oModel:CommitData()
			lOk := .T.

			//Se não deu certo, altera a variável para false
		Else
			lOk := .F.
		EndIf

	//Se não conseguir validar as informações, altera a variável para false
	Else
		lOk := .F.
	EndIf

	//Se não deu certo a inclusão, mostra a mensagem de erro
	If ! lOk
		//Busca o Erro do Modelo de Dados
		aErro := oModel:GetErrorMessage()

		//Monta o Texto que será mostrado na tela
		cMessage := "Id do formulário de origem:"  + ' [' + cValToChar(aErro[01]) + '], '
		cMessage += "Id do campo de origem: "      + ' [' + cValToChar(aErro[02]) + '], '
		cMessage += "Id do formulário de erro: "   + ' [' + cValToChar(aErro[03]) + '], '
		cMessage += "Id do campo de erro: "        + ' [' + cValToChar(aErro[04]) + '], '
		cMessage += "Id do erro: "                 + ' [' + cValToChar(aErro[05]) + '], '
		cMessage += "Mensagem do erro: "           + ' [' + cValToChar(aErro[06]) + '], '
		cMessage += "Mensagem da solução: "        + ' [' + cValToChar(aErro[07]) + '], '
		cMessage += "Valor atribuído: "            + ' [' + cValToChar(aErro[08]) + '], '
		cMessage += "Valor anterior: "             + ' [' + cValToChar(aErro[09]) + ']'

		//Mostra mensagem de erro
		lRet := .F.
		lSuccess := lRet
		oResponse:=EncodeUtf8('{"FB106PCP":"Erro ao incluir Produto"},{"EXECAUTO":"'+cMessage+'"}')
	Else
		lRet := .T.
		oResponse:=EncodeUtf8('{"FB106PCP":"Produto '+IIF(nOpc==3,'incluído','alterado')+' com sucesso"}')
	EndIf

	//Desativa o modelo de dados
	oModel:DeActivate()

Return oResponse


