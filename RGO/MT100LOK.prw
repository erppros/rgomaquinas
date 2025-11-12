#include "TOPCONN.CH"
#include "PROTHEUS.CH"
// Ponto de entrada para validar linha da nota fiscal de entrada
// Eduardo em 01/02/08

User Function MT100LOK()

Local	_bValCC	:=	GetMv("ML_VALCCUS")
Local	_cConta	:=	GDFieldGet("D1_CONTA")
Local	_cCusto	:=	GDFieldGet("D1_CC")
Local  	_nPrcPed	:=	0
Local  	_nPrcNfe	:=	0
Local	_nValTol	:=	0
Local	_cTxtTpPed	:=	""
Local	_aDadRet	:=	{}
//
_sarea := getarea()
_sarsf4 := sf4->(getarea())
_sarsb1 := sb1->(getarea())
_sarsc7 := sc7->(getarea())
//
_lret := .T.
//
if !Gddeleted(n)
	sf4->(dbsetorder(1))
	if ! sf4->(dbseek(XFilial("SF4")+GDFieldGet("D1_TES")))
		Msginfo ("TES invalido !!! (MT100LOK)")
		_lret := .F.
	endif
	if _lret
		sb1->(dbsetorder(1))
		if ! sb1->(dbseek(XFilial("SB1")+GDFieldGet("D1_COD")))
			Msginfo ("Produto Invalido !!! (MT100LOK)")
			_lret := .F.
		endif
	endif
	if _lret
		// Movimenta estoque e n controla 3os a conta contabil deve comecar com 1010301
		if SF4->F4_ESTOQUE == 'S' .and. SF4->F4_PODER3 == 'N' .and. left(GDFieldGet("D1_CONTA"),5) <> '1010301'
			Msginfo ('Na atualizacao de estoque sem poder de terceiros a conta deve iniciar com 60175 !')
			_lret := .F.
		endif
	endif
	if _lret
		// N Movimenta estoque - a conta deve ser <> de 1010301
		if SF4->F4_ESTOQUE <> 'S' .and. left(GDFieldGet("D1_CONTA"),5) = '1010301'
			Msginfo ('Tes que nao atualiza estoque nao pode conter conta com 1010301 !')
			_lret := .F.
		endif
	endif
	//FÁBIO A. MICHELON - 27/03/2012 - MICROTRUST
	//OBJETIVO: VALIDAR O CÓDIGO DO CENTRO DE CUSTO CONFORME A CONTA CONTÁBIL
	IF _lret
		If _bValCC .and. !Empty(_cConta)
			DbSelectArea("CT1")
			DbSetOrder(1)
			DbSeek( xFilial("CT1") + _cConta )
			If Found()
				//CT1_ACCUSTO == "1-Sim"; "2=Nao"	=> Aceita centro de custo
				//CT1_CCOBRG  == "1-Sim"; "2=Nao"	=> Obrigatório o centro de custo
				//CT1_RGNV1
				If (CT1->CT1_CCOBRG == "1") .and. Empty(_cCusto)
					_lret	:=	.f.
					MsgAlert( "Informe o Centro de Custo" )
				Elseif (CT1->CT1_ACCUSTO <> "1") .and. !Empty(_cCusto)
					_lret	:=	.f.
					MsgAlert( "Centro de Custo NÃO deve ser preenchido" )
				Endif
			Endif
		Endif
	endif
		
endif
restarea (_sarsc7)
restarea (_sarsb1)
restarea (_sarsf4)
restarea (_sarea)

Return(_lret)
