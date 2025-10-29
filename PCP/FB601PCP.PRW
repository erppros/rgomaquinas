#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.ch"
#INCLUDE "RPTDEF.ch"
#INCLUDE "FWPRINTSETUP.ch"
#INCLUDE "COLORS.ch"

/*/{Protheus.doc} User Function FB601PCP
    Impressão OP
    @type  Function
    @author Roberta Neukamp Guerreiro
    @since 21/08/2023
    /*/
User Function FB601PCP()
	//RpcSetType(3)
	//RpcSetEnv("01","0101",,,"PCP")
	Private dDatade 	:= CTOD('')
	Private dDataate	:= CTOD('')
	Private cOPde 		:= SPACE(13)
	Private cOPate 		:= SPACE(13)
	Private cCombo1     := ""
	Private aItems      := {"SIM","NÃO"}
	Private nPage  		:= 0

	Private cAliasSC2 	:= GetNextAlias()
	//Private cPerg := PADR( ( "FB601PCP"  ), LEN( SX1->X1_GRUPO  ), ""  )

	//If fParam()
	///ValidPerg()



	If fParam()

		//cOPde 	:= 	MV_PAR01//"00000401001"//
		//cOPate 	:=	MV_PAR02//"00000401006"//
		//dDatade := 	MV_PAR03//CTOD("01/01/1999")//
		//dDataate:= 	MV_PAR04//CTOD("31/12/2099")//

		Processa({|| RunReport()})
	EndIf

Return




/*/{Protheus.doc} RunReport
    Instancia o arquivo de Relatório
    @type Function
    @author Roberta Neukamp Guerreiro
    @since 21/08/2023
/*/
Static Function RunReport()


	Local cName 			:= ""
	Local lAdjustToLegacy   := .F.
	Local lDisableSetup     := .T.
	Local cPathPDF			:= "C:\TEMP\"

	Private _oPrinter

	cName           		:= "FB601PCP_" + DToS(MsDate()) + StrTran(Time(),":", "_")

	_oPrinter:= FWMSPrinter():New(cName, IMP_PDF, lAdjustToLegacy, cPathPDF,lDisableSetup, , , , , , .F.,)
	_oPrinter:lServer:= .T.

	SearchOP()
	If !( (cAliasSC2)->(EOF()) )
		RunPrint()
	Else
		MsgInfo("Dados nao encontrados!", "Não foram encontrados dados para impressão!")
	Endif

Return




/*/{Protheus.doc} RunPrint
    Executa a impressão conforme parametros
    @type Function
    @author Roberta Neukamp Guerreiro
    @since 16/08/2023
/*/
Static Function RunPrint()
	Private _oFont06  := TFont():New( "Arial" /*cName*/, /*uPar2*/, 06 /*nHeight*/, /*uPar4*/, .F. /*lBold*/, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, /*lUnderline*/, .F. /*lItalic*/ )
	Private _oFont09B := TFont():New( "Arial" /*cName*/, /*uPar2*/, 09 /*nHeight*/, /*uPar4*/, .T. /*lBold*/, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, /*lUnderline*/, .F. /*lItalic*/ )
	Private _oFont09  := TFont():New( "Arial" /*cName*/, /*uPar2*/, 09 /*nHeight*/, /*uPar4*/, .F. /*lBold*/, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, /*lUnderline*/, .F. /*lItalic*/ )
	Private _oFont10B := TFont():New( "Arial" /*cName*/, /*uPar2*/, 10 /*nHeight*/, /*uPar4*/, .T. /*lBold*/, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, /*lUnderline*/, .F. /*lItalic*/ )
	Private _oFont10  := TFont():New( "Arial" /*cName*/, /*uPar2*/, 10 /*nHeight*/, /*uPar4*/, .F. /*lBold*/, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, /*lUnderline*/, .F. /*lItalic*/ )
	Private _oFont11B := TFont():New( "Arial" /*cName*/, /*uPar2*/, 11 /*nHeight*/, /*uPar4*/, .T. /*lBold*/, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, /*lUnderline*/, .F. /*lItalic*/ )
	Private _oFont11  := TFont():New( "Arial" /*cName*/, /*uPar2*/, 11 /*nHeight*/, /*uPar4*/, .F. /*lBold*/, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, /*lUnderline*/, .F. /*lItalic*/ )
	Private _oFont12B := TFont():New( "Arial" /*cName*/, /*uPar2*/, 12 /*nHeight*/, /*uPar4*/, .T. /*lBold*/, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, /*lUnderline*/, .F. /*lItalic*/ )
	Private _oFont12  := TFont():New( "Arial" /*cName*/, /*uPar2*/, 12 /*nHeight*/, /*uPar4*/, .F. /*lBold*/, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, /*lUnderline*/, .F. /*lItalic*/ )
	Private _oFont13B := TFont():New( "Arial" /*cName*/, /*uPar2*/, 13 /*nHeight*/, /*uPar4*/, .T. /*lBold*/, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, /*lUnderline*/, .F. /*lItalic*/ )
	Private _oFont13  := TFont():New( "Arial" /*cName*/, /*uPar2*/, 13 /*nHeight*/, /*uPar4*/, .F. /*lBold*/, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, /*lUnderline*/, .F. /*lItalic*/ )
	Private _oFont14B := TFont():New( "Arial" /*cName*/, /*uPar2*/, 14 /*nHeight*/, /*uPar4*/, .T. /*lBold*/, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, /*lUnderline*/, .F. /*lItalic*/ )
	Private _oFont14  := TFont():New( "Arial" /*cName*/, /*uPar2*/, 14 /*nHeight*/, /*uPar4*/, .F. /*lBold*/, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, /*lUnderline*/, .F. /*lItalic*/ )
	Private _oFont16B := TFont():New( "Arial" /*cName*/, /*uPar2*/, 16 /*nHeight*/, /*uPar4*/, .T. /*lBold*/, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, /*lUnderline*/, .F. /*lItalic*/ )
	Private _oFont16  := TFont():New( "Arial" /*cName*/, /*uPar2*/, 16 /*nHeight*/, /*uPar4*/, .F. /*lBold*/, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, /*lUnderline*/, .F. /*lItalic*/ )
	Private _oFont18B := TFont():New( "Arial" /*cName*/, /*uPar2*/, 18 /*nHeight*/, /*uPar4*/, .T. /*lBold*/, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, /*lUnderline*/, .F. /*lItalic*/ )
	Private _oFont18  := TFont():New( "Arial" /*cName*/, /*uPar2*/, 18 /*nHeight*/, /*uPar4*/, .F. /*lBold*/, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, /*lUnderline*/, .F. /*lItalic*/ )
	Private _oFont20B := TFont():New( "Arial" /*cName*/, /*uPar2*/, 20 /*nHeight*/, /*uPar4*/, .T. /*lBold*/, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, /*lUnderline*/, .F. /*lItalic*/ )
	Private _oFont20  := TFont():New( "Arial" /*cName*/, /*uPar2*/, 20 /*nHeight*/, /*uPar4*/, .F. /*lBold*/, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, /*lUnderline*/, .F. /*lItalic*/ )
	Private _oFont24B := TFont():New( "Arial" /*cName*/, /*uPar2*/, 24 /*nHeight*/, /*uPar4*/, .T. /*lBold*/, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, /*lUnderline*/, .F. /*lItalic*/ )
	Private _oFont24  := TFont():New( "Arial" /*cName*/, /*uPar2*/, 24 /*nHeight*/, /*uPar4*/, .F. /*lBold*/, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, /*lUnderline*/, .F. /*lItalic*/ )
	Private _oFont32B := TFont():New( "Arial" /*cName*/, /*uPar2*/, 32 /*nHeight*/, /*uPar4*/, .T. /*lBold*/, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, /*lUnderline*/, .F. /*lItalic*/ )

	Private _oBrush1 := TBrush():New( , RGB(255, 166, 154)) 	//VERMELHO
	Private _oBrush2 := TBrush():New( , RGB(145, 224, 138)) 	//VERDE
	Private _oBrush3 := TBrush():New( , CLR_YELLOW) 			//AMARELO
	Private _oBrush4 := TBrush():New( , RGB(213, 220, 240)) 	//AZUL
	Private _oBrush5 := TBrush():New( , RGB(255, 165, 0)) 		//LARANJA
	Private _oBrush6 := TBrush():New( , RGB(220, 220, 220)) 	//CINZA
	Private _oBrush7 := TBrush():New( , RGB(240, 255, 240)) 	//CIANO CLARO (LINHAS POR OPERAÇÃO)
	Private _nLine 	 := 1
	Private nTotPage := PageCount()

	Private _cPathImg := SUPERGETMV("TRS_PATHIM",, "/ordemdeproducao/")

	Private _cObsMemo := ""

	While !( (cAliasSC2)->(EOF()) )
		nPage += 1
		PrintHead()

		DetailsOP()

		ItensOP()

		RodapeOP()

		If File(_cPathImg + AllTrim((cAliasSC2)->(C2_PRODUTO)) + ".jpg", 0, .F.)
			ImpImgOp()
		Endif



		(cAliasSC2)->(DbSkip())

	End

	_oPrinter:Preview()
Return




/*/{Protheus.doc} PrintHead
    Imprime o cabeçalho
    @type Function
    @author Roberta Neukamp Guerreiro
    @since 21/08/2023
/*/
Static Function PrintHead()
	Local cLogo := "/logo/logorgo.png"//FisxLogo("1")//"/ordem_de_producao/logos/logozeyana.jpg"
	Local cCliLogo

	SA1->(DbSetOrder(1))
	SC5->(DBSETORDER(1))
	SB1->(DBSETORDER(1))
	SC5->(MSSEEK(FWXFILIAL("SC2")+(cAliasSC2)->(C2_PEDIDO)))
	SA1->(MsSeek(FwxFilial("SA1") +SC5->C5_CLIENTE + SC5->C5_LOJACLI))
	SB1->(MSSEEK(FWXFILIAL("SB1")+(cAliasSC2)->(C2_PRODUTO)))

	cCliLogo := cLogo


	_oPrinter:EndPage()
	_oPrinter:StartPage()


	_oPrinter:SayBitmap(015, 035, cCliLogo, 100, 50)

	_oPrinter:SayAlign(020, 020, "Ordem de produção: "+(cAliasSC2)->(C2_NUM + C2_ITEM + C2_SEQUEN), _oFont10B, 525 ,, , 2, 0)
	_oPrinter:SayAlign(020, 400, "Data da Impressão: "+DToC(date()), _oFont10, 145 ,, , 0, 0)
	_oPrinter:SayAlign(030, 400, "Hora da Impressão: " +SUBSTR(TIME(), 1, 5), _oFont10, 145 ,, , 0, 0)
	_oPrinter:SayAlign(040, 400, "Reimpressão: "+Alltrim(cCombo1), _oFont10, 145 ,, , 0, 0)

	_oPrinter:Code128(040, 220, (cAliasSC2)->(C2_NUM) + (cAliasSC2)->(C2_ITEM) + (cAliasSC2)->(C2_SEQUEN), 1, 25, .T., _oFont10B, /* 100 */ )

	_oPrinter:SayAlign(080, 020, "Produto: "+AllTrim((cAliasSC2)->(C2_PRODUTO)), _oFont10B, 525 ,, , 0, 0)
	_oPrinter:SayAlign(080, 400, "QUANT: ", _oFont10B, 145 ,, , 0, 0)
	_oPrinter:SayAlign(080, 370, CVALTOCHAR((cAliasSC2)->(C2_QUANT)), _oFont32B, 125 ,, , 1, 0)
	_oPrinter:SayAlign(095, 020, "Descrição: "+AllTrim(SB1->B1_DESC), _oFont10B, 525 ,, , 0, 0)
	_oPrinter:SayAlign(110, 020, "Pedido de Venda: "+AllTrim((cAliasSC2)->(C2_PEDIDO)+" - "+SA1->A1_NOME), _oFont10B, 525 ,, , 0, 0)
	_oPrinter:SayAlign(125, 020, /* "Observação da Ordem: "+ */AllTrim((cAliasSC2)->(C2_OBS)), _oFont14, 525 ,, , 0, 0)

Return




/*/{Protheus.doc} DetailsOP
	Impressão dos Detalhes da Ordem de Produção
	@type  Static Function
	@author Roberta Neukamp Guerreiro
	@since 22/08/2023
/*/
Static Function DetailsOP()

	SA1->(DbSetOrder(1))
	SB1->(DbSetOrder(1))
	SB5->(DbSetOrder(1))
	SC2->(DbSetOrder(1))
	SC5->(DBSETORDER(1))
	SC5->(MSSEEK(FWXFILIAL("SC2")+(cAliasSC2)->(C2_PEDIDO)))
	SA1->(MsSeek(FwxFilial("SA1") +SC5->C5_CLIENTE+SC5->C5_LOJACLI))
	SB1->(MsSeek(FwxFilial("SB1") +(cAliasSC2)->(C2_PRODUTO)))
	SB5->(MsSeek(FwxFilial("SB5") +(cAliasSC2)->(C2_PRODUTO)))
	SC2->(MsSeek(FwxFilial("SC2") +(cAliasSC2)->(C2_NUM + C2_ITEM + C2_SEQUEN)))
	_nLine := 150


	_oPrinter:SayAlign(_nLine, 020, /* "Código Pai: " */'Produto Final: ' +fProdPai((cAliasSC2)->(C2_NUM),(cAliasSC2)->(C2_ITEM)), _oFont10, 525 ,, , 0, 0)

	_nLine += 15
	_oPrinter:Line(_nLine, 020, _nLine, 545)
	_nLine += 5


Return




/*/{Protheus.doc} ItensOP
	Impressão de Roteiros e Lista de Materiais
	@type  Static Function
	@author Roberta Neukamp
	@since 22/08/2023
/*/
Static Function ItensOP()
	Local nTop 		:= 0
	Local nBottom 	:= 0
	Local nX 		:= 0
	Local aConsIn	:= {}
	//Local cObsG2    := ""

	//for nx :=1 to 10

	SG2->(DbSetOrder(1))
	SH1->(DbSetOrder(1))
	SB1->(DBSETORDER(1))
	SG2->(MsSeek(FwxFilial("SG2") + (cAliasSC2)->(C2_PRODUTO) + (cAliasSC2)->(C2_ROTEIRO)))


	ConsumoInverso(aConsIn)

	if !QRYIN->(EoF())
		_oPrinter:SayAlign(_nLine, 020 , "Estrutura Inversa: " , _oFont10B, 525, , , 0, 0)
		_nLine += 15

		_oPrinter:SayAlign(_nLine, 020 , 'Nível' 			, _oFont10B, 50, , , 0, 0)
		_oPrinter:SayAlign(_nLine, 050 , 'Componente' 			, _oFont10B, 230, , , 0, 0)
		_oPrinter:SayAlign(_nLine, 120 , 'Desc. Componente' 	, _oFont10B, 230, , , 0, 0)
		_oPrinter:SayAlign(_nLine, 270 , 'Onde é Usado' 			, _oFont10B, 230, , , 0, 0)
		_oPrinter:SayAlign(_nLine, 340 , 'Desc. Onde é Usado' 			, _oFont10B, 120, , , 0, 0)

		_nLine += 15

	endif

	While !QRYIN->(EOF())
		If _nLine >= 750
			RodapeOP()
			_oPrinter:EndPage()
			_oPrinter:StartPage()
			nPage += 1
			_nLine := 050
		EndIf
		nTop += 10
		nBottom := nTop + 30

		aDescCOMP := _MSG(AllTrim(Posicione('SB1', 1, xFilial('SB1') + QRYIN->COD_COMP, 'B1_DESC')), 30)
		aDescPAI :=  _MSG(AllTrim(Posicione('SB1', 1, xFilial('SB1') + QRYIN->COD_PAI_NIVEL, 'B1_DESC')), 30)

		_oPrinter:SayAlign(_nLine, 020 , AllTrim(Str(QRYIN->NIVEL)) 			, _oFont10, 50, , , 0, 0)
		_oPrinter:SayAlign(_nLine, 050 , QRYIN->COD_COMP 						, _oFont10, 230, , , 0, 0)
		_oPrinter:SayAlign(_nLine, 120 , aDescCOMP[1]		 					, _oFont10, 230, , , 0, 0)
		_oPrinter:SayAlign(_nLine, 270 , QRYIN->COD_PAI_NIVEL 					, _oFont10, 230, , , 0, 0)
		_oPrinter:SayAlign(_nLine, 340 , aDescPAI[1]					 		, _oFont10, 230, , , 0, 0)

		for nX := 2 to iIf(Len(aDescCOMP) > Len(aDescPAI), Len(aDESCCOMP), Len(aDescPAI))
			_nLine += 10
			if Len(aDescCOMP) >= nX
				_oPrinter:SayAlign(_nLine, 120 , aDescCOMP[nX]		 					, _oFont10, 230, , , 0, 0)
			endif
			if Len(aDescPAI) >= nX
				_oPrinter:SayAlign(_nLine, 340 , aDescPAI[nX]					 		, _oFont10, 230, , , 0, 0)
			endif		

		next

		_nLine += 15

		QRYIN->(DBSKIP())
	END

	QRYIN->(DbCloseArea())

	_nLine += 15
	_oPrinter:Line(_nLine, 020, _nLine, 545)

	While !SG2->(EOF()) .AND. (cAliasSC2)->(C2_PRODUTO) == SG2->G2_PRODUTO .AND. (cAliasSC2)->(C2_ROTEIRO) == SG2->G2_CODIGO
		If _nLine >= 750
			RodapeOP()
			_oPrinter:EndPage()
			_oPrinter:StartPage()
			nPage += 1
			_nLine := 050
		EndIf

		_oPrinter:SayAlign(_nLine, 020 , "Operação: "+alltrim(SG2->G2_OPERAC) , _oFont10B, 525, , , 0, 0)

		_nLine+=10

		SH1->(MsSeek(FwxFilial("SH1") + SG2->G2_RECURSO))

		_oPrinter:SayAlign(_nLine, 020 , AllTrim(SG2->G2_RECURSO)+ " - "+ALLTRIM(SH1->H1_DESCRI) , _oFont14B, 525, , , 0, 0)
		_oPrinter:SayAlign(_nLine, 280 , "Tempo Total: "+Transform(SG2->G2_TEMPAD*(cAliasSC2)->(C2_QUANT) ,"@E 99,999.9999")  , _oFont10B, 100, , , 0, 0)
		_oPrinter:Code128(_nLine, 420, AllTrim(SG2->G2_RECURSO), 1, 22, .T., _oFont09, /* 100 */ )

		_nLine +=15

		_oPrinter:SayAlign(_nLine, 280 , "Tempo Cronometrado: "+IIF(SG2->G2_ZTCRO=='S',"SIM","NÃO") , _oFont10B, 150, , , 0, 0)

		if !empty(SG2->G2_ZOBSE)
			aObs := _MSG(alltrim(SG2->G2_ZOBSE),40)
			For nX :=1 to Len(aObs)
				If nX == 1
					_oPrinter:SayAlign(_nLine, 020 , "Observação: "+ aObs[nX] , _oFont10, 525, , , 0, 0)
				else
					_oPrinter:SayAlign(_nLine, 020 ,  aObs[nX] , _oFont10, 525, , , 0, 0)
				endif

				if nX <> Len(aObs)
					_nLine += 15
				endif
			Next
		ENDIF

		_nLine += 20


		_oPrinter:Line(_nLine, 020, _nLine, 545)


		_nLine += 15
		// _nLine += 5

		SG2->(DBSkip())
	End
	//Next

	_nLine += 15

	SD4->(DbSetOrder(2))
	If SD4->(MsSeek(FwxFilial("SD4") + (cAliasSC2)->(C2_NUM + C2_ITEM + C2_SEQUEN)))


		nTop += 10
		nBottom := nTop + 30

		_oPrinter:SayAlign(_nLine, 020 , "Consumos: " , _oFont10B, 525, , , 0, 0)
		_nLine += 15
		_oPrinter:SayAlign(_nLine, 020 , "Código " , _oFont10B, 50, , , 0, 0)
		_oPrinter:SayAlign(_nLine, 070 , "Descrição " , _oFont10B, 420, , , 0, 0)
		_oPrinter:SayAlign(_nLine, 300 , "Endereço OP: " , _oFont10B, 120, , , 0, 0)
		_oPrinter:SayAlign(_nLine, 420 , "Un " , _oFont10B, 50, , , 0, 0)
		_oPrinter:SayAlign(_nLine, 470 , "Quantidade " , _oFont10B, 100, , , 0, 0)
		_nLine += 15

		While !SD4->(EOF()) .AND. AllTrim(SD4->D4_OP) == (cAliasSC2)->(C2_NUM + C2_ITEM + C2_SEQUEN)

			If _nLine >= 750
				RodapeOP()
				_oPrinter:EndPage()
				_oPrinter:StartPage()
				nPage += 1
				_nLine := 050
			EndIf

			_oPrinter:SayAlign(_nLine, 020 , SD4->D4_COD , _oFont10, 50, , , 0, 0)
			SB1->(MsSeek(FwxFilial("SB1") + SD4->D4_COD))
			_oPrinter:SayAlign(_nLine, 070 , ALLTRIM(SB1->B1_DESC), _oFont10, 230, , , 0, 0)
			_oPrinter:SayAlign(_nLine, 300 , ALLTRIM(SB1->B1_ZENDOP) , _oFont10, 120, , , 0, 0)
			_oPrinter:SayAlign(_nLine, 420 , SB1->B1_UM , _oFont10, 50, , , 0, 0)
			// SG1->(MsSeek(FwxFilial("SG1") + SG1->G1_COMP))
			_oPrinter:SayAlign(_nLine, 470 , Transform(SD4->D4_QUANT*(cAliasSC2)->(C2_QUANT) ,"@E 99,999.9999") , _oFont10, 100, , , 0, 0)
			_nLine += 15

			aAdd(aConsIn, SD4->D4_COD)

			SD4->(DBSKIP())
		END

	ENDIF

	_nLine += 15
	_oPrinter:Line(_nLine, 020, _nLine, 545)

	_nLine += 5
	// Endif

Return





/*/{Protheus.doc} RodapeOP
	Impressão do rodapé da OP
	@type  Static Function
	@author Roberta Neukamp Guerreiro
	@since 25/08/2023
/*/
Static Function RodapeOP()
	Local cUsuario 	:= UsrFullName(RetCodUsr())
	// Local dData 	:= DTOC(DATE())
	// Local nTime 	:= SUBSTR(TIME(), 1, 5)



	//BOX DO RODAPÉ E IMPRESSÃO DE NÚMERO DE PÁGINAS
	//_oPrinter:Box(790, 010, 830, 585, "-4")
	_oPrinter:Line(800, 020, 800, 250)
	_oPrinter:SayAlign(795, 260 , "Página " + cValToChar(nPage) + " de " + cValToChar(nTotPage), _oFont09, 070, 014, , 0, 2)
	_oPrinter:Line(800, 310, 800, 545)

	_oPrinter:SayAlign(815, 020 , "Emitido por: " + cUsuario/*  + " em " + dData + " " + nTime */, _oFont09B, 220, 014, , 0, 2)

	_oPrinter:SayAlign(815, 020 , "Documento das Ordens de Produção", _oFont09B, 525, 014, , 2, 0)

	_oPrinter:SayAlign(815, 020, "FB601PCP", _oFont09B, 525, 014, , 1, 2)

Return





/*/{Protheus.doc} SearchOP
    Executa a consulta conforme parametros definidos pelo usuário
    @type  Static Function
    @author Roberta Neukamp Guerreiro
    @since 21/08/2023
/*/
Static Function SearchOP()

	BeginSql Alias cAliasSC2

    SELECT SC2.C2_NUM, SC2.C2_ITEM, SC2.C2_SEQUEN, SC2.C2_EMISSAO, SC2.C2_ROTEIRO, 
        SC2.C2_PEDIDO, SC2.C2_PRODUTO, SC2.C2_QUANT, SC2.C2_DATPRI, SC2.C2_DATPRF, SC2.C2_PEDIDO, SC2.C2_OBS
    FROM %table:SC2% SC2

    WHERE SC2.C2_FILIAL = %xFilial:SC2% AND
	  SC2.C2_NUM || SC2.C2_ITEM || SC2.C2_SEQUEN >= %Exp:cOPde% AND
	  SC2.C2_NUM || SC2.C2_ITEM || SC2.C2_SEQUEN <= %Exp:cOPate% AND
      SC2.C2_EMISSAO BETWEEN %Exp:DTOS(dDatade)% AND %Exp:DTOS(dDataate)% AND
	  SC2.%NotDel%

	EndSql

Return





/*/{Protheus.doc} fParam
    Tela de parâmetros para impressão
    @type  Static Function
    @author Roberta Neukamp Guerreiro
    @since 21/08/2023
/*/
Static Function fParam()
	Local lRet

	oParamTl    := FWDialogModal():New()
	oParamTl:SetEscClose(.F.)
	oParamTl:setTitle("Informar Dados.")
	//SETA A LARGURA E ALTURA DA JANELA EM PIXELS
	oParamTl:setSize(140, 190)
	oParamTl:createDialog()

	//IDENTIFICA SE A IMPRESSÃO É ATRAVÉS DA TELA DE ORDENS DE PRODUÇÃO
	If FwIsInCallStack("MATA650")
		cOPde 		:= SC2->C2_NUM+C2_ITEM+C2_SEQUEN
		cOPate 		:= SC2->C2_NUM+C2_ITEM+C2_SEQUEN
		dDatade 	:= SC2->C2_EMISSAO
		dDataate 	:= SC2->C2_EMISSAO
	EndIf

	TSay():New(010,010,{|| "Da O.P.?"} ,oParamTl:getPanelMain(),,,,,,.T.,,,060,014,,,,,,.T.)
	oGetOpDe    := TGet():New(007,075,bSETGET(cOPde),oParamTl:getPanelMain(),080,010,X3Picture("D4_OP"),{||},0,,,,,.T.,/*15*/,,{||},,,,.F.,.F.,,"dDatade",,,, )
	oGetOpDe:cF3:= 'SC2'
	TSay():New(025,010,{|| "Ate O.P.?"} ,oParamTl:getPanelMain(),,,,,,.T.,,,060,014,,,,,,.T.)
	oGetOpAte    := TGet():New(022,075,bSETGET(cOPate),oParamTl:getPanelMain(),080,010,X3Picture("D4_OP"),{||},0,,,,,.T.,/*15*/,,{||},,,,.F.,.F.,,"dDatade",,,, )
	oGetOpAte:cF3:= 'SC2'
	TSay():New(040,010,{|| "Data de:"} ,oParamTl:getPanelMain(),,,,,,.T.,,,060,014,,,,,,.T.)
	oGetDtDe    := TGet():New(037,075,bSETGET(dDatade),oParamTl:getPanelMain(),080,010,X3Picture("C2_EMISSAO"),{||},0,,,,,.T.,/*15*/,,{||},,,,.F.,.F.,,"dDatade",,,, )
	TSay():New(055,010,{|| "Data ate:"} ,oParamTl:getPanelMain(),,,,,,.T.,,,060,014,,,,,,.T.)
	oGetDtAte   := TGet():New(052,075,bSETGET(dDataate),oParamTl:getPanelMain(),080,010,X3Picture("C2_EMISSAO"),{||},0,,,,,.T.,/*15*/,,{||},,,,.F.,.F.,,"dDataate",,,, )

	TSay():New(070,010,{|| "Reimpressao"} ,oParamTl:getPanelMain(),,,,,,.T.,,,060,014,,,,,,.T.)
	cCombo1:= aItems[2]
	oCombo1 := TComboBox():New(067,075,{|u|if(PCount()>0,cCombo1:=u,cCombo1)},aItems,100,10,oParamTl:getPanelMain(),,,,,,.T.,,,,,,,,,'cCombo1')
	oParamTl:addButton("Confirmar",{|| lRet := .T., oParamTl:OOWNER:END()},"Confirmar")
	oParamTl:addButton("Cancelar" ,{|| lRet := .F.,oParamTl:OOWNER:END()},"Cancelar")
	oParamTl:Activate()

Return lRet





/*/{Protheus.doc} DataPrev
	Cálculo para data prevista por operação
	@type  Static Function
	@author Roberta Neukamp Guerreiro
	@since 04/09/2023
/*/
Static Function DataPrev()
	Local dDatPri 	:= STOD((cAliasSC2)->(C2_DATPRI))
	Local dDatPrf 	:= STOD((cAliasSC2)->(C2_DATPRF))
	Local nTotDia 	:= DateDiffDay(dDatPri,dDatPrf)
	Local nTotTemp 	:= 0
	Local nTempo
	Local nPctgTemp
	Local nQtdDia
	Local dDia 		:= dDatPri
	Local aDias 	:= {}

	SG2->(DbSetOrder(1))

	If SG2->(MsSeek(FwxFilial("SG2") +(cAliasSC2)->(C2_PRODUTO) + (cAliasSC2)->(C2_ROTEIRO)))

		nTempo := SG2->G2_TEMPAD

		While !SG2->(EOF()) .AND. (cAliasSC2)->(C2_PRODUTO) == SG2->G2_PRODUTO .AND. (cAliasSC2)->(C2_ROTEIRO) == SG2->G2_CODIGO
			nTotTemp += SG2->G2_TEMPAD
			SG2->(DBSKIP())
		End
		SG2->(DBGOTOP())
		SG2->(MsSeek(FwxFilial("SG2") +(cAliasSC2)->(C2_PRODUTO) + (cAliasSC2)->(C2_ROTEIRO)))
		nQtdDia := 0
		While !SG2->(EOF()) .AND. (cAliasSC2)->(C2_PRODUTO) == SG2->G2_PRODUTO .AND. (cAliasSC2)->(C2_ROTEIRO) == SG2->G2_CODIGO
			nTempo := SG2->G2_TEMPAD
			nPctgTemp := nTempo/nTotTemp
			nQtdDia += nPctgTemp*nTotDia
			If nQtdDia <= 0.7
				AAdd(aDias, {dDia, SG2->G2_OPERAC, SG2->G2_RECURSO})
			ElseIf nQtdDia > 0.7
				AAdd(aDias, {dDia, SG2->G2_OPERAC, SG2->G2_RECURSO})
				dDia += 1
				If dDia > dDatPrf
					dDia -= 1
				EndIf
				nQtdDia := 0
			EndIf
			SG2->(DBSKIP())
		End
	EndIf
Return aDias




Static Function _MSG(_cObs, _nTam)
	Local _aMsg := {}
	Local _i    := 0

	_cObs := StrTran(_cObs, " ", ";")
	Do While At(";;", _cObs) != 0
		_cObs := StrTran(_cObs, ";;", ";")
	EndDo

	_aObs := {}
	Do While Len(_cObs) > 0
		If At(";", _cObs) != 0
			AADD(_aObs, SubStr(_cObs, 1, At(";", _cObs) -1))
			_cObs := Stuff(_cObs, 1, At(";", _cObs), "")
		Else
			AADD(_aObs, AllTrim(_cObs))
			_cObs := ""
		EndIf
	EndDo

	_cObs := ""
	For _i := 1 To Len(_aObs)
		If Len(_cObs + cValToChar(_aObs[_i])) > _nTam
			AADD(_aMsg, Padr(_cObs,_nTam))
			_cObs := _aObs[_i] + " "
		Else
			_cObs := _cObs + _aObs[_i] + " "
		EndIf
	Next _i

	If AllTrim(_cObs) != ""
		AADD(_aMsg, Padr(_cObs,_nTam))
	EndIf

Return _aMsg




Static Function PageCount()

	Local nX
	Local aConsIn	:= {}

	Local nTotPage := 0

	While !( (cAliasSC2)->(EOF()) )

		nTotPage += 1

		_nLine := 150

		//for nx :=1 to 10
		SG2->(DbSetOrder(1))
		SH1->(DbSetOrder(1))
		SB1->(DBSETORDER(1))
		SG2->(MsSeek(FwxFilial("SG2") + (cAliasSC2)->(C2_PRODUTO) + (cAliasSC2)->(C2_ROTEIRO)))

		ConsumoInverso(aConsIn)

		if !QRYIN->(EoF())

			_nLine += 15

			_nLine += 15

		endif

		While !QRYIN->(EOF())
			If _nLine >= 750

				nTotPage += 1
				_nLine := 050
			EndIf

			aDescCOMP := _MSG(AllTrim(Posicione('SB1', 1, xFilial('SB1') + QRYIN->COD_COMP, 'B1_DESC')), 40)
			aDescPAI :=  _MSG(AllTrim(Posicione('SB1', 1, xFilial('SB1') + QRYIN->COD_PAI_NIVEL, 'B1_DESC')), 40)

			for nX := 2 to iIf(Len(aDescCOMP) > Len(aDescPAI), Len(aDESCCOMP), Len(aDescPAI))
				_nLine += 10

			next

			_nLine += 15

			QRYIN->(DBSKIP())
		END

		QRYIN->(DbCloseArea())

		_nLine += 15


		While !SG2->(EOF()) .AND. (cAliasSC2)->(C2_PRODUTO) == SG2->G2_PRODUTO .AND. (cAliasSC2)->(C2_ROTEIRO) == SG2->G2_CODIGO
			If _nLine >= 750

				nTotPage += 1
				_nLine := 050
			EndIf

			_nLine+=10

			SH1->(MsSeek(FwxFilial("SH1") + SG2->G2_RECURSO))

			_nLine +=15

			if !empty(SG2->G2_ZOBSE)
				aObs := _MSG(alltrim(SG2->G2_ZOBSE),40)
				For nX :=1 to Len(aObs)

					if nX <> Len(aObs)
						_nLine += 15
					endif

				Next

			ENDIF

			_nLine += 20

			_nLine += 15

			SG2->(DBSkip())

			_nLine += 5

			//IMPRESSÃO COMPONENTE X OPERAÇÃO
			SGF->(DbSetOrder(1))
			If SGF->(MsSeek(FwxFilial("SGF") + SG2->G2_PRODUTO + SG2->G2_CODIGO + SG2->G2_OPERAC))
				If _nLine >= 750
					nTotPage += 1
					_nLine := 050
				EndIf

				_nLine += 15
				_nLine += 15

				While !SGF->(EOF()) .AND. SG2->G2_PRODUTO == SGF->GF_PRODUTO .AND. SG2->G2_CODIGO == SGF->GF_ROTEIRO .AND. SG2->G2_OPERAC == SGF->GF_OPERAC

					_nLine += 15

					SGF->(DBSKIP())
				END

				_nLine += 15
				_nLine += 5


			Endif


			SG2->(DBSkip())

		End
		//Next

		_nLine += 15

		SD4->(DbSetOrder(2))
		If SD4->(MsSeek(FwxFilial("SD4") + (cAliasSC2)->(C2_NUM + C2_ITEM + C2_SEQUEN)))

			If _nLine >= 750
				nTotPage += 1
				_nLine := 050
			EndIf

			_nLine += 15
			_nLine += 15

			While !SD4->(EOF()) .AND. AllTrim(SD4->D4_OP) == (cAliasSC2)->(C2_NUM + C2_ITEM + C2_SEQUEN)

				_nLine += 15
				aAdd(aConsIn, SD4->D4_COD)

				SD4->(DBSKIP())
			END

		ENDIF

		_nLine += 15

		_nLine += 5

		// Endif

		(cAliasSC2)->(DbSkip())

	end

	(cAliasSC2)->(DbGoTop())
Return nTotPage




Static Function ImpImgOp()

	_oPrinter:EndPage()
	_oPrinter:StartPage()
	_oPrinter:SayBitmap(0, 0, _cPathImg + AllTrim((cAliasSC2)->(C2_PRODUTO)) + ".jpg", 595, 842 )

Return

Static Function ValidPerg()
	Local _aRegs  := {}
	Local _aHelps := {}
	Local _i      := 0
	Local _j      := 0
	_aRegs := {}

//                 GRUPO  ORDEM PERGUNT           	PERSPA 				PERENG 				VARIAVL  TIPO 	TAM 				  DEC PRESEL 	GSC  VALID           VAR01       DEF01         DEFSPA1 DEFENG1 CNT01 VAR02 DEF02        DEFSPA2 DEFENG2 CNT02 VAR03 DEF03    DEFSPA3 DEFENG3 CNT03 VAR04 DEF04 DEFSPA4 DEFENG4 CNT04 VAR05 DEF05 DEFSPA5 DEFENG5 CNT05 F3     GRPSXG
	AADD (_aRegs, {cPerg, "01", "Da O.P.?      ", "                    	", "                ",  "mv_ch1", "C", 06,  			0,  0,		"G", "", 			"mv_par01", "",				"",     		"",		"",		"",				"",				"",     		"",	     "",	"",   			"",      		"",     		"", 	"",		"",   		"",				"",				"",		"",		"",			"",   		"",     		 "",	"","SA3"   , ""})
	AADD (_aRegs, {cPerg, "02", "Ate a O.P.?   ", "        				", "          		",  "mv_ch2", "C", 06, 				0,  0, 		"G", "", 			"mv_par02", "",				"",     		"",		"",		"",				"",				"",     		"",	     "",	"",   			"",      		"",     		"", 	"",		"",   		"",				"",				"",		"",		"",			"",  		"",    			 "",	"","SA3"   , ""})
	AADD (_aRegs, {cPerg, "03", "Da Data?      ", "     			    ", "    			",  "mv_ch3", "D", 08,				0,  0,		"G", "", 			"mv_par03", "",				"",     		"",		"",		"",				"",				"",     		"",	     "",	"",   			"",      		"",     		"",		"",		"",   		"",				"",				"",		"",		"",			"",  		"",     		 "",	"",""  	   , ""})
	AADD (_aRegs, {cPerg, "04", "Ate a Data ?  ", "     			    ", "       			",  "mv_ch4", "D", 08, 				0,  0,		"G", "", 			"mv_par04",	"",				"",     		"",		"",		"",				"",				"",     		"",	     "",	"",   			"",     		"",     		"", 	"",		"",   		"",				"",				"",		"",		"",			"",  		"",    			 "",	"",""  	   , ""})
	AADD (_aRegs, {cPerg, "05", "Reimpressão ? ", "						", "				",  "mv_ch5", "C", 01, 				0,  0,		"C", "", 			"mv_par05", "",				"SIM",        	"",		"",		"NÃO", 			"",				"",     		"",	     "",	"",   			"",             "",				"",		"",		"",   		"",				"",             "",		"",		"",			"",			"",              "",	"","SUA"   , ""})


// Definicao de textos de help (versao 7.10 em diante): uma array para cada linha.
	_aHelps = {}

	DbSelectArea ("SX1")
	DbSetOrder (1)
	For _i := 1 to Len (_aRegs)
		If ! DbSeek (cPerg + _aRegs [_i, 2])
			RecLock("SX1", .T.)
		Else
			RecLock("SX1", .F.)
		Endif
		For _j := 1 to FCount ()
// Campos CNT nao sao gravados para preservar conteudo anterior.
			If _j <= Len (_aRegs [_i]) .and. left (fieldname (_j), 6) != "X1_CNT" .and. fieldname (_j) != "X1_PRESEL"
				FieldPut(_j, _aRegs [_i, _j])
			Endif
		Next
		MsUnlock()
	Next
Return

Static Function fProdPai(cNumOP,cItemOP)

	Local cProdPai := ""
	Local cAliTMP := GetNextAlias()

	BeginSql Alias cAliTMP

    SELECT SC2.C2_NUM, SC2.C2_ITEM, SC2.C2_SEQUEN, SC2.C2_PRODUTO
    FROM %table:SC2% SC2

    WHERE SC2.C2_FILIAL = %xFilial:SC2% AND
	  SC2.C2_NUM = %Exp:cNumOP% AND
	  SC2.C2_ITEM = %Exp:cItemOP% AND
	  SC2.C2_SEQUEN = "001" AND
	  SC2.%NotDel%
	EndSql

	cProdPai := (cAliTMP)->(C2_PRODUTO)

	(cAliTMP)->(DBCloseArea())

Return cProdPai






static function ConsumoInverso(aConsIn)

	Local cQuery := ''
	// Local nX := 0

	cQuery += "		WITH 			ESTRUT	(	CODIGO, 		"														+ CHR(13) + CHR(10)
	cQuery += "									COD_PAI_NIVEL, 	"														+ CHR(13) + CHR(10)
	cQuery += "									COD_COMP, 		"														+ CHR(13) + CHR(10)
	cQuery += "									QTD, 			"														+ CHR(13) + CHR(10)
	cQuery += "									PERDA, 			"														+ CHR(13) + CHR(10)
	cQuery += "									DT_INI, 		"														+ CHR(13) + CHR(10)
	cQuery += "									DT_FIM, 		"														+ CHR(13) + CHR(10)
	cQuery += "									NIVEL 			"														+ CHR(13) + CHR(10)
	cQuery += "								) AS 		"																+ CHR(13) + CHR(10)
	cQuery += "						(	SELECT			G1_COD PAI, 		"											+ CHR(13) + CHR(10)
	cQuery += "											G1_COD, 		"												+ CHR(13) + CHR(10)
	cQuery += "											G1_COMP, 		"												+ CHR(13) + CHR(10)
	cQuery += "											G1_QUANT, 		"												+ CHR(13) + CHR(10)
	cQuery += "											G1_PERDA, 		"												+ CHR(13) + CHR(10)
	cQuery += "											G1_INI, 		"												+ CHR(13) + CHR(10)
	cQuery += "											G1_FIM, 		"												+ CHR(13) + CHR(10)
	cQuery += "											1 AS NIVEL 		"												+ CHR(13) + CHR(10)
	cQuery += "				"																							+ CHR(13) + CHR(10)
	cQuery += "							FROM			"+RetSqlName('SG1')+" SG1 		"								+ CHR(13) + CHR(10)
	cQuery += "				"																							+ CHR(13) + CHR(10)
	cQuery += "							WHERE			SG1.D_E_L_E_T_ = ' ' 		"									+ CHR(13) + CHR(10)
	cQuery += "										AND G1_FILIAL      = '"+xFilial('SG1')+"' 		"					+ CHR(13) + CHR(10)
	cQuery += "				"																							+ CHR(13) + CHR(10)
	cQuery += "							UNION ALL 		"																+ CHR(13) + CHR(10)
	cQuery += "				"																							+ CHR(13) + CHR(10)
	cQuery += "							SELECT			CODIGO, 		"												+ CHR(13) + CHR(10)
	cQuery += "											G1_COD, 		"												+ CHR(13) + CHR(10)
	cQuery += "											G1_COMP, 		"												+ CHR(13) + CHR(10)
	cQuery += "											QTD * G1_QUANT, 		"										+ CHR(13) + CHR(10)
	cQuery += "											G1_PERDA, 		"												+ CHR(13) + CHR(10)
	cQuery += "											G1_INI, 		"												+ CHR(13) + CHR(10)
	cQuery += "											G1_FIM, 		"												+ CHR(13) + CHR(10)
	cQuery += "											NIVEL + 1 		"												+ CHR(13) + CHR(10)
	cQuery += "				"																							+ CHR(13) + CHR(10)
	cQuery += "							FROM			"+RetSqlName('SG1')+" SG1 		"								+ CHR(13) + CHR(10)
	cQuery += "																INNER JOIN 		"							+ CHR(13) + CHR(10)
	cQuery += "											ESTRUT EST						ON	G1_COD = COD_COMP 		"	+ CHR(13) + CHR(10)
	cQuery += "				"																							+ CHR(13) + CHR(10)
	cQuery += "							WHERE			SG1.D_E_L_E_T_ = ' ' 		"									+ CHR(13) + CHR(10)
	cQuery += "										AND SG1.G1_FILIAL = '"+xFilial('SG1')+"' 		"					+ CHR(13) + CHR(10)
	cQuery += "						) 		"																			+ CHR(13) + CHR(10)
	cQuery += "				"																							+ CHR(13) + CHR(10)
	cQuery += "		SELECT			*		"																			+ CHR(13) + CHR(10)
	cQuery += "				"																							+ CHR(13) + CHR(10)
	cQuery += "		FROM			ESTRUT E1		"																	+ CHR(13) + CHR(10)
	cQuery += "				"																							+ CHR(13) + CHR(10)
	cQuery += "		WHERE			E1.COD_COMP = '"+AllTrim((cAliasSC2)->C2_PRODUTO)+"' 		"						+ CHR(13) + CHR(10)
	cQuery += "					AND E1.CODIGO = '"+fProdPai((cAliasSC2)->(C2_NUM),(cAliasSC2)->(C2_ITEM))+"' 		"	+ CHR(13) + CHR(10)
	// cQuery += "		WHERE			E1.COD_COMP in ("														
	// for nX := 1 to Len(aConsIn)
	// 	cQuery += "'"+AllTrim(aConsIn[nX])+"', "
	// next
	// cQuery := SubStr(cQuery, 1, Len(cQuery)-2)
	// cQuery += ')'+ CHR(13) + CHR(10)

	// cQuery += "					AND E1.CODIGO = '"+AllTrim((cAliasSC2)->C2_PRODUTO)+"' 		"							+ CHR(13) + CHR(10)
	cQuery += "		ORDER BY		E1.CODIGO, E1.NIVEL, E1.COD_PAI_NIVEL,  E1.COD_COMP"														

	// MsgAlert(cQuery, 'QUERY')
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"QRYIN",.T.,.T.)

	DbSelectArea('QRYIN')
	QRYIN->(DbGoTop())



return
