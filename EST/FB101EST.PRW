#INCLUDE "Protheus.ch"
#INCLUDE "Totvs.ch"

//Função retirada do fonte padrão M241SELES()

USER Function FB101EST()
	Local aEstrutura   := {}
	Local i            := 0
	Local nx           := 0
	Local oDlg
	Local lOk          := .F.
	Local aAreaSD4     := SD4->(GetArea())
	Local aAreaSDC     := SDC->(GetArea())
	Local nPercOP      := 0
	Local lSugSemSld   := .F.
	Local aColsPE      := {}
	Local cLocaliz     := Criavar("D3_LOCALIZ",.F.)
	Local cNumSeri     := Criavar("D3_NUMSERI",.F.)
	Local lItemNeg     := .F.
	Local aMov := {}

	Private nQtdOrigEs := 1
	Private cProdEst   := Criavar("D3_COD",.F.)
	Private cOpEst     := Criavar("D3_OP",.F.)
	Private nEstru     := 0
	PRIVATE cTM        := "501"//SD3->D3_TM //Adicionado por Rogerio Duarte para pegar o tipo de movimento

	DEFINE MSDIALOG oDlg FROM  140,000 TO 300,400 TITLE OemToAnsi("Informe produto com estrutura") PIXEL //"Informe produto com estrutura"
	@ 10,15 TO 63,185 LABEL Alltrim(RetTitle("D3_OP"))+" - "+Alltrim(RetTitle("D3_COD"))+" - "+Alltrim(RetTitle("D3_QUANT")) OF oDlg PIXEL
	@ 20,20 MSGET cOpEst F3 "SC2" Picture PesqPict("SD3","D3_OP") When(oSugerSld:lVisible := .T.,SysRefresh(),.T.) Valid ((Vazio() .Or. ExistCpo("SC2",cOpEst)) .And. A241IniOP()) SIZE 70,9 OF oDlg PIXEL
	@ 35,20 MSGET cProdEst F3 "SB1" Picture PesqPict("SD3","D3_COD") When( lSugSemSld := If(Empty(cOpEst),.F.,lSugSemSld),oSugerSld:lVisible:=!Empty(cOpEst),SysRefresh(),.T.) Valid (NaoVazio() .And. ExistCpo("SB1",cProdEst)) SIZE 70,9 OF oDlg PIXEL
	@ 35,95 MSGET nQtdOrigEs Picture PesqPict("SD3","D3_QUANT") Valid (Positivo() .And. NaoVazio()) SIZE 60,9 OF oDlg PIXEL
	@ 50,20 CHECKBOX oSugerSld Var lSugSemSld PROMPT OemtoAnsi( "Sugere itens sem saldo" )	SIZE 150,10 OF oDlg PIXEL
	DEFINE SBUTTON FROM 67,131 TYPE 1 ACTION (oDlg:End(),lOk:=.T.) ENABLE OF oDlg
	DEFINE SBUTTON FROM 67,158 TYPE 2 ACTION (oDlg:End(),lOk:=.F.) ENABLE OF oDlg
	ACTIVATE MSDIALOG oDlg CENTERED ON INIT(oSugerSld:lVisible := .T.)

	If lOk .And. !Empty(cProdEst) .And. nQtdOrigEs > 0
		// Le os empenhos caso a op esteja preenchida
		If !Empty(cOPEst)
			dbSelectArea("SC2")
			dbSetOrder(1)
			dbSeek(xFilial("SC2")+cOpEst)
			// Calcula qual o percentual da baixa de insumos
			nPercOp:=nQtdOrigEs/SC2->C2_QUANT
			dbSelectArea("SDC")
			dbSetOrder(2)
			dbSelectArea("SD4")
			dbSetOrder(2)
			dbSeek(xFilial("SD4")+cOpEst)
			While !Eof() .And. D4_FILIAL+D4_OP==xFilial("SD4")+cOpEst
				If !lSugSemSld .AND. QtdComp(D4_QUANT)==QtdComp(0)
					dbSkip()
					Loop
				EndIf
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//| Produtos de apropriacao indireta, quando ja possuem saldo no armazem de processo |
				//| a baixa e automatica pela producao, quando ainda nao possuem saldo no armazem de |
				//| de processo devera ser feita requisicao manual do armazem padrao.                |
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If A260ApropI(D4_COD)
					dbSkip()
					Loop
				EndIf

				//Pesquisa na tabela SG1 se existe estrutura para o produto
				lTemEstr := .F.
				dbSelectArea("SG1")
				dbSetOrder(1)
				lTemEstr := SG1->(MsSeek(xFilial("SG1")+SD4->D4_COD))

				//if cTm > "500" 
				If !lTemEstr
					If SDC->(dbSeek(xFilial("SDC")+SD4->D4_COD+SD4->D4_LOCAL+SD4->D4_OP+SD4->D4_TRT+SD4->D4_LOTECTL+SD4->D4_NUMLOTE))
						While !SDC->(Eof()) .And. xFilial("SDC")+SD4->D4_COD+SD4->D4_LOCAL+SD4->D4_OP+SD4->D4_TRT+SD4->D4_LOTECTL+SD4->D4_NUMLOTE == SDC->(DC_FILIAL+DC_PRODUTO+DC_LOCAL+DC_OP+DC_TRT+DC_LOTECTL+DC_NUMLOTE)
							AADD(aEstrutura,{NIL,NIL,SD4->D4_COD,Min(SDC->DC_QUANT,(SDC->DC_QTDORIG*nPercOp)),SDC->DC_TRT,SDC->DC_LOTECTL,SDC->DC_NUMLOTE,SDC->DC_LOCALIZ,SDC->DC_NUMSERI,SD4->D4_LOCAL,SD4->D4_DTVALID})
							SDC->(dbSkip())
						End
					Else
						AADD(aEstrutura,{NIL,NIL,SD4->D4_COD,Min(SD4->D4_QUANT,(SD4->D4_QTDEORI*nPercOp)),SD4->D4_TRT,SD4->D4_LOTECTL,SD4->D4_NUMLOTE,cLocaliz,cNumSeri,SD4->D4_LOCAL,SD4->D4_DTVALID})
					EndIf
				Else
					AADD(aEstrutura,{NIL,NIL,SD4->D4_COD,Min(SD4->D4_QTDEORI*nPercOp,SD4->D4_QTDEORI-SD4->D4_QUANT),SD4->D4_TRT,SD4->D4_LOTECTL,SD4->D4_NUMLOTE,cLocaliz,cNumSeri,SD4->D4_LOCAL,SD4->D4_DTVALID})
				EndIf
				dbSelectArea("SD4")
				dbSkip()
			End
			RestArea(aAreaSD4)
			RestArea(aAreaSDC)
			// Se nao preencheu OP le somente a estrutura
		Else
			// Explode o 1 nivel da estrutura
			If FindFunction("aCusbExpld")
				aCusbExpld(cProdEst,nQtdOrigEs,@aEstrutura)
			Else
				Help(,,"OUTDATEDSOURCE",,"O Fonte SIGACUSB.PRX encontra-se desatualizado.", 1, 0) // "O Fonte SIGACUSB.PRX encontra-se desatualizado."
				aEstrutura := {}
			EndIf
		EndIf

		// Adicionado Rogerio Duarte para pegar a posição dos campos do getdados
		nPosCod	 := aScan(aHeader,{|x| AllTrim(x[2])=="D3_COD"})
        nPosCodD := aScan(aHeader,{|x| AllTrim(x[1])=="Prod.Destino"}) //Pego pelo nome pois o campo é o mesmo do produto de origem D3_COD
        nPosDesD := aScan(aHeader,{|x| AllTrim(x[1])=="Desc.Destino"}) //Pego pelo nome pois o campo é o mesmo do produto de origem D3_DESCRI
        nPosArmD := aScan(aHeader,{|x| AllTrim(x[1])=="Armazem Destino"}) //Pego pelo nome pois o campo é o mesmo do produto de origem D3_LOCAL

		// Le somente os itens de primeiro nivel
		If Len(aEstrutura) > 0
			For i:=1 to Len(aEstrutura)
				// Se a primeira linha esta em branco remove a mesma do acols

				SB1->(dbSetOrder(1))
				SB1->(MsSeek(xFilial("SB1")+aEstrutura[i,3]))
				if SB1->B1_TIPO $ ('PA|PI|SV|BN')		// ADICIONAR SERVIÇOS E OUTROS QUE NAO CONTROLAM ESTOQUE
					Loop
				else	
					aAdd(aMov, SB1->B1_COD)
				endif

				If Empty(aCols[1,nPosCod])
					ADEL(aCols,1)
					ASIZE(aCols,Len(aCols)-1)
				EndIf
				// Adiciona item no acols
				AADD(aCols,Array(Len(aHeader)+1))
				// Preenche conteudo do acols
				For nx:=1 to Len(aHeader)
					cCampo:=Alltrim(aHeader[nx,2])
					If IsHeadRec(cCampo)
						aCols[Len(aCols)][nx] := 0
					ElseIf IsHeadAlias(cCampo)
						aCols[Len(aCols)][nx] := "SD3"
					Else
						aCols[Len(aCols)][nx] := CriaVar(cCampo,.F.)
					EndIf
				Next nx

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Tratamento para marcar como deletados os itens com quantidade negativa na ³
				//³estrutura ou positiva-los, de acordo com o tipo de movimentacao RE/DE.    ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				//If QtdComp(aEstrutura[i,4]) <= QtdComp(0)
				//	lItemNeg := .T. // variavel para exibicao de aviso ao usuario
				//	If cTm > "500"
				//		// Requisicoes
				//		If QtdComp(aEstrutura[i,4]) <= QtdComp(0)
				//			// Quantidade negativa ou zerada: deve ser deletado, pois nao se pode requisitar quantidade negativa ou zerada
				//			aCOLS[Len(aCols)][Len(aHeader)+1] := .T.
				//		EndIf
				//	Else
				//		// Devolucoes
				//		If QtdComp(aEstrutura[i,4]) < QtdComp(0)
				//			// Quantidade negativa: deve ser positivada, pois trata-se de devolucao
				//			aCOLS[Len(aCols)][Len(aHeader)+1] := .F.
				//			aEstrutura[i,4] := (aEstrutura[i,4] * -1)
				//		Else
				//			// Quantidade zerada: deve ser deletado, pois nao se pode devolver quantidade zerada
				//			aCOLS[Len(aCols)][Len(aHeader)+1] := .T.
				//		EndIF
				//	EndIf
				//Else
				//	// Item com quantidade positiva > 0
					aCOLS[Len(aCols)][Len(aHeader)+1] := .F.
				//EndIf

				// Preenche campos especificos
				GDFieldPut("D3_COD",aEstrutura[i,3],Len(aCols))
				GDFieldPut("D3_DESCRI",SB1->B1_DESC,Len(aCols))
				GDFieldPut("D3_UM",SB1->B1_UM,Len(aCols))
				GDFieldPut("D3_SEGUM",SB1->B1_SEGUM,Len(aCols))
				GDFieldPut("D3_QUANT",aEstrutura[i,4],Len(aCols))
				GDFieldPut("D3_LOCAL",RetFldProd(SB1->B1_COD,"B1_LOCPAD"),Len(aCols))
				GDFieldPut("D3_CONTA",SB1->B1_CONTA,Len(aCols))
				GDFieldPut("D3_ITEMCTA",SB1->B1_ITEMCC,Len(aCols))
				// Preenche o numero da OP
				If !Empty(cOpEst)
					// If aEstrutura[i,10]# NIL .AND. !Empty(aEstrutura[i,10])
					// 	GDFieldPut("D3_LOCAL",aEstrutura[i,10],Len(aCols))
					// EndIf
					GDFieldPut("D3_OP",cOpEst,Len(aCols))
					GDFieldPut("D3_TRT",aEstrutura[i,5],Len(aCols))
					GDFieldPut("D3_LOTECTL",aEstrutura[i,6],Len(aCols))
					GDFieldPut("D3_NUMLOTE",aEstrutura[i,7],Len(aCols))
					GDFieldPut("D3_DTVALID",aEstrutura[i,11],Len(aCols))
					If ! Empty(cTM) .and. SF5->F5_TIPO=="D"
						GDFieldPut("D3_LOCALIZ",Space(15),Len(aCols))
						GDFieldPut("D3_NUMSERI",Space(20),Len(aCols))
					Else
						GDFieldPut("D3_LOCALIZ",aEstrutura[i,8],Len(aCols))
						GDFieldPut("D3_NUMSERI",aEstrutura[i,9],Len(aCols))
					EndIf
				EndIf

                //Adicionado por Rogerio Duarte para preencher o produto e armazem destino
                If nPosCodD > 0 .And. nPosArmD > 0
                    acols[Len(aCols)][nPosCodD] := aEstrutura[i,3] //Produto Destino
                    acols[Len(aCols)][nPosDesD] := SB1->B1_DESC //Descricao Produto Destino
                    acols[Len(aCols)][nPosArmD] := SUPERGETMV( "TRS_TRANSM", ,"02",)//"02" //Armazem Destino 
                EndIf

				// Executa gatilhos e validacoes
				If ExistTrigger("D3_COD")
					RunTrigger(2,Len(aCols),,"D3_COD")
				EndIf
				If ExistTrigger("D3_QUANT")
					RunTrigger(2,Len(aCols),,"D3_QUANT")
				EndIf
				If ExistTrigger("D3_LOCAL")
					RunTrigger(2,Len(aCols),,"D3_LOCAL")
				EndIf
				If ExistTrigger("D3_OP")
					RunTrigger(2,Len(aCols),,"D3_OP")
				EndIf
			Next i
		EndIf
	EndIf

	if Empty(aMov)
		MsgAlert('Nenhum produto incluido a lista devido a tipagem.', 'Atenção')
	endif

	If lItemNeg
		If cTM > '500'
			Aviso("Atenção", "Os itens com quantidade <= 0 serão marcados como apagados, pois não é possível realizar movimento de requisição com quantidade negativa ou zerada.", {"OK"})
		Else
			Aviso("Atenção", "Os itens com quantidade <= 0 serão positivados, pois não é possível realizar movimento de devolução com quantidade negativa ou zerada.", {"OK"})
		EndIf
	EndIf

	If ExistBlock('MT241SE')
		aColsPE := Execblock('MT241SE', .F., .F., aCols)
		If Valtype(aColsPE) == 'A'
			aCols := aClone(aColsPE)
		EndIf
	EndIf

//-- Forca atualizacao da GetDados
	oGet:Refresh()

Return

Static Function A241IniOP()
	Local lRet := .T.
// Inicializa produto e quantidade
	If !Empty(cOPEst) .And. SC2->(MsSeek(xFilial("SC2")+cOpEst))
		If !Empty(SC2->C2_DATRF)
			Help(" ",1,"A250ENCERR")
			lRet := .F.
		ElseIf SC2->C2_TPOP == "P"
			Help(" ",1,"NOPPREVIST")
			lRet := .F.
		Else
			nQtdOrigEs:=SC2->C2_QUANT-SC2->C2_QUJE
			cProdEst:=SC2->C2_PRODUTO
		EndIf
	EndIf
Return lRet
