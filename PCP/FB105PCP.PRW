#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE 'FWMVCDef.ch'

/*/{Protheus.doc} FB105PCP
Grava Estrutura
@type function
@author Rogério Duarte  
@since 29/10/2024
@version 1.0
/*/
User Function FB105PCP(oJson)

	//RpcSetType(3)
	//RpcSetEnv("01","0101",,,"PCP")
	Local aArea := GetArea()
	lOCAL oResponse := JsonObject():New()
	Local nX   := 0
	lOCAL lRet  := .T.
	Local cCod  := ""

	Private lMsErroAuto := .F.
	//oJson:=JsonObject():New()
	//cJson := '[{"G1_COD":"10063457","G1_COMP":"10063605","G1_QUANT":1},{"G1_COD":"10063605","G1_COMP":"456","G1_QUANT":0.1554},{"G1_COD":"10063457","G1_COMP":"10063477","G1_QUANT":10},{"G1_COD":"10063477","G1_COMP":"528","G1_QUANT":0.0248},{"G1_COD":"10063457","G1_COMP":"10063472","G1_QUANT":1},{"G1_COD":"10063472","G1_COMP":"456","G1_QUANT":0.0986},{"G1_COD":"10063457","G1_COMP":"10063471","G1_QUANT":1},{"G1_COD":"10063471","G1_COMP":"454","G1_QUANT":0.2586},{"G1_COD":"10063457","G1_COMP":"10063470","G1_QUANT":1},{"G1_COD":"10063470","G1_COMP":"454","G1_QUANT":0.2586},{"G1_COD":"10063457","G1_COMP":"10063467","G1_QUANT":2},{"G1_COD":"10063467","G1_COMP":"456","G1_QUANT":0.045},{"G1_COD":"10063457","G1_COMP":"10063466","G1_QUANT":1},{"G1_COD":"10063466","G1_COMP":"456","G1_QUANT":0.0986},{"G1_COD":"10063457","G1_COMP":"10063458","G1_QUANT":1},{"G1_COD":"10063458","G1_COMP":"454","G1_QUANT":4.8711},{"G1_COD":"10063457","G1_COMP":"10049505","G1_QUANT":1},{"G1_COD":"10049505","G1_COMP":"456","G1_QUANT":0.045},{"G1_COD":"10063457","G1_COMP":"10043100","G1_QUANT":1},{"G1_COD":"10043100","G1_COMP":"456","G1_QUANT":0.045},{"G1_COD":"10063457","G1_COMP":"10029256","G1_QUANT":2},{"G1_COD":"10029256","G1_COMP":"456","G1_QUANT":0.045},{"G1_COD":"10063457","G1_COMP":"10029246","G1_QUANT":1},{"G1_COD":"10029246","G1_COMP":"456","G1_QUANT":0.045},{"G1_COD":"10063457","G1_COMP":"10023443","G1_QUANT":2},{"G1_COD":"10023443","G1_COMP":"456","G1_QUANT":0.0609},{"G1_COD":"10063457","G1_COMP":"261212","G1_QUANT":4},{"G1_COD":"261212","G1_COMP":"454","G1_QUANT":0.0674},{"G1_COD":"10063457","G1_COMP":"486","G1_QUANT":50},{"G1_COD":"10063457","G1_COMP":"478","G1_QUANT":100}]'
	//cJson := '[{"G1_COD":"0000010","G1_COMP":"0000012","G1_QUANT":10},{"G1_COD":"0000010","G1_COMP":"0000011","G1_QUANT":10},{"G1_COD":"0000010","G1_COMP":"0000017","G1_QUANT":10}]'
	//cJson := '[{"G1_COD":"0000010","G1_COMP":"0000012","G1_QUANT":1}]'
	//cJson := '[{"G1_COD":"0000010","G1_COMP":"0000012","G1_QUANT":8},{"G1_COD":"0000010","G1_COMP":"0000011","G1_QUANT":3}]'
	//cError  := oJson:fromJson( cJson )
	DBSELECTAREA("SB1")
	DBSELECTAREA("SG1")
	SB1->(DBSETORDER(1))
	SG1->(DBSETORDER(1))

	//Verifica se os produtos estão cadastrados
	For nX := 1 to len (oJson)
		if !SB1->(MSSEEK(FWXFILIAL("SB1")+ojson[nX]["G1_COD"]))
			lRet := .F.
			If nX == len (oJson)
				cCod += ALLTRIM(ojson[nX]["G1_COD"])
			else
				cCod += ALLTRIM(ojson[nX]["G1_COD"])+","
			endif
		endif

	Next

	If lRet

		BEGIN TRANSACTION
			IF SG1->(MSSEEK(FWXFILIAL("SG1")+PADR(ojson[1]["G1_COD"],TAMSX3("G1_COD")[1],"")))
				oResponse:=fExecAuto(oJson,4)
			Else
				oResponse:=fExecauto(oJson,3)
			EndIf

		END TRANSACTION

	else
		oResponse:=EncodeUtf8('{"FB105PCP":"Código de Produto não cadastrado no Protheus"},{"B1_COD":"'+cCod+'"}')
		lSuccess := .F.
	endif
	SB1->(DBCLOSEAREA())

	RestArea(aArea)

Return oResponse


Static Function fExecAuto(oJson,nOpc)

	Local oResponse := JsonObject():New()
	Local aCab  := {}
	Local aGets := {}
	Local cString := ""
	Local nX :=0
	Local cRev:= (P200IniRev(ojson[1]["G1_COD"]))

	Private  aItem := {}

	if nOpc == 3 //inclusão

		aCab := {{"G1_COD"   , ojson[1]["G1_COD"] , NIL},; //Código do produto PAI.
		{"G1_QUANT" ,  0 , NIL},; //Quantidade base do produto PAI.
		{"ATUREVSB1", "N"     , NIL},; //A variável ATUREVSB1 é utilizada para gerar nova revisão quando MV_REVAUT=.F.
		{"NIVALT"   , "S"     , NIL},; //A variável NIVALT é utilizada para recalcular ou não os níveis da estrutura.
		{"AUTREVPAI" , "001"   , NIL}}

	elseif nOpc == 4 //alteração
		SetMV("MV_REVAUT",.T.)

		aCab := {{"G1_COD"   , ojson[1]["G1_COD"] , NIL},; //Código do produto PAI.
		{"G1_QUANT" ,  0 			, NIL},; //Quantidade base do produto PAI.
		{"ATUREVSB1", "S"     		, NIL},; //A variável ATUREVSB1 é utilizada para gerar nova revisão quando MV_REVAUT=.F.
		{"AUTREVPAI", IIF(EMPTY(cRev),soma1(cRev),cRev) 	, NIL},; //A variável AUTREVPAI é utilizada para indicar qual a revisão do produto pai será considerada. Caso não seja enviado, será utilizada a revisão atual do produto.
		{"NIVALT"   , "S"     		, NIL}}  //A variável NIVALT é utilizada para recalcular ou não os níveis da estrutura.
	ENDIF

	for nX :=1 to len(oJson)
		aGets := {}


		aadd(aGets, {"G1_COD"  		, ojson[nX]["G1_COD"]    	, NIL})
		aadd(aGets, {"G1_COMP" 		, ojson[nX]["G1_COMP"]   	, NIL})
		aadd(aGets, {"G1_TRT"  		, Space(3)      			, NIL})
		aadd(aGets, {"G1_FANTASM"	, ojson[nX]["G1_FANTASM"] 	, NIL})
		aadd(aGets, {"G1_QUANT"		, ojson[nX]["G1_QUANT"]     , NIL})
		aadd(aGets, {"G1_INI"  		, DATE()					, NIL})
		aadd(aGets, {"G1_FIM"  		, CTOD("31/12/49")			, NIL})
		aadd(aGets, {"G1_PERDA"		, ojson[nX]["G1_PERDA"]     , NIL})
		aadd(aGets, {"G1_ZCOMPRI"	, ojson[nX]["G1_ZCOMPRI"]   , NIL})
		aadd(aGets, {"G1_ZLARGUR"	, ojson[nX]["G1_ZLARGUR"]   , NIL})

		//aadd(aGets, {"G1_REVINI"  ,cRev , NIL})
		//aadd(aGets, {"G1_REVFIM"  , cRev, NIL})

		//if SG1->(MSSEEK(FWXFILIAL("SG1")+;
			//		PADR(ojson[nX]["G1_COD"],TAMSX3("G1_COD")[1],"")+;
			//		PADR(ojson[nX]["G1_COMP"],TAMSX3("G1_COMP")[1],"")+cRev))
		//	aAdd(aGets, {"LINPOS"  ,"G1_COD+G1_COMP+G1_TRT", PADR(ojson[nX]["G1_COD"],TAMSX3("G1_COD")[1],"") ,PADR(ojson[nX]["G1_COMP"],TAMSX3("G1_COMP")[1],""),SG1->G1_TRT})
		//ENDIF


		aadd(aItem,aGets)

	Next

	//fDelEst(PADR(ojson[1]["G1_COD"],TAMSX3("G1_COD")[1],""),oJson,cRev)

	If nOpc == 3
		MSExecAuto({|x,y,z| PCPA200(x,y,z)},aCab,aItem,nOpc)



//Verifica se ocorreu algum erro, e exibe a mensagem.
		If lMsErroAuto

			If IsBlind()
				If IsTelnet()
					VTDispFile(NomeAutoLog(),.t.)
				Else

					cString := MemoRead(NomeAutoLog())
					CONOUT(cString)
					oResponse:=EncodeUtf8('{"FB105PCP":"Erro ao incluir Estrutura"},{"EXECAUTO":"'+cString+'"}')
					lSuccess:= .F.
					DisarmTransaction()
				EndIf
			Else
				MostraErro()
			EndIf
		Else
			//DBSelectArea("SB1")
			//
			//SB1->(DbSetOrder(1))
			//If SB1->(DbSeek(xFilial("SB1") + ojson[1]["G1_COD"]))
			//	oModel := FwLoadModel ("MATA010")
			//	oModel:SetOperation(MODEL_OPERATION_UPDATE)
			//	oModel:Activate()
			//	oModel:SetValue("SB1MASTER","B1_REVATU",cRev)
			//
			//	If oModel:VldData()
			//		oModel:CommitData()
			//	Else
			//		oResponse:=EncodeUtf8(oModel:GetErrorMessage())
			//		Return oResponse
			//	EndIf
			//
			//	oModel:DeActivate()
			IF nOpc == 4
				SetMV("MV_REVAUT",.F.)
			ENDIF
			//EndIf
			oResponse:=EncodeUtf8('{"FB105PCP":"Estrutura incluída com sucesso"}')
		EndIf

	elseif nOpc == 4

		cCodRev := (P200IniRev(ojson[1]["G1_COD"]))
		cCodRev := Soma1(cCodRev)

		For nX := 1 To len(oJson)

			SG1->(DbSelectArea('SG1'))
			SG1->(RecLock('SG1',.T.))
			SG1->G1_FILIAL := xFilial('SG1')
			SG1->G1_COD    := ojson[nX]["G1_COD"]
			SG1->G1_COMP   := ojson[nX]["G1_COMP"] 
			SG1->G1_FANTASM:= ojson[nX]["G1_FANTASM"]
			SG1->G1_QUANT  := ojson[nX]["G1_QUANT"] 
			SG1->G1_PERDA  := ojson[nX]["G1_PERDA"]
			SG1->G1_INI    := Date() 
			SG1->G1_FIM    := CtoD("31/12/49")
			//SG1->G1_FIXVAR := oJsonSg1['cabec'][1]['itens'][nRc]['fixoVariavel']
			SG1->G1_REVINI 	:= cCodRev
			SG1->G1_REVFIM 	:= cCodRev
			SG1->G1_NIV    	:= '01'
			SG1->G1_NIVINV 	:= '99' 
			SG1->G1_VLCOMPE := 'N'
			SG1->G1_USAALT  := '1'
			SG1->G1_ZCOMPRI := ojson[nX]["G1_ZCOMPRI"]
			SG1->G1_ZLARGUR := ojson[nX]["G1_ZLARGUR"]

			SG1->(MsUnLock())
			
		Next

		SG5->(DbSelectArea('SG5'))
		SG5->(RecLock('SG5',.T.))
		SG5->G5_FILIAL   := xFilial('SG5')
		SG5->G5_PRODUTO  := ojson[1]["G1_COD"]
		SG5->G5_REVISAO  := cCodRev 
		SG5->G5_DATAREV  := Date()
		SG5->G5_USER     := __cUserID 
		SG5->(MsUnLock())

		SB1->(DbSelectArea('SB1'))
		SB1->(DbSetOrder(1))
		If SB1->(DbSeek(xFilial('SB1') + ojson[1]["G1_COD"] ))
			SB1->(RecLock('SB1',.F.))
			SB1->B1_REVATU := cCodRev
			SB1->(MsUnLock())
		EndIf

		oResponse:=EncodeUtf8('{"FB105PCP":"Estrutura incluída com sucesso"}')
	endif


Return oResponse

Static Function fDelEst(cCod, ojson,cRev)

	Local nX := 0
	Local aJson := {}
	Local aGets := {}

	For nX:= 1 to Len(ojson)
		AADD(aJson,{ojson[nx,"G1_COMP"]})
	Next

	BEGINSQL Alias "SG1TMP"
		SELECT G1_COD,G1_COMP,G1_TRT, G1_QUANT, G1_INI, G1_FIM, G1_PERDA
		FROM %TABLE:SG1% SG1
		WHERE G1_COD = %EXP:cCod%
		AND G1_TRT = %EXP:cRev%
		AND SG1.%NOTDEL%
	ENDSQL


	while !SG1TMP->(EOF())

		if aScan(aJson,{|x| x[1] == alltrim(SG1TMP->(G1_COMP))}) == 0
			aGets := {}
			aadd(aGets, {"G1_COD"  ,SG1TMP->(G1_COD) 	,NIL})
			aadd(aGets, {"G1_COMP" ,SG1TMP->(G1_COMP)	,NIL})
			aadd(aGets, {"G1_TRT"  ,SG1TMP->(G1_TRT) 	,NIL})
			aadd(aGets, {"G1_QUANT",SG1TMP->(G1_QUANT)  ,NIL})
			aadd(aGets, {"G1_PERDA",SG1TMP->(G1_PERDA)  ,NIL})
			aadd(aGets, {"G1_INI"  ,SG1TMP->(G1_INI) 	,NIL})
			aadd(aGets, {"G1_FIM"  ,SG1TMP->(G1_FIM)  	,NIL})
			aAdd(aGets, {"LINPOS"  ,"G1_COD+G1_COMP+G1_TRT",SG1TMP->(G1_COD),SG1TMP->(G1_COMP),SG1TMP->(G1_TRT)})
			aAdd(aGets, {"AUTDELETA","S"             	,NIL})
			aadd(aItem,aGets)
		endif
		SG1TMP->(DBSKIP())
	END

	SG1TMP->(DBCloseArea())
Return



