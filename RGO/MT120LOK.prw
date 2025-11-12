#INCLUDE "PROTHEUS.CH"

//FÁBIO A. MICHELON - 27/03/2012 - MICROTRUST
//OBJETIVO: VALIDAR O CÓDIGO DO CENTRO DE CUSTO CONFORME A CONTA CONTÁBIL

User Function MT120LOK()

Local	_bOk	:=	.t.
Local	_aArea	:=	GetArea()
Local	_bValCC	:=	.T.
Local	_cConta	:=	GDFieldGet("C7_CONTA")
Local	_cCusto	:=	GDFieldGet("C7_CC")
Local	_cGrpAprov	:=	""
Local	_cFornece	:=	M->CA120FORN
Local	_cLoja		:=	M->CA120LOJ
Local	_cCodMod	:=	""
Local	_nVlrUnit	:=	0


If !GDDeleted() .and. _bValCC .and. !Empty(_cConta) 
	DbSelectArea("CT1")
	DbSetOrder(1)
	DbSeek( xFilial("CT1") + _cConta )
	If Found()
		//CT1_ACCUSTO == "1-Sim"; "2=Nao"	=> Aceita centro de custo
		//CT1_CCOBRG  == "1-Sim"; "2=Nao"	=> Obrigatório o centro de custo   
		//CT1_RGNV1
		If (CT1->CT1_CCOBRG == "1") .and. Empty(_cCusto)
			_bOk	:=	.f.
			MsgAlert( "Informe o Centro de Custo" )
		Elseif (CT1->CT1_ACCUSTO <> "1") .and. !Empty(_cCusto)
			_bOk	:=	.f.
			MsgAlert( "Centro de Custo NÃO deve ser preenchido" )
		Endif
	Endif

	


Endif
RestArea(_aArea)



Return _bOk
