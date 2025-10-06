#Include "RPTDEF.CH"
#Include "FwPrintSetup.ch"
#Include "trsf001.ch"
#INCLUDE "TbiConn.ch"
#Include "Totvs.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ TRSF001  ³ Autor ³ Fabio Briddi          ³ Data ³ Nov/2013 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Impressao de Boletos Bancarios com Codigo de Barras        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Financeiro / Faturamento                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³                         Manutencoes                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄ´±±
±±³Analista  ³ Motivo                                            ³  Data  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄ´±±
±±³F.Briddi  ³ Criacao original Banco Itau                       ³Nov/2013³±±
±±³Denis Rod ³ Adicionado impressao para o Banco do Brasil       ³Dez/2013³±±
±±³Denis Rod ³ Adicionado impressao para o Banco HSBC            ³Dez/2013³±±
±±³Denis Rod ³ Adicionado impressao para o Banco Brade        ³Jan/2014³±±
±±³Denis Rod ³ Adicionado impressao para o Banco Caixa           ³Jan/2014³±±
±±³F.Briddi  ³ Implementado Impressao Boleto Banrisul            ³Jan/2014³±±
±±³F.Briddi  ³ Implementado Impressao Boleto Santander           ³Jun/2014³±±
±±³F.Briddi  ³ Implementado Criacao de Arquivo p/ Cliente+Loja e ³Dez/2014³±±
±±³          ³ p/ Cliente+Loja+Prefixo+Titulo                    ³        ³±±
±±³F.Briddi  ³ Implementado Envio p/ E-mail e impressao cega,    ³Dez/2014³±±
±±³          ³ p/ uso Schedule / WS                              ³        ³±±
±±³Giovanni M³ Adicionado impressao para o Banco Safra           ³Fev/2015³±±
±±³Giovanni M³ Adicionado impressao para o Banco Fibra           ³Fev/2015³±±
±±³Giovanni M³ Adicionado impressao para a Coop. Cred. Sicredi   ³Fev/2015³±±
±±³Giovanni M³ Adicionado impressao para o Banco Redasset        ³Fev/2015³±±
±±³Giovanni M³ Adicionado impressao para o Banco ABC Brasil      ³Mar/2015³±±
±±³Giovanni M³ Adicionado impressao para o Banco Votorantim      ³Mar/2015³±±
±±³Giovanni M³ Adicionado impressao para o Banco do Nordeste     ³Mar/2015³±±
±±³F.Briddi  ³ Alterado Caluculo DV Cod Emp CAIXA de Mod11B9     ³Mai/2015³±±
±±³          ³ para Mod11B29 (Modulo 11 Base de 2 a 9)           ³        ³±±
±±³Jeferson D³ Inclusao / validacao do campo EE_ACEITE           ³Mai/2015³±±
±±³Paola     ³ Alterada a validação do tamanho da conta          ³        ³±±
±±³          ³ corrente do banco ABC  de 5 para 8                ³Mai/2015³±±
±±³Paola     ³ Inclusão do calculo do DV do nosso número em banco³        ³±±
±±³          ³ correspondentes Bradesco nos que nao estavam      ³Mai/2015³±±
±±³          ³ gravando no campo E1_NUMBCO                       ³        ³±±
±±³Paola     ³ Na impressao so nosso número o Banco Nordeste     ³        ³±±
±±³          ³ não deve ser impresso o código da carteira        ³Jun/2015³±±
±±³Paola     ³ Alteração na impressao por faixa de / ate dos     ³        ³±±
±±³          ³ bancos correspondentes                            ³Jun/2015³±±
±±³Paola     ³ Alteração na validação da CC Votorantin           ³        ³±±
±±³          ³ contem 9 digitos ao invés de 5                    ³Jun/2015³±±
±±³Paola     ³ Alteração na validação da agencia  de 4 digitos   ³        ³±±
±±³          ³ para 3 NORDESTE                                   ³Jun/2015³±±
±±³Paola     ³ Alteração na validação da CC NORDESTE             ³        ³±±
±±³          ³ contem 7 digitos ao invés de 3                    ³Jun/2015³±±
±±³Paola     ³ Alteração para gravar nosso numero + DV           ³        ³±±
±±³          ³ no campo E1_NUMBCO NORDESTE                       ³Jun/2015³±±
±±³Paola     ³ Alteração para gravar nosso numero + DV           ³        ³±±
±±³          ³ no campo E1_NUMBCO   ABC                          ³Jun/2015³±±
±±³Giovanni M³ Ajustes necessarios na geracao do Cod.Barras e no ³Jun/2015³±±
±±³          ³ DV do Nosso Numero da Caixa                       ³        ³±±
±±³Paola    M³ calculo novo do BANRISUL,quando o resto e 0 ou 1  ³Jun/2015³±±
±±³          ³ tem regras a definir, inclui outro cálculo para   ³        ³±±
±±³          ³ o cálculo do nosso número.                        ³        ³±±
±±³Giovanni M³ Correções no boleto CITI, no calculo do DV do     ³Jun/2015³±±
±±³          ³ Nosso Numero e informacoes a serem impressas      ³        ³±±
±±³Paola    M³ AFEC solicitou voltar a validação do tamanho da   ³Jun/2015³±±
±±³          ³ agencia do banco Nordeste conforme manual de 3    ³        ³±±
±±³          ³ para 4                                            ³        ³±±
±±³Paola    M³ Alteração na impressão do valor do titulo         ³Jun/2015³±±
±±³          ³ o CLIENTE terá  opção  para iformar como          ³        ³±±
±±³          ³ qual valor a considerar para a impressão.         ³        ³±±
±±³          ³ parametro TRS_VALIMP                              ³        ³±±
±±³Paola    M³ Alteração no digito verificador do nosso          ³Jun/2015³±±
±±³          ³ numero, alterar o DV calculado no modulo 10       ³        ³±±
±±³          ³ quando resto for 1 ou 0                           ³        ³±±
±±³Paola    M³ Alteração para gravar o digito do nosso numero    ³Jun/2015³±±
±±³          ³ no campo E1_NUMBCO banco CITIBANK                 ³        ³±±
±±³Paola    M³ Alteração para gravar o digito do nosso numero    ³Jun/2015³±±
±±³          ³ no campo E1_NUMBCO banco SICREDI                  ³        ³±±
±±³Paola    M³ Alteração no calculo da linha digitável do        ³Jun/2015³±±
±±³          ³ boleto da CAIXA                                   ³        ³±±
±±³Giovanni M³ Alteracao no calculo do DV Nosso Numero boleto    ³Jun/2015³±±
±±³          ³ Banco Nordeste, utilizando o Modulo11 Base 8.     ³        ³±±
±±³Giovanni M³ Inclusao da formacao do codigo de barras do Banco ³Jul/2015³±±
±±³          ³ do Brasil com CODEMP tamanho 4, 6 e 7 posicoes    ³        ³±±
±±³Giovanni M³ Tratamento no tamanho do numero da conta, quando  ³Jul/2015³±±
±±³          ³ o tamanho do convenio for diferente de 7          ³        ³±±
±±³Giovanni M³ Adicionado impressao para o Banco BBM,            ³Jul/2015³±±
±±³          ³ correspondente Banco Bradesco                     ³        ³±±
±±³Paola     ³ Para O BANCO ITAU 400 posições não tem necessidade³Jul/2015³±±
±±³          ³ de informar o DV do nosso numero , mas para layout³        ³±±
±±³          ³ de 240 posições é preciso informar , assim vamos  ³        ³±±
±±³          ³ gravar o DV no campo E1_NUMBCO.                   ³        ³±±
±±³Paola     ³ Alteração para o banco do BRASIL com 4 e 6 posiçoe³Jul/2015³±±
±±³          ³ do número do convênio. Gravar e imprimir DV       ³        ³±±
±±³          ³ do nosso número                                   ³        ³±±
±±³Paola     ³ Alteração na impressao do logo do banco           ³Jul/2015³±±
±±³          ³ função saybitmap esta com problemas, abri um      ³        ³±±
±±³          ³ chamado número TSTXAI - Ate a função estar ok     ³        ³±±
±±³          ³  foi criada a F001TEMP                            ³        ³±±
±±³Paola     ³ Alteração no cálculo do DV BB convênio 6 posições ³Jul/2015³±±
±±³          ³                                                   ³        ³±±
±±³Paola     ³ Alteração no cálculo do DV SAFRA com correspondent³Jul/2015³±±
±±³          ³ Bradesco. Calcula DV do 
 mai DV do BRADESCO  ³        ³±±
±±³Paola     ³ Alteração referente ao logo BBM quando corresponde³Jul/2015³±±
±±³          ³ Bradesco.                                         ³        ³±±
±±³Paola     ³ Alteração no reimpressao no nosso numero BB       ³Jul/2015³±±
±±³          ³ quando convênio 6 posições                        ³        ³±±
±±³Giovanni M³ Alteração na impressao do campo ESPECIE do banco  ³Ago/2015³±±
±±³          ³ Sicredi como DMI, conforme especificado pelo banco³        ³±±
±±³Giovanni M³ Alteração na impressao do campo agencia\Beneficia ³Ago/2015³±±
±±³          ³ ario não e preciso imprimir DV da conta           ³        ³±±
±±³Giovanni M³ Alteração no campo livre do Banco SAFRA corresp.  ³Ago/2015³±±
±±³          ³ BRADESCO                                          ³        ³±±
±±³Giovanni M³ Inclusão de mensagem para SAFRA correspondente    ³Ago/2015³±±
±±³          ³ BRADESCO,assim foi preciso mudar o espaçamento    ³        ³±±
±±³          ³ do boleto                                         ³        ³±±
±±³Paola    M³ Alteracao na validação da conta corrente do       ³Ago/2015³±±
±±³          ³ banco do Brasil.Verificamos que além da conta de  ³        ³±±
±±³          ³ 5 digitos pode variar de 4 a 8                    ³        ³±±
±±³Paola    M³ Alteracao na impressao do endereço do beneficiario³Ago/2015³±±
±±³          ³ com carteira de cobrança correspondente,imprimir  ³        ³±±
±±³          ³ informações do cadastro do bco correspondente.    ³        ³±±
±±³Giovanni M³ Tratamento na validacao do campo EE_CONTA com tama³Set/2015³±±
±±³          ³ nho entre 4 e 8 posicoes para boletos do Banco do ³        ³±±
±±³          ³ Brasil.                                           ³        ³±±
±±³Giovanni M³ Tratamento na geracao do campo livre do codigo de ³Set/2015³±±
±±³          ³ barras do Banco Safra correspondente Bradesco.    ³        ³±±
±±³Giovanni M³ Tratamento no calculo do DV do Nosso Numero Banco ³Set/2015³±±
±±³          ³ Safra, removendo a subtracao do Resto por 11.     ³        ³±±
±±³Paola     ³ Alteração para impressão do CNPJ do banco         ³Set/2015³±±
±±³          ³ correspondente.                                   ³        ³±±
±±³Giovanni M³ Alteração na composição do Nosso Número Bco. Safra³Nov/2015³±±
±±³          ³ Correspondente Bradesco, alterado no cálculo data ³        ³±±
±±³          ³ do vcto pela data de emissão, cfe. manual do banco³        ³±±
±±³Giovanni M³ Alteracao na impressao do CNPJ do Avalista, para  ³Nov/2015³±±
±±³          ³ impressao de mais de um titulo na mesma impressao ³        ³±±
±±³Leonir D  ³ Inclusao do campo E1_CODDIG para gravacao         ³Jan/2016³±±
±±³          ³ da linha digitavel                                ³        ³±±
±±³Giovanni M³ Criado o modulo Mod11B27B para calcular o segundo ³Fev/2016³±±
±±³          ³ digito do numero de controle (NC) do Nosso Numero ³        ³±±
±±³          ³ do Banco Banrisul                                 ³        ³±±
±±³Paola     ³ Mudamos a gravação do campo EE_FAXATU grava       ³mar/2016³±±
±±³          ³ no Reclock ao inves de somar a faixa fora do      ³        ³±±
±±³          ³ reclock, devido grande fluxo no cliente.          ³        ³±±
±±³Leonir D  ³ Inclusão da pesquisa do campo E1_FORMA,           ³Mar/2016³±±
±±³          ³ verifica se o campo existe, se existe inclui      ³        ³±±
±±³          ³ nas perguntas a opção Forma de Pagamento          ³        ³±±
±±³Gregory A.³ Inclusão de pergunta, parâmetros e Validações para³Mar/2016³±±
±±³          ³ a execução de impressao de segunda via dos boletos³        ³±±
±±³Gregory A.³ Atualizacao das validacoes para segunda via para  ³Abr/2016³±±
±±³          ³ (nao existencia dos campos de segunda via)        ³        ³±±
±±³Giovanni M³ Inclusao de impressao Cobr. Direta BCO ABC BRASIL ³Ago/2016³±±
±±³Joao Mttos³ Alteracao da Funcao TRSF001D Via WebServices rece-³Ago/2016³±±
±±³          ³ bendo como parametro objeto de impressao          ³        ³±±
±±³          ³ FWMSPrinter                                       ³        ³±±
±±³Paola     ³ Alteracao para buscar o campo E1_VLCRUZ ao invés d³Marc/2017±±
±±³          ³ valor, devido outras moedas. O campo E1_SALDO     ³        ³±±
±±³          ³ convertemos caso necessário.                      ³        ³±±
±±³Paola     ³ Alteracao para considerar o parametro TRS_BOL01   ³27/04/17³±±
±±³          ³ No caso de banco correspondente considerar        ³        ³±±
±±³          ³ para a impressão dos dados do beneficiário        ³        ³±±
±±³          ³ no boleto os dados do beneficiario ou o banco     ³        ³±±
±±³          ³ correspondente.                                   ³        ³±±
±±³Jeferson D³ Inclusao de regra para exibir mensagem de abatimen³11/06/18³±±
±±³          ³ to na funcao F001Proc. Neste processo incluimos o ³        ³±±
±±³          ³ campo A1_IMPABAT responsavel por esse controle.   ³        ³±±
±±³Paola     ³ Inclusao pto de entrada TF001BCLI para considerar ³13/11/18³±±
±±³          ³ banco do cadastro do cliente ao invés dos         ³        ³±±
±±³          ³ parametros.                                       ³        ³±± 
±±³Paola     ³ Retirei a validação de valores no caso do MBCAD   ³10/12/18³±±
±±³          ³ Devido solicitação do cliente MAZER. Somente este ³        ³±±
±±³          ³ cliente utiliza MBCAD.                            ³        ³±± 
±±³Paola     ³ Alteração do Boleto para moeda 2 para o banco Itaú 15/12/21³±±
±±³          ³                                                   ³        ³±±
±±³Paola     ³ Considera 0 titulo do Abatimento(AB-) no vlr impre³30/12/21³±± 
±±³          ³ criado parâmetro TRS_BOL02                        ³        ³±±
±±³Paola     ³ Inclusao banco SICOOB                             ³03/24   ³±± 
±±³          ³                                                   ³        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

*/
User Function TRSF001( cAlias, nReg, nOpc )

	Local   aCores    := {}
	Private cCadastro := "Contas a Receber - Impressao de Boletos"
	Private aRotina   := MenuDef()

	Private lForma		:= (SE1->(FieldPos("E1_FORMA"))   > 0)
	Private lSegundaVia	:= .F.
	Private nSegVia		:= 0
	Private _cCodBar := ""

	If SE1->( FieldPos("E1_PORBCO")) > 0 .AND. SE1->( FieldPos("E1_PORAGC")) > 0 .AND.;
			SE1->( FieldPos("E1_PORDVA")) > 0 .AND. SE1->( FieldPos("E1_PORCTA")) > 0 .AND.;
			SE1->( FieldPos("E1_PORDVC")) > 0 .AND. SE1->( FieldPos("E1_PORSUB")) > 0
		lSegundaVia := .T.
	EndIf

	If	ValType(cAlias) = "U" .And. ValType(nReg) = "U" .And. ValType(nOpc) = "U"

		cAlias := "SE1"

		dbSelectArea(cAlias)
		&(cAlias)->( DbSetOrder( 1 ) )

		mBrowse( 6, 1, 22, 75, cAlias, , , , , , Fa040Legenda(cAlias) )

	Else

		U_TRSF001B( cAlias, nReg, nOpc )

	EndIf

Return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ TRSF001B ³ Autor ³ Fabio Briddi          ³ Data ³ Nov/2013 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Chamada da Funcao de Processamento de Impressao de Boletos ³±±
±±³          ³ Bancarios                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TRSF001 - Programa Principal                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function TRSF001B( cAlias, nReg, nOpc )

	Local   aArea       := GetArea()
	Local   nAlias      := Select()
	Local   cPerg       := F001AjSx1()
	Local   lBcoPar     := .T.
	Local   lSetCentury := __SetCentury()

	Local   oBoleto     := Nil
	Local   oSetup      := Nil
	Local   lExistBol   := .F.

	Local	lBlind      := .F.

	Local cTempPath   := IIf( IsBlind(), "\boletos\tmp", GetTempPath())
	Local cBolPath    := "\boletos\"

	Private lBCLI       := .F.

	Private lAmbHml     := (SM0->M0_CODIGO == "99")
	Private lBCLI       := .F.



	If	!File( cBolPath+"." )
		MakeDir( cBolPath )
	EndIf

	If	!File( cTempPath+"." )
		MakeDir( cTempPath )
	EndIf

	If	!lSetCentury
		__SetCentury("ON")
	EndIf

	If ExistBlock( "TF001PAR" )
		ExecBlock( "TF001PAR", .F., .F., {} )
	EndIf

	// Pto de entrada se considera o bco do cliente
	If ExistBlock( "TF001BCLI" )
		lBCLI:= ExecBlock( "TF001BCLI", .F., .F., {} )
	EndIf


	If	Pergunte( cPerg, .T. )

		Private cBanco       := MV_PAR01
		Private cAgencia     := MV_PAR02
		Private cConta       := MV_PAR03
		Private cSubCta      := MV_PAR04
		Private lPosicionado := (MV_PAR05 = 1)
		Private cDoPrefixo   := IIf(lPosicionado, SE1->E1_PREFIXO, MV_PAR06)
		Private cAtePrefixo  := IIf(lPosicionado, SE1->E1_PREFIXO, MV_PAR07)
		Private cDoNum       := IIf(lPosicionado, SE1->E1_NUM,     MV_PAR08)
		Private cAteNum      := IIf(lPosicionado, SE1->E1_NUM,     MV_PAR09)
		Private cDaParcela   := IIf(lPosicionado, SE1->E1_PARCELA, MV_PAR10)
		Private cAteParcel   := IIf(lPosicionado, SE1->E1_PARCELA, MV_PAR11)
		Private cDoTipo      := IIf(lPosicionado, SE1->E1_TIPO,    MV_PAR12)
		Private cAteTipo     := IIf(lPosicionado, SE1->E1_TIPO,    MV_PAR13)
		Private dDaEmissao   := MV_PAR14
		Private dAteEmissao  := MV_PAR15
		Private dDoVencRea   := MV_PAR16
		Private dAteVencRea  := MV_PAR17
		Private cDoNumBor    := MV_PAR18
		Private cAteNumBor   := MV_PAR19
		Private cDoCliente   := MV_PAR20
		Private cDaLoja      := MV_PAR21
		Private cAteCliente  := MV_PAR22
		Private cAteLoja     := MV_PAR23
		Private nTipoPDF     := MV_PAR24
		Private lEmail       := (MV_PAR25 = 2)


		If lForma
			Private cForma		:= IIf(lPosicionado, SE1->E1_FORMA, MV_PAR26)
		EndIf

		If lSegundaVia
			nSegVia		:=	 MV_PAR27
		EndIf

		Private nPosBcoHml   := 0
		Private lIniImp      := .F.

		If	lEmail

			lBlind := .T.
			If	nTipoPDF = 1
				nTipoPDF := 2
			EndIf

		EndIf

		If	F001ValParam()

			Processa( {|| F001Proc( @oBoleto, @oSetup, @lExistBol, @lBlind,""  ) }, "Impressao de Boletos" ,"Aguarde...." )

		EndIf

	EndIf

	If	!lSetCentury

		__SetCentury("OFF")

	EndIf

	RestArea(aArea)
	dbSelectArea(nAlias)

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ TRSF001C ³ Autor ³ Fabio Briddi          ³ Data ³ Jul/2014 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Chamada da Funcao de Processamento de Impressao de Boletos ³±±
±±³          ³ Bancarios por Rotinas Diversas fora da TRSF001.PRW         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TRSF001 - Programa Principal                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

/*
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Array com os Paramentros dos Titulos a Serem Impressos³
//³                                                      ³
//³Manter essa Ordem                                     ³
//³                                                      ³
//³01 - Prefixo Inicial                                  ³
//³02 - Prefixo Final                                    ³
//³03 - Titulo Inical                                    ³
//³04 - Titulo Final                                     ³
//³05 - Parcela Inicial                                  ³
//³06 - Parcela Final                                    ³
//³07 - Tipo Titulo Inicial                              ³
//³08 - Tipo Titulo Final                                ³
//³09 - Data Emissao Inicial                             ³
//³10 - Data Emissao Final                               ³
//³11 - Data Vencimento Real Inicial                     ³
//³12 - Data Vencimento Real Final                       ³
//³13 - Bordero Inicial                                  ³
//³14 - Bordero Final                                    ³
//³15 - Cliente Inicial                                  ³
//³16 - Loja Inicial                                     ³
//³17 - Cliente Inicial                                  ³
//³18 - Loja Inicial                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/

User Function TRSF001C( aTitBol, aBcoBol )

	Local   aArea       := GetArea()
	Local   aAreaSE1    := SE1->(GetArea())
	Local   aAreaSA1    := SA1->(GetArea())
	Local   aAreaSA6    := SA6->(GetArea())
	Local   aAreaSEE    := SEE->(GetArea())
	Local   nAlias      := Select()
	Local   lBcoPar     := .T.
	Local   lSetCentury := __SetCentury()
	Local   oBoleto     := Nil
	Local   oSetup      := Nil
	Local   lExistBol   := .F.

	Private lAmbHml     := (SM0->M0_CODIGO=="99")
	Private lBCLI       := .F.

	//=====================//
	// Tratamento de Forma //
	//=====================//
	Private lForma		:= .F. //Forma de Pagamento Não ï¿½ considerada em pontos de entrada
	//=======================================//
	// Tratamento de impressï¿½o de segunda via//
	//=======================================//
	Private lSegundaVia	:= .F. //Segunda via de boleto Não serï¿½ considerado em pontos de entrada
	Private nSegVia		:= 0

	If	!lSetCentury
		__SetCentury("ON")
	EndIf

	If	(ValType(aTitBol) = "A" .And. ValType(aBcoBol) = "A") .And.;
			(Len(aTitBol) = 18 .And. Len(aBcoBol) = 4)

		Private cBanco       := PadR( aBcoBol[01] , TamSX3("EE_CODIGO")[1] )
		Private cAgencia     := PadR( aBcoBol[02] , TamSX3("EE_AGENCIA")[1] )
		Private cConta       := PadR( aBcoBol[03] , TamSX3("EE_CONTA")[1] )
		Private cSubCta      := PadR( aBcoBol[04] , TamSX3("EE_SUBCTA")[1] )
		Private lPosicionado := .F.
		Private cDoPrefixo   := PadR( aTitBol[01] , TamSX3("E1_PREFIXO")[1] )
		Private cAtePrefixo  := PadR( aTitBol[02] , TamSX3("E1_PREFIXO")[1] )
		Private cDoNum       := PadR( aTitBol[03] , TamSX3("E1_NUM")[1] )
		Private cAteNum      := PadR( aTitBol[04] , TamSX3("E1_NUM")[1] )
		Private cDaParcela   := PadR( aTitBol[05] , TamSX3("E1_PARCELA")[1] )
		Private cAteParcel   := PadR( aTitBol[06] , TamSX3("E1_PARCELA")[1] )
		Private cDoTipo      := PadR( aTitBol[07] , TamSX3("E1_TIPO")[1] )
		Private cAteTipo     := PadR( aTitBol[08] , TamSX3("E1_TIPO")[1] )
		Private dDaEmissao   := aTitBol[09]
		Private dAteEmissao  := aTitBol[10]
		Private dDoVencRea   := aTitBol[11]
		Private dAteVencRea  := aTitBol[12]
		Private cDoNumBor    := PadR( aTitBol[13] , TamSX3("E1_NUMBOR")[1] )
		Private cAteNumBor   := PadR( aTitBol[14] , TamSX3("E1_NUMBOR")[1] )
		Private cDoCliente   := PadR( aTitBol[15] , TamSX3("E1_CLIENTE")[1] )
		Private cDaLoja		 := PadR( aTitBol[16] , TamSX3("E1_LOJA")[1] )
		Private cAteCliente  := PadR( aTitBol[17] , TamSX3("E1_CLIENTE")[1] )
		Private cAteLoja     := PadR( aTitBol[18] , TamSX3("E1_LOJA")[1] )
		Private nTipoPDF     := 1
		Private lEmail       := .F.

		Private nPosBcoHml   := 0
		Private lIniImp      := .F.

		If	F001ValParam()

			Processa( {|| F001Proc( @oBoleto, @oSetup, @lExistBol, .F.,""  ) }, "Impressao de Boletos" ,"Aguarde...." )

		EndIf

		If	ValType(oBoleto) = "O" .And. nTipoPDF = 1

			If	oBoleto:nDevice = IMP_PDF .And. lExistBol

				oBoleto:Preview()

			EndIf

			FreeObj(oBoleto)
			FreeObj(oSetup)
			oBoleto   := Nil
			oSetup    := Nil
			lExistBol := .F.

		EndIf

	EndIf

	If	!lSetCentury

		__SetCentury("OFF")

	EndIf

	RestArea(aArea)
	dbSelectArea(nAlias)

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ TRSF001D ³ Autor ³ Denis Rodrigues       ³ Data ³ Dez/2014 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Chamada da Funcao de Processamento de Impressao de Boletos ³±±
±±³          ³ Bancarios pelo WebServices                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TRSF001 - Programa Principal                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

/*
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Array com os Paramentros dos Titulos a Serem Impressos³
//³                                                      ³
//³Manter essa Ordem                                     ³
//³                                                      ³
//³01 - Prefixo Inicial                                  ³
//³02 - Prefixo Final                                    ³
//³03 - Titulo Inical                                    ³
//³04 - Titulo Final                                     ³
//³05 - Parcela Inicial                                  ³
//³06 - Parcela Final                                    ³
//³07 - Tipo Titulo Inicial                              ³
//³08 - Tipo Titulo Final                                ³
//³09 - Data Emissao Inicial                             ³
//³10 - Data Emissao Final                               ³
//³11 - Data Vencimento Real Inicial                     ³
//³12 - Data Vencimento Real Final                       ³
//³13 - Bordero Inicial                                  ³
//³14 - Bordero Final                                    ³
//³15 - Cliente Inicial                                  ³
//³16 - Loja Inicial                                     ³
//³17 - Cliente Inicial                                  ³
//³18 - Loja Inicial                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/

User Function TRSF001D( aTitBol, aBcoBol, oBoleto, lEmailWS )

	Local   aArea       := GetArea()
	Local   aAreaSE1    := SE1->(GetArea())
	Local   aAreaSA1    := SA1->(GetArea())
	Local   aAreaSA6    := SA6->(GetArea())
	Local   aAreaSEE    := SEE->(GetArea())
	Local   nAlias      := Select()
	Local   lBcoPar     := .T.
	Local   lSetCentury := __SetCentury()
	Local   oSetup      := Nil
	Local   lExistBol   := .T.
	Local	cNomRot     := "TRSF001D"

	Private lAmbHml     := (SM0->M0_CODIGO=="99")
	Private lBCLI       := .F.

	//=====================//
	// Tratamento de Forma //
	//=====================//
	Private lForma		:= .F. //Forma de Pagamento nao e considerada no WebService
	//===========================//
	// Tratamento de Segunda Via //
	//===========================//
	Private lSegundaVia	:= .F. //Segunda Via de boleto nao sera considerado no WebService
	Private nSegVia		:= 0

	If	!lSetCentury
		__SetCentury("ON")
	EndIf

	If	(ValType(aTitBol) = "A" .And. ValType(aBcoBol) = "A") .And.;
			(Len(aTitBol) = 18 .And. Len(aBcoBol) = 4)

		Private cBanco       := PadR( aBcoBol[01] , TamSX3("EE_CODIGO")[1] )
		Private cAgencia     := PadR( aBcoBol[02] , TamSX3("EE_AGENCIA")[1] )
		Private cConta       := PadR( aBcoBol[03] , TamSX3("EE_CONTA")[1] )
		Private cSubCta      := PadR( aBcoBol[04] , TamSX3("EE_SUBCTA")[1] )
		Private lPosicionado := .F.
		Private cDoPrefixo   := PadR( aTitBol[01] , TamSX3("E1_PREFIXO")[1] )
		Private cAtePrefixo  := PadR( aTitBol[02] , TamSX3("E1_PREFIXO")[1] )
		Private cDoNum       := PadR( aTitBol[03] , TamSX3("E1_NUM")[1] )
		Private cAteNum      := PadR( aTitBol[04] , TamSX3("E1_NUM")[1] )
		Private cDaParcela   := PadR( aTitBol[05] , TamSX3("E1_PARCELA")[1] )
		Private cAteParcel   := PadR( aTitBol[06] , TamSX3("E1_PARCELA")[1] )
		Private cDoTipo      := PadR( aTitBol[07] , TamSX3("E1_TIPO")[1] )
		Private cAteTipo     := PadR( aTitBol[08] , TamSX3("E1_TIPO")[1] )
		Private dDaEmissao   := aTitBol[09]
		Private dAteEmissao  := aTitBol[10]
		Private dDoVencRea   := aTitBol[11]
		Private dAteVencRea  := aTitBol[12]
		Private cDoNumBor    := PadR( aTitBol[13] , TamSX3("E1_NUMBOR")[1] )
		Private cAteNumBor   := PadR( aTitBol[14] , TamSX3("E1_NUMBOR")[1] )
		Private cDoCliente   := PadR( aTitBol[15] , TamSX3("E1_CLIENTE")[1] )
		Private cDaLoja      := PadR( aTitBol[16] , TamSX3("E1_LOJA")[1] )
		Private cAteCliente  := PadR( aTitBol[17] , TamSX3("E1_CLIENTE")[1] )
		Private cAteLoja     := PadR( aTitBol[18] , TamSX3("E1_LOJA")[1] )
		Private nTipoPDF     := 1
		Private lEmail       := .F.
		Private nPosBcoHml   := 0
		Private lIniImp      := .F.

		Default lEmailWS 	:= .F.


		//+-------------------------------------+
		//| Denis Rodrigues - 08/09/2020        |
		//| Envia o e-mail caso seja passado na |
		//| chamada o parametro TRUE            |
		//+-------------------------------------+
		If lEmailWS

			lEmail  := lEmailWS
			cNomRot := "TRSF001D"

		EndIf

		dbSelectArea("SEE")
		dbSetOrder(1)	//-- EE_FILIAL+EE_CODIGO+EE_AGENCIA+EE_CONTA+EE_SUBCTA
		dbSeek( xFilial("SEE") + cBanco + cAgencia + cConta + cSubCta )

		F001Proc( @oBoleto, @oSetup, @lExistBol, .T.,cNomRot )

	EndIf

	If	!lSetCentury

		__SetCentury("OFF")

	EndIf

	RestArea(aArea)
	dbSelectArea(nAlias)

Return( oBoleto )
/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
	±±³Funcao    ³ F001ValParam ³ Autor ³ Fabio Briddi      ³ Data ³ Nov/2013 ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Descricao ³ Validacao dos Parametros informados                        ³±±
	±±³          ³                                                            ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Parametros³                                                            ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Retorno   ³                                                            ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Retorno   ³ Nenhum                                                     ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Uso       ³ TRSF001 - Programa Principal                               ³±±
	±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function F001ValParam()

	Local lRet    := .T.
	Local lBcoCorr:= .T.
	Local cMsg    := ""
	Local nPosHml := 0

	If	( nPosBcoHml := aScan( BANCO_HML, {|x| x[1] == cBanco } ) ) = 0

		cMsg := "Banco não Homologado nessa Versão do TRSF001" + CRLF
		Help( "", 1, "TRSF001|PARAM01", , cMsg, 1, 0 )

		lRet := .F.

	EndIf

	If	lRet

		//-- Verifica se Empresa esta autorizada a imprimir
		aDadosAux := { "TRSF001", SM0->M0_CGC, cBanco }
		aRet := u_SFAUTORI( aDadosAux )

		If	!aRet[1]

			cMsg += aRet[2]
			Help( "", 1, "TRSF001|AUTORIZ", , cMsg, 1, 0 )

			lRet := .F.
		EndIf

	EndIf

	If lRet

		//-- Verifica se a forma ï¿½ compatï¿½vel com a pergunta, mesmo na opï¿½ï¿½o posicionado
		If lForma

			If (lPosicionado) .AND. (AllTrim(SE1->E1_FORMA) <> AllTrim(MV_PAR26))
				cMsg := "Parâmetro:" + CRLF
				cMsg += "Forma Pagto." + CRLF
				cMsg += "Não é compativel com o registro posicionado" + CRLF
				Help( "", 1, "TRSF001|PARAM26", , cMsg, 1, 0 )
				lRet := .F.
			EndIf

		EndIf

	EndIf

	// Validaï¿½ï¿½o para tipo de Titulo
	// IF  !cDoTipo  $ "BOL" .and. !cAteTipo $ "BOL"
	// lRet:= .F.
	//	Help( "", 1, "ALERT TIPO", , "TESTE" 1, 0 )
	// Endif

	If	lRet
		If	Empty(cBanco) .Or.;
				Empty(cAgencia) .Or.;
				Empty(cConta) .Or.;
				Empty(cSubCta)

			cMsg := "Parâmetros:" + CRLF
			cMsg += IIf(Empty(cBanco),"Banco" + CRLF,"")
			cMsg += IIf(Empty(cAgencia),"Agência" + CRLF,"")
			cMsg += IIf(Empty(cConta),"Conta" + CRLF,"")
			cMsg += IIf(Empty(cSubCta),"SubConta" + CRLF,"")
			cMsg += "Em Branco" + CRLF
			Help( "", 1, "TRSF001|PARAM02", , cMsg, 1, 0 )

			lRet := .F.

		EndIf
	EndIf

	If	lRet
		//-- Posiciona SA6 - Bancos
		DbSelectArea("SA6")
		DbSetOrder(1)
		If	!dbSeek(xFilial('SA6') + cBanco + cAgencia + cConta)

			cMsg := "Parâmetros:" + CRLF
			cMsg += "Banco/Agência/Conta" + CRLF
			cMsg += "Não Cadastrado (Tabela SA6)" + CRLF
			Help( "", 1, "TRSF001|PARAM03", , cMsg, 1, 0 )

			lRet := .F.
		Else
			//-- Posiciona SEE - Parametros/Configuracoes de Bancos
			DbSelectArea("SEE")
			DbSetOrder(1)
			If	!DbSeek(xFilial("SEE") + cBanco + cAgencia + cConta + cSubCta)

				cMsg := "Parâmetros:" + CRLF
				cMsg += "Banco/Agência/Conta" + CRLF
				cMsg += "Não Cadastrados (Tabela SEE)" + CRLF
				Help( "", 1, "TRSF001|PARAM04", , cMsg, 1, 0 )

				lRet := .F.

			EndIf

		EndIf

	EndIf

	If	lRet
		If	Empty(SEE->EE_FAXATU) .Or.;
				(Empty(SEE->EE_NOME).AND. !cBanco = BANRISUL)  .Or.;
				Empty(SEE->EE_CODCART) .Or.;
				Empty(SEE->EE_ACEITE)

			cMsg := "Campos em Branco (Tabela SEE) Parâmetros de Bancos" + CRLF
			cMsg += IIf(Empty(SEE->EE_FAXATU),"Faixa Atual" + CRLF,"")
			cMsg += IIf(Empty(SEE->EE_NOME),"Nome do Banco" + CRLF,"")
			cMsg += IIf(Empty(SEE->EE_CODCART),"Cod Carteira" + CRLF,"")
			cMsg += IIf(Empty(SEE->EE_ACEITE),"Aceite" + CRLF,"")
			cMsg += CRLF + "Altere o Cadastro e Execute novamente a Rotina" + CRLF
			Help( "", 1, "TRSF001|PARAM05", , cMsg, 1, 0 )

			lRet := .F.

		EndIf

	EndIf

	If	lRet
		If	((cBanco = FIBRA       .Or.;
				cBanco = REDASSET    .Or.;
				cBanco = BBM         .Or.;
				cBanco = VOTORANTIM) .And.;
				Empty(SEE->EE_CODCOR)) .Or.;
				(cBanco = SAFRA .And. SEE->EE_CODCART = "09" .And. Empty(SEE->EE_CODCOR))

			cMsg := "Campos em Branco (Tabela SEE) Parâmetros de Bancos" + CRLF
			cMsg += IIf(Empty(SEE->EE_CODCOR),"Banco Correspondente" + CRLF,"")
			cMsg += CRLF + "Este Banco utiliza impressão por Banco Correspondente." + CRLF
			cMsg += CRLF + "Altere o Cadastro e Execute novamente a Rotina" + CRLF
			Help( "", 1, "TRSF001|PARAM05", , cMsg, 1, 0 )

			lRet := .F.

		EndIf

	EndIf

	If	lRet
		If	!Empty(SEE->EE_CODCOR) .And.;
				(Empty(SEE->EE_AGECOR) .Or.;
				Empty(SEE->EE_CTACOR) .Or.;
				Empty(SEE->EE_NOMECOR))

			cMsg := "Campos em Branco (Tabela SEE) Parâmetros de Bancos" + CRLF
			cMsg += IIf(Empty(SEE->EE_AGECOR),"Agência Banco Correspondente" + CRLF,"")
			cMsg += IIf(Empty(SEE->EE_CTACOR),"Conta Banco Correspondente " + CRLF,"")
			cMsg += IIf(Empty(SEE->EE_NOMECOR),"Nome do Banco Correspondente" + CRLF,"")
			cMsg += CRLF + "Altere o Cadastro e Execute novamente a Rotina" + CRLF
			Help( "", 1, "TRSF001|PARAM05", , cMsg, 1, 0 )

			lRet := .F.

		EndIf

	EndIf

	If	lRet

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Validacao especifica para cada Banco  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		If		cBanco = BRASIL

			If	Len(AllTrim(SEE->EE_FAXATU))  <> 05 .And.;
					Len(AllTrim(SEE->EE_FAXATU))  <> 07 .And.;
					Len(AllTrim(SEE->EE_FAXATU))  <> 10 .Or.;
					Len(AllTrim(SEE->EE_AGENCIA)) <> 04 .Or.;
					Len(AllTrim(SEE->EE_CONTA))    < 04 .And.;
					Len(AllTrim(SEE->EE_CONTA))    > 08 .Or.;
					Len(AllTrim(SEE->EE_CODCART)) <> 02 .Or.;
					Len(AllTrim(SEE->EE_CODEMP))  <> 04 .And.;
					Len(AllTrim(SEE->EE_CODEMP))  <> 06 .And.;
					Len(AllTrim(SEE->EE_CODEMP))  <> 07

				cMsg := "Campos com o conteúdo de tamanho Divergente (Tabela SEE) Parâmetros de Bancos" + CRLF
				cMsg += IIf(Len(AllTrim(SEE->EE_AGENCIA))<>04,"Agência (4)"       + CRLF,"")
				cMsg += IIf(Len(AllTrim(SEE->EE_CONTA))  < 04 .And.;
					Len(AllTrim(SEE->EE_CONTA))  > 08,"Conta (8)"         + CRLF,"")
				cMsg += IIf(Len(AllTrim(SEE->EE_FAXATU)) <>05 .And.;
					Len(AllTrim(SEE->EE_FAXATU)) <>07 .And.;
					Len(AllTrim(SEE->EE_FAXATU)) <>10,"Faixa Atual (10)"  + CRLF,"")
				cMsg += IIf(Len(AllTrim(SEE->EE_CODCART))<>02,"Cod Carteira (2)"  + CRLF,"")
				cMsg += IIf(Len(AllTrim(SEE->EE_CODEMP)) <>04 .And.;
					Len(AllTrim(SEE->EE_CODEMP)) <>06 .And.;
					Len(AllTrim(SEE->EE_CODEMP)) <>07,"Cod Empresa (7)"   + CRLF,"")
				cMsg += CRLF + "Altere o Cadastro e Execute novamente a Rotina" + CRLF

				lRet := .F.

			EndIf

		ElseIf cBanco = SANTANDER

			If	Len(AllTrim(SEE->EE_FAXATU))  <> 12 .Or.;
					Len(AllTrim(SEE->EE_AGENCIA)) <> 04 .Or.;
					Len(AllTrim(SEE->EE_CODEMP))  <> 07

				cMsg := "Campos com o conteudo de tamanho Divergente (Tabela SEE) Parâmetros de Bancos" + CRLF
				cMsg += IIf(Len(AllTrim(SEE->EE_AGENCIA))<>04,"Agência (4)"      + CRLF,"")
				cMsg += IIf(Len(AllTrim(SEE->EE_FAXATU)) <>12,"Faixa Atual (12)" + CRLF,"")
				cMsg += IIf(Len(AllTrim(SEE->EE_CODEMP)) <>07,"Cod Empresa (7)"  + CRLF,"")
				cMsg += CRLF + "Altere o Cadastro e Execute novamente a Rotina"  + CRLF

				lRet := .F.

			EndIf

			If	lRet
				If	!(AllTrim(SEE->EE_CODCART)  $ "101|102|201")

					cMsg += "Cod Carteira Inválido"  + CRLF
					cMsg += CRLF
					cMsg += "Use 101, 102 ou 201"  + CRLF
					lRet := .F.

				EndIf
			EndIf

		ElseIf cBanco = BANRISUL

			If	Len(AllTrim(SEE->EE_FAXATU))  <> 08 .Or.;
					Len(AllTrim(SEE->EE_AGENCIA)) <> 04 .Or.;
					Len(AllTrim(SEE->EE_CODEMP))  <> 09

				cMsg := "Campos com o conteúdo de tamanho Divergente (Tabela SEE) Parâmetros de Bancos" + CRLF
				cMsg += IIf(Len(AllTrim(SEE->EE_AGENCIA))<>04,"Agência (4)"      + CRLF,"")
				cMsg += IIf(Len(AllTrim(SEE->EE_FAXATU)) <>08,"Faixa Atual (8)"  + CRLF,"")
				cMsg += IIf(Len(AllTrim(SEE->EE_CODEMP)) <>09,"Cod Empresa (9)"  + CRLF,"")
				cMsg += CRLF + "Altere o Cadastro e Execute novamente a Rotina" + CRLF

				lRet := .F.

			EndIf

		ElseIf cBanco = CAIXA

			cMsg := ""

			If	!(AllTrim(SEE->EE_CODCART)  $ "RG|SR")

				cMsg += "Cod Carteira Inválido"  + CRLF
				cMsg += CRLF
				cMsg += "Use RG ou SR"  + CRLF
				lRet := .F.

			EndIf

			If	lRet

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Para a Caixa o Nosso Numero eh tamanho 15, nas primeiras versoes foram alterados os campos para 15. ³
				//³ Mas, por  de dicionarios em versoes do Protheus passei a tratar somente com 12.             ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

				If	(Len(AllTrim(SEE->EE_FAXATU)) <> 15 .And. Len(AllTrim(SEE->EE_FAXATU)) <> 12) .Or.;
						Len(AllTrim(SEE->EE_CODCART)) <> 02 .Or.;
						Len(AllTrim(SEE->EE_AGENCIA)) <> 04 //.Or.;
						//Len(AllTrim(SEE->EE_CODEMP))  <> 06

					cMsg := "Campos com conteúdo de tamanho Divergente (Tabela SEE) Parâmetros de Bancos" + CRLF
					cMsg += IIf(Len(AllTrim(SEE->EE_AGENCIA))<>04,"Agência (4)"      + CRLF,"")
					cMsg += IIf((Len(AllTrim(SEE->EE_FAXATU))<>15 .And.;
						Len(AllTrim(SEE->EE_FAXATU))<>12),"Faixa Atual (12)" + CRLF,"")
					cMsg += IIf(Len(AllTrim(SEE->EE_CODCART))<>02,"Cod Carteira (2)"  + CRLF,"")
					//cMsg += IIf(Len(AllTrim(SEE->EE_CODEMP)) <>06,"Cod Empresa (6)"   + CRLF,"")
					cMsg += CRLF + "Altere o Cadastro e Execute novamente a Rotina"   + CRLF

					lRet := .F.

				EndIf
			EndIf

		ElseIf cBanco = BRADESCO

			If	Len(AllTrim(SEE->EE_FAXATU))  <> 11 .Or.;
					Len(AllTrim(SEE->EE_CODCART)) <> 02 .Or.;
					Len(AllTrim(SEE->EE_AGENCIA)) <> 04 .Or.;
					Len(AllTrim(SEE->EE_CONTA))   <> 07

				cMsg := "Campos com o conteúdo de tamanho Divergente (Tabela SEE) Parâmetros de Bancos" + CRLF
				cMsg += IIf(Len(AllTrim(SEE->EE_AGENCIA))<>04,"Agência (4)"       + CRLF,"")
				cMsg += IIf(Len(AllTrim(SEE->EE_CONTA))  <>07,"Conta (7)"         + CRLF,"")
				cMsg += IIf(Len(AllTrim(SEE->EE_FAXATU)) <>11,"Faixa Atual (11)"  + CRLF,"")
				cMsg += IIf(Len(AllTrim(SEE->EE_CODCART))<>02,"Cod Carteira (2)"  + CRLF,"")
				cMsg += CRLF + "Altere o Cadastro e Execute novamente a Rotina"   + CRLF

				lRet := .F.

			EndIf


		ElseIf	cBanco = ITAU

			If	Len(AllTrim(SEE->EE_FAXATU))  <> 8 .Or.;
					Len(AllTrim(SEE->EE_CODCART)) <> 3 .Or.;
					Len(AllTrim(SEE->EE_AGENCIA)) <> 4 .Or.;
					Len(AllTrim(SEE->EE_CONTA))   <> 5

				cMsg := "Campos com o conteudo de tamanho Divergente (Tabela SEE) Parâmetros de Bancos" + CRLF
				cMsg += IIf(Len(AllTrim(SEE->EE_AGENCIA))<>04,"Agência (4)"      + CRLF,"")
				cMsg += IIf(Len(AllTrim(SEE->EE_CONTA))  <>05,"Conta (5)"        + CRLF,"")
				cMsg += IIf(Len(AllTrim(SEE->EE_FAXATU)) <>08,"Faixa Atual (8)"  + CRLF,"")
				cMsg += IIf(Len(AllTrim(SEE->EE_CODCART))<>03,"Cod Carteira (3)" + CRLF,"")
				cMsg += CRLF + "Altere o Cadastro e Execute novamente a Rotina"  + CRLF

				lRet := .F.

			EndIf

		ElseIf	cBanco = HSBC

			cMsg := ""

			If	!(AllTrim(SEE->EE_CODCART)  $ "CNR|CSB")

				cMsg += "Cod Carteira Inválido"  + CRLF
				cMsg += CRLF
				cMsg += "Use CNR ou CSB"  + CRLF
				lRet := .F.

			EndIf

			If	lRet
				If	Len(AllTrim(SEE->EE_CODCART)) <> 03 .Or.;
						Len(AllTrim(SEE->EE_AGENCIA)) <> 04 .Or.;
						Len(AllTrim(SEE->EE_CODEMP))  <> 07

					cMsg += IIf(Len(AllTrim(SEE->EE_AGENCIA))<>04,"Agência"      + CRLF,"")
					cMsg += IIf(Len(AllTrim(SEE->EE_CODCART))<>03,"Cod Carteira" + CRLF,"")
					cMsg += IIf(Len(AllTrim(SEE->EE_CODEMP)) <>07,"Cod Empresa"  + CRLF,"")
					lRet := .F.

				Else
					If	(SEE->EE_CODCART = "CNR" .And. Len(AllTrim(SEE->EE_FAXATU))  <> 08) .Or.;
							(SEE->EE_CODCART = "CSB" .And. Len(AllTrim(SEE->EE_FAXATU))  <> 10)

						cMsg += "Faixa Atual"  + CRLF
						lRet := .F.

					EndIf

				EndIf

			EndIf

			If	!lRet

				cMsg := "Campos com tamanhos ou conteudo Divergentes (Tabela SEE) Parâmetros de Bancos" + CRLF + cMsg
				cMsg += CRLF + "Altere o Cadastro e Execute novamente a Rotina" + CRLF

			EndIf


		ElseIf cBanco = SAFRA

			cMsg := ""

			If	!(AllTrim(SEE->EE_CODCART)  $ "01|06|09|02") //Incluido em 13/0/2021 a carteira 02 -PAOLA

				cMsg += "Cod Carteira Inválido"  + CRLF
				cMsg += CRLF
				cMsg += "Use 01, 06 ,02 ou 09"  + CRLF
				lRet := .F.

			EndIf

			If lRet .And. AllTrim(SEE->EE_CODCART) = "06" //-- COBRANCA EXPRESS

				If	Len(AllTrim(SEE->EE_FAXATU))  <> 10 .Or.;
						Len(AllTrim(SEE->EE_CODCART)) <> 02 .Or.;
						Len(AllTrim(SEE->EE_AGENCIA)) <> 05 .Or.;
						Len(AllTrim(SEE->EE_CODEMP))  <> 06 .Or.;
						Len(AllTrim(SEE->EE_CONTA))   <> 09

					cMsg := "Campos com o conteúdo de tamanho Divergente (Tabela SEE) Parâmetros de Bancos" + CRLF
					cMsg += IIf(Len(AllTrim(SEE->EE_AGENCIA))<>05,"Agência (6)"      + CRLF,"")
					cMsg += IIf(Len(AllTrim(SEE->EE_CONTA))  <>09,"Conta (9)"        + CRLF,"")
					cMsg += IIf(Len(AllTrim(SEE->EE_FAXATU)) <>10,"Faixa Atual (10)" + CRLF,"")
					cMsg += IIf(Len(AllTrim(SEE->EE_CODCART))<>02,"Cod Carteira (2)" + CRLF,"")
					cMsg += IIf(Len(AllTrim(SEE->EE_CODEMP)) <>06,"Cod Empresa (6)"  + CRLF,"")
					cMsg += CRLF + "Altere o Cadastro e Execute novamente a Rotina"  + CRLF

					lRet := .F.

				EndIf

			ElseIf lRet .And. (AllTrim(SEE->EE_CODCART)  $ "01|02")  //AllTrim(SEE->EE_CODCART) = "01" //-- COBRANCA
				//Alterado Paola 13.08.2021

				If	Len(AllTrim(SEE->EE_FAXATU))  <> 08 .Or.;
						Len(AllTrim(SEE->EE_CODCART)) <> 02 .Or.;
						Len(AllTrim(SEE->EE_AGENCIA)) <> 05 .Or.;
						Len(AllTrim(SEE->EE_CONTA))   <> 09

					cMsg := "Campos com o conteúdo de tamanho Divergente (Tabela SEE) Parâmetros de Bancos" + CRLF
					cMsg += IIf(Len(AllTrim(SEE->EE_AGENCIA))<>05,"Agência (5)"      + CRLF,"")
					cMsg += IIf(Len(AllTrim(SEE->EE_CONTA))   >09,"Conta (9)"        + CRLF,"")
					cMsg += IIf(Len(AllTrim(SEE->EE_FAXATU)) <>08,"Faixa Atual (8)"  + CRLF,"")
					cMsg += IIf(Len(AllTrim(SEE->EE_CODCART))<>02,"Cod Carteira (2)" + CRLF,"")
					cMsg += CRLF + "Altere o Cadastro e Execute novamente a Rotina"  + CRLF

					lRet := .F.

				EndIf

			ElseIf lRet .And. AllTrim(SEE->EE_CODCART) = "09"  //-- COBRANCA CORRESPONDENTE BRADESCO

				If AllTrim(SEE->EE_CODCOR)  = BRADESCO

					If	Len(AllTrim(SEE->EE_FAXATU))  <> 08 .Or.;
							Len(AllTrim(SEE->EE_CODCART)) <> 02 .Or.;
							Len(AllTrim(SEE->EE_AGENCIA)) <> 05 .Or.;
							Len(AllTrim(SEE->EE_CONTA))   <> 09 .Or.;
							Len(AllTrim(SEE->EE_AGECOR))  <> 04 .Or.;
							Len(AllTrim(SEE->EE_CTACOR))  <> 07 .Or.;
							Empty(SEE->EE_NOMECOR)

						cMsg := "Campos com o conteúdo de tamanho Divergente (Tabela SEE) Parâmetros de Bancos" + CRLF
						cMsg += IIf(Len(AllTrim(SEE->EE_AGENCIA))<>05,"Agência (5)"               + CRLF,"")
						cMsg += IIf(Len(AllTrim(SEE->EE_CONTA))  <>09,"Conta (9)"                 + CRLF,"")
						cMsg += IIf(Len(AllTrim(SEE->EE_FAXATU)) <>08,"Faixa Atual (8)"           + CRLF,"")
						cMsg += IIf(Len(AllTrim(SEE->EE_CODCART))<>02,"Cod Carteira (2)"          + CRLF,"")
						cMsg += IIf(Len(AllTrim(SEE->EE_AGECOR)) <>04,"Agência Correspondente (4)"+ CRLF,"")
						cMsg += IIf(Len(AllTrim(SEE->EE_CTACOR)) <>07,"Conta Correspondente (7)"  + CRLF,"")
						cMsg += IIf(Empty(SEE->EE_NOMECOR)           ,"Nome Banco Corresp."   + CRLF,"")
						cMsg += CRLF + "Altere o Cadastro e Execute novamente a Rotina"       + CRLF

						lRet := .F.

					EndIf

				Else

					lBcoCorr := .F.
					lRet     := .F.

				EndIf

			EndIf

		ElseIf cBanco = FIBRA

			cMsg := ""

			If	!(AllTrim(SEE->EE_CODCART)  $ "19")

				cMsg += "Cod Carteira Inválido"  + CRLF
				cMsg += CRLF
				cMsg += "Use 19"  + CRLF
				lRet := .F.

			EndIf

			If lRet .And. AllTrim(SEE->EE_CODCART) = "19" //-- COBRANCA CORRESPONDENTE BRADESCO

				If AllTrim(SEE->EE_CODCOR) = BRADESCO

					If	Len(AllTrim(SEE->EE_FAXATU))  <> 11 .Or.;
							Len(AllTrim(SEE->EE_CODCART)) <> 02 .Or.;
							Len(AllTrim(SEE->EE_AGENCIA)) <> 04 .Or.;
							Len(AllTrim(SEE->EE_CONTA))   <> 07 .Or.;
							Len(AllTrim(SEE->EE_AGECOR))  <> 04 .Or.;
							Len(AllTrim(SEE->EE_CTACOR))  <> 07 .Or.;
							Empty(SEE->EE_NOMECOR)

						cMsg := "Campos com o conteúdo de tamanho Divergente (Tabela SEE) Parâmetros de Bancos" + CRLF
						cMsg += IIf(Len(AllTrim(SEE->EE_AGENCIA))<>04,"Agência (4)"               + CRLF,"")
						cMsg += IIf(Len(AllTrim(SEE->EE_CONTA))  <>07,"Conta (7)"                 + CRLF,"")
						cMsg += IIf(Len(AllTrim(SEE->EE_FAXATU)) <>11,"Faixa Atual (11)"          + CRLF,"")
						cMsg += IIf(Len(AllTrim(SEE->EE_CODCART))<>02,"Cod Carteira (2)"          + CRLF,"")
						cMsg += IIf(Len(AllTrim(SEE->EE_AGECOR)) <>04,"Agência Correspondente (4)"+ CRLF,"")
						cMsg += IIf(Len(AllTrim(SEE->EE_CTACOR)) <>07,"Conta Correspondente (7)"  + CRLF,"")
						cMsg += IIf(Empty(SEE->EE_NOMECOR)           ,"Nome Banco Corresp."   + CRLF,"")
						cMsg += CRLF + "Altere o Cadastro e Execute novamente a Rotina"       + CRLF

						lRet := .F.

					EndIf

				Else

					lBcoCorr := .F.
					lRet     := .F.

				EndIf

			EndIf

		ElseIf cBanco = SICREDI

			If	AllTrim(SEE->EE_CODCART) <> "1"

				cMsg += "Cod Carteira Inválido"  + CRLF
				cMsg += CRLF
				cMsg += "Use 1"  + CRLF
				lRet := .F.

			EndIf
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ O Sicredi possui um codigo referente ao posto/agencia da  ³
			//³ agencia do beneficiario. Para isso, devera ser criado no  ³
			//³ configurador o campo EE_POSTO, conforme boletim tecnico.  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

			If	Len(AllTrim(SEE->EE_POSTO))   <> 02 .Or.;
					Len(AllTrim(SEE->EE_FAXATU))  <> 05 .Or.;
					Len(AllTrim(SEE->EE_CODCART)) <> 01 .Or.;
					Len(AllTrim(SEE->EE_AGENCIA)) <> 04 .Or.;
					Len(AllTrim(SEE->EE_CONTA))   <> 05

				cMsg := "Campos com o conteúdo de tamanho Divergente (Tabela SEE) Parâmetros de Bancos" + CRLF
				cMsg += IIf(Len(AllTrim(SEE->EE_AGENCIA))<>04,"Agência (4)"      + CRLF,"")
				cMsg += IIf(Len(AllTrim(SEE->EE_CONTA))  <>05,"Conta (5)"        + CRLF,"")
				cMsg += IIf(Len(AllTrim(SEE->EE_FAXATU)) <>05,"Faixa Atual (5)"  + CRLF,"")
				cMsg += IIf(Len(AllTrim(SEE->EE_POSTO))  <>01,"Cod Carteira (1)" + CRLF,"")
				cMsg += IIf(Len(AllTrim(SEE->EE_CODEMP)) <>02,"Cod Empresa (2)"  + CRLF,"")
				cMsg += CRLF + "Altere o Cadastro e Execute novamente a Rotina"  + CRLF

				lRet := .F.

			EndIf

		ElseIf cBanco = REDASSET

			cMsg := ""

			If	!(AllTrim(SEE->EE_CODCART)  $ "09")

				cMsg += "Cod Carteira Inválido"  + CRLF
				cMsg += CRLF
				cMsg += "Use 09"  + CRLF
				lRet := .F.

			EndIf

			If lRet .And. AllTrim(SEE->EE_CODCART) = "09" //-- COBRANCA CORRESPONDENTE BRADESCO

				If AllTrim(SEE->EE_CODCOR) = BRADESCO

					If	Len(AllTrim(SEE->EE_FAXATU))  <> 11 .Or.;
							Len(AllTrim(SEE->EE_CODCART)) <> 02 .Or.;
							Len(AllTrim(SEE->EE_AGENCIA)) <> 04 .Or.;
							Len(AllTrim(SEE->EE_CONTA))   <> 07 .Or.;
							Len(AllTrim(SEE->EE_AGECOR))  <> 04 .Or.;
							Len(AllTrim(SEE->EE_CTACOR))  <> 07 .Or.;
							Empty(SEE->EE_NOMECOR)

						cMsg := "Campos com o conteúdo de tamanho Divergente (Tabela SEE) Parâmetros de Bancos" + CRLF
						cMsg += IIf(Len(AllTrim(SEE->EE_AGENCIA))<>04,"Agência (4)"           		+ CRLF,"")
						cMsg += IIf(Len(AllTrim(SEE->EE_CONTA))  <>07,"Conta (7)"             		+ CRLF,"")
						cMsg += IIf(Len(AllTrim(SEE->EE_FAXATU)) <>11,"Faixa Atual (11)"      		+ CRLF,"")
						cMsg += IIf(Len(AllTrim(SEE->EE_CODCART))<>02,"Cod Carteira (2)"      		+ CRLF,"")
						cMsg += IIf(Len(AllTrim(SEE->EE_AGECOR)) <>04,"Agência Correspondente (4)" 	+ CRLF,"")
						cMsg += IIf(Len(AllTrim(SEE->EE_CTACOR)) <>07,"Conta Correspondente (7)" 	+ CRLF,"")
						cMsg += IIf(Empty(SEE->EE_NOMECOR)           ,"Nome Banco Corresp."   		+ CRLF,"")
						cMsg += CRLF + "Altere o Cadastro e Execute novamente a Rotina"       		+ CRLF

						lRet := .F.

					EndIf

				Else

					lBcoCorr := .F.
					lRet     := .F.

				EndIf

			EndIf

		ElseIf cBanco = BBM

			cMsg := ""

			If	!(AllTrim(SEE->EE_CODCART)  $ "09")

				cMsg += "Cod Carteira Inválido"  + CRLF
				cMsg += CRLF
				cMsg += "Use 09"  + CRLF
				lRet := .F.

			EndIf

			If lRet .And. AllTrim(SEE->EE_CODCART) = "09" //-- COBRANCA CORRESPONDENTE BRADESCO

				If AllTrim(SEE->EE_CODCOR) = BRADESCO

					If	Len(AllTrim(SEE->EE_FAXATU))  <> 11 .Or.;
							Len(AllTrim(SEE->EE_CODCART)) <> 02 .Or.;
							Len(AllTrim(SEE->EE_AGENCIA)) <> 04 .Or.;
							Len(AllTrim(SEE->EE_CONTA))   <> 07 .Or.;
							Len(AllTrim(SEE->EE_AGECOR))  <> 04 .Or.;
							Len(AllTrim(SEE->EE_CTACOR))  <> 07 .Or.;
							Empty(SEE->EE_NOMECOR)

						cMsg := "Campos com o conteúdo de tamanho Divergentes (Tabela SEE) Parâmetros de Bancos" + CRLF
						cMsg += IIf(Len(AllTrim(SEE->EE_AGENCIA))<>04,"Agência (4)"                + CRLF,"")
						cMsg += IIf(Len(AllTrim(SEE->EE_CONTA))  <>07,"Conta (7)"                  + CRLF,"")
						cMsg += IIf(Len(AllTrim(SEE->EE_FAXATU)) <>11,"Faixa Atual (11)"           + CRLF,"")
						cMsg += IIf(Len(AllTrim(SEE->EE_CODCART))<>02,"Cod Carteira (2)"           + CRLF,"")
						cMsg += IIf(Len(AllTrim(SEE->EE_AGECOR)) <>04,"Agência Correspondente (4)" + CRLF,"")
						cMsg += IIf(Len(AllTrim(SEE->EE_CTACOR)) <>07,"Conta Correspondente (7)"   + CRLF,"")
						cMsg += IIf(Empty(SEE->EE_NOMECOR)           ,"Nome Banco Corresp."   + CRLF,"")
						cMsg += CRLF + "Altere o Cadastro e Execute novamente a Rotina"       + CRLF

						lRet := .F.

					EndIf

				Else

					lBcoCorr := .F.
					lRet     := .F.

				EndIf

			EndIf

		ElseIf	cBanco = ABC

			cMsg := ""

			If	!(AllTrim(SEE->EE_CODCART)  $ "109|110|121")

				cMsg += "Cod Carteira Inválido"  + CRLF
				cMsg += CRLF
				cMsg += "Use 109, 110 ou 121"  + CRLF
				lRet := .F.

			EndIf

			If AllTrim(SEE->EE_CODCART) = "109" // Banco Correspondente

				If AllTrim(SEE->EE_CODCOR) = ITAU

					If	Len(AllTrim(SEE->EE_FAXATU))  <> 08 .Or.;
							Len(AllTrim(SEE->EE_CODCART)) <> 03 .Or.;
							Len(AllTrim(SEE->EE_AGENCIA)) <> 04 .Or.;
							Len(AllTrim(SEE->EE_AGECOR))  <> 04 .Or.;
							Len(AllTrim(SEE->EE_CTACOR))  <> 07 .Or.;
							Len(AllTrim(SEE->EE_DVCTCOR)) <> 01 .Or.;
							Empty(SEE->EE_NOMECOR)

						cMsg := "Campos com o conteúdo de tamanho Divergente (Tabela SEE) Parâmetros de Bancos" + CRLF
						cMsg += IIf(Len(AllTrim(SEE->EE_AGENCIA))<>04,"Agência (4)"               + CRLF,"")
						cMsg += IIf(Len(AllTrim(SEE->EE_FAXATU)) <>08,"Faixa Atual (8)"           + CRLF,"")
						cMsg += IIf(Len(AllTrim(SEE->EE_CODCART))<>03,"Cod Carteira (3)"          + CRLF,"")
						cMsg += IIf(Len(AllTrim(SEE->EE_AGECOR)) <>04,"Agência Correspondente (4)"+ CRLF,"")
						cMsg += IIf(Len(AllTrim(SEE->EE_CTACOR)) <>07,"Conta Correspondente (5)"  + CRLF,"")
						cMsg += IIf(Len(AllTrim(SEE->EE_DVCTCOR))<>01,"Digito Conta Corresp. (1)" + CRLF,"")
						cMsg += IIf(Empty(SEE->EE_NOMECOR)           ,"Nome Banco Corresp."   + CRLF,"")
						cMsg += CRLF + "Altere o Cadastro e Execute novamente a Rotina" + CRLF

						lRet := .F.

					EndIf

				Else

					lBcoCorr := .F.
					lRet 	 := .F.

				EndIf

			ElseIf AllTrim(SEE->EE_CODCART) $ "110|121"  // Cobranca Direta

				If	Len(AllTrim(SEE->EE_FAXATU))  <> 10 .Or.;
						Len(AllTrim(SEE->EE_CODCART)) <> 03 .Or.;
						Len(AllTrim(SEE->EE_AGENCIA)) <> 04 .Or.;
						Len(AllTrim(SEE->EE_CODEMP))  <> 07

					cMsg := "Campos com o conteudo de tamanho Divergente (Tabela SEE) Parâmetros de Bancos" + CRLF
					cMsg += IIf(Len(AllTrim(SEE->EE_AGENCIA))<>04,"Agência (4)"        + CRLF,"")
					cMsg += IIf(Len(AllTrim(SEE->EE_CODEMP)) <>07,"Conta (7)"          + CRLF,"")
					cMsg += IIf(Len(AllTrim(SEE->EE_FAXATU)) <>10,"Faixa Atual (10)"   + CRLF,"")
					cMsg += IIf(Len(AllTrim(SEE->EE_CODCART))<>03,"Cod Carteira (3)"   + CRLF,"")
					cMsg += CRLF + "Altere o Cadastro e Execute novamente a Rotina" + CRLF

					lRet := .F.

				EndIf

			EndIf

		ElseIf		cBanco = VOTORANTIM

			If AllTrim(SEE->EE_CODCOR) = BRASIL

				If	Len(AllTrim(SEE->EE_FAXATU))  <> 10 .Or.;
						Len(AllTrim(SEE->EE_AGENCIA)) <> 04 .Or.;
						Len(AllTrim(SEE->EE_CONTA))   <> 09 .Or.; //Paola - 10/06/2015
					Len(AllTrim(SEE->EE_CODCART)) <> 02 .Or.;
						Len(AllTrim(SEE->EE_AGECOR))  <> 04 .Or.;
						Len(AllTrim(SEE->EE_CTACOR))  <> 05 .Or.;
						Len(AllTrim(SEE->EE_CODEMP))  <> 07

					cMsg := "Campos com o conteudo de tamanho Divergente (Tabela SEE) Parâmetros de Bancos" + CRLF
					cMsg += IIf(Len(AllTrim(SEE->EE_AGENCIA))<>04,"Agência (4)"      			+ CRLF,"")
					cMsg += IIf(Len(AllTrim(SEE->EE_CONTA))  <>05,"Conta (5)"        			+ CRLF,"")
					cMsg += IIf(Len(AllTrim(SEE->EE_FAXATU)) <>10,"Faixa Atual (10)" 			+ CRLF,"")
					cMsg += IIf(Len(AllTrim(SEE->EE_CODCART))<>02,"Cod Carteira (2)" 			+ CRLF,"")
					cMsg += IIf(Len(AllTrim(SEE->EE_AGECOR)) <>04,"Agência Correspondente (4)"	+ CRLF,"")
					cMsg += IIf(Len(AllTrim(SEE->EE_CTACOR)) <>05,"Conta Correspondente (5)" 	+ CRLF,"")
					cMsg += IIf(Len(AllTrim(SEE->EE_CODEMP)) <>07,"Cod Empresa (7)"  			+ CRLF,"")
					cMsg += CRLF + "Altere o Cadastro e Execute novamente a Rotina" + CRLF

					lRet := .F.

				EndIf

			Else

				lBcoCorr := .F.
				lRet     := .F.

			EndIf

		ElseIf		cBanco = NORDESTE

			If	Len(AllTrim(SEE->EE_FAXATU))  <> 07 .Or.;
					Len(AllTrim(SEE->EE_AGENCIA)) <> 04 .Or.;
					Len(AllTrim(SEE->EE_CONTA))   <> 07 .Or.; // cfe. pagina 4 do manual, conta DEVE possuir 7 digitos
				Len(AllTrim(SEE->EE_CODCART)) <> 02

				cMsg := "Campos com o conteúdo de tamanho Divergente (Tabela SEE) Parâmetros de Bancos" + CRLF
				cMsg += IIf(Len(AllTrim(SEE->EE_AGENCIA))<>04,"Agência (4)"      + CRLF,"")
				cMsg += IIf(Len(AllTrim(SEE->EE_CONTA))  <>07,"Conta (7)"        + CRLF,"")
				cMsg += IIf(Len(AllTrim(SEE->EE_FAXATU)) <>07,"Faixa Atual (7)"  + CRLF,"")
				cMsg += IIf(Len(AllTrim(SEE->EE_CODCART))<>02,"Cod Carteira (2)" + CRLF,"")
				cMsg += CRLF + "Altere o Cadastro e Execute novamente a Rotina" + CRLF

				lRet := .F.

			EndIf

		ElseIf		cBanco = CITIBANK

			If	Len(AllTrim(SEE->EE_FAXATU))  <> 11 .Or.;
					Len(AllTrim(SEE->EE_AGENCIA)) <> 04 .Or.;
					Len(AllTrim(SEE->EE_CONTA))   <> 09 .Or.;
					Len(AllTrim(SEE->EE_DVCTA))   <> 01 .Or.;
					Len(AllTrim(SEE->EE_CODCART)) <> 03

				cMsg := "Campos com o conteúdo de tamanho Divergente (Tabela SEE) Parâmetros de Bancos" + CRLF
				cMsg += IIf(Len(AllTrim(SEE->EE_AGENCIA))<>04,"Agência (4)"       + CRLF,"")
				cMsg += IIf(Len(AllTrim(SEE->EE_CONTA))  <>09,"Conta (9)"         + CRLF,"")
				cMsg += IIf(Len(AllTrim(SEE->EE_DVCTA))  <>01,"DV Conta (1)"      + CRLF,"")
				cMsg += IIf(Len(AllTrim(SEE->EE_FAXATU)) <>11,"Faixa Atual (11)"  + CRLF,"")
				cMsg += IIf(Len(AllTrim(SEE->EE_CODCART))<>03,"Cod Carteira (3)"  + CRLF,"")
				cMsg += CRLF + "Altere o Cadastro e Execute novamente a Rotina" + CRLF

				lRet := .F.

			EndIf
		elseif 	cBanco = SICOOB //Paola em 03.2024

			if	len(allTrim(SEE->EE_FAXATU))  <> 05 .And.;
					len(allTrim(SEE->EE_FAXATU))  <> 07 .And.;
					len(allTrim(SEE->EE_FAXATU))  <> 09 .Or.;
					len(allTrim(SEE->EE_AGENCIA)) <> 04 .Or.;
					len(allTrim(SEE->EE_CONTA))    < 04 .And.;
					len(allTrim(SEE->EE_CONTA))    > 08 .Or.;
					len(allTrim(SEE->EE_CODCART)) <> 02 .Or.;
					len(allTrim(SEE->EE_CODEMP))  <> 04 .And.;
					len(allTrim(SEE->EE_CODEMP))  <> 06 .And.;
					len(allTrim(SEE->EE_CODEMP))  <> 07

				cMsg := "Campos com tamanhos Divergentes (Tabela SEE) Par?tros de Bancos" + CRLF
				cMsg += iIf(len(allTrim(SEE->EE_AGENCIA))<>04,"Ag?ia"      + CRLF,"")
				cMsg += iIf(len(allTrim(SEE->EE_CONTA))  < 04 .And.;
					len(allTrim(SEE->EE_CONTA))  > 08,"Conta"        + CRLF,"")
				cMsg += iIf(len(allTrim(SEE->EE_FAXATU)) <>05 .And.;
					len(allTrim(SEE->EE_FAXATU)) <>07 .And.;
					len(allTrim(SEE->EE_FAXATU)) <>10,"Faixa Atual"  + CRLF,"")
				cMsg += iIf(len(allTrim(SEE->EE_CODCART))<>02,"Cod Carteira" + CRLF,"")
				cMsg += iIf(len(allTrim(SEE->EE_CODEMP)) <>04 .And.;
					len(allTrim(SEE->EE_CODEMP)) <>06 .And.;
					len(allTrim(SEE->EE_CODEMP)) <>07,"Cod Empresa"  + CRLF,"")
				cMsg += CRLF + "Altere o Cadastro e Execute novamente a Rotina" + CRLF

				lRet := .f.

			endIf


		EndIf

		If !lBcoCorr //-- Banco Correspondente invalido

			cMsg := "Banco correspondente Inválido para este tipo de carteira." + CRLF
			cMsg += CRLF + "Carteira informada: " + AllTrim(SEE->EE_CODCART)    + CRLF
			cMsg += "Banco selecionado: "         + AllTrim(SEE->EE_CODCOR)     + CRLF
			cMsg += CRLF + "Altere o Cadastro e Execute novamente a Rotina"     + CRLF

		EndIf

		If !lRet
			Help( "", 1, "TRSF001|PARAM06", , cMsg, 1, 0 )
		EndIf

	EndIf

Return(lRet)
/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
	±±³Funcao    ³ F001Proc ³ Autor ³ Fabio Briddi          ³ Data ³ Nov/2013 ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Descricao ³ Funcao de Processamento para a Impressao de Boletos        ³±±
	±±³          ³ Bancarios                                                  ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Parametros³                                                            ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Retorno   ³                                                            ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Retorno   ³ Nenhum                                                     ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Uso       ³ TRSF001 - Programa Principal                               ³±±
	±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function F001Proc( oBoleto, oSetup, lExistBol, lBlind,cNomRot )

	Local aCedente   := {}
	Local aBanco     := {}
	Local aAvalista  := {}
	Local aSacado    := {}
	Local aTitulo    := {}
	Local cAliasSE1  := GetNextAlias()
	Local cPorBco    := ""
	Local cPorAgc    := ""
	Local cPorCta    := ""
	Local cPorSub    := ""
	Local lNrEnd     := (SA1->(FieldPos("A1_NR_END"))  > 0)
	Local lNrEndC    := (SA1->(FieldPos("A1_NR_ENDC")) > 0)
	Local lComplC    := (SA1->(FieldPos("A1_COMPLEC")) > 0)
	Local lEmailBl   := (SA1->(FieldPos("A1_EMAILBL")) > 0)
	Local lImpAbat	 := (SA1->(FieldPos("A1_IMPABAT")) > 0)
	Local lAbatcli	 := .F.
	Local lStart     := .T.
	Local aTitMail   := {}
	Local aSegVia     := {}
	Local lReimprime := .T.
	Local nMsg       := 0

	Local cTempPath	:= IIf( IsBlind(), "\boletos\tmp\", GetTempPath() )
	Local cBolPath	:= "\boletos\"

	Local nValorImp	:= 0
	Local lErrSaldo	:= .F. //Variï¿½vel para tratamentos de erro de saldo apï¿½s a query
	Local cTitLiq	:= ""
	Local cMsgErr	:= ""

	Private lVlrOrigi	:= GetMv("TRS_VALIMP") = 1
	Private nDadBenf  := SuperGetMV("TRS_BOL01", .T., 2) // No caso de Banco correpondente imprime dados no beneficiario do Banco ou do beneficiario
	Private lAbatVlr  := SuperGetMV("TRS_BOL02", .T., .T.) // No caso de ter título com tipo AB- Considera no valor impresso no boleto?

	Private lVencto  := SuperGetMV("TRS_VENCTO", .T., .T.) // Vencto REAL ou vencto  na impressão e envio do email


	If	!File( cBolPath+"." )
		MakeDir( cBolPath )
	EndIf

	If	!File( cTempPath+"." )
		MakeDir( cTempPath )
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Valida Cedente                 ³
	//³e Carrega Dados Array aCedente ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	If !lBCLI
		F001Cedente( @aCedente,Nil )
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Valida Banco                   ³
	//³e Carrega Dados Array aBanco   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lSegundaVia

		If nSegVia = 1
			F001Banco( @aBanco, nil )
		EndIf

	Else
		F001Banco( @aBanco, nil )
	EndIf


	cQuery := "SELECT "
	If lBCLI
		cQuery +=       " DISTINCT(SEE.EE_CODIGO) BANCO, "
	EndIf
	cQuery +=       " E1_FILIAL, E1_TIPO, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_CLIENTE, E1_LOJA "
	cQuery +=       " ,E1_EMISSAO, E1_VENCTO, E1_VENCREA, E1_MOEDA "
	cQuery +=       " ,E1_NUMBCO, E1_PORTADO, E1_NUMBOR "
	cQuery +=       " ,E1_NUMNOTA, E1_SERIE "
	cQuery +=       " ,E1_VALOR, E1_SALDO ,E1_VLCRUZ  "
	cQuery +=       " ,E1_DECRESC, E1_SDDECRE, E1_ACRESC, E1_SDACRES "
	cQuery +=       " ,E1_MULTA, E1_JUROS "
	cQuery +=       " ,E1_IRRF, E1_ISS, E1_INSS, E1_PIS, E1_COFINS, E1_CSLL ,E1_CODCART"
	cQuery +=       IIf(lForma," ,E1_FORMA ", "")
	cQuery +=       " ,SE1.R_E_C_N_O_ AS E1_RECNO "
	cQuery +=       " ,A1_COD, A1_LOJA, A1_NOME, A1_PESSOA, A1_CGC "
	cQuery +=       " ,A1_END "
	cQuery +=       IIf(lNrEnd, ", A1_NR_END", "")
	cQuery +=       " ,A1_COMPLEM, A1_MUN, A1_EST, A1_CEP, A1_BAIRRO "
	cQuery +=       " ,A1_ENDCOB "
	cQuery +=       IIf(lNrEndC, ", A1_NR_ENDC", "")
	cQuery +=       IIf(lComplC, ", A1_COMPLEC", "")
	cQuery +=       " ,A1_MUNC, A1_ESTC, A1_BAIRROC, A1_CEPC "
	cQuery +=       " ,A1_BCO1 "
	cQuery +=       " ,A1_CONTATO "
	cQuery +=       " ,A1_EMAIL "
	cQuery +=       IIf(lEmailBl, ", A1_EMAILBL", "")

	If nSegVia = 2
		cQuery +=		" ,E1_PORBCO, E1_PORAGC, E1_PORCTA, E1_PORSUB, E1_PORDVA, E1_PORDVC "
	EndIf

	cQuery +=       " ,SA1.R_E_C_N_O_ AS A1_RECNO "
	cQuery += "FROM " + RetSqlName("SE1") + " SE1, "
	cQuery +=           RetSqlName("SA1") + " SA1 "

	If lBCLI
		cQuery += BCCLI('INNER')
	EndIf

	cQuery += "WHERE SE1.E1_FILIAL  =  '" + xFilial("SE1")    + "' "
	cQuery += "AND   SE1.E1_PREFIXO >= '" + cDoPrefixo        + "' "
	cQuery += "AND   SE1.E1_PREFIXO <= '" + cAtePrefixo       + "' "
	cQuery += "AND   SE1.E1_NUM     >= '" + cDoNum            + "' "
	cQuery += "AND   SE1.E1_NUM     <= '" + cAteNum           + "' "
	cQuery += "AND   SE1.E1_PARCELA >= '" + cDaParcela        + "' "
	cQuery += "AND   SE1.E1_PARCELA <= '" + cAteParcel       + "' "
	cQuery += "AND   SE1.E1_TIPO    >= '" + cDoTipo           + "' "
	cQuery += "AND   SE1.E1_TIPO    <= '" + cAteTipo          + "' "
	cQuery += "AND   SE1.E1_TIPO    NOT IN " + FormatIn(MVPROVIS+"|"+MVABATIM,"|")


	// MVPROVIS =PR
	//MVABATIM  = AB-|FB-|FC-|FU-|IR-|IN-|IS-|PI-|CF-|CS-|FE-|IV-

	// Se é Segunda Via (2-Sim) e os campos customizados para a Segunda Via foram criados , considera os mesmos.
	// Se não é Segunda Via (1 - Não) e os campos customizados para a Segunda Via foram criados, busca apenas titulos não impressos.
	// Se os campos não foram criados busca informações bancárias do pergunte.
	If lSegundaVia  .AND. nSegVia = 2

		cQuery += "AND  SE1.E1_PORTADO <> '' "
		cQuery += "AND  SE1.E1_PORBCO  <> '' "

	ElseIf lSegundaVia  .AND. nSegVia = 1
		cQuery += "AND  (SE1.E1_PORTADO = '' OR "
		cQuery += "      SE1.E1_PORTADO = "+IIF(lBCLI,"SEE.EE_CODIGO","'"+cBanco+"'") + " ) "
	Else

		cQuery += "AND  (SE1.E1_PORTADO =  '' OR "
		cQuery += "     SE1.E1_PORTADO = "+IIF(lBCLI,"SEE.EE_CODIGO","'"+cBanco+"'") + " ) "

	EndIf

	// Se ï¿½ Segunda Via e os campos customizados para a Segunda Via foram criados , considera. Se os campos Não foram criados
	// e Não ï¿½ Segunda Via busca informaï¿½ï¿½es bancï¿½rias do pergunte
	If !lSegundaVia .AND. !lBCLI
		cQuery += "AND  (SE1.E1_CODCART =  '' OR "
		cQuery += "      SE1.E1_CODCART =  '" + aBanco[BCO_CARTEIR]  + "') "
	EndIf

	If	!(lPosicionado)

		cQuery += "AND   SE1.E1_EMISSAO >= '" + DToS(dDaEmissao)  + "' "
		cQuery += "AND   SE1.E1_EMISSAO <= '" + DToS(dAteEmissao) + "' "
		cQuery += "AND   SE1.E1_VENCREA >= '" + DToS(dDoVencRea)  + "' "
		cQuery += "AND   SE1.E1_VENCREA <= '" + DToS(dAteVencRea) + "' "
		cQuery += "AND   SE1.E1_NUMBOR  >= '" + cDoNumBor         + "' "
		cQuery += "AND   SE1.E1_NUMBOR  <= '" + cAteNumBor        + "' "
		cQuery += "AND   SE1.E1_CLIENTE >= '" + cDoCliente        + "' "
		cQuery += "AND   SE1.E1_CLIENTE <= '" + cAteCliente       + "' "
		cQuery += "AND   SE1.E1_LOJA    >= '" + cDaLoja           + "' "
		cQuery += "AND   SE1.E1_LOJA    <= '" + cAteLoja          + "' "

		If lForma
			cQuery += "AND   SE1.E1_FORMA    IN " + FormatIn(Alltrim(cForma), ";")
		EndIf

	EndIf

	cQuery += "AND   SE1.D_E_L_E_T_ <> '*'  "
	cQuery += "AND   SA1.A1_FILIAL  =  '" + xFilial("SA1") + "' "
	cQuery += "AND   SA1.A1_COD     =  SE1.E1_CLIENTE "
	cQuery += "AND   SA1.A1_LOJA    =  SE1.E1_LOJA "
	cQuery += "AND   SA1.D_E_L_E_T_ <> '*'  "

	if !lBCLI
		cQuery += "ORDER BY E1_FILIAL, E1_CLIENTE, E1_LOJA, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO "
	Else
		cQuery += "ORDER BY E1_FILIAL,E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO "
	Endif
	ConOut(cQuery)
	cQuery := ChangeQuery(cQuery)

	dbUseArea( .T., "TOPCONN", TcGenQry( , , cQuery), cAliasSE1, .T., .T. )
	TCSetField( cAliasSE1, "E1_EMISSAO", "D", 8, 0 )
	TCSetField( cAliasSE1, "E1_VENCTO" , "D", 8, 0 )
	TCSetField( cAliasSE1, "E1_VENCREA", "D", 8, 0 )

	DbSelectArea(cAliasSE1)
	Count to nReg
	DbGoTop()
	ProcRegua(nReg)

	If	!((cAliasSE1)->(EOF()))


		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Chama a SumAbatRec para abrir alias auxiliar __SE1 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		If	Select("__SE1") == 0
			SumAbatRec("","","",1,"")
		EndIf

		Do While !( (cAliasSE1)->(EOF()) )


			If	nTipoPDF = 1 .Or. !lIniImp

				lContinua := F001IniImp( @oBoleto, @oSetup, @lExistBol, @lBlind, aBanco, Array(TAM_TIT), aSacado )

			EndIf

			If	!lContinua
				Exit
			EndIf

			If		nTipoPDF = 1 //-- Arquivo unico

				cCpoQuebra := "(E1_FILIAL)"
				cCntQuebra := (cAliasSE1)->(E1_FILIAL)

			ElseIf	nTipoPDF = 2 //-- Por Cliente

				cCpoQuebra := "(E1_FILIAL+E1_CLIENTE+E1_LOJA)"
				cCntQuebra := (cAliasSE1)->(E1_FILIAL+E1_CLIENTE+E1_LOJA)

			ElseIf	nTipoPDF = 3 //-- Por Titulo

				cCpoQuebra := "(E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM)"
				cCntQuebra := (cAliasSE1)->(E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM)

			EndIf

			Do While (cAliasSE1)->&(cCpoQuebra) == cCntQuebra .And. !((cAliasSE1)->(EOF()))

				If lBCLI

					If nSegVia == 1
						dbSelectArea("SEE")
						dbSetOrder(1)
						dbSeek(xFilial("SEE")+(cAliasSE1)->BANCO)

						cBanco   := SEE->EE_CODIGO
						cAgencia := SEE->EE_AGENCIA
						cConta   := SEE->EE_CONTA
						cSubCta  := SEE->EE_SUBCTA
					Else
						cBanco := (cAliasSE1)->(E1_PORBCO)
						cAgencia := (cAliasSE1)->(E1_PORAGC)
						cConta := (cAliasSE1)->(E1_PORCTA)
						cSubCta := (cAliasSE1)->(E1_PORSUB)
					EndIf


					//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
					//ï¿½Valida Cedente                 ï¿½
					//ï¿½e Carrega Dados Array aCedente ï¿½
					//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½

					F001Cedente( @aCedente,Nil )

					F001Banco( @aBanco, nil )

					If !Empty((cAliasSE1)->(E1_CODCART))
						If (cAliasSE1)->(E1_CODCART) <> aBanco[BCO_CARTEIR]
							(cAliasSE1)->(dbSkip())
							loop
						EndIf
					EndIf

				EndIf

				If nSegVia = 2

					aSegVia := {}

					cPorBco := (cAliasSE1)->(E1_PORBCO)
					cPorAgc := (cAliasSE1)->(E1_PORAGC)
					cPorCta := (cAliasSE1)->(E1_PORCTA)
					cPorSub := (cAliasSE1)->(E1_PORSUB)

					aAdd(aSegVia, cPorBco)
					aAdd(aSegVia, cPorAgc)
					aAdd(aSegVia, cPorCta)
					aAdd(aSegVia, cPorSub)

					F001Banco(@aBanco, aSegVia)
					F001Cedente(@aCedente,aSegVia)

				EndIf

				IncProc()

				//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
				//ï¿½ Posiciono no Registro Correspondente do SE1 e no SA1                                ï¿½
				//ï¿½ para perfeito executar as formulas das Mensagens.                                   ï¿½
				//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
				dbSelectArea("SE1")
				dbGoTo((cAliasSE1)->E1_RECNO)

				dbSelectArea("SA1")
				dbGoTo((cAliasSE1)->A1_RECNO)

				If lImpAbat
					lAbatCli := ( (SA1->A1_IMPABAT="S") .Or. Empty( SA1->A1_IMPABAT ) )
				EndIf

				If	SE1->E1_ORIGEM = 'MATA460'

					dbSelectArea("SF2")
					dbSetOrder(2)	//-- F2_FILIAL+F2_CLIENTE+F2_LOJA+F2_DOC+F2_SERIE
					dbSeek( xFilial("SF2") + (cAliasSE1)->A1_COD + (cAliasSE1)->A1_LOJA + (cAliasSE1)->E1_NUM + (cAliasSE1)->E1_SERIE )

				EndIf

				//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
				//ï¿½ Carrega Dados Array aSacado   ï¿½
				//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
				aSacado := Array(TAM_SAC)
				aSacado[SAC_NOME] := IIf(lAmbHml, "Cliente Teste", (cAliasSE1)->A1_NOME)									//-- Razao Social
				aSacado[SAC_CNPJ] := TransForm((cAliasSE1)->A1_CGC, IIf((cAliasSE1)->A1_PESSOA = "J", PICT_CNPJ, PICT_CPF))	//-- CNPJ/CPF

				aSacado[SAC_CONTATO] := IIf(lAmbHml, "Contato Teste", (cAliasSE1)->A1_CONTATO)							//-- Contato
				If	lEmailBl
					If	!Empty( (cAliasSE1)->A1_EMAILBL )
						aSacado[SAC_EMAIL] := Lower(AllTrim((cAliasSE1)->A1_EMAILBL))									//-- Email Especifico P/ Boletos
					Else
						aSacado[SAC_EMAIL] := Lower(AllTrim((cAliasSE1)->A1_EMAIL))										//-- Email Cadastro
					EndIf
				Else
					aSacado[SAC_EMAIL] := Lower(AllTrim((cAliasSE1)->A1_EMAIL))											//-- Email Cadastro
				EndIf

				If	!Empty((cAliasSE1)->A1_ENDCOB)
					aSacado[SAC_END] := AllTrim((cAliasSE1)->A1_ENDCOB)												//-- Endereco
					If	lNrEndC .And. !Empty((cAliasSE1)->A1_NR_ENDC) .And. !( AllTrim((cAliasSE1)->A1_NR_ENDC) $ aSacado[SAC_END] )
						aSacado[SAC_END] += ", " + AllTrim((cAliasSE1)->A1_NR_ENDC)									//-- Numero do Endereco
					EndIf

					If	lComplC
						aSacado[SAC_END] += IIf( !Empty((cAliasSE1)->A1_COMPLEC)," - "+AllTrim((cAliasSE1)->A1_COMPLEC),"")	//-- Complemento do Endereco
					EndIf

					aSacado[SAC_END] += IIf( !Empty((cAliasSE1)->A1_BAIRROC)," - "+AllTrim((cAliasSE1)->A1_BAIRROC),"")	//-- Bairro
					aSacado[SAC_END] += " - " + AllTrim((cAliasSE1)->A1_MUNC)										//-- Cidade
					aSacado[SAC_END] += "-"   + AllTrim((cAliasSE1)->A1_ESTC)										//-- Estado
					aSacado[SAC_END] += "  CEP: " + TransForm((cAliasSE1)->A1_CEPC,PICT_CEP)							//-- CEP
				Else
					aSacado[SAC_END] := AllTrim((cAliasSE1)->A1_END)													//-- Endereco

					If	lNrEnd .And. !Empty((cAliasSE1)->A1_NR_END) .And. !( AllTrim((cAliasSE1)->A1_NR_END) $ aSacado[SAC_END] )
						aSacado[SAC_END] += ", " + AllTrim((cAliasSE1)->A1_NR_END)									//-- Numero do Endereco
					EndIf

					aSacado[SAC_END] += IIf( !Empty((cAliasSE1)->A1_COMPLEM)," - "+AllTrim((cAliasSE1)->A1_COMPLEM),"")	//-- Complemento do Endereco
					aSacado[SAC_END] += IIf( !Empty((cAliasSE1)->A1_BAIRRO)," - "+AllTrim((cAliasSE1)->A1_BAIRRO),"")		//-- Bairro
					aSacado[SAC_END] += " - " + AllTrim((cAliasSE1)->A1_MUN)											//-- Cidade
					aSacado[SAC_END] += "-"   + AllTrim((cAliasSE1)->A1_EST)											//-- Estado
					aSacado[SAC_END] += "  CEP: " + TransForm((cAliasSE1)->A1_CEP,PICT_CEP)							//-- CEP
				EndIf

				//-- SumAbatRec( cPrefixo,cNumero,cParcela,nMoeda,cCpo,dData,nTotAbImp,nTotIrAbt,nTotCsAbt,nTotPisAbt,nTotCofAbt,nTotInsAbt,cFilAbat)
				nTotAbImp  := 0
				nTotIrAbt  := 0
				nTotCsAbt  := 0
				nTotPisAbt := 0
				nTotCofAbt := 0
				nTotInsAbt := 0
				nTotIssAbt := 0
				nTotTitAbt := 0

				//Alteração para moeda2 -Banco Itau - 15.12.2021
				If aBanco[BCO_NUMBCO] = ITAU  .AND. aBanco[BCO_CARTEIR]  == '150' //SE1->E1_MOEDA = 2
					nSaldo:= 0

				Else
					nValorImp  := If(lVlrOrigi, (cAliasSE1)->E1_VLCRUZ, xMoeda((cAliasSE1)->E1_SALDO,(cAliasSE1)->E1_MOEDA,1,DdataBase) )
					//Valor do Abatimento titulo tipo AB-
					nValAbat   := SumAbatRec( (cAliasSE1)->E1_PREFIXO, (cAliasSE1)->E1_NUM, (cAliasSE1)->E1_PARCELA, (cAliasSE1)->E1_MOEDA, "S", dDataBase, @nTotAbImp, @nTotIrAbt, @nTotCsAbt, @nTotPisAbt, @nTotCofAbt, @nTotInsAbt, @nTotIssAbt, @nTotTitAbt )

					If aBanco[BCO_NUMBCO] = ITAU .OR. aBanco[BCO_NUMBCO] = BRADESCO  .OR. aBanco[BCO_NUMBCO] = SANTANDER // Estes bancos o valor impresso é sempre o original- Paola 23.08.2021
						nValorImp  :=SaldoTit(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_TIPO,SE1->E1_NATUREZ,"R",SE1->E1_CLIENTE,1,dDatabase,IIF(Empty(SE1->E1_DATABOR),DdataBase,SE1->E1_DATABOR),SE1->E1_LOJA,,SE1->E1_TXMOEDA,1,.T.)
						// Se o cliente não quer considerar o título do abatimento AB- no valor impresso do boleto
						IF lAbatVlr
							nValorImp:= nValorImp - nValAbat
						Endif

					Endif

					If aBanco[BCO_NUMBCO] = ITAU .OR. aBanco[BCO_NUMBCO] = BRADESCO  .OR. aBanco[BCO_NUMBCO] = SANTANDER // Estes bancos o valor impresso é sempre o original- Paola 23.08.2021
						nSaldo   := nValorImp
					Else
						nSaldo   := nValorImp - (cAliasSE1)->E1_DECRESC + (cAliasSE1)->E1_ACRESC
						iF lAbatVlr
							nSaldo   := nSaldo - nValAbat
						Endif
					Endif
				Endif //Fim da Alateração 15.12.2021

				aTitulo := Array(TAM_TIT)
				aTitulo[TIT_PREF]   := (cAliasSE1)->E1_PREFIXO					//-- Prefixo da NF
				aTitulo[TIT_NUM]    := (cAliasSE1)->E1_PREFIXO
				aTitulo[TIT_NUM]    += " " + (cAliasSE1)->E1_NUM
				aTitulo[TIT_NUM]    += " " + (cAliasSE1)->E1_PARCELA 			//-- Prefixo/Numero/Parcela do Titulo
				aTitulo[TIT_DTEMI]  := DTOC((cAliasSE1)->E1_EMISSAO)			//-- Data Emissao Titulo
				aTitulo[TIT_DTPROC] := DTOC(MsDate())							//-- Data Emissao Boleto
				If aBanco[BCO_MBCARD] = "1" .or. !lVencto
					aTitulo[TIT_DTVCTO] := DTOC((cAliasSE1)->E1_VENCTO)			//-- Data Vencimento
				Else
					aTitulo[TIT_DTVCTO] := DTOC((cAliasSE1)->E1_VENCREA)			//-- Data Vencimento
				Endif
				aTitulo[TIT_VALOR]  := nSaldo									//-- Valor do Titulo
				aTitulo[TIT_TIPO]   := (cAliasSE1)->E1_TIPO						//-- Tipo do Titulo
				aTitulo[TIT_IRRF]   := nTotIrAbt								//-- IRRF
				aTitulo[TIT_ISS]    := nTotIssAbt								//-- ISS
				aTitulo[TIT_INSS]   := nTotInsAbt								//-- INSS
				aTitulo[TIT_PIS]    := nTotPisAbt								//-- PIS
				aTitulo[TIT_COFINS] := nTotCofAbt								//-- COFINS
				aTitulo[TIT_CSLL]   := nTotCsAbt								//-- CSLL
				aTitulo[TIT_DECRES] := (cAliasSE1)->E1_DECRESC					//-- Decrescimos
				aTitulo[TIT_ACRESC] := (cAliasSE1)->E1_ACRESC						//-- Acrescimos
				aTitulo[TIT_ABATIM] := nTotTitAbt								//-- Abatimentos (AB-)
				aTitulo[TIT_RECSE1] := (cAliasSE1)->E1_RECNO						//-- Recno do Titulo no SE1
				aTitulo[TIT_RECSA1] := (cAliasSE1)->A1_RECNO						//-- Recno do Titulo no SA1

				If	!Empty(SEE->EE_NUMTIT)

					aTitulo[TIT_NUM] := &(SEE->EE_NUMTIT)

				EndIf

/*
				If 		aBanco[BCO_NUMBCO] = CITIBANK

						aTitulo[TIT_NUM] := (cAliasSE1)->E1_PREFIXO + " " + Right( (cAliasSE1)->E1_NUM ,5 ) + "/" + (cAliasSE1)->E1_PARCELA

				EndIf
*/

				If		aBanco[BCO_NUMBCO] = HSBC

					aTitulo[TIT_ESPECIE] := "PD"							//-- Especie Documento

				ElseIf aBanco[BCO_NUMBCO] = CITIBANK


					aTitulo[TIT_ESPECIE] := "DMI"                           //-- Especie Documento

				ElseIf aBanco[BCO_NUMBCO] = SICREDI

					aTitulo[TIT_ESPECIE] := "DMI"                           //-- Especie Documento

				ElseIf aBanco[BCO_MBCARD]= "1"

					aTitulo[TIT_ESPECIE] := "Recibo"                           //-- Especie Documento - MBCAD

				ElseIF aBanco[BCO_NUMBCO] = ITAU .AND.  aBanco[BCO_CARTEIR] == '150' //SE1->E1_MOEDA = 2

					aTitulo[TIT_ESPECIE] := "DMI"
				Else

					aTitulo[TIT_ESPECIE] := "DM"							//-- Especie Documento

				EndIf

				//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
				//ï¿½ Carrega Dados Array aAvalista ï¿½
				//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
				F001Avalista( @aAvalista, @aCedente, aSacado, aBanco, aTitulo )

				//-- Mensagens para o Boleto
				aMsgBol  := {}
				If	lAmbHml
					cMsg := "* * * BOLETO EMITIDO PARA HOMOLOGAÇÃO DE IMPRESSÃO, SEM VALOR COMERCIAL * * *"
					aAdd( aMsgBol, cMsg )
				EndIf

				For nMsg := BCO_MSG1 To BCO_MSG6
					If	!Empty(aBanco[nMsg])
						cMsg := &(aBanco[nMsg])
						If	!Empty(cMsg)
							aAdd( aMsgBol, cMsg )
						EndIf
					EndIf
				Next nMsg

				//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
				//ï¿½ Mensagens demosntrativas                                                                       ï¿½
				//ï¿½ Deducoes, Impostos, Abatimentos (AB-), Acrescimos e Descrescimos                               ï¿½
				//ï¿½ Posiciona nas duas ultimas linhas das Mensagens                                                ï¿½
				//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
				If	aTitulo[TIT_PIS] + aTitulo[TIT_COFINS] + aTitulo[TIT_CSLL] + aTitulo[TIT_IRRF] + aTitulo[TIT_ISS] + aTitulo[TIT_INSS] > 0
					cMsg := ""
					cMsg += "Deduções/Impostos: "
					If	aTitulo[TIT_PIS] > 0
						cMsg += "PIS: " + AllTrim(F001FormVal(aTitulo[TIT_PIS])) + " "
					EndIf
					If	aTitulo[TIT_COFINS] > 0
						cMsg += "COFINS: " + AllTrim(F001FormVal(aTitulo[TIT_COFINS])) + " "
					EndIf
					If	aTitulo[TIT_CSLL] > 0
						cMsg += "CSLL: " + AllTrim(F001FormVal(aTitulo[TIT_CSLL])) + " "
					EndIf
					If	aTitulo[TIT_IRRF] > 0
						cMsg += "IR: " + AllTrim(F001FormVal(aTitulo[TIT_IRRF])) + " "
					EndIf
					If	aTitulo[TIT_ISS] > 0
						cMsg += "ISS: " + AllTrim(F001FormVal(aTitulo[TIT_ISS])) + " "
					EndIf
					If	aTitulo[TIT_INSS] > 0
						cMsg += "INSS: " + AllTrim(F001FormVal(aTitulo[TIT_INSS])) + " "
					EndIf
					aAdd( aMsgBol, cMsg )
				EndIf

				cMsg := ""
				If	aTitulo[TIT_ABATIM] + aTitulo[TIT_DECRES] > 0

					If lAbatCli
						cMsg += "Abatimentos/Decrescimos: "
						cMsg += AllTrim( F001FormVal(aTitulo[TIT_ABATIM] + aTitulo[TIT_DECRES])) + "  "
					EndIf

				EndIf

				If	aTitulo[TIT_ACRESC] > 0
					cMsg += "Acrescimos: "
					cMsg += AllTrim( F001FormVal(aTitulo[TIT_ACRESC]) ) + "  "
				EndIf
				aAdd( aMsgBol, cMsg )

				//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
				//ï¿½ Adiciona linhas em branco ate Limte do Tamanho do Quadro de Mensagens               ï¿½
				//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
				For	 nMsg := (Len(aMsgBol)+1) To 9
					aAdd( aMsgBol, "" )
				Next nMsg

				aTitulo[TIT_MSGS]   := aMsgBol									//-- Mensagens / Instrucoes

				If Empty(aBanco[BCO_LOCPAG]) .And. Empty(aBanco[BCO_NOMCOR])

					aTitulo[TIT_LOCPAG] := {"ATE O VENCIMENTO PAGUE PREFERENCIALMENTE NO " + aBanco[BCO_NOMBCO],;
						"ATE O VENCIMENTO PAGUE SOMENTE NO " + aBanco[BCO_NOMBCO]}

				ElseIf Empty(aBanco[BCO_LOCPAG]) .And. !Empty(aBanco[BCO_NOMCOR])

					aTitulo[TIT_LOCPAG] := {"ATE O VENCIMENTO PAGUE PREFERENCIALMENTE NO " + aBanco[BCO_NOMCOR],;
						"APOS O VENCIMENTO PAGUE SOMENTE NO " + aBanco[BCO_NOMCOR]}

				Else

					aTitulo[TIT_LOCPAG]	:= {aBanco[BCO_LOCPAG],""}

				EndIf

				//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
				//ï¿½ Monta o Nosso Numero e Calcula o Digito Verificador                                 ï¿½
				//ï¿½ Carrega Informacoes nas posicoes do aTitulo                                         ï¿½
				//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
				F001NNum( aBanco, @aTitulo)

				//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
				//ï¿½ Monta o Codigo de Barras e Calcula Digito Verificador                               ï¿½
				//ï¿½ Carrega Informacoes nas posicoes do aTitulo                                         ï¿½
				//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
				F001CodBar( aBanco, @aTitulo)

				//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
				//ï¿½ Monta a Linha Digitavel e Calcula os Digitos Verificadores dos Campos               ï¿½
				//ï¿½ Carrega Informacoes nas posicoes do aTitulo                                         ï¿½
				//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
				F001LinDig( aBanco, @aTitulo )

				//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
				//ï¿½ Grava a Linha Digitavel no banco de dados                                           ï¿½
				//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½

				F001GrvLin ( @aTitulo )

				//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
				//ï¿½                                                                                     ï¿½
				//ï¿½ Funcao que executa Impressao de Boleto Bancario conforme laytout no formato retrato ï¿½
				//ï¿½                                                                                     ï¿½
				//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½

				aMsgBol := aTitulo[TIT_CODBAR]

				If F001ValImp(aTitulo, aBanco)

					If aTitulo[TIT_VALOR] > 0  .or. (aTitulo[TIT_ESPECIE] ="DMI" .AND. aBanco[BCO_NUMBCO] = ITAU .AND. aBanco[BCO_CARTEIR] =='150')//Valida impressï¿½o de tï¿½tulo com valor zerado

						F001Imprime( aCedente, aBanco, aSacado, aAvalista, aTitulo, @oBoleto, @oSetup, @lExistBol, @lStart, cTempPath ,@lBlind)

						IF aBanco[BCO_NUMBCO] = ITAU .AND. aBanco[BCO_CARTEIR] == '150' //Paola 20.12.2021
							dbSelectArea("SE1")
							DbGoTo(aTitulo[TIT_RECSE1])

							aAdd( aTitMail, { aTitulo[TIT_NUM], aTitulo[TIT_DTVCTO], AllTrim(F001FormVal(SE1->E1_VALOR)), aBanco[BCO_NUMBCO] } )
						Else
							aAdd( aTitMail, { aTitulo[TIT_NUM], aTitulo[TIT_DTVCTO], AllTrim(F001FormVal(aTitulo[TIT_VALOR])), aBanco[BCO_NUMBCO] } )
						Endif

					Else
						If !lBlind //Tratamento de WS
							lErrSaldo := .T.
							cTitLiq += aTitulo[TIT_NUM] + CRLF
						EndIf
					EndIf

				EndIf

				DbSelectArea(cAliasSE1)
				(cAliasSE1)->(dbSkip())

			EndDo

			If !lBlind
				If lErrSaldo
					cMsgErr := "Saldo zerado." + CRLF
					cMsgErr += "Os seguintes titulos estao totalmente liquidados:" + CRLF
					cMsgErr += cTitLiq
					Aviso( "TRSF001|SALDO", cMsgErr, {"OK"},2 )
				EndIf
			EndIf


			If	ValType(oBoleto) = "O"

				If	lBlind

					If	lEmail

						If	oBoleto:nDevice = IMP_PDF .And. lExistBol

							oBoleto:Preview()

							cPathPDF  := AllTrim( oBoleto:cPathPDF )
							cFileName := StrTran( Lower( AllTrim( oBoleto:cFileName ) ) , ".rel" , ".pdf" )

							If __CopyFile( cPathPDF + cFileName , cBolPath + cFileName )

								If AllTrim( cNomRot ) <> "TRSF001D"
									FErase( cPathPDF + cFileName )//Apaga o arquivo
								EndIf

							EndIf

							aRet := F001Email( aCedente, aSacado, aTitMail, cBolPath + cFileName)

							If aRet[1]
								//FErase( cBolPath + cFileName )	//--	Se Envio Ok, Deleta PDF
							Else
								Aviso( "Atencao!","Falha no Envio do Email" + CRLF + aRet[2], { "OK" } )
							EndIf

						EndIf

						If AllTrim( cNomRot ) <> "TRSF001D"

							FreeObj(oBoleto)
							oBoleto   := Nil

						EndIf

						If	ValType(oSetup) = "O"
							FreeObj(oSetup)
						EndIf

						oSetup    := Nil

						lExistBol := .F.
						lIniImp   := .F.
						aTitMail  := {}

					EndIf

				Else

//					If	nTipoPDF <> 1

					If	oBoleto:nDevice = IMP_PDF .And. lExistBol

						oBoleto:Preview()

					EndIf

					FreeObj(oBoleto)

//					EndIf

					If	ValType(oSetup) = "O"

						FreeObj(oSetup)

					EndIf

					oBoleto   := Nil
					oSetup    := Nil

					lExistBol := .F.
					lIniImp   := .F.
					aTitMail  := {}

				EndIf

			EndIf

		EndDo

	Else

		MsgInfo("Nenhum registro encontrado. Por favor, verifique os Parâmetros.", "Atenção")

	EndIf

	DbSelectArea(cAliasSE1)
	(cAliasSE1)->(DbCloseArea())

Return(Nil)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³F001GrvLin ³ Autor ³ Leonir Donatti       ³ Data ³08/01/2016³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Grava a linha digitável no banco de dados                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ @aTitulo - array com dados a serem gravados                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TRSF001                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function F001GrvLin ( aTitulo )

	Local cLinDig := ""

	cLinDig := STRTRAN( aTitulo[TIT_LINDIG], ".", "" )
	cLinDig := STRTRAN( cLinDig, " ", "" )

	dbSelectArea("SE1")

	//Se for banco do Brasil e já foi
	RecLock( "SE1",.F. )
	SE1->E1_CODDIG  := cLinDig
	SE1->E1_CODBAR  := _cCodBar
	MsUnLock()

Return( Nil )

/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
	±±³Programa  ³F001Cedente³ Autor ³ Fabio Briddi         ³ Data ³ Nov/2013 ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Descricao ³ Inicializa Array aCedente                                  ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Parametros³ @aCedente - Array com os dados da Empresa/Filial           ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Retorno   ³ Nenhum                                                     ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Uso       ³ TRSF001                                                    ³±±
	±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function F001Cedente( aCedente, aSegVia )

	Local cBOLMBC:= "2" // Não eh boleto MBCAD
	aCedente := Array(TAM_CED)
	//-- Posiciona SEE - Parametros/Configuracoes de Bancos
	If nSegVia = 2 .and. !aSegVia == NIL
		dbSelectArea("SEE")
		dbSeek(xFilial("SEE") + aSegVia[1] + aSegVia[2] + aSegVia[3] + aSegVia[4] )
	Else
		DbSelectArea("SEE")
		DbSetOrder(1)
		DbSeek(xFilial("SEE") + cBanco + cAgencia + cConta + cSubCta)

	Endif

	IF SEE->( FieldPos("EE_BOLMBCA")) > 0

		IF SEE->EE_BOLMBCA = "1" // Se Não for MBCAD

			cBOLMBC:= "1"
		Else

			cBOLMBC:= "2"
		Endif
	Endif

	If cBolMBC <> "1"

		SM0->(DbSeek(cEmpAnt+cFilAnt))

		aCedente[CED_NOME] := IIf(lAmbHml,"Empresa Teste",AllTrim(SM0->M0_NOMECOM))				//-- Nome da Empresa
		aCedente[CED_CNPJ] := TransForm(SM0->M0_CGC,PICT_CNPJ)									//-- CNPJ
		aCedente[CED_END]  :=  AllTrim(SM0->M0_ENDCOB)											//-- Endereco
		aCedente[CED_END]  +=  IIf( !Empty(SM0->M0_COMPCOB)," - "+AllTrim(SM0->M0_COMPCOB),"")	//-- Complemento do Endereco
		aCedente[CED_END]  +=  IIf( !Empty(SM0->M0_BAIRCOB)," - "+AllTrim(SM0->M0_BAIRCOB),"")	//-- Bairro
		aCedente[CED_END]  +=  " - " + AllTrim(SM0->M0_CIDCOB)									//-- Cidade
		aCedente[CED_END]  +=  "-" + SM0->M0_ESTCOB												//-- Estado
		aCedente[CED_END]  +=  " CEP: " + TransForm(SM0->M0_CEPCOB,PICT_CEP)					//-- CEP

	Else

		If SEE->( FieldPos("EE_BENFMB")) > 0  .AND.;
				SEE->( FieldPos("EE_CNPJMB")) > 0 .AND.;
				SEE->( FieldPos("EE_ENDMB")) > 0 .AND. ;
				SEE->( FieldPos("EE_COMPMB")) > 0 .AND.;
				SEE->( FieldPos("EE_BAIMB")) > 0 .AND. ;
				SEE->( FieldPos("EE_MUNMB")) > 0 .AND.;
				SEE->( FieldPos("EE_ESTMB")) > 0 .AND.;
				SEE->( FieldPos("EE_CEPMB")) > 0




			aCedente[CED_NOME] := SEE->EE_BENFMB	//-- Nome da Empresa
			aCedente[CED_CNPJ] := SEE->EE_CNPJMB	//-- CNPJ
			aCedente[CED_END]  := IIF(!Empty(alltrim(SEE->EE_ENDMB)),alltrim(SEE->EE_ENDMB),"")		//-- Endereco
			aCedente[CED_END]  += IIF(!Empty(alltrim(SEE->EE_COMPMB))," - " +alltrim(SEE->EE_COMPMB),"")   	//-- Complemento do Endereco
			aCedente[CED_END]  += IIF(!Empty(alltrim(SEE->EE_BAIMB))," - "+alltrim(SEE->EE_BAIMB),"")		//-- Bairro
			aCedente[CED_END]  += IIF(!Empty(alltrim(SEE->EE_MUNMB))," - "+alltrim(SEE->EE_MUNMB),"")		//-- Cidade
			aCedente[CED_END]  += IIF(!Empty(alltrim(SEE->EE_ESTMB))," - " + alltrim(SEE->EE_ESTMB),"")		//-- Estado
			aCedente[CED_END]  += IIF(!Empty(alltrim(SEE->EE_CEPMB))," - " +alltrim(SEE->EE_CEPMB),"")		//-- CEP

		Else



			aCedente[CED_NOME] := "Inclua campos MBCAD"	//-- Nome da Empresa
			aCedente[CED_CNPJ] := ""    	//-- CNPJ
			aCedente[CED_END]  := ""		//-- Endereco
			aCedente[CED_END]  += ""    	//-- Complemento do Endereco
			aCedente[CED_END]  += ""		//-- Bairro
			aCedente[CED_END]  += ""		//-- Cidade
			aCedente[CED_END]  += ""		//-- Estado
			aCedente[CED_END]  += ""		//-- CEP
		Endif // Se campos incluidos no dicionï¿½rio


	Endif
Return( )

/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
	±±³Programa  ³F001Banco  ³ Autor ³ Fabio Briddi         ³ Data ³ Nov/2013 ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Descricao ³ Inicializa Array aBanco                                    ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Parametros³ @aBanco  - Array com os dados do Banco Selecionado         ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Retorno   ³ Nenhum                                                     ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Uso       ³ TRSF001                                                    ³±±
	±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function F001Banco( aBanco, aSegVia )

	Local cBcoCorr := ""
	Local cBOLMBC:= "2" // Não eh boleto MBCAD

	aBanco := Array(TAM_BCO)

	nPosBcoHml := aScan( BANCO_HML, {|x| x[1] == cBanco } )
	If nSegVia = 2 .AND. aSegVia != Nil
		dbSelectArea("SEE")
		dbSeek(xFilial("SEE") + aSegVia[1] + aSegVia[2] + aSegVia[3] + aSegVia[4] )
	EndIf
	IF SEE->( FieldPos("EE_BOLMBCA")) > 0

		IF SEE->EE_BOLMBCA = "1" // Se Não for MBCAD

			cBOLMBC:= "1"
		Else

			cBOLMBC:= "2"
		Endif
	Endif

	cBcoCorr := AllTrim(SEE->EE_CODCOR)

	aBanco[BCO_NUMBCO]  := AllTrim(SEE->EE_CODIGO) //-- Numero Banco no BACEN
	aBanco[BCO_DVBCO]   := BANCO_HML[nPosBcoHml,2]	//-- Digito Banco
	aBanco[BCO_NUMAGE]  := AllTrim(SEE->EE_AGENCIA)//-- Numero Agencia
	aBanco[BCO_DVAGE]   := AllTrim(SEE->EE_DVAGE)	//-- Digito Agencia
	aBanco[BCO_NUMCTA]  := AllTrim(SEE->EE_CONTA)	//-- Numero Conta
	aBanco[BCO_DVCTA]   := AllTrim(SEE->EE_DVCTA)	//-- Digito Conta
	aBanco[BCO_NOMBCO]  := AllTrim(SEE->EE_NOME)	//-- Nome do Banco
	aBanco[BCO_SUBCTA]  := AllTrim(SEE->EE_SUBCTA)	//-- Subconta
	aBanco[BCO_CODEMP]  := AllTrim(SEE->EE_CODEMP)	//-- Codigo Cedente
	aBanco[BCO_CARTEIR] := AllTrim(SEE->EE_CODCART)//-- Codigo da Carteira
	aBanco[BCO_VARIAC]  := AllTrim(SEE->EE_VARIAC)	//-- Variacao da Carteira
	aBanco[BCO_MSG1]    := AllTrim(SEE->EE_FORMEN1)//-- Formula Mensagem 1
	aBanco[BCO_MSG2]    := AllTrim(SEE->EE_FORMEN2)//-- Formula Mensagem 2
	aBanco[BCO_MSG3]    := AllTrim(SEE->EE_FOREXT1)//-- Formula Mensagem 3
	aBanco[BCO_MSG4]    := AllTrim(SEE->EE_FOREXT2)//-- Formula Mensagem 4
	aBanco[BCO_MSG5]    := AllTrim(SEE->EE_FOREXT3)//-- Formula Mensagem 5
	aBanco[BCO_MSG6]    := AllTrim(SEE->EE_FOREXT4)//-- Formula Mensagem 6
	aBanco[BCO_LOCPAG]  := IIf(SEE->(FieldPos("EE_MSLOCPG"))>0,AllTrim(SEE->EE_MSLOCPG),"") //-- Mensagem Local de Pagamento
	aBanco[BCO_BCOFORM] := "|" + TransForm(AllTrim(aBanco[BCO_NUMBCO]) + aBanco[BCO_DVBCO],PICT_BANCO) + "|"
	aBanco[BCO_AGEFORM] := AllTrim(aBanco[BCO_NUMAGE]) + IIf(!Empty(aBanco[BCO_DVAGE]), "-"+AllTrim(aBanco[BCO_DVAGE]) , "" )
	aBanco[BCO_CTAFORM] := AllTrim(aBanco[BCO_NUMCTA]) + IIf(!Empty(aBanco[BCO_DVCTA]), "-"+AllTrim(aBanco[BCO_DVCTA]) , "" )
	aBanco[BCO_ACEITE]  := SEE->EE_ACEITE //-- Aceite ( S = Sim ou N = Nao )
	IF cBOLMBC = "1"
		aBanco[BCO_USOBCO]  := "8650"  // MBCAD
	ELSE
		aBanco[BCO_USOBCO]  := If(CITIBANK $ aBanco[BCO_NUMBCO], "CLIENTE", "") //-- Uso exclusivo do Citibank
	ENDIF

	aBanco[BCO_MBCARD]:=cBOLMBC

	If	!Empty(SEE->EE_CODCOR)

		// Banco Correspondente
		nPosBcoHml := aScan( BANCO_HML, {|x| x[1] == cBcoCorr } )
		aBanco[BCO_BCOCOR]  := AllTrim(SEE->EE_CODCOR)  //-- Numero Banco Correspondente no BACEN
		aBanco[BCO_DVBCOR]  := BANCO_HML[nPosBcoHml,2]  //-- Digito Banco Correspondente
		aBanco[BCO_AGECOR]  := AllTrim(SEE->EE_AGECOR)  //-- Numero Agencia Banco Correspondente
		aBanco[BCO_DVAGCO]  := AllTrim(SEE->EE_DVAGCOR) //-- Digito Agencia Banco Correspondente
		aBanco[BCO_NCTACO]  := AllTrim(SEE->EE_CTACOR)  //-- Numero Conta Banco Correspondente
		aBanco[BCO_DVCTCO]  := AllTrim(SEE->EE_DVCTCOR) //-- Digito Conta Banco Correspondente
		aBanco[BCO_NOMCOR]  := AllTrim(SEE->EE_NOMECOR) //-- Nome do Banco Correspondente

	Else

		aBanco[BCO_BCOCOR]  := ""  //-- Numero Banco Correspondente no BACEN
		aBanco[BCO_DVBCOR]  := ""  //-- Digito Banco Correspondente
		aBanco[BCO_AGECOR]  := ""  //-- Numero Agencia Banco Correspondente
		aBanco[BCO_DVAGCO]  := ""  //-- Digito Agencia Banco Correspondente
		aBanco[BCO_NCTACO]  := ""  //-- Numero Conta Banco Correspondente
		aBanco[BCO_DVCTCO]  := ""  //-- Digito Conta Banco Correspondente
		aBanco[BCO_NOMCOR]  := ""  //-- Nome do Banco Correspondente

	EndIf


	If		aBanco[BCO_NUMBCO] = SANTANDER

		aBanco[BCO_AGECTA]  := aBanco[BCO_AGEFORM] +" /  "+ aBanco[BCO_CODEMP]

	ElseIf	aBanco[BCO_NUMBCO] = BANRISUL

		aBanco[BCO_AGECTA] := aBanco[BCO_AGEFORM] + " / " + TransForm(aBanco[BCO_CODEMP],"@R 999999.9.99")

	ElseIf	aBanco[BCO_NUMBCO] = CAIXA

		aBanco[BCO_AGECTA]  := aBanco[BCO_AGEFORM]+"/"+aBanco[BCO_CODEMP] + "-" + Mod11B29(aBanco[BCO_CODEMP])

	ElseIf	aBanco[BCO_NUMBCO] = HSBC

		If	aBanco[BCO_CARTEIR] = "CNR"
			aBanco[BCO_AGECTA]  := aBanco[BCO_CODEMP]
		Else
			aBanco[BCO_AGECTA]  := aBanco[BCO_AGEFORM] +" "+ aBanco[BCO_CODEMP]
		EndIf

	ElseIf	aBanco[BCO_NUMBCO] = SAFRA

		If	aBanco[BCO_CARTEIR] = "09"
			aBanco[BCO_BCOFORM] := "|" + TransForm(AllTrim(aBanco[BCO_BCOCOR]) + aBanco[BCO_DVBCOR],PICT_BANCO) + "|"
			aBanco[BCO_AGEFORM] := AllTrim(aBanco[BCO_AGECOR]) + IIf(!Empty(aBanco[BCO_DVAGCO]), "-"+AllTrim(aBanco[BCO_DVAGCO]) , "" )
			aBanco[BCO_CTAFORM] := AllTrim(aBanco[BCO_NCTACO]) + IIf(!Empty(aBanco[BCO_DVCTCO]), "-"+AllTrim(aBanco[BCO_DVCTCO]) , "" )
		EndIf

		aBanco[BCO_AGECTA]  := aBanco[BCO_AGEFORM] + "/" + aBanco[BCO_CTAFORM]

	ElseIf	aBanco[BCO_NUMBCO] = FIBRA

		If	aBanco[BCO_CARTEIR] = "19"
			aBanco[BCO_BCOFORM] := "|" + TransForm(AllTrim(aBanco[BCO_BCOCOR]) + aBanco[BCO_DVBCOR],PICT_BANCO) + "|"
			aBanco[BCO_AGEFORM] := AllTrim(aBanco[BCO_AGECOR]) + IIf(!Empty(aBanco[BCO_DVAGCO]), "-"+AllTrim(aBanco[BCO_DVAGCO]) , "" )
			aBanco[BCO_CTAFORM] := AllTrim(aBanco[BCO_NCTACO]) + IIf(!Empty(aBanco[BCO_DVCTCO]), "-"+AllTrim(aBanco[BCO_DVCTCO]) , "" )
		EndIf

		aBanco[BCO_AGECTA]  := aBanco[BCO_AGEFORM] + "/" + aBanco[BCO_CTAFORM]

	ElseIf aBanco[BCO_NUMBCO] = SICREDI

		aBanco[BCO_POSTO]   := AllTrim(SEE->EE_POSTO)
		aBanco[BCO_AGECTA]  := aBanco[BCO_NUMAGE] + "." + aBanco[BCO_POSTO] + "." + aBanco[BCO_NUMCTA]

	ElseIf	aBanco[BCO_NUMBCO] = REDASSET

		If	aBanco[BCO_CARTEIR] = "09"
			aBanco[BCO_BCOFORM] := "|" + TransForm(AllTrim(aBanco[BCO_BCOCOR]) + aBanco[BCO_DVBCOR],PICT_BANCO) + "|"
			aBanco[BCO_AGEFORM] := AllTrim(aBanco[BCO_AGECOR]) + IIf(!Empty(aBanco[BCO_DVAGCO]), "-"+AllTrim(aBanco[BCO_DVAGCO]) , "" )
			aBanco[BCO_CTAFORM] := AllTrim(aBanco[BCO_NCTACO]) + IIf(!Empty(aBanco[BCO_DVCTCO]), "-"+AllTrim(aBanco[BCO_DVCTCO]) , "" )
		EndIf

		aBanco[BCO_AGECTA]  := aBanco[BCO_AGEFORM] + "/" + aBanco[BCO_CTAFORM]

	ElseIf	aBanco[BCO_NUMBCO] = BBM

		If	aBanco[BCO_CARTEIR] = "09"
			aBanco[BCO_BCOFORM] := "|" + TransForm(AllTrim(aBanco[BCO_BCOCOR]) + aBanco[BCO_DVBCOR],PICT_BANCO) + "|"
			aBanco[BCO_AGEFORM] := AllTrim(aBanco[BCO_AGECOR]) + IIf(!Empty(aBanco[BCO_DVAGCO]), "-"+AllTrim(aBanco[BCO_DVAGCO]) , "" )
			aBanco[BCO_CTAFORM] := AllTrim(aBanco[BCO_NCTACO]) + IIf(!Empty(aBanco[BCO_DVCTCO]), "-"+AllTrim(aBanco[BCO_DVCTCO]) , "" )
		EndIf

		aBanco[BCO_AGECTA]  := aBanco[BCO_AGEFORM] + "/" + aBanco[BCO_CTAFORM]

	ElseIf aBanco[BCO_NUMBCO] = ABC

		If aBanco[BCO_CARTEIR] = "109" // Banco Correspondente
			aBanco[BCO_BCOFORM] := "|" + TransForm(AllTrim(aBanco[BCO_BCOCOR]) + aBanco[BCO_DVBCOR],PICT_BANCO) + "|"
			aBanco[BCO_AGEFORM] := AllTrim(aBanco[BCO_AGECOR]) + IIf(!Empty(aBanco[BCO_DVAGCO]), "-"+AllTrim(aBanco[BCO_DVAGCO]) , "" )
			aBanco[BCO_CTAFORM] := AllTrim(aBanco[BCO_NCTACO]) + IIf(!Empty(aBanco[BCO_DVCTCO]), "-"+AllTrim(aBanco[BCO_DVCTCO]) , "" )
		EndIf

		aBanco[BCO_AGECTA]  := aBanco[BCO_AGEFORM] + "/" + aBanco[BCO_CTAFORM]

	ElseIf aBanco[BCO_NUMBCO] = VOTORANTIM

		aBanco[BCO_BCOFORM] := "|" + TransForm(AllTrim(aBanco[BCO_BCOCOR]) + aBanco[BCO_DVBCOR],PICT_BANCO) + "|"
		aBanco[BCO_AGEFORM] := AllTrim(aBanco[BCO_AGECOR]) + IIf(!Empty(aBanco[BCO_DVAGCO]), "-"+AllTrim(aBanco[BCO_DVAGCO]) , "" )
		aBanco[BCO_CTAFORM] := AllTrim(aBanco[BCO_NCTACO]) + IIf(!Empty(aBanco[BCO_DVCTCO]), "-"+AllTrim(aBanco[BCO_DVCTCO]) , "" )

		aBanco[BCO_AGECTA]  := aBanco[BCO_AGEFORM] + "/" + aBanco[BCO_CTAFORM]

	ElseIf aBanco[BCO_NUMBCO] = NORDESTE

		aBanco[BCO_AGECTA]  := aBanco[BCO_AGEFORM] + " " + aBanco[BCO_CTAFORM]

	ElseIf aBanco[BCO_NUMBCO] = CITIBANK

		aBanco[BCO_AGECTA] := aBanco[BCO_AGEFORM] + "  " + TransForm(aBanco[BCO_NUMCTA],"@R 9.999999.99") + "." + aBanco[BCO_DVCTA]

	elseif	aBanco[BCO_NUMBCO] = SICOOB//Paola totvs 03/2024

		aBanco[BCO_AGECTA]  := aBanco[BCO_AGEFORM] +" /  "+ aBanco[BCO_CODEMP]
	Else

		aBanco[BCO_AGECTA]  := aBanco[BCO_AGEFORM] + "/" + aBanco[BCO_CTAFORM]

	EndIf

Return( )

/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
	±±³Programa  ³F001Avalista³ Autor ³ Fabio Briddi        ³ Data ³ Nov/2013 ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Descricao ³ Inicializa Array aAvalista                                 ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Parametros³ @aAvalista - Array com os dados do Avalista do Titulo      ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Retorno   ³ Nenhum                                                     ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Uso       ³ TRSF001                                                    ³±±
	±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function F001Avalista( aAvalista, aCedente, aSacado, aBanco, aTitulo )

	Local l001PeAval := ExistBlock("TF001Aval")

	aAvalista := Array(TAM_AVA)

	aAvalista[AVA_NOME]   := ""	//-- Nome da Empresa
	aAvalista[AVA_CNPJ]   := ""	//-- CNPJ
	aAvalista[AVA_END]    := ""	//-- Endereco
	aAvalista[AVA_COMPL]  := ""	//-- Complemento do Endereco
	aAvalista[AVA_BAIRRO] := ""	//-- Bairro
	aAvalista[AVA_MUN]    := ""	//-- Cidade
	aAvalista[AVA_EST]    := ""	//-- Estado
	aAvalista[AVA_CEP]    := ""	//-- CEP


	// Se o banco correpondente estiver preenchido e o conteï¿½do do parametro for configurado para imprimir os dados do banco correspondente.
	If  !Empty(aBanco[BCO_BCOCOR]).and. nDadBenf = 2 //GetMv("TRS_BOL01")Correspondente

		aAvalista[AVA_NOME]   := AllTrim(SM0->M0_NOMECOM) //aCedente[CED_NOME]	//-- Nome da Empresa - Paola- 10/06/2015- faixa
		aAvalista[AVA_CNPJ]   := TransForm(SM0->M0_CGC,PICT_CNPJ) //aCedente[CED_CNPJ]  //-- CNPJ - Giovanni - 06/11/2015
		aAvalista[AVA_END]    := aCedente[CED_END]	//-- Endereco
		aAvalista[AVA_COMPL]  := aCedente[CED_COMPL]	//-- Complemento do Endereco
		aAvalista[AVA_BAIRRO] := aCedente[CED_BAIRRO]	//-- Bairro
		aAvalista[AVA_MUN]    := aCedente[CED_MUN]	//-- Cidade
		aAvalista[AVA_EST]    := aCedente[CED_EST]	//-- Estado
		aAvalista[AVA_CEP]    := aCedente[CED_CEP]	//-- CEP


		aCedente[CED_NOME]  := aBanco[BCO_NOMBCO]
		aCedente[CED_CNPJ]  := TransForm( AllTrim( SA6->A6_CGC ), PICT_CNPJ )
		aCedente[CED_END]   := AllTrim( SA6->A6_END ) + " - " +;
			AllTrim( SA6->A6_BAIRRO ) + " - " +;
			AllTrim( SA6->A6_MUN ) + "-" +;
			AllTrim( SA6->A6_EST ) + " " +;
			"CEP " + AllTrim( SA6->A6_CEP )

		aCedente[CED_END]   := If( Empty( SA6->A6_END ),"", aCedente[CED_END])

	EndIf

	If	l001PeAval

		aAvalAux := U_TF001Aval( aAvalista, aSacado, aBanco, aTitulo )

		If	ValType( aAvalAux ) = "A" .And. Len(aAvalAux) = TAM_AVA
			aAvalista := aAvalAux
		EndIf

	EndIF

Return( )

/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
	±±³Programa  ³ F001NNum ³ Autor ³ Fabio Briddi          ³ Data ³ Nov/2013 ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Descricao ³ Monta o Nosso Numero e Calcula o Digito Verificador        ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Parametros³ aBanco = Array com Dados do Banco Selecionado              ³±±
	±±³          ³ aTitulos = Array com Informacoes do Titulo sendo impresso  ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Retorno   ³ Nenhum                                                     ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Uso       ³ TRSF001                                                    ³±±
	±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function F001NNum( aBanco,  aTitulo )

	Local aArea      := GetArea()
	Local cNNum      := ""
	Local cDvNNum    := ""
	Local cNNumAux   := ""
	Local cFaixaAtu  := ""
	Local cFaixaProx := ""
	Local cAnoVcto   := ""
	Local cAnoAtual  := ""

	dbSelectArea("SE1")
	SE1->(dbGoTo(aTitulo[TIT_RECSE1]))

	If 	Empty(SE1->E1_NUMBCO) .Or.	Empty(SE1->E1_PORTADO)

		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
		//ï¿½ Pega a Faixa Atual do Nosso Numero e Calcula a Proxima, ï¿½
		//ï¿½ Salvando no SEE                                         ï¿½
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		dbSelectArea("SEE")
		RecLock("SEE",.F.)
		cFaixaAtu  := AllTrim(SEE->EE_FAXATU)
		cFaixaProx := Soma1(cFaixaAtu)
		SEE->EE_FAXATU := cFaixaProx
		MsUnLock()

		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
		//ï¿½ Grava Faixa atual do Nosso Numero e Portador no SE1     ï¿½
		//ï¿½                                                         ï¿½
		//ï¿½ A Gravacao do Nosso numero no SE1 sem o Dig Verificador ï¿½
		//ï¿½ devido aos criterios diferenciados de calculo entre os  ï¿½
		//ï¿½ Bancos. Sao recalculados a cada impressao               ï¿½
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½

		RecLock("SE1",.F.)

		SE1->E1_PORTADO := SEE->EE_CODIGO //aBanco[BCO_NUMBCO]- Paola - 10/06/2015 - faixa
		SE1->E1_NUMBCO  := cFaixaAtu
		SE1->E1_CODCART := aBanco[BCO_CARTEIR]
		SE1->E1_AGEDEP  := SEE->EE_AGENCIA
		SE1->E1_CONTA   := SEE->EE_CONTA

		//If lSegundaVia

		SE1->E1_PORBCO	:= SEE->EE_CODIGO
		SE1->E1_PORAGC	:= SEE->EE_AGENCIA
		SE1->E1_PORDVA	:= SEE->EE_DVAGE
		SE1->E1_PORCTA	:= SEE->EE_CONTA
		SE1->E1_PORDVC	:= SEE->EE_DVCTA
		SE1->E1_PORSUB	:= SEE->EE_SUBCTA

		//EndIf

		MsUnLock()

	Else


	EndIf

	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
	//ï¿½ Nesse Ponto deve ser realizado os tratamentos           ï¿½
	//ï¿½ especificos de cada Banco para a Montagem do Nosso      ï¿½
	//ï¿½ Numero e  Calculo do Digito Verificador                 ï¿½
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½

	If		aBanco[BCO_NUMBCO] = BRASIL

		If		Len( aBanco[BCO_CODEMP] ) = 4

			If Len( AllTrim(SE1->E1_NUMBCO) ) = 5
				cNNum := Right(AllTrim(SE1->E1_NUMBCO),7)
			Else
				cNNum := SubStr(SE1->E1_NUMBCO,1,7)
			EndIf

		ElseIf	Len( aBanco[BCO_CODEMP] ) = 6

			If Len( AllTrim(SE1->E1_NUMBCO) ) = 5
				cNNum := Right(AllTrim(SE1->E1_NUMBCO),5)
			Else
				cNNum := SubStr(SE1->E1_NUMBCO,1,5)
			EndIf

		ElseIf	Len( aBanco[BCO_CODEMP] ) = 7

			cNNum := SubStr(SE1->E1_NUMBCO,1,10)

		EndIf

		//-- Monta String para Calculo do Digito Verificador
		cNNumAux := aBanco[BCO_CODEMP]	//-- Numero da Agencia (4 Digitos)
		cNNumAux += cNNum				//-- Sequencial Nosso Numero

		aTitulo[TIT_NNUM]     := cNNum
		aTitulo[TIT_DVNNUM]   := If( Len(aBanco[BCO_CODEMP]) <> 7, Mod11B92(cNNumAux), "" )
		aTitulo[TIT_NNUMFORM] := aBanco[BCO_CODEMP] + aTitulo[TIT_NNUM]
		aTitulo[TIT_NNUMFORM] += If( Len(aBanco[BCO_CODEMP]) <> 7, "-", "" )
		aTitulo[TIT_NNUMFORM] += If( Val(aTitulo[TIT_DVNNUM]) > 9, "X", aTitulo[TIT_DVNNUM])

		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
		//ï¿½ Grava Faixa atual do Nosso Numero e Portador no SE1     ï¿½
		//ï¿½                                                         ï¿½
		//ï¿½ A Gravacao do Nosso numero no SE1 sem o Dig Verificador ï¿½
		//ï¿½ devido aos criterios diferenciados de calculo entre os  ï¿½
		//ï¿½ Bancos. Sao recalculados a cada impressao               ï¿½
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½

		If Len(aBanco[BCO_CODEMP]) <> 7
			RecLock("SE1",.F.)
			// Tratamento do DV "X" realizado na gravacao do E1_NUMBCO, para evitar erros de conversao
			SE1->E1_NUMBCO  := aTitulo[TIT_NNUM] + If( Val(aTitulo[TIT_DVNNUM]) > 9, "X", aTitulo[TIT_DVNNUM])
			MsUnLock()
		Endif


	ElseIf	aBanco[BCO_NUMBCO] = SANTANDER

		cNNum    := SubStr(SE1->E1_NUMBCO,01,12)
		cDvNNum  := Mod11CB( cNNum , .F. )				//-- Calcula Primeiro DV Nosso Numero (Modulo 11)

		aTitulo[TIT_NNUM]     := cNNum
		aTitulo[TIT_DVNNUM]   := cDvNNum
		aTitulo[TIT_NNUMFORM] := aTitulo[TIT_NNUM] + "-" +aTitulo[TIT_DVNNUM]

		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
		//ï¿½ Grava Faixa atual do Nosso Numero e Portador no SE1     ï¿½
		//ï¿½                                                         ï¿½
		//ï¿½ A Gravacao do Nosso numero no SE1 sem o Dig Verificador ï¿½
		//ï¿½ devido aos criterios diferenciados de calculo entre os  ï¿½
		//ï¿½ Bancos. Sao recalculados a cada impressao               ï¿½
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		RecLock("SE1",.F.)
		SE1->E1_NUMBCO  := aTitulo[TIT_NNUM] + aTitulo[TIT_DVNNUM]
		MsUnLock()

	ElseIf	aBanco[BCO_NUMBCO] = BANRISUL

		cNNum    := SubStr(SE1->E1_NUMBCO,01,08)

		cNNumAux := cNNum
		cDv1NNum := Modulo10( cNNumAux )					//-- Calcula Primeiro DV Nosso Numero (Modulo 10)
		cNNumAux := cNNum + cDv1NNum
		cDv2NNum := Mod11B27B( cNNumAux )					//-- Calcula Segundo DV Nosso Numero (Modulo 11)

		aTitulo[TIT_NNUM]     := cNNum
		aTitulo[TIT_DVNNUM]   := cDv2NNum					//-- O DV 1 pode modificar devido o calculo do DV2
		//-- entï¿½o do DV 2 retorna os dois // Paola -01/2018
		aTitulo[TIT_NNUMFORM] := aTitulo[TIT_NNUM] + "." + aTitulo[TIT_DVNNUM]

		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
		//ï¿½ Grava Faixa atual do Nosso Numero e Portador no SE1     ï¿½
		//ï¿½                                                         ï¿½
		//ï¿½ A Gravacao do Nosso numero no SE1 sem o Dig Verificador ï¿½
		//ï¿½ devido aos criterios diferenciados de calculo entre os  ï¿½
		//ï¿½ Bancos. Sao recalculados a cada impressao               ï¿½
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		RecLock("SE1",.F.)
		SE1->E1_NUMBCO  := aTitulo[TIT_NNUM] + aTitulo[TIT_DVNNUM]
		MsUnLock()

	ElseIf	aBanco[BCO_NUMBCO] = CAIXA

		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
		//ï¿½ Para a Caixa o Nosso Numero e tamanho 15, nas primeiras versoes foram alterados os campos para 15. ï¿½
		//ï¿½ Mas, por  de dicionarios em versoes do Protheus passei a tratar somente com 12.             ï¿½
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		If	(Len(AllTrim(SE1->E1_NUMBCO)) = 12)

			cNNum   := "000" + SE1->E1_NUMBCO
		Else

			cNNum   := SE1->E1_NUMBCO

		EndIf

		//-- Monta String para Calculo do Digito Verificador
		cNNumAux += Iif( aBanco[BCO_CARTEIR] = "RG","1","2")//-- Carteira de Cobranca (1 Digitos)
		cNNumAux += "4"										//-- Emissao do boleto (4-Beneficiario)
		cNNumAux += cNNum									//-- Sequencial Nosso Numero
		cDvNNum := Mod11B29( AllTrim(cNNumAux) )		//-- Calcula DV Nosso Numero

		aTitulo[TIT_NNUM]     := cNNum
		aTitulo[TIT_DVNNUM]   := cDvNNum
		aTitulo[TIT_NNUMFORM] := Iif( aBanco[BCO_CARTEIR] = "RG","1","2") + "4" + aTitulo[TIT_NNUM] + "-" +aTitulo[TIT_DVNNUM]

	ElseIf	aBanco[BCO_NUMBCO] = BRADESCO

		cNNum   := SubStr(SE1->E1_NUMBCO,1,11)

		//-- Monta String para Calculo do Digito Verificador
		cNNumAux += aBanco[BCO_CARTEIR]	//-- Carteira de Cobranca (2 Digitos)
		cNNumAux += cNNum				//-- Sequencial Nosso Numero
		cDvNNum := Mod11B7( cNNumAux )  //-- Calcula DV Nosso Numero

		aTitulo[TIT_NNUM]     := cNNum
		aTitulo[TIT_DVNNUM]   := cDvNNum
		aTitulo[TIT_NNUMFORM] := aBanco[BCO_CARTEIR] + "/" + aTitulo[TIT_NNUM] + "-" + aTitulo[TIT_DVNNUM]

		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
		//ï¿½ Grava Faixa atual do Nosso Numero e Portador no SE1     ï¿½
		//ï¿½                                                         ï¿½
		//ï¿½ A Gravacao do Nosso numero no SE1 sem o Dig Verificador ï¿½
		//ï¿½ devido aos criterios diferenciados de calculo entre os  ï¿½
		//ï¿½ Bancos. Sao recalculados a cada impressao               ï¿½
		//ï¿½                                                         ï¿½
		//ï¿½ Somente para o Bradesco foi alterado para Gravar o DV   ï¿½
		//ï¿½ pois o mesmo e necessario ser enviado via CNAB          ï¿½
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		RecLock("SE1",.F.)
		If aBanco[BCO_MBCARD]= "1"
			SE1->E1_NUMBCO  := aTitulo[TIT_NNUM]
		Else
			SE1->E1_NUMBCO  := aTitulo[TIT_NNUM] + aTitulo[TIT_DVNNUM]
		Endif
		MsUnLock()

	ElseIf 	aBanco[BCO_NUMBCO] = ITAU

		cNNum   := SubStr(SE1->E1_NUMBCO,1,8)
		If  aBanco[BCO_CARTEIR]	$ "150" // Alteração para MOEDA 2 banco itau - carteira 150 // Paola 21.12.2021
			//-- Monta String para Calculo do Digito Verificador
			cNNumAux += aBanco[BCO_CARTEIR]	//-- Carteira de Cobranca (3 Digitos)
			cNNumAux += cNNum				//-- Sequencial Nosso Numero
			cDvNNum := Modulo10( cNNumAux , aBanco[BCO_NUMBCO])	//-- Calcula DV Nosso Numero
		Else

			//-- Monta String para Calculo do Digito Verificador
			cNNumAux := aBanco[BCO_NUMAGE]	//-- Numero da Agencia (4 Digitos)
			cNNumAux += aBanco[BCO_NUMCTA]	//-- Numero da Conta (5 Digitos)
			cNNumAux += aBanco[BCO_CARTEIR]	//-- Carteira de Cobranca (3 Digitos)
			cNNumAux += cNNum				//-- Sequencial Nosso Numero
			cDvNNum := Modulo10( cNNumAux , aBanco[BCO_NUMBCO])	//-- Calcula DV Nosso Numero

		Endif
		aTitulo[TIT_NNUM]     := cNNum
		aTitulo[TIT_DVNNUM]   := cDvNNum
		aTitulo[TIT_NNUMFORM] := aBanco[BCO_CARTEIR] + "/" + aTitulo[TIT_NNUM]+"-"+aTitulo[TIT_DVNNUM]

		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
		//ï¿½ Grava Faixa atual do Nosso Numero e Portador no SE1     ï¿½
		//ï¿½                                                         ï¿½
		//ï¿½ A Gravacao do Nosso numero no SE1 sem o Dig Verificador ï¿½
		//ï¿½ devido aos criterios diferenciados de calculo entre os  ï¿½
		//ï¿½ Bancos. Sao recalculados a cada impressao               ï¿½
		//ï¿½                                                         ï¿½
		//ï¿½ Somente para o Bradesco foi alterado para Gravar o DV   ï¿½
		//ï¿½ pois o mesmo e necessario ser enviado via CNAB          ï¿½
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		RecLock("SE1",.F.)
		SE1->E1_NUMBCO  := aTitulo[TIT_NNUM] + aTitulo[TIT_DVNNUM]
		MsUnLock()

	ElseIf	aBanco[BCO_NUMBCO] = HSBC

		If		aBanco[BCO_CARTEIR] = "CNR"

			cNNum    := SubStr(SE1->E1_NUMBCO,01,08)
			cDvNNum1 := Mod11B9(cNNum)      // 1o Digito verificador no Nosso Numero

			cNNumAux := AllTrim( Str( Val( cNNum + cDvNNum1 + "4" ) + Val(aBanco[BCO_CODEMP]) + Val( GravaData( cToD(aTitulo[TIT_DTVCTO]),.F.,1) ) ) )

			cDvNNum2 := Mod11B9( cNNumAux ) // 2o Digito verificador no Nosso Numero

			aTitulo[TIT_NNUM]     := cNNum
			aTitulo[TIT_DVNNUM]   := AllTrim( cDvNNum1 + "4" + cDvNNum2 )
			aTitulo[TIT_NNUMFORM] := aTitulo[TIT_NNUM] + aTitulo[TIT_DVNNUM]

		ElseIf	aBanco[BCO_CARTEIR] = "CSB"

			cNNum    := SubStr(SE1->E1_NUMBCO,01,10)
			cNNumAux := cNNum
			cDvNNum  := Mod11B7(cNNumAux) 	     //Digito verificador no Nosso Numero

			aTitulo[TIT_NNUM]     := cNNum
			aTitulo[TIT_DVNNUM]   := cDvNNum
			aTitulo[TIT_NNUMFORM] := aTitulo[TIT_NNUM] + " " + aTitulo[TIT_DVNNUM]

			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
			//ï¿½ Grava Faixa atual do Nosso Numero e Portador no SE1     ï¿½
			//ï¿½                                                         ï¿½
			//ï¿½ A Gravacao do Nosso numero no SE1 sem o Dig Verificador ï¿½
			//ï¿½ devido aos criterios diferenciados de calculo entre os  ï¿½
			//ï¿½ Bancos. Sao recalculados a cada impressao               ï¿½
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			RecLock("SE1",.F.)
			SE1->E1_NUMBCO  := aTitulo[TIT_NNUM] + aTitulo[TIT_DVNNUM]
			MsUnLock()

		EndIf

	ElseIf 	aBanco[BCO_NUMBCO] = SAFRA

		If 		aBanco[BCO_CARTEIR] = "06" //-- COBRANCA EXPRESS

			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
			//ï¿½ Em caso de cobranca sem registro (Express) o campo Nosso  ï¿½
			//ï¿½ Numero no corpo do boleto deve conter a literal "EXPRESS" ï¿½
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			aTitulo[TIT_NNUMFORM]  := "EXPRESS"

		ElseIf aBanco[BCO_CARTEIR] $ "01|02" //-- COBRANCA REGISTRADA! - Alterado PAOLA 13.08.2021

			cNNum   := SubStr(SE1->E1_NUMBCO,1,8)
			cDvNNum := Mod11B29(cNNum)

			aTitulo[TIT_NNUM]     := cNNum
			aTitulo[TIT_DVNNUM]   := cDvNNum
			aTitulo[TIT_NNUMFORM] := cNNum + cDvNNum

			RecLock("SE1", .F.)
			SE1->E1_IDCNAB := aTitulo[TIT_NNUM]+aTitulo[TIT_DVNNUM]  //AllTrim(SEE->EE_FAXATU) Alterado Paola 23.08
			SE1->E1_NUMBCO := aTitulo[TIT_NNUM]+aTitulo[TIT_DVNNUM]  //AllTrim(SEE->EE_FAXATU)
			MsUnlock()


		ElseIf aBanco[BCO_CARTEIR] = "09" //-- COBRANCA CORRESPONDENTE BRADESCO

			cNNum    := SubStr(SE1->E1_NUMBCO,1,8)
			cAnoVcto := Right(aTitulo[TIT_DTEMI], 2)

			cNNumAux += aBanco[BCO_CARTEIR]	           //-- Carteira de Cobranca (2 Digitos)
			cNNumAux += cAnoVcto                       //-- Ano Vencimento 2 digitos
			cNNumAux += cNNum                          //-- Sequencial Nosso Numero
			cNNumAux += Mod11B29(cNNum)                //-- Calcula DV Nosso Numero Safra

			cDvNNum  := Mod11B27( cNNumAux )            //-- Calcula DV Nosso Numero Bradesco

			aTitulo[TIT_NNUM]     := cNNum + Mod11B29(cNNum)
			aTitulo[TIT_DVNNUM]   := cDvNNum
			aTitulo[TIT_NNUMFORM] := aBanco[BCO_CARTEIR] + "/" + cAnoVcto + Space(1) + aTitulo[TIT_NNUM] + "-" + aTitulo[TIT_DVNNUM]

			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
			//ï¿½ Grava Faixa atual do Nosso Numero e Portador no SE1     ï¿½
			//ï¿½                                                         ï¿½
			//ï¿½ A Gravacao do Nosso numero no SE1 sem o Dig Verificador ï¿½
			//ï¿½ devido aos criterios diferenciados de calculo entre os  ï¿½
			//ï¿½ Bancos. Sao recalculados a cada impressao               ï¿½
			//ï¿½                                                         ï¿½
			//ï¿½ Somente para o Bradesco foi alterado para Gravar o DV   ï¿½
			//ï¿½ pois o mesmo e necessario ser enviado via CNAB          ï¿½
			//ï¿½                                                         ï¿½
			//ï¿½ Neste caso, para o Banco Safra, Não ï¿½ necessï¿½rio o DV   ï¿½
			//ï¿½ do Banco Correspondente, apenas o DV do Banco Safra     ï¿½
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			RecLock("SE1",.F.)
			SE1->E1_NUMBCO  := aTitulo[TIT_NNUM]
			MsUnLock()

		EndIf

	ElseIf 	aBanco[BCO_NUMBCO] = FIBRA

		If 		aBanco[BCO_CARTEIR] = "19" //-- COBRANCA CORRESPONDENTE BRADESCO

			cNNum   := SubStr(SE1->E1_NUMBCO,1,11)

			//-- Monta String para Calculo do Digito Verificador
			cNNumAux += aBanco[BCO_CARTEIR]	//-- Carteira de Cobranca (2 Digitos)
			cNNumAux += cNNum				//-- Sequencial Nosso Numero
			cDvNNum := Mod11B7( cNNumAux )  //-- Calcula DV Nosso Numero

			aTitulo[TIT_NNUM]     := cNNum
			aTitulo[TIT_DVNNUM]   := cDvNNum
			aTitulo[TIT_NNUMFORM] := aBanco[BCO_CARTEIR] + "/" + aTitulo[TIT_NNUM] + "-" + aTitulo[TIT_DVNNUM]

			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
			//ï¿½ Grava Faixa atual do Nosso Numero e Portador no SE1     ï¿½
			//ï¿½                                                         ï¿½
			//ï¿½ A Gravacao do Nosso numero no SE1 sem o Dig Verificador ï¿½
			//ï¿½ devido aos criterios diferenciados de calculo entre os  ï¿½
			//ï¿½ Bancos. Sao recalculados a cada impressao               ï¿½
			//ï¿½                                                         ï¿½
			//ï¿½ Somente para o Bradesco foi alterado para Gravar o DV   ï¿½
			//ï¿½ pois o mesmo e necessario ser enviado via CNAB          ï¿½
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			RecLock("SE1",.F.)
			SE1->E1_NUMBCO  := aTitulo[TIT_NNUM] + aTitulo[TIT_DVNNUM]
			MsUnLock()

		EndIf

	ElseIf 	aBanco[BCO_NUMBCO] = SICREDI

		cAnoAtual := Right(CValToChar(Year( Date() )), 2)
		cNNum     := Left(SE1->E1_NUMBCO, 5)

		// Tratamento para a reimpressï¿½o do boleto,
		// evitando que seja gerado um novo nosso nï¿½mero
		If Len( AllTrim(SE1->E1_NUMBCO) ) > 5
			cNNum := SubStr(SE1->E1_NUMBCO, 4, 5)
		EndIf

		// Calculo do DV do Nosso Numero
		cNNumAux  += aBanco[BCO_NUMAGE]         //-- Agencia cedente
		cNNumAux  += aBanco[BCO_POSTO]          //-- Posto cedente
		cNNumAux  += aBanco[BCO_NUMCTA]         //-- Conta cedente
		cNNumAux  += cAnoAtual                  //-- Ano atual
		cNNumAux  += "2"                        //-- Indicador de geracao do Nosso Numero (2 a 9)
		cNNumAux  += cNNum                      //-- Sequencial Nosso Numero

		cDvNNum   += Mod11B29(cNNumAux)

		aTitulo[TIT_NNUM]     := Right(cNNumAux, 8)
		aTitulo[TIT_DVNNUM]   := cDvNNum
		aTitulo[TIT_NNUMFORM] := cAnoAtual + "/" + SubStr(cNNumAux, 14,1) + cNNum + "-" + cDvNNum


		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
		//ï¿½ Grava Faixa atual do Nosso Numero e Portador no SE1     ï¿½
		//ï¿½                                                         ï¿½
		//ï¿½ A Gravacao do Nosso numero no SE1 sem o Dig Verificador ï¿½
		//ï¿½ devido aos criterios diferenciados de calculo entre os  ï¿½
		//ï¿½ Bancos. Sao recalculados a cada impressao               ï¿½
		//ï¿½                                                         ï¿½
		//ï¿½ Somente para o Bradesco foi alterado para Gravar o DV   ï¿½
		//ï¿½ pois o mesmo e necessario ser enviado via CNAB          ï¿½
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		RecLock("SE1",.F.)
		SE1->E1_NUMBCO  := aTitulo[TIT_NNUM] + aTitulo[TIT_DVNNUM]
		MsUnLock()

	ElseIf 	aBanco[BCO_NUMBCO] = REDASSET

		If 		aBanco[BCO_CARTEIR] = "09" //-- COBRANCA CORRESPONDENTE BRADESCO

			cNNum   := SubStr(SE1->E1_NUMBCO,1,11)

			//-- Monta String para Calculo do Digito Verificador
			cNNumAux += aBanco[BCO_CARTEIR]	//-- Carteira de Cobranca (2 Digitos)
			cNNumAux += cNNum				//-- Sequencial Nosso Numero
			cDvNNum := Mod11B7( cNNumAux )  //-- Calcula DV Nosso Numero

			aTitulo[TIT_NNUM]     := cNNum
			aTitulo[TIT_DVNNUM]   := cDvNNum
			aTitulo[TIT_NNUMFORM] := aBanco[BCO_CARTEIR] + "/" + aTitulo[TIT_NNUM] + "-" + aTitulo[TIT_DVNNUM]

			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
			//ï¿½ Grava Faixa atual do Nosso Numero e Portador no SE1     ï¿½
			//ï¿½                                                         ï¿½
			//ï¿½ A Gravacao do Nosso numero no SE1 sem o Dig Verificador ï¿½
			//ï¿½ devido aos criterios diferenciados de calculo entre os  ï¿½
			//ï¿½ Bancos. Sao recalculados a cada impressao               ï¿½
			//ï¿½                                                         ï¿½
			//ï¿½ Somente para o Bradesco foi alterado para Gravar o DV   ï¿½
			//ï¿½ pois o mesmo e necessario ser enviado via CNAB          ï¿½
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			RecLock("SE1",.F.)
			SE1->E1_NUMBCO  := aTitulo[TIT_NNUM] + aTitulo[TIT_DVNNUM]
			MsUnLock()

		EndIf

	ElseIf 	aBanco[BCO_NUMBCO] = BBM

		If 		aBanco[BCO_CARTEIR] = "09" //-- COBRANCA CORRESPONDENTE BRADESCO

			cNNum   := SubStr(SE1->E1_NUMBCO,1,11)

			//-- Monta String para Calculo do Digito Verificador
			cNNumAux += aBanco[BCO_CARTEIR]	//-- Carteira de Cobranca (2 Digitos)
			cNNumAux += cNNum				//-- Sequencial Nosso Numero
			cDvNNum := Mod11B7( cNNumAux )  //-- Calcula DV Nosso Numero

			aTitulo[TIT_NNUM]     := cNNum
			aTitulo[TIT_DVNNUM]   := cDvNNum
			aTitulo[TIT_NNUMFORM] := aBanco[BCO_CARTEIR] + "/" + aTitulo[TIT_NNUM] + "-" + aTitulo[TIT_DVNNUM]

			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
			//ï¿½ Grava Faixa atual do Nosso Numero e Portador no SE1     ï¿½
			//ï¿½                                                         ï¿½
			//ï¿½ A Gravacao do Nosso numero no SE1 sem o Dig Verificador ï¿½
			//ï¿½ devido aos criterios diferenciados de calculo entre os  ï¿½
			//ï¿½ Bancos. Sao recalculados a cada impressao               ï¿½
			//ï¿½                                                         ï¿½
			//ï¿½ Somente para o Bradesco foi alterado para Gravar o DV   ï¿½
			//ï¿½ pois o mesmo e necessario ser enviado via CNAB          ï¿½
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			RecLock("SE1",.F.)
			SE1->E1_NUMBCO  := aTitulo[TIT_NNUM] + aTitulo[TIT_DVNNUM]
			MsUnLock()

		EndIf

	ElseIf 	aBanco[BCO_NUMBCO] = ABC

		If aBanco[BCO_CARTEIR] = "109" // Banco Correspondente

			cNNum   := SubStr(SE1->E1_NUMBCO,1,8)

			//-- Monta String para Calculo do Digito Verificador
			cNNumAux := aBanco[BCO_AGECOR]	//-- Numero da Agencia (4 Digitos)
			cNNumAux += aBanco[BCO_NCTACO]	//-- Numero da Conta (8 Digitos)
			cNNumAux += aBanco[BCO_CARTEIR]	//-- Carteira de Cobranca (3 Digitos)
			cNNumAux += cNNum				//-- Sequencial Nosso Numero
			cDvNNum := Modulo10( cNNumAux , aBanco[BCO_BCOCOR])	//-- Calcula DV Nosso Numero

			aTitulo[TIT_NNUM]     := cNNum
			aTitulo[TIT_DVNNUM]   := cDvNNum
			aTitulo[TIT_NNUMFORM] := aBanco[BCO_CARTEIR] + "/" + aTitulo[TIT_NNUM]+"-"+aTitulo[TIT_DVNNUM]

			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
			//ï¿½ Grava Faixa atual do Nosso Numero e Portador no SE1     ï¿½
			//ï¿½                                                         ï¿½
			//ï¿½ A Gravacao do Nosso numero no SE1 sem o Dig Verificador ï¿½
			//ï¿½ devido aos criterios diferenciados de calculo entre os  ï¿½
			//ï¿½ Bancos. Sao recalculados a cada impressao               ï¿½
			//ï¿½                                                         ï¿½
			//ï¿½ Somente para o Bradesco foi alterado para Gravar o DV   ï¿½
			//ï¿½ pois o mesmo e necessario ser enviado via CNAB          ï¿½
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			RecLock("SE1",.F.) //Paola - 10/06/2015
			SE1->E1_NUMBCO  := aTitulo[TIT_NNUM] + aTitulo[TIT_DVNNUM]
			MsUnLock()

		ElseIf aBanco[BCO_CARTEIR] $ "110|121" // Cobranï¿½a Direta

			cNNum   := SubStr(SE1->E1_NUMBCO,1,10)

			//-- Monta String para Calculo do Digito Verificador
			cNNumAux := aBanco[BCO_NUMAGE]	//-- Numero da Agencia (4 Digitos)
			cNNumAux += aBanco[BCO_CARTEIR]	//-- Carteira de Cobranca (3 Digitos)
			cNNumAux += cNNum				//-- Sequencial Nosso Numero (10 Digitos)
			cDvNNum  := Modulo10( cNNumAux , aBanco[BCO_NUMBCO] )	//-- Calcula DV Nosso Numero

			aTitulo[TIT_NNUM]     := cNNum
			aTitulo[TIT_DVNNUM]   := cDvNNum
			aTitulo[TIT_NNUMFORM] := aBanco[BCO_CARTEIR] + "/" + aTitulo[TIT_NNUM]+"-"+aTitulo[TIT_DVNNUM]

			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
			//ï¿½ Grava Faixa atual do Nosso Numero e Portador no SE1     ï¿½
			//ï¿½                                                         ï¿½
			//ï¿½ A Gravacao do Nosso numero no SE1 sem o Dig Verificador ï¿½
			//ï¿½ devido aos criterios diferenciados de calculo entre os  ï¿½
			//ï¿½ Bancos. Sao recalculados a cada impressao               ï¿½
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			RecLock("SE1",.F.) //Paola - 10/06/2015
			SE1->E1_NUMBCO  := aTitulo[TIT_NNUM] + aTitulo[TIT_DVNNUM]
			MsUnLock()

		EndIf

	ElseIf		aBanco[BCO_NUMBCO] = VOTORANTIM

		cNNum := SubStr(SE1->E1_NUMBCO,1,10)

		//-- Monta String para Calculo do Digito Verificador
		cNNumAux := aBanco[BCO_CODEMP]	//-- Numero da Agencia (4 Digitos)
		cNNumAux += cNNum				//-- Sequencial Nosso Numero

		aTitulo[TIT_NNUM]     := cNNum
		aTitulo[TIT_DVNNUM]   := ""
		aTitulo[TIT_NNUMFORM] := aBanco[BCO_CODEMP] + aTitulo[TIT_NNUM]

	ElseIf		aBanco[BCO_NUMBCO] = NORDESTE

		cNNum   := SubStr(SE1->E1_NUMBCO,1,7)
		cDvNNum := Mod11B8(AllTrim(cNNum))

		aTitulo[TIT_NNUM]     := cNNum
		aTitulo[TIT_DVNNUM]   := cDvNNum
		aTitulo[TIT_NNUMFORM] := cNNum + "-" + cDvNNum   // + Space(5) + aBanco[BCO_CARTEIR] - nosso numero sem carteira - Paola - 10/06/2015

		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
		//ï¿½ Grava Faixa atual do Nosso Numero e Portador no SE1     ï¿½
		//ï¿½                                                         ï¿½
		//ï¿½ A Gravacao do Nosso numero no SE1 sem o Dig Verificador ï¿½
		//ï¿½ devido aos criterios diferenciados de calculo entre os  ï¿½
		//ï¿½ Bancos. Sao recalculados a cada impressao               ï¿½
		//ï¿½                                                         ï¿½
		//ï¿½ Somente para o Bradesco foi alterado para Gravar o DV   ï¿½
		//ï¿½ pois o mesmo e necessario ser enviado via CNAB          ï¿½
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		RecLock("SE1",.F.)  //Paola - 10/06/2015
		SE1->E1_NUMBCO  := aTitulo[TIT_NNUM] + aTitulo[TIT_DVNNUM]
		MsUnLock()


	ElseIf		aBanco[BCO_NUMBCO] = CITIBANK

		cNNum   := SubStr(SE1->E1_NUMBCO,1,11)
		cDvNNum := Mod11B29(cNNum)

		aTitulo[TIT_NNUM]     := cNNum
		aTitulo[TIT_DVNNUM]   := cDvNNum
		aTitulo[TIT_NNUMFORM] := cNNum + " " + cDvNNum


		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
		//ï¿½ Grava Faixa atual do Nosso Numero e Portador no SE1     ï¿½
		//ï¿½                                                         ï¿½
		//ï¿½ A Gravacao do Nosso numero no SE1 sem o Dig Verificador ï¿½
		//ï¿½ devido aos criterios diferenciados de calculo entre os  ï¿½
		//ï¿½ Bancos. Sao recalculados a cada impressao               ï¿½
		//ï¿½                                                         ï¿½
		//ï¿½ Somente para o Bradesco foi alterado para Gravar o DV   ï¿½
		//ï¿½ pois o mesmo e necessario ser enviado via CNAB          ï¿½
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		RecLock("SE1",.F.)
		SE1->E1_NUMBCO  := aTitulo[TIT_NNUM] + aTitulo[TIT_DVNNUM]
		MsUnLock()

	elseif	aBanco[BCO_NUMBCO] = SICOOB //Paola em 03.24

		cNNum   := subStr(SE1->E1_NUMBCO,1,9)
			/*
		    Formato dos campos:
			Cooperativa = 4 posicao numericas (fornecido pela Cooperativa)
			Cta Cliente = 9 posicao numericas (fornecido pela Cooperativa)
			Digito Cliente = 1 posicao(fornecido pela Cooperativa)
			Nosso nro = 7 posicao (sequencial de acordo com a necessidade do cliente) 
			*/
		cNNumAux :=aBanco[BCO_NUMAGE]	//-- Numero da Agencia (4 Digitos)
		cNNumAux +=STRZERO(VAL(aBanco[BCO_CODEMP]),10)
		cNNumAux +=Alltrim(cNNum)	//-- Sequencial Nosso Numero

		cDvNNum := Mod11756(Alltrim(cNNumAux) )//Mod11B9(cNNum)
		aTitulo[TIT_NNUM]     := cNNum
		aTitulo[TIT_DVNNUM]   := cDvNNum
		aTitulo[TIT_NNUMFORM] := cNNum + "" + cDvNNum

		//+---------------------------------------------------------+
		//| Grava Faixa atual do Nosso Numero e Portador no SE1     |
		//|                                                         |
		//| A Gravacao do Nosso numero no SE1 sem o Dig Verificador |
		//| devido aos criterios diferenciados de calculo entre os  |
		//| Bancos. Sao recalculados a cada impressao               |
		//+---------------------------------------------------------+


		recLock("SE1",.f.)
		// Tratamento do DV "X" realizado na gravacao do E1_NUMBCO, para evitar erros de conversao
		SE1->E1_NUMBCO  := aTitulo[TIT_NNUM] +  aTitulo[TIT_DVNNUM]
		msUnLock()

	EndIf

	RestArea(aArea)

Return( )

/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
	±±³Programa  ³F001CodBar ³ Autor ³ Fabio Briddi         ³ Data ³ Nov/2013 ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Descricao ³ Monta o Codigo de Barras                                   ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Parametros³ aBanco = Array com Dados do Banco Selecionado              ³±±
	±±³          ³ aTitulos = Array com Informacoes do Titulo sendo impresso  ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Retorno   ³ Nenhum                                                     ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Uso       ³ TRSF001                                                    ³±±
	±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function F001CodBar( aBanco, aTitulo, nValor )

	Local dDtBase	   := CTOD("07/10/1997")
	Local cFatorVencto := ""
	Local cValor       := ""
	Local cPsq         := ""
	Local cCpoLivre    := ""

	//-- Calculo do Fator de Vencimento do Titulo
	//Para o Banco do Brasil o vencimento na linha digitável fica o original o registrado no envio -- Paola 26.08.2021
	if aBanco[BCO_NUMBCO] = BRASIL  .OR. aBanco[BCO_NUMBCO] = ITAU  .OR. aBanco[BCO_NUMBCO] = SANTANDER
		//Adicionada Regra para fator de Vencimento a partir de 22/02/2025 - Rogério Duarte
		if SE1->E1_VENCORIG > ctod('21/02/2025')
			cFatorVencto := Str(  999 + SE1->E1_VENCORIG  -  CToD( "21/02/2025"  ), 4  )
		else
			cFatorVencto := StrZero( SE1->E1_VENCORIG - dDtBase, 4 ) //Paola 23.08.2021
		endif
	Else
		//Adicionada Regra para fator de Vencimento a partir de 22/02/2025 - Rogério Duarte
		if CTOD(aTitulo[TIT_DTVCTO]) > ctod('21/02/2025')
			cFatorVencto := Str(  999 + CTOD(aTitulo[TIT_DTVCTO])  -  CToD( "21/02/2025"  ), 4  )
		else
			cFatorVencto := StrZero( CTOD(aTitulo[TIT_DTVCTO]) - dDtBase, 4 ) //Paola - alterado em 23.08.2021 os bancos não alteram o vencimento
		endif
	Endif	                                                                    //original no código de barras e linha digitável

	IF aBanco[BCO_NUMBCO] = SICOOB
		//Adicionada Regra para fator de Vencimento a partir de 22/02/2025 - Rogério Duarte
		if CTOD(aTitulo[TIT_DTVCTO]) > ctod('21/02/2025')
			dDtBase	   := CTOD("22/05/2025")  
			cFatorVencto := StrZero( CTOD(aTitulo[TIT_DTVCTO]) - dDtBase +1000, 4 )

		else 
			dDtBase	   := CTOD("03/07/2000")  //= 03/07/2000 (
			cFatorVencto := StrZero( CTOD(aTitulo[TIT_DTVCTO]) - dDtBase +1000, 4 )
		endif
	Endif


	// Alteração para MOEDA 2 banco itau - carteira 150 // Paola 21.12.2021
	If	aBanco[BCO_NUMBCO] = ITAU .AND. aBanco[BCO_CARTEIR] =='150'
		cValor       :=  "0000000000" //StrZero( (SE1->E1_SALDO*100), 10)
	Else

		If	aBanco[BCO_NUMBCO] = BRASIL .OR. 	aBanco[BCO_NUMBCO] = BRADESCO  .or. (aBanco[BCO_NUMBCO] = ITAU .AND.  aBanco[BCO_CARTEIR] <>'150') .OR. aBanco[BCO_NUMBCO] = SANTANDER //Se for banco do Brasil . sempre considerar o saldo do título na geração do bordero. Paola - 16.08.2021

			nValorImp  := If(lVlrOrigi, SE1->E1_VLCRUZ, xMoeda(SE1->E1_SALDO,SE1->E1_MOEDA,1,DdataBase) )
			//Valor do Abatimento titulo tipo AB-
			nValAbat   := SumAbatRec( SE1->E1_PREFIXO, SE1->E1_NUM, SE1->E1_PARCELA, SE1->E1_MOEDA, "S", dDataBase, @nTotAbImp, @nTotIrAbt, @nTotCsAbt, @nTotPisAbt, @nTotCofAbt, @nTotInsAbt, @nTotIssAbt, @nTotTitAbt )

			If aBanco[BCO_NUMBCO] = ITAU .OR. aBanco[BCO_NUMBCO] = BRADESCO  .OR. aBanco[BCO_NUMBCO] = SANTANDER // Estes bancos o valor impresso é sempre o original- Paola 23.08.2021

				nValorImp  :=SaldoTit(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_TIPO,SE1->E1_NATUREZ,"R",SE1->E1_CLIENTE,1,dDatabase,IIF(Empty(SE1->E1_DATABOR),DdataBase,SE1->E1_DATABOR),SE1->E1_LOJA,,SE1->E1_TXMOEDA,1,.T.)
				// Se o cliente não quer considerar o título do abatimento AB- no valor impresso do boleto
				IF lAbatVlr
					nValorImp:= nValorImp - nValAbat
				Endif

			Endif

			If aBanco[BCO_NUMBCO] = ITAU .OR. aBanco[BCO_NUMBCO] = BRADESCO  .OR. aBanco[BCO_NUMBCO] = SANTANDER // Estes bancos o valor impresso é sempre o original- Paola 23.08.2021
				cValor:= nValorImp
			Else
				cValor   := nValorImp - SE1->E1_DECRESC + SE1->E1_ACRESC
				iF lAbatVlr
					cValor   := cValor - nValAbat
				Endif
			Endif

			cValor:=StrZero((cValor*100),10)
			//                 1               2              3             4              5           6       7          8     9         10              11         12      13

		Else
			cValor       := StrZero( (aTitulo[TIT_VALOR]*100), 10) // Retirei as informações acima a pedido do cliente MAZER que é o único que utiliza em 10/12/18
		EndIF

	Endif // Moeda 2 -Itau


	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
	//ï¿½ Montagem dos Dados Para o Codigo de Barras                     ï¿½
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
	//ï¿½ Da Posicao 01 a 19 e igual para Todos os Bancos               ï¿½
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	
	cCodBar := aBanco[BCO_NUMBCO]			//-- 01-03 - Codigo do Banco
	cCodBar += "9"							//-- 04-04 - Codigo da Moeda
	cCodBar += ""							//-- 05-05 - DAC do Codigo de Barras
	cCodBar += cFatorVencto					//-- 06-09 - Fator de Vencimento
	cCodBar += cValor						//-- 10-19 - Valor
	
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
	//ï¿½ Da Posicao 20 a 44 Campo Livre de Acordo com o Manual do Banco ï¿½
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	If	 	aBanco[BCO_NUMBCO] = BRASIL

		If		Len( aBanco[BCO_CODEMP] ) = 4

			cCodBar += aBanco[BCO_CODEMP]						//-- 20-23 - Cod Empresa (fornecido pelo banco)
			cCodBar += aTitulo[TIT_NNUM]						//-- 24-30 - Sequencial Nosso Numero
			cCodBar += aBanco[BCO_NUMAGE]						//-- 31-34 - Agencia
			cCodBar += StrZero(Val( aBanco[BCO_NUMCTA] ),8,0)   //-- 35-42 - Conta corrente
			cCodBar += aBanco[BCO_CARTEIR]						//-- 43-44 - Carteira

		ElseIf Len( aBanco[BCO_CODEMP] ) = 6

			cCodBar += aBanco[BCO_CODEMP]						//-- 20-25 - Cod Empresa (fornecido pelo banco)
			cCodBar += aTitulo[TIT_NNUM]						//-- 26-30 - Sequencial Nosso Numero
			cCodBar += aBanco[BCO_NUMAGE]						//-- 31-34 - Agencia
			cCodBar += StrZero(Val( aBanco[BCO_NUMCTA] ),8,0)   //-- 35-42 - Conta corrente
			cCodBar += aBanco[BCO_CARTEIR]						//-- 43-44 - Carteira

		ElseIf	Len( aBanco[BCO_CODEMP] ) = 7

			cCodBar += Replicate("0",6)	   						//-- 20-25 - Zeros fixos
			cCodBar += aBanco[BCO_CODEMP]						//-- 26-32 - Cod Empresa
			cCodBar += aTitulo[TIT_NNUM]						//-- 33-42 - Sequencial Nosso Numero
			cCodBar += aBanco[BCO_CARTEIR]						//-- 43-44 - Carteira

		EndIf

	ElseIf	aBanco[BCO_NUMBCO] = SANTANDER

		cCodBar += "9"										//-- 20-20 - Constante 9
		cCodBar += Left(aBanco[BCO_CODEMP],7)	  			//-- 21-27 - Cod. Beneficiario
		cCodBar += aTitulo[TIT_NNUM]						//-- 28-39 - Nosso Numero
		cCodBar += aTitulo[TIT_DVNNUM]						//-- 40-40 - Dig Verificador Nosso Numero
		cCodBar += "0"										//-- 41-41 - Constante 0
		cCodBar += aBanco[BCO_CARTEIR]						//-- 42-44 - Carteira

	ElseIf	aBanco[BCO_NUMBCO] = BANRISUL

		cCpoLivre := "2"									//-- 20-20 - Produto:
		//-- 1-Cobranca Normal / 2-Cobranca Direta (Emisssao Cliente)
		cCpoLivre += "1"									//-- 21-21 - Constante 1
		cCpoLivre += aBanco[BCO_NUMAGE]						//-- 22-25 - Agencia Cedente (Cobranca)
		cCpoLivre += Left(aBanco[BCO_CODEMP],7)	  			//-- 26-32 - Cod. Beneficiario
		cCpoLivre += aTitulo[TIT_NNUM]						//-- 33-40 - Sequencial Nosso Numero
		cCpoLivre += "40"									//-- 41-42 - Constante 40

		cCpoAux  := cCpoLivre
		cDv1Cpo  := Modulo10( cCpoLivre )					//-- Calcula Primeiro DV Pos 20 a 42 Campo Livre (Modulo 10)
		cCpoAux  := cCpoLivre + cDv1Cpo
		cDv2Cpo  := Mod11B27B( cCpoAux )					//-- Calcula Segundo DV Pos 20 a 42 Campo Livre (Modulo 11)

		cCodBar  += cCpoLivre + cDv2Cpo						//-- 43-44 - Duplo Dï¿½gito referente ï¿½s posiï¿½ï¿½es 20 a 42 (mï¿½dulos 10 e 11)
		// O DV 1 pode modificar apï¿½s o calculo do DV 2 entï¿½o
		// o DV 2 Volta com os dois - Paola - 01/2018
	ElseIf	aBanco[BCO_NUMBCO] = CAIXA

		cDvCodEmp := ""  // DV do cod. Beneficiario
		cDv1Cpo   := ""  // DV do campo livre
		cDv1cBar  := ""  // DV do codigo de barras
		//Para beneficiário com código entre as faixas 000001 e 999999, utilizar as posições 20 a 25 e calcular o DV do Código do Beneficiário, a ser informado na posição 26, através do Modulo 11
		//cCpoLivre += AllTrim(aBanco[BCO_CODEMP])               //-- 20-26 - Cod. Beneficiario
		cCpoLivre += AllTrim(Left(aBanco[BCO_CODEMP],6))		//-- 20-25 - Cod. Beneficiario (Alterado Rogerio Duarte 12/05/2025)		
		cDvCodEmp := Mod11B29(AllTrim(Left(aBanco[BCO_CODEMP],6)))     //-- 26-26 - DV do Cod. Beneficiario
		cCpoLivre += cDvCodEmp                                 //Calcula o DV do COd. Beneficiario
		cCpoLivre += SubStr(aTitulo[TIT_NNUMFORM], 3, 3)       //-- 27-29 - Posicao 3 a 5 do Nosso Numero
		cCpoLivre += Iif( aBanco[BCO_CARTEIR] = "RG","1","2")  //-- 30-30 - Tipo de Cobranca (1-Registrada / 2-Sem Registro)
		cCpoLivre += SubStr(aTitulo[TIT_NNUMFORM], 6, 3)       //-- 31-33 - Posicao 6 a 8 do Nosso Numero
		cCpoLivre += "4"                                       //-- 34-34 - Identificador de Emissao do Boleto (4-Beneficiario)
		cCpoLivre += SubStr(aTitulo[TIT_NNUMFORM], 9, 9)       //-- 35-43 - Posicao 9 a 17 do Nosso Numero

		cCodBen := AllTrim(aBanco[BCO_CODEMP]) + AllTrim(aTitulo[TIT_DVNNUM])
		//cNNum   := Iif( aBanco[BCO_CARTEIR] = "RG","1","2") + "4" + AllTrim(aTitulo[TIT_NNUM])

		cDv1Cpo +=Mod11B29(AllTrim(cCpoLivre))//-- 44-44 - Digito Campo livre
		cCodBar +=cCpoLivre  + cDv1Cpo //Codigo de barras = campo livre + DV do campo livre

	ElseIf	aBanco[BCO_NUMBCO] = BRADESCO

		cCodBar += AllTrim(aBanco[BCO_NUMAGE])				//-- 20-23 - Agencia Cedente (Cobranca)
		cCodBar += AllTrim(aBanco[BCO_CARTEIR])				//-- 24-25 - Carteira
		cCodBar += aTitulo[TIT_NNUM]						//-- 26-36 - Sequencial Nosso Numero
		cCodBar += AllTrim(aBanco[BCO_NUMCTA]) 				//-- 37-43 - Conta Cedente (Cobranca)
		cCodBar += "0"										//-- 44-44 - Zero fixo

	ElseIf	aBanco[BCO_NUMBCO] = ITAU

		cCodBar += aBanco[BCO_CARTEIR]						//-- 20-22 - Carteira
		cCodBar += aTitulo[TIT_NNUM]						//-- 23-30 - Nosso Numero
		cCodBar += aTitulo[TIT_DVNNUM]						//-- 31-31 - DAC Age+Cta+Cart+Nosso numero
		cCodBar += AllTrim(aBanco[BCO_NUMAGE])				//-- 32-35 - Agencia
		cCodBar += AllTrim(aBanco[BCO_NUMCTA])				//-- 36-40 - Conta Corrente
		cCodBar += AllTrim(aBanco[BCO_DVCTA])				//-- 41-41 - DAC Conta
		cCodBar += "000"									//-- 42-44 - Posicoes Livres (zeros)

	ElseIf 	aBanco[BCO_NUMBCO] = HSBC

		If	aBanco[BCO_CARTEIR] = "CNR"

			cAno    := StrZero(Year(cToD(aTitulo[TIT_DTVCTO])),4)
			dPriAno := CTOD("01/01/"+cAno)
			cVencJul:= StrZero((cToD(aTitulo[TIT_DTVCTO]) - dPriAno)+1,3)

			cCodBar += aBanco[BCO_CODEMP]					//-- 20-26 - Codigo Beneficiario
			cCodBar += "00000" + AllTrim(aTitulo[TIT_NNUM]) //-- 27-39 - Sequencial Nosso Numero
			cCodBar += cVencJul								//-- 40-43 - Data Vencimento Formato Juliano
			cCodBar += Right(cAno,1)						//-- 44-44 - Correspondem ao algarismo final do ano da data de vencimento
			cCodBar += "2"									//-- 45-45 - Codigo do Produto CNR, deve preencher o numero 2.

		ElseIf aBanco[BCO_CARTEIR] = "CSB"

			cCodBar += aTitulo[TIT_NNUM]					//-- 20-29 - Sequencial Nosso Numero
			cCodBar += aTitulo[TIT_DVNNUM]					//-- 30-30 - Digito Verificador	Nosso Numero
			cCodBar += AllTrim(aBanco[BCO_NUMAGE])			//-- 31-34 - Agencia
			cCodBar += AllTrim(aBanco[BCO_CODEMP])			//-- 35-41 - Conta Cobranca (EE_CODEMP)
			cCodBar += "00"									//-- 42-43 - Codigo Carteira
			cCodBar += "1"									//-- 44-44 - Codigo do aplicativo da Cobranca (COB) = '1'

		EndIf

	ElseIf	aBanco[BCO_NUMBCO] = SAFRA

		If	aBanco[BCO_CARTEIR] = "06"                       	//-- COBRANCA EXPRESS

			cCodBar += "7"                                   	//-- 20    - Digito Banco Safra
			cCodBar += Left(aBanco[BCO_CODEMP],6)            	//-- 21-26 - Identificacao do Beneficiario
			cCodBar += AllTrim(SEE->EE_FAXATU)               	//-- 27-36 - No. livre do cliente (Faixa Sequencial)
			cCodBar += PadL(aBanco[BCO_CODEMP],7,"0")        	//-- 37-43 - No. livre do cliente (Codigo Empresa)
			cCodBar += "4"                                   	//-- 44    - Tipo de Cobranca (Nao registrada)

		ElseIf aBanco[BCO_CARTEIR] $ "01|02"                   	//-- COBRANCA REGISTRADA  -Alterado Paola 13.08.2021

			cCodBar += "7"                                   	//-- 20    - Digito Banco Safra
			cCodBar += AllTrim(aBanco[BCO_NUMAGE])           	//-- 21-25 - Agencia do Cliente
			cCodBar += AllTrim(aBanco[BCO_NUMCTA])           	//-- 26-34 - Conta Corrente
			cCodBar += aTitulo[TIT_NNUM]                     	//-- 35-42 - Nosso Numero
			cCodBar += aTitulo[TIT_DVNNUM]                   	//-- 43-43 - DV Nosso Numero
			cCodBar += "2"                                   	//-- 44    - Tipo de Cobranca (Registrada)

		ElseIf aBanco[BCO_CARTEIR] = "09"                   	//-- COBRANCA CORRESPONDENTE BRADESCO

			cAno := Str( Year( Date() ) )

			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
			//ï¿½ Substitui os 3 primeiros digitos do banco cedente, no ï¿½
			//ï¿½ codigo de barras, pelo banco correspondente           ï¿½
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			If !Empty(aBanco[BCO_BCOCOR])

				cPsq	:= Left(cCodBar, 3)
				cCodBar := StrTran(cCodBar, cPsq, AllTrim(aBanco[BCO_BCOCOR]))

			EndIf

			cCodBar += AllTrim(aBanco[BCO_AGECOR])           	//-- 20-23 - Agencia Beneficiario
			cCodBar += aBanco[BCO_CARTEIR]                   	//-- 24-25 - Carteira
			cCodBar += Right(cAno, 2)                        	//-- 26-27 - Ano Emissao do Boleto
			cCodBar += aTitulo[TIT_NNUM]                     	//-- 28-35 - Nosso Numero Safra
//			cCodBar += Mod11B29(aTitulo[TIT_NNUM])					//-- 36-36 - DV Nosso Numero Safra
			cCodBar += AllTrim(aBanco[BCO_NCTACO])           	//-- 37-43 - Conta Beneficiario
			cCodBar += "0"                                   	//-- 44-44 - Zero fixo

		EndIf

	ElseIf	aBanco[BCO_NUMBCO] = FIBRA

		If aBanco[BCO_CARTEIR] = "19"                   		//-- COBRANCA CORRESPONDENTE BRADESCO

			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
			//ï¿½ Substitui os 3 primeiros digitos do banco cedente, no ï¿½
			//ï¿½ codigo de barras, pelo banco correspondente           ï¿½
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			If !Empty(aBanco[BCO_BCOCOR])

				cPsq	:= Left(cCodBar, 3)
				cCodBar := StrTran(cCodBar, cPsq, AllTrim(aBanco[BCO_BCOCOR]))

			EndIf

			cCodBar += AllTrim(aBanco[BCO_AGECOR])				//-- 20-23 - Agencia Cedente (Cobranca)
			cCodBar += AllTrim(aBanco[BCO_CARTEIR])				//-- 24-25 - Carteira
			cCodBar += aTitulo[TIT_NNUM]						//-- 26-36 - Sequencial Nosso Numero
			cCodBar += AllTrim(aBanco[BCO_NCTACO]) 				//-- 37-43 - Conta Cedente (Cobranca)
			cCodBar += "0"			                         	//-- 44-44 - Zero fixo

		EndIf

	ElseIf	aBanco[BCO_NUMBCO] = SICREDI

		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
		//ï¿½ Calculo do Digito Verificador do Campo Livre do      ï¿½
		//ï¿½ Codigo de Barras                                     ï¿½
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		cCpoLivre += "1"                                      //-- 20-20 - Tipo de Cobranca "Com registro"
		cCpoLivre += AllTrim(aBanco[BCO_CARTEIR])             //-- 21-21 - Carteira
		cCpoLivre += aTitulo[TIT_NNUM]                        //-- 22-29 - Nosso Numero
		cCpoLivre += aTitulo[TIT_DVNNUM]                      //-- 30-30 - DV Nosso Numero
		cCpoLivre += AllTrim(aBanco[BCO_NUMAGE])              //-- 31-34 - Cooperativa/Agencia beneficiaria
		cCpoLivre += AllTrim(aBanco[BCO_POSTO])               //-- 35-36 - Posto da Cooperativa/Agencia
		cCpoLivre += AllTrim(aBanco[BCO_NUMCTA])              //-- 37-41 - Codigo/Conta do cedente
		cCpoLivre += Iif(!Empty(SE1->E1_VLCRUZ), "1","0")      //-- 42-42 - Sera '1' quando houver valor no documento
		cCpoLivre += "0"                                      //-- 43-43 - Filler - zero fixo
		cCpoLivre += Mod11CB( cCpoLivre , .F. )               //-- 44-44 - DV do Campo Livre

		cCodBar += cCpoLivre

	ElseIf	aBanco[BCO_NUMBCO] = REDASSET

		If aBanco[BCO_CARTEIR] = "09"                   		//-- COBRANCA CORRESPONDENTE BRADESCO

			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
			//ï¿½ Substitui os 3 primeiros digitos do banco cedente, no ï¿½
			//ï¿½ codigo de barras, pelo banco correspondente           ï¿½
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			If !Empty(aBanco[BCO_BCOCOR])

				cPsq	:= Left(cCodBar, 3)
				cCodBar := StrTran(cCodBar, cPsq, AllTrim(aBanco[BCO_BCOCOR]))

			EndIf

			cCodBar += AllTrim(aBanco[BCO_AGECOR])				//-- 20-23 - Agencia Cedente (Cobranca)
			cCodBar += AllTrim(aBanco[BCO_CARTEIR])				//-- 24-25 - Carteira
			cCodBar += aTitulo[TIT_NNUM]						//-- 26-36 - Sequencial Nosso Numero
			cCodBar += AllTrim(aBanco[BCO_NCTACO]) 				//-- 37-43 - Conta Cedente (Cobranca)
			cCodBar += "0"			                         	//-- 44-44 - Zero fixo

		EndIf

	ElseIf	aBanco[BCO_NUMBCO] = BBM

		If aBanco[BCO_CARTEIR] = "09"                   		//-- COBRANCA CORRESPONDENTE BRADESCO

			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
			//ï¿½ Substitui os 3 primeiros digitos do banco cedente, no ï¿½
			//ï¿½ codigo de barras, pelo banco correspondente           ï¿½
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			If !Empty(aBanco[BCO_BCOCOR])

				cPsq	:= Left(cCodBar, 3)
				cCodBar := StrTran(cCodBar, cPsq, AllTrim(aBanco[BCO_BCOCOR]))

			EndIf

			cCodBar += AllTrim(aBanco[BCO_AGECOR])				//-- 20-23 - Agencia Cedente (Cobranca)
			cCodBar += AllTrim(aBanco[BCO_CARTEIR])				//-- 24-25 - Carteira
			cCodBar += aTitulo[TIT_NNUM]						//-- 26-36 - Sequencial Nosso Numero
			cCodBar += AllTrim(aBanco[BCO_NCTACO]) 				//-- 37-43 - Conta Cedente (Cobranca)
			cCodBar += "0"			                         	//-- 44-44 - Zero fixo

		EndIf

	ElseIf		aBanco[BCO_NUMBCO] = ABC

		If aBanco[BCO_CARTEIR] = "109" // Banco Correspondente

			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
			//ï¿½ Substitui os 3 primeiros digitos do banco cedente, no ï¿½
			//ï¿½ codigo de barras, pelo banco correspondente           ï¿½
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			If !Empty(aBanco[BCO_BCOCOR])

				cPsq	:= Left(cCodBar, 3)
				cCodBar := StrTran(cCodBar, cPsq, AllTrim(aBanco[BCO_BCOCOR]))

			EndIf

			cCodBar += aBanco[BCO_CARTEIR]						//-- 20-22 - Carteira
			cCodBar += aTitulo[TIT_NNUM]						//-- 23-30 - Nosso Numero
			cCodBar += aTitulo[TIT_DVNNUM]						//-- 31-31 - DAC Age+Cta+Cart+Nosso numero
			cCodBar += AllTrim(aBanco[BCO_AGECOR])				//-- 32-35 - Agencia
			cCodBar += AllTrim(aBanco[BCO_NCTACO])				//-- 36-40 - Conta Corrente
			cCodBar += AllTrim(aBanco[BCO_DVCTCO])				//-- 41-41 - DAC Conta
			cCodBar += "000"									//-- 42-44 - Posicoes Livres (zeros)

		ElseIf  aBanco[BCO_CARTEIR] $ "110|121" // Cobranï¿½a Direta

			cCodBar += AllTrim(aBanco[BCO_NUMAGE])				//-- 20-23 - Agencia
			cCodBar += aBanco[BCO_CARTEIR]						//-- 24-26 - Carteira
			cCodBar += Left(aBanco[BCO_CODEMP],7)				//-- 27-33 - Num. Operacao
			cCodBar += aTitulo[TIT_NNUM] + aTitulo[TIT_DVNNUM]	//-- 34-44 - Nosso Numero + DV

		EndIf

	ElseIf	 	aBanco[BCO_NUMBCO] = VOTORANTIM

		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
		//ï¿½ Substitui os 3 primeiros digitos do banco cedente, no ï¿½
		//ï¿½ codigo de barras, pelo banco correspondente           ï¿½
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		If !Empty(aBanco[BCO_BCOCOR])

			cPsq	:= Left(cCodBar, 3)
			cCodBar := StrTran(cCodBar, cPsq, AllTrim(aBanco[BCO_BCOCOR]))

		EndIf

		cCodBar += Replicate("0",6)	   						//-- 20-25 - Zeros fixos
		cCodBar += aBanco[BCO_CODEMP]						//-- 26-32 - Cod Empresa
		cCodBar += aTitulo[TIT_NNUM]						//-- 33-42 - Sequencial Nosso Numero
		cCodBar += aBanco[BCO_CARTEIR]						//-- 43-44 - Carteira

	ElseIf		aBanco[BCO_NUMBCO] = NORDESTE

		cCodBar += aBanco[BCO_NUMAGE]                    //-- 20-23 - Agencia
		cCodBar += aBanco[BCO_NUMCTA]                    //-- 24-30 - Conta Corrente
		cCodBar += aBanco[BCO_DVCTA]                     //-- 31-31 - DV Conta Corrente
		cCodBar += aTitulo[TIT_NNUM]                     //-- 32-38 - Nosso Numero
		cCodBar += aTitulo[TIT_DVNNUM]                   //-- 39-39 - DV Nosso Numero
		cCodBar += aBanco[BCO_CARTEIR]                   //-- 40-41 - Carteira
		cCodBar += Replicate("0",3)	   						//-- 42-44 - Zeros fixos

	ElseIf		aBanco[BCO_NUMBCO] = CITIBANK

		cCodBar += "3"                                   //-- 20-20 - Cobranca com registro / sem registro
		cCodBar += aBanco[BCO_CARTEIR]                   //-- 21-23 - Portfolio (Equivalente a carteira)
		cCodBar += SubStr(aBanco[BCO_NUMCTA],2,6)        //-- 24-29 - Base Conta Cosmos
		cCodBar += SubStr(aBanco[BCO_NUMCTA],8,9)        //-- 30-31 - Sequencia Conta Cosmos
		cCodBar += aBanco[BCO_DVCTA]                     //-- 32-32 - DV Conta Cosmos
		cCodBar += aTitulo[TIT_NNUM]						//-- 33-43 - Nosso Numero
		cCodBar += aTitulo[TIT_DVNNUM]                   //-- 44-44 - DV Nosso Numero

	elseif aBanco[BCO_NUMBCO] = SICOOB //Paola TOTVS em 03.24

		cCodBar += "1"				   						//-- 20-20 - C??o da carteira
		cCodBar += aBanco[BCO_NUMAGE] 						//-- 21-24 - Cod Agencia
		cCodBar += "01"										//-- 25-26 - Modalidade de Cobranca
		cCodBar += ALLTRIM(aBanco[BCO_CODEMP])		       //-- 27-33 - codigo cliente _dv
		cCodBar += RIGHT(aTitulo[6],7,1)    			   //-- 34-41 - Nosso n??o
		cCodBar += aTitulo[TIT_DVNNUM]
		cCodBar += "001"									//-- 42-44 - Parcela

	EndIf

	cDvCodBar := Mod11CB( cCodBar , .T. )								//-- Digito verificador do Codigo de Barras


	cCodBar   := SubStr(cCodBar,1,4) + cDvCodBar + SubStr(cCodBar,5,39)	//-- Insere o DAC na posicao 5 do Codigo de Barras
	aTitulo[TIT_CODBAR] := cCodBar

	_cCodBar := cCodBar
	//MemoWrite("C:\Temp\codbar.txt", cCodBar)

Return()

/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
	±±³Programa  ³F001LinDig³ Autor ³ Fabio Briddi          ³ Data ³ Nov/2013 ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Descricao ³ Monta a Linha Digitavel a partir do Codigo de Barras       ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Parametros³ aBanco = Array com Dados do Banco Selecionado              ³±±
	±±³          ³ aTitulos = Array com Informacoes do Titulo sendo impresso  ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Retorno   ³ Nenhum                                                     ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Uso       ³ TRSF001                                                    ³±±
	±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function F001LinDig( aBanco, aTitulo )

	Local cCampo1 := cCampo2 := cCampo3 := cCampo4 := cCampo5 := ""
	Local cCodBar := aTitulo[TIT_CODBAR]

	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
	//ï¿½ Montagem da Linha Digitavel Igual p/ Todos os Bancos ï¿½
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½

	cCampo1  := SubStr(cCodBar,01,03)	//-- Codigo do Banco
	cCampo1  += SubStr(cCodBar,04,01)	//-- Codigo da Moeda
	cCampo1  += SubStr(cCodBar,20,05)	//--
	cCampo1  += Modulo10( cCampo1 , aBanco[BCO_NUMBCO])

	cCampo2  := SubStr(cCodBar,25,10)	//--
	cCampo2  += Modulo10( cCampo2 , aBanco[BCO_NUMBCO])

	cCampo3  := SubStr(cCodBar,35,10)	//--
	cCampo3  += Modulo10( cCampo3 , aBanco[BCO_NUMBCO])

	cCampo4  := SubStr(cCodBar,05,01)	//-- DAC Codigo de Barras

	cCampo5  := SubStr(cCodBar,06,04)	//-- Fator de Vencimento


	If aBanco[BCO_MBCARD] = "1" .or.(aBanco[BCO_CARTEIR] = '150'.and.  aBanco[BCO_NUMBCO] = '341')
		cCampo5  += "0000000000"	//-- Valor
	Else
		cCampo5  += SubStr(cCodBar,10,10)	//-- Valor
	Endif


	cLinDig  := cCampo1+cCampo2+cCampo3+cCampo4+cCampo5

	aTitulo[TIT_LINDIG] := TransForm(cLinDig, PICT_LINDIG )

Return()

/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
	±±³Funcao    ³  Mod11Cb ³ Autor ³                       ³ Data ³          ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Descricao ³ Calculo Modulo 11 Base 9 para Codigo de Barras             ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Uso       ³ TRSF001                                                    ³±±
	±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Mod11CB( cString , lCBarr )

	Local nStr  := Len(cString)
	Local nSoma := 0
	Local nBase := 1
	Local nDvCB := 0

	While nStr > 0
		nBase++
		nSoma += (Val(SubStr(cString, nStr, 1)) * nBase)
		nBase := IIf( nBase = 9, 1, nBase)
		nStr--
	EndDo

	nCBResto := Mod(nSoma,11)  //-- Resto da Divisao

	If	lCBarr

		nDvCB    := (11 - nCBResto)

		If	(nDvCB == 0 .Or. nDvCB == 1 .Or. nDvCB == 10 .Or. nDvCB == 11)
			nDvCB := 1
		EndIf

	Else

		If		(nCBResto == 10)
			nDvCB := 1

		ElseIf	(nCBResto == 0 .Or. nCBResto == 1)
			nDvCB := 0

		Else
			nDvCB := Abs(11 - nCBResto)

		EndIf

	EndIf

Return( AllTrim(Str(nDvCB)) )


/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
	±±³Programa  ³ Modulo10 ³ Autor ³                       ³ Data ³          ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Descricao ³ Calcula Digito Verificador Pelo Modulo 10 da String Passada³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Uso       ³ TRSF001 - Geracao e Impressao de Boletos                   ³±±
	±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Modulo10( cString , cBanco )

	Local nStr  := Len( cString )
	Local nSoma := 0
	Local nDac  := 0
	Local nPeso := 2
	Local nPos  := 0

	Do	While nStr > 0
		nPos := (Val(SubStr(cString, nStr, 1)) * nPeso)
		If	nPos > 9
			nSoma += (nPos - 9)
		Else
			nSoma += nPos
		EndIf
		nPeso := IIf( nPeso = 2, 1, 2)
		nStr--
	EndDo

	nDac := Mod(nSoma,10)
	nDac := 10 - nDac

	If	nDac == 10
		nDac := 0
	EndIf

Return( AllTrim(Str(nDac)) )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³Mod11B27B ³ Autor ³Giovanni Melo          ³ Data ³17/02/2016³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Calculo Modulo 11 Base 2 a 7 para nosso Numero BANRISUL     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³Mod11B27B(ExpC1)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpC1: Nosso Numero + DV calculado pelo Modulo10            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpC1: Segundo DV gerado                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Mod11B27B( cString )

	Local nStr   := Len(cString)
	Local nSoma  := 0
	Local nPeso  := 2
	Local nDV    := 0
	Local nDvAnt := Val( SubStr( cString, nStr, 1 ) )

	While nStr > 0
		nSoma += Val( SubStr( cString, nStr, 1 ) ) * nPeso
		nPeso++
		nPeso := Iif(nPeso > 7, 2, nPeso )
		nStr--
	EndDo

	If nSoma < 11
		nResto := nSoma
	Else
		nResto := Mod(nSoma,11)

		If nResto = 1 //-- DV invalido

			/*
			If nDvAnt >= 9 //-- DV invalido
				nDvAnt := 0
				cString := SubStr( cString, 1, nStr-1 ) + CValToChar( nDvAnt )
			Else
				nDvAnt++
				cString := Soma1( cString )
			EndIf

			Mod11B27B( cString )
			*/

			If nDvAnt = 9 //-- DV invalido
				nDvAnt := 0
				cString := SubStr( cString, 1, ( Len( cString ) - 1 ) ) + cValToChar( nDvAnt )
			Else
				nDvAnt++
				cString := Soma1( cString )
			EndIf

			Mod11B27B( cString )

		EndIf
	EndIf

	If nResto != 0
		nDV := 11 - nResto
	EndIf

Return( cValToChar( nDvAnt ) + cValToChar( nDv ) )

Static Function Mod11B27( cString )

	Local nStr   := Len(cString)
	Local nSoma  := 0
	Local nPeso  := 2
	Local nDV    := 0

	While nStr > 0
		nSoma += Val( SubStr( cString, nStr, 1 ) ) * nPeso
		nPeso++
		nPeso := Iif(nPeso > 7, 2, nPeso )
		nStr--
	EndDo

	nResto := Mod(nSoma,11)	//-- Resto da Divisao

	If	nResto = 0
		nDV := 0
	ElseIf nResto = 1
		nDv := "P"
	Else
		nDV := (11 - nResto)
	EndIf

Return( AllTrim(cValToChar(nDV)) )

/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
	±±³Funcao    ³  Mod11B27³ Autor ³ Giovanni Melo         ³ Data ³30/06/2015³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Descricao ³ Calculo Modulo 11 Base 2 a 7 DV Nosso Numero Bradesco      ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Uso       ³ TRSF001                                                    ³±±
	±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Mod11B7( cString )

	Local nStr   := Len(cString)
	Local nSoma  := 0
	Local nPeso  := 2
	Local nDV    := 0

	While nStr > 0
		nSoma += Val( SubStr( cString, nStr, 1 ) ) * nPeso
		nPeso++
		nPeso := Iif(nPeso = 8, 2, nPeso )
		nStr--
	EndDo

	nResto := Mod(nSoma,11)	//-- Resto da Divisao

	If	cBanco = BRADESCO

		Do Case

		Case nResto = 0

			nDV := 0

		Case nResto = 1

			nDV := "P"

		OtherWise

			nDV := 11 - nResto

		EndCase

	Else

		If	(nResto = 0 .Or. nResto = 1)

			nDV := 0

		Else

			nDV := 11 - nResto

		EndIf

	EndIf

Return( AllTrim(cValToChar(nDV)) )
/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
	±±³Funcao    ³  Mod11B9 ³ Autor ³                       ³ Data ³          ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Descricao ³ Calculo Modulo 11 Base 9 para Codigo de Barras             ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Uso       ³ TRSF001                                                    ³±±
	±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Mod11B9( cString )

	Local nStr   := Len(cString)
	Local nSoma  := 0
	Local nPeso  := 9
	Local nDV    := 0

	While nStr > 0
		nSoma += Val( SubStr( cString, nStr, 1 ) ) * nPeso
		nPeso--
		nPeso := Iif(nPeso = 1, 9, nPeso )
		nStr--
	EndDo

	nResto := Mod(nSoma,11)	//-- Resto da Divisao
	nDV    := (11 - nResto)

	If	nDV > 9
		nDV := 0
	EndIf

Return( AllTrim(Str(nDV)) )

/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
	±±³Funcao    ³  Mod11B8 ³ Autor ³                       ³ Data ³          ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Descricao ³ Calculo Modulo 11 Base 9 para Codigo de Barras Bco Nordeste³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Uso       ³ TRSF001                                                    ³±±
	±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Mod11B8( cString )

	Local nStr   := Len(cString)
	Local nSoma  := 0
	Local nPeso  := 2
	Local nDV    := 0

	While nStr > 0
		nSoma += Val( SubStr( cString, nStr, 1 ) ) * nPeso
		nPeso++
		nPeso := Iif(nPeso > 8, 2, nPeso )
		nStr--
	EndDo

	nResto := Mod(nSoma,11)	//-- Resto da Divisao
	nDV    := (11 - nResto)

	If	nDV > 9
		nDV := 0
	ElseIf nDv < 2
		nDv := 1
	EndIf

Return( AllTrim(Str(nDV)) )

/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
	±±³Funcao    ³  Mod11B29 ³ Autor ³                       ³ Data ³         ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Descricao ³ Calculo Modulo 11 Base de 2 a 9 para Codigo de Barras      ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Uso       ³ TRSF001                                                    ³±±
	±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Mod11B29( cString )

	Local nStr   := Len(cString)
	Local nSoma  := 0
	Local nPeso  := 2
	Local nDV    := 0

	While nStr > 0
		nSoma += Val( SubStr( cString, nStr, 1 ) ) * nPeso
		nPeso++
		nPeso := Iif(nPeso > 9, 2, nPeso )
		nStr--
	EndDo

	nResto := Mod(nSoma,11)	//-- Resto da Divisao
	nDV    := (11 - nResto)

	If cBanco = SAFRA
		If nResto = 0
			nDv := 1
		ElseIf nResto = 1
			nDv := 0
		EndIf
	EndIf

	If    nDV > 9
		If 	!cBanco = BRASIL .or.  !cBanco = SICOOB //Paola em 03.2024
			nDV := 0
		EndIf
	EndIf


Return( AllTrim(Str(nDv)) )
/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
	±±³Funcao    ³  Mod11B29 ³ Autor ³                       ³ Data ³         ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Descricao ³ Calculo Modulo 11 Base de 2 a 9 para Codigo de Barras      ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Uso       ³ TRSF001                                                    ³±±
	±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Mod11B92( cString )

	Local nStr   := Len(cString)
	Local nSoma  := 0
	Local nPeso  := 9
	Local nResto := 0

	While nStr > 0
		nSoma += Val( SubStr( cString, nStr, 1 ) ) * nPeso
		nPeso--
		nPeso := Iif(nPeso < 2, 9, nPeso )
		nStr--
	EndDo

	nResto := Mod(nSoma,11)	//-- Resto da Divisao


	//-- Tratamento do DV "X" na gravacao do E1_NUMBCO
Return( AllTrim(Str(nResto)) )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³F001Imprime³ Autor ³Fabio Briddi          ³ Data ³ Nov/2013 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Impressao de Boleto Bancario grafico conforme laytout no    ³±±
±±³          ³formato retrato                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³F001Imprime( aCedente, aBanco, aSacado, aAvalista, aTitulo )³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ aCedente:                                                  ³±±
±±³          ³ aBanco:                                                    ³±±
±±³          ³ aSacado:                                                   ³±±
±±³          ³ aAvalista:                                                 ³±±
±±³          ³ oBoleto:                                                   ³±±
±±³          ³ oSetup:                                                    ³±±
±±³          ³ lExistBol:                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function F001Imprime( aCedente, aBanco, aSacado, aAvalista, aTitulo, oBoleto, oSetup, lExistBol, lStart, cTempPath, lBlind )

	Local cPixel      := "-1"	//-- Espessura da linha de Bordas em pixels
	Local cCnpjCor    := ""
	Local cInstrucoes := ""
	Local cMsg1Pag    := ""
	Local cMsg2Pag    := ""
	Local cMsg3Pag    := ""
	Local cMsg4Pag    := ""
	Local nLinha, x   := 0
	Local nLinIni     := 0000	//-- Linha Inicial do Quadro
	Local nColIni     := 0000	//-- Coluna Inicial do Quadro
	Local lBox        := .T.
	Local lNoBox      := .F.

	oArial06   := TFontEx():New(oBoleto,"Arial"      ,06,06,.F.,.T.,.F.)
	oArial06n  := TFontEx():New(oBoleto,"Arial"      ,06,06,.T.,.T.,.F.)
	oArial08   := TFontEx():New(oBoleto,"Arial"      ,08,08,.T.,.T.,.F.)
	oArial09   := TFontEx():New(oBoleto,"Arial"      ,09,09,.F.,.T.,.F.)
	oArial10   := TFontEx():New(oBoleto,"Arial"      ,10,10,.F.,.T.,.F.)
	oArial13   := TFontEx():New(oBoleto,"Arial"      ,13,13,.F.,.T.,.F.)
	oArial13n  := TFontEx():New(oBoleto,"Arial"      ,13,13,.T.,.T.,.F.)
	oArial14n  := TFontEx():New(oBoleto,"Arial"      ,14,14,.T.,.T.,.F.)
	oCourier10 := TFontEx():New(oBoleto,"Courier New",10,10,.T.,.T.,.F.)
	oCourier08 := TFontEx():New(oBoleto,"Courier New",08,08,.T.,.T.,.F.)

	oBoleto:StartPage()   		// Inicia uma nova pï¿½gina

	nLinBar   :=  000						//-- Linha Inicial do Codigo de Barras
	nLinIni   :=  000						//-- Linha Inicial do Quadro
	nColIni   :=  000						//-- Coluna Inicial do Quadro
	cBCO_NUMBCO:= aBanco[BCO_NUMBCO]	//Paola - 10/06/2015 - faixa
	cBCO_NOMBCO:= aBanco[BCO_NOMBCO] 	// Paola - 10/06/2015 - faixa

	cInstrucoes := STRBOL018

	If		aBanco[BCO_NUMBCO] = SAFRA    .Or.;
			aBanco[BCO_NUMBCO] = REDASSET .Or.;
			aBanco[BCO_NUMBCO] = FIBRA    .Or.;
			aBanco[BCO_NUMBCO] = BBM

		cInstrucoes := STRBOL034

		If	aBanco[BCO_CARTEIR] = "09" .Or. aBanco[BCO_CARTEIR] = "19"			//-- COBRANCA CORRESPONDENTE BRADESCO


			cBCO_NUMBCO:= aBanco[BCO_BCOCOR]  //  aBanco[BCO_NUMBCO]  := aBanco[BCO_BCOCOR] -Paola - 10/06/2015 - faixa
			cBCO_NOMBCO:= aBanco[BCO_NOMCOR] // aBanco[BCO_NOMBCO]  := aBanco[BCO_NOMCOR]   -Paola - 10/06/2015 - faixa

			//-- Mensagem incluï¿½da no boleto banco Safra correspondente Bradesco, conforme solicitaï¿½ï¿½o do prï¿½prio banco
			cMsg1Pag := "ESTE BOLETO REPRESENTA DUPLICATA CEDIDA FIDUCIARIAMENTE AO " + AllTrim(aBanco[BCO_NOMBCO]) + ", FICANDO"
			cMsg2Pag := "VEDADO O PAGAMENTO DE QUALQUER OUTRA FORMA QUE NÃO ATRAVES DO PRESENTE BOLETO"

		EndIf

	EndIf

	If	aBanco[BCO_NUMBCO] = CAIXA
		//-- Mensagem incluida do banco CAIXA conforme orientação do proprio banco
		cMsg1Pag := "SAC CAIXA: 0800 726 0101 (informações, reclamações, sugestões e elogios)"
		cMsg2Pag := "Para pessoas com deficiência auditiva ou de fala: 0800 726 2492"
		cMsg3Pag := "Ouvidoria: 0800 725 7474"
		cMsg4Pag := "caixa.gov.br"
	EndIf

	If		( aBanco[BCO_NUMBCO] = ABC .And. aBanco[BCO_CARTEIR] = "109") .Or. aBanco[BCO_NUMBCO] = VOTORANTIM

		cInstrucoes := STRBOL034

		cBCO_NUMBCO:= aBanco[BCO_BCOCOR] // aBanco[BCO_NUMBCO]  := aBanco[BCO_BCOCOR] -Paola - 10/06/2015 - faixa
		cBCO_NOMBCO:= aBanco[BCO_NOMCOR]// aBanco[BCO_NOMBCO]  := aBanco[BCO_NOMCOR] - Paola - 10/06/2015 - faixa

	EndIf

	If	aBanco[BCO_NUMBCO] = BANRISUL
		//-- Mensagem incluida do banco BANRISUL conforme orientação do proprio banco
		cMsg1Pag := "SAC BANRISUL: 0800.646.1515 OUVIDORIA BANRISUL: 0800.644.2200"
	EndIf
	cCnpjCor := " " + If( !Empty(aBanco[BCO_BCOCOR]), aAvalista[AVA_CNPJ], aCedente[CED_CNPJ] )

//	For nImp := 1 To 2
	aCampos := {}
	//-- Recibo do Pagador
	//-- aCampos  { Linha Inicial, Coluna Inicial, Linha Final, Coluna Final, Box, Nome Campo, Conteudo Campo, Fonte Conteudo, alinhamento, ajuste Linha}
	aAdd(aCampos, {-015, 493, 000, 605, lNoBox, STRBOL000, STRBOL030            , oArial08:oFont,  1, 0  }) //-- "" # "Recibo do Pagador"

	aAdd(aCampos, { 000, 060, 015, 200, lNoBox, STRBOL000, cBCO_NOMBCO   , oArial13:oFont,  0, 0  }) //-- "" #   // aBanco[BCO_NOMBCO]   -Paola - 10/06/2015
	aAdd(aCampos, { 000, 200, 015, 260, lNoBox, STRBOL000, aBanco[BCO_BCOFORM]  , oArial14n:oFont, 1, 0  }) //-- "" #
	aAdd(aCampos, { 000, 260, 015, 600, lNoBox, STRBOL000, aTitulo[TIT_LINDIG]  , oArial13n:oFont, 0, 0  })

	aAdd(aCampos, { 015, 000, 032, 320, lBox  , STRBOL003, STRBOL000            , oArial09:oFont,  0, 06 }) //-- "Beneficiï¿½rio"
	aAdd(aCampos, { 015, 000, 032, 230, lNoBox, STRBOL003, aCedente[CED_NOME]   , oArial09:oFont,  0, 06 }) //-- "Beneficiï¿½rio"
	If !aBanco[BCO_NUMBCO] $ BANRISUL
		aAdd(aCampos, { 015, 230, 032, 320, lNoBox, STRBOL004, aCedente[CED_CNPJ]   , oArial09:oFont,  0, 06 }) //-- "CNPJ/CPF"
	Endif

	If aBanco[BCO_NUMBCO] $ SAFRA // 13.06.2022 -Paola
		aAdd(aCampos, { 015, 320, 032, 495, lBox  , STRBOL033, Left(aAvalista[AVA_NOME],20) + cCnpjCor  , oArial09:oFont,  0, 06 }) //-- "Sacador/Avalista"
	else
		aAdd(aCampos, { 015, 320, 032, 495, lBox  , STRBOL027, Left(aAvalista[AVA_NOME],20) + cCnpjCor  , oArial09:oFont,  0, 06 }) //-- "Sacador/Avalista"
	Endif

	aAdd(aCampos, { 015, 495, 032, 600, lBox  , STRBOL002, aTitulo[TIT_DTVCTO]  , oArial09:oFont,  2, 06 }) //-- "Vencimento"

	If aBanco[BCO_NUMBCO] $ SAFRA // 13.06.2022 -Paola
		aAdd(aCampos, { 032, 000, 049, 600, lBox  , STRBOL034, aCedente[CED_END]    , oArial09:oFont,  0, 06 }) //-- "Endereï¿½o Beneficiï¿½rio/Sacador Avalista"
	else
		aAdd(aCampos, { 032, 000, 049, 600, lBox  , STRBOL029, aCedente[CED_END]    , oArial09:oFont,  0, 06 }) //-- "Endereï¿½o Beneficiï¿½rio/Sacador Avalista"
	Endif
	aAdd(aCampos, { 049, 000, 066, 600, lBox  , STRBOL000, STRBOL000            , oArial09:oFont,  0, 06 }) //-- ""
	aAdd(aCampos, { 049, 000, 066, 300, lNoBox, STRBOL024, aSacado[SAC_NOME]    , oArial09:oFont,  0, 06 }) //-- "Pagador:"
	aAdd(aCampos, { 049, 300, 066, 600, lNoBox, STRBOL025, aSacado[SAC_CNPJ]    , oArial09:oFont,  0, 06 }) //-- "CNPJ/CPF:"

	aAdd(aCampos, { 066, 000, 083, 140, lBox  , STRBOL011, aTitulo[TIT_NNUMFORM], oArial09:oFont,  2, 06 }) //-- "Nosso Nï¿½mero"
	aAdd(aCampos, { 066, 140, 083, 200, lBox  , STRBOL013, aBanco[BCO_CARTEIR]  , oArial09:oFont,  2, 06 }) //-- "Carteira"
	If aBanco[BCO_NUMBCO] = ITAU .AND. aBanco[BCO_CARTEIR] == '150' //Paola 20.12.2021


		aAdd(aCampos, { 066, 200, 083, 250, lBox  , STRBOL014, "US$"                 , oArial09:oFont,  1, 06 }) //-- "Espï¿½cie"
		aAdd(aCampos, { 066, 250, 083, 360, lBox  , STRBOL015, F001FormVal(aTitulo[TIT_VALOR])            , oArial09:oFont,  1, 06 }) //-- "Quantidade"

	Else
		aAdd(aCampos, { 066, 200, 083, 250, lBox  , STRBOL014, "R$"                 , oArial09:oFont,  1, 06 }) //-- "Espï¿½cie"
		aAdd(aCampos, { 066, 250, 083, 360, lBox  , STRBOL015, STRBOL000            , oArial09:oFont,  1, 06 }) //-- "Quantidade"
	Endif


	aAdd(aCampos, { 066, 360, 083, 485, lBox  , STRBOL016, STRBOL000            , oArial09:oFont,  1, 06 }) //-- "Valor"
	aAdd(aCampos, { 066, 485, 083, 600, lBox  , STRBOL005, aBanco[BCO_AGECTA]   , oArial09:oFont,  2, 06 }) //-- "Agência/Cï¿½digo do Beneficiï¿½rio"

	aAdd(aCampos, { 083, 000, 100, 085, lBox  , STRBOL006, aTitulo[TIT_DTPROC]  , oArial09:oFont,  2, 06 }) //-- "Data do Documento"
	aAdd(aCampos, { 083, 085, 100, 225, lBox  , STRBOL007, aTitulo[TIT_NUM]     , oArial09:oFont,  2, 06 }) //-- "Nï¿½mero do Documento"
	aAdd(aCampos, { 083, 225, 100, 310, lBox  , STRBOL008, aTitulo[TIT_ESPECIE] , oArial09:oFont,  2, 06 }) //-- "Espï¿½cie do Documento"
	aAdd(aCampos, { 083, 310, 100, 360, lBox  , STRBOL009, aBanco[BCO_ACEITE]   , oArial09:oFont,  2, 06 }) //-- "Aceite"
	aAdd(aCampos, { 083, 360, 100, 450, lBox  , STRBOL010, aTitulo[TIT_DTPROC]  , oArial09:oFont,  2, 06 }) //-- "Data de Processamento"

	If aBanco[BCO_NUMBCO] = ITAU .AND. aBanco[BCO_CARTEIR] == '150' //Paola 20.12.2021
		aAdd(aCampos, { 083, 450, 100, 600, lBox  , STRBOL033, STRBOL000				    	, oArial09:oFont,  1, 06 }) //-- "Valor do Documento"
	Else
		aAdd(aCampos, { 083, 450, 100, 600, lBox  , STRBOL033, F001FormVal(aTitulo[TIT_VALOR]) , oArial09:oFont,  1, 06 }) //-- "Valor do Documento"
	Endif

	aAdd(aCampos, { 100, 450, 110, 605, lNoBox, STRBOL000, STRBOL032            , oArial08:oFont,  1, 00 }) //-- "" # "Autenticaï¿½ï¿½o Mecï¿½nica"

	aAdd(aCampos, { 095, 000, 105, 605, lNoBox, STRBOL000, cMsg1Pag            , oArial09:oFont,  0, 06 }) //-- "Linha 1 Mensagem Pagador"
	aAdd(aCampos, { 105, 000, 115, 605, lNoBox, STRBOL000, cMsg2Pag            , oArial09:oFont,  0, 06 }) //-- "Linha 2 Mensagem Pagador"
	aAdd(aCampos, { 115, 000, 125, 605, lNoBox, STRBOL000, cMsg3Pag            , oArial09:oFont,  0, 06 }) //-- "Linha 3 Mensagem Pagador"
	aAdd(aCampos, { 125, 000, 135, 605, lNoBox, STRBOL000, cMsg4Pag            , oArial09:oFont,  0, 06 }) //-- "Linha 4 Mensagem Pagador"

	//-- Ficha de Compensacao

	// Cria a pasta temporaria se Não existir, porque a funï¿½ï¿½o saybitmap Não imprime a 2 imagem do systempath do protheus
   	/*If !lBlind  //FunName("TRSF001C") .And. !FunName("TRSF001D")
		F001TEMP ( @oBoleto )
	Else
   		oBoleto:SayBitmap(  -002,001,"lgbco"+cBCO_NUMBCO+".bmp",060,015, , )//Logotipo Ficha Compensacao
	EndIf*/
	F001TEMP ( @oBoleto )

   	//oBoleto:SayBitmap(  128,001,"lgbco"+cBCO_NUMBCO+".bmp",060,015, , )//Logotipo Ficha Compensacao

	aAdd(aCampos, { 155, 060, 040, 200, lNoBox, STRBOL000, cBCO_NOMBCO          , oArial13:oFont,  0, 00 }) //-- "" #   // aBanco[BCO_NOMBCO] - Paola - 10/06/2015
	aAdd(aCampos, { 155, 200, 040, 260, lNoBox, STRBOL000, aBanco[BCO_BCOFORM]  , oArial14n:oFont, 1, 00 }) //-- "" #
	aAdd(aCampos, { 155, 260, 040, 600, lNoBox, STRBOL000, aTitulo[TIT_LINDIG]  , oArial13n:oFont, 0, 00 }) //-- "" #

	aAdd(aCampos, { 170, 000, 195, 450, lBox  , STRBOL001, STRBOL000            , oArial08:oFont,  0, 00 }) //-- "Local Pagamento"
	aAdd(aCampos, { 175, 000, 185, 450, lNoBox, STRBOL000, aTitulo[TIT_LOCPAG,1], oArial08:oFont,  0, 00 }) //-- "Local Pagamento"
	aAdd(aCampos, { 185, 000, 195, 450, lNoBox, STRBOL000, aTitulo[TIT_LOCPAG,2], oArial08:oFont,  0, 00 }) //-- ""
	aAdd(aCampos, { 170, 450, 195, 600, lBox  , STRBOL002, aTitulo[TIT_DTVCTO]  , oArial10:oFont,  2, 08 }) //-- "Vencimento"

    aAdd(aCampos, { 195, 000, 215, 450, lBox  , STRBOL003, STRBOL000            , oArial10:oFont,  0, 08 }) //-- "Beneficiï¿½rio/Cedente"

	If !aBanco[BCO_MBCARD]  = "1"
		aAdd(aCampos, { 195, 000, 215, 300, lNoBox, STRBOL003, aCedente[CED_NOME] + "- " + Space(1) + aCedente[CED_END] , oArial10:oFont,  0, 08 }) //-- "Beneficiï¿½rio/Cedente"
		aAdd(aCampos, { 195, 300, 215, 450, lNoBox, STRBOL004, aCedente[CED_CNPJ]   , oArial10:oFont,  0, 08 }) //-- "CNPJ/CPF"
		aAdd(aCampos, { 195, 450, 215, 600, lBox  , STRBOL005, aBanco[BCO_AGECTA]   , oArial10:oFont,  2, 08 }) //-- "Agência/Cï¿½digo do Beneficiï¿½rio"
    Else

		aAdd(aCampos, { 195, 000, 215, 350, lNoBox, STRBOL003, alltrim(aCedente[CED_NOME])  ,  oCourier10:oFont, 0, 00  }) //-- "Beneficiï¿½rio/Cedente"
	   	aAdd(aCampos, { 195, 350, 215, 450, lNoBox, STRBOL004, aCedente[CED_CNPJ]   , oArial10:oFont,  0, 08 }) //-- "CNPJ/CPF"
		aAdd(aCampos, { 195, 450, 215, 600, lBox  , STRBOL005, aBanco[BCO_AGECTA]   , oArial10:oFont,  2, 08 }) //-- "Agência/Cï¿½digo do Beneficiï¿½rio"
		aAdd(aCampos, { 202, 000, 215, 600, lNoBox, STRBOL000, alltrim(aCedente[CED_END])   ,  oCourier10:oFont, 0, 00  })


   Endif
	aAdd(aCampos, { 215, 000, 235, 100, lBox  , STRBOL006, aTitulo[TIT_DTEMI]   , oArial10:oFont,  2, 08 }) //-- "Data Documento"
	aAdd(aCampos, { 215, 100, 235, 250, lBox  , STRBOL007, aTitulo[TIT_NUM]     , oArial10:oFont,  2, 08 }) //-- "Nï¿½mero do Documento"
	aAdd(aCampos, { 215, 250, 235, 315, lBox  , STRBOL008, aTitulo[TIT_ESPECIE] , oArial10:oFont,  2, 08 }) //-- "Espï¿½cie Documento"
	aAdd(aCampos, { 215, 315, 235, 375, lBox  , STRBOL009, aBanco[BCO_ACEITE]   , oArial10:oFont,  2, 08 }) //-- "Aceite"
	aAdd(aCampos, { 215, 375, 235, 450, lBox  , STRBOL010, aTitulo[TIT_DTPROC]  , oArial10:oFont,  2, 08 }) //-- "Data Processamento"
	aAdd(aCampos, { 215, 450, 235, 600, lBox  , STRBOL011, aTitulo[TIT_NNUMFORM], oArial10:oFont,  2, 08 }) //-- "Nosso Nï¿½mero"
	aAdd(aCampos, { 235, 000, 255, 100, lBox  , STRBOL012, aBanco[BCO_USOBCO]   , oArial10:oFont,  0, 08 }) //-- "Uso do Banco"
	If aBanco[BCO_MBCARD]  = "1"
		aAdd(aCampos, { 235, 100, 255, 150, lBox  , "CIP", "000"                    , oArial10:oFont,  2, 08 }) //-- "Carteira"
		aAdd(aCampos, { 235, 150, 255, 200, lBox  , STRBOL013, aBanco[BCO_CARTEIR]  , oArial10:oFont,  2, 08 }) //-- "Carteira"
	Else
		aAdd(aCampos, { 235, 100, 255, 200, lBox  , STRBOL013, aBanco[BCO_CARTEIR]  , oArial10:oFont,  2, 08 }) //-- "Carteira"
	Endif
	
	If  aBanco[BCO_NUMBCO] = ITAU .AND. aBanco[BCO_CARTEIR] == '150' //Paola 20.12.2021
         dbSelectArea("SE1")
		DbGoTo(aTitulo[TIT_RECSE1])

		aAdd(aCampos, { 235, 200, 255, 255, lBox  , STRBOL014, "US$"                 , oArial10:oFont,  2, 08 }) //-- "Espï¿½cie"
		//aAdd(aCampos, { 235, 255, 255, 315, lBox  , STRBOL015, F001FormVal(aTitulo[TIT_VALOR])          , oArial10:oFont,  1, 08 }) //-- "Quantidade"
		aAdd(aCampos, { 235, 255, 255, 315, lBox  , STRBOL015, ALLTRIM(F001FormVal(SE1->E1_SALDO) )         , oArial10:oFont,  1, 08 }) //-- "Quantidade"
	Else
		aAdd(aCampos, { 235, 200, 255, 255, lBox  , STRBOL014, "R$"                 , oArial10:oFont,  2, 08 }) //-- "Espï¿½cie"
		aAdd(aCampos, { 235, 255, 255, 315, lBox  , STRBOL015, STRBOL000            , oArial10:oFont,  1, 08 }) //-- "Quantidade"
	Endif	

	
	aAdd(aCampos, { 235, 315, 255, 450, lBox  , STRBOL016, STRBOL000            , oArial10:oFont,  1, 08 }) //-- "Valor"
	
	If aBanco[BCO_NUMBCO] = ITAU .AND. aBanco[BCO_CARTEIR] == '150' //Paola 20.12.2021
		aAdd(aCampos, { 235, 450, 255, 600, lBox  , STRBOL017, STRBOL000   , oArial10:oFont,  1, 08 }) //-- "(=) Valor Documento"
	Else
		aAdd(aCampos, { 235, 450, 255, 600, lBox  , STRBOL017, F001FormVal(aTitulo[TIT_VALOR])   , oArial10:oFont,  1, 08 }) //-- "(=) Valor Documento"
	Endif

    If !aBanco[BCO_MBCARD] = "1"
		aAdd(aCampos, { 255, 000, 355, 450, lBox  , cInstrucoes, STRBOL000            , oArial10:oFont,   0, 05 }) //-- "Instruï¿½ï¿½es" // Somente Monta o Quadro Maior
		aAdd(aCampos, { 260, 000, 285, 450, lNoBox, STRBOL000, aTitulo[TIT_MSGS][1] , oCourier08:oFont, 0, 00 }) //-- Linha 1 Mensagem Boleto
		aAdd(aCampos, { 270, 000, 280, 450, lNoBox, STRBOL000, aTitulo[TIT_MSGS][2] , oCourier08:oFont, 0, 00 }) //-- Linha 2 Mensagem Boleto
		aAdd(aCampos, { 280, 000, 290, 450, lNoBox, STRBOL000, aTitulo[TIT_MSGS][3] , oCourier08:oFont, 0, 00 }) //-- Linha 3 Mensagem Boleto
		aAdd(aCampos, { 290, 000, 300, 450, lNoBox, STRBOL000, aTitulo[TIT_MSGS][4] , oCourier08:oFont, 0, 00 }) //-- Linha 4 Mensagem Boleto
		aAdd(aCampos, { 300, 000, 310, 450, lNoBox, STRBOL000, aTitulo[TIT_MSGS][5] , oCourier08:oFont, 0, 00 }) //-- Linha 5 Mensagem Boleto
		aAdd(aCampos, { 310, 000, 320, 450, lNoBox, STRBOL000, aTitulo[TIT_MSGS][6] , oCourier08:oFont, 0, 00 }) //-- Linha 6 Mensagem Boleto
		aAdd(aCampos, { 320, 000, 330, 450, lNoBox, STRBOL000, aTitulo[TIT_MSGS][7] , oCourier08:oFont, 0, 00 }) //-- Linha 7 Mensagem Boleto
		aAdd(aCampos, { 330, 000, 340, 450, lNoBox, STRBOL000, aTitulo[TIT_MSGS][8] , oCourier08:oFont, 0, 00 }) //-- Linha 8 Mensagem Boleto
		aAdd(aCampos, { 340, 000, 350, 450, lNoBox, STRBOL000, aTitulo[TIT_MSGS][9] , oCourier08:oFont, 0, 00 }) //-- Linha 9 Mensagem Boleto

    Else

		dbSelectArea("SEE")
		dbSetOrder(1)	//-- EE_FILIAL+EE_CODIGO+EE_AGENCIA+EE_CONTA+EE_SUBCTA
		dbSeek( xFilial("SEE") + cBanco + cAgencia + cConta + cSubCta )


	    aAdd(aCampos, { 255, 000, 355, 450, lBox  , cInstrucoes, STRBOL000            , oArial10:oFont,   0, 05 }) //-- "Instruï¿½ï¿½es" // Somente Monta o Quadro Maior
		aAdd(aCampos, { 260, 000, 285, 450, lNoBox, STRBOL000, aTitulo[TIT_MSGS][1] , oCourier08:oFont, 0, 00 }) //-- Linha 1 Mensagem Boleto
		aAdd(aCampos, { 270, 000, 280, 450, lNoBox, STRBOL000, aTitulo[TIT_MSGS][2] , oCourier08:oFont, 0, 00 }) //-- Linha 2 Mensagem Boleto
		aAdd(aCampos, { 280, 000, 290, 450, lNoBox, STRBOL000, aTitulo[TIT_MSGS][3] , oCourier08:oFont, 0, 00 }) //-- Linha 3 Mensagem Boleto
		aAdd(aCampos, { 290, 000, 300, 450, lNoBox, STRBOL000, aTitulo[TIT_MSGS][4] , oCourier08:oFont, 0, 00 }) //-- Linha 4 Mensagem Boleto
		aAdd(aCampos, { 300, 000, 310, 450, lNoBox, STRBOL000, aTitulo[TIT_MSGS][5] , oCourier08:oFont, 0, 00 }) //-- Linha 5 Mensagem Boleto
		aAdd(aCampos, { 310, 000, 320, 450, lNoBox, STRBOL000, aTitulo[TIT_MSGS][6] , oCourier08:oFont, 0, 00 }) //-- Linha 6 Mensagem Boleto
		If !Empty(SEE->EE_FORMBC1)
			aAdd(aCampos, { 320, 000, 330, 450, lNoBox, STRBOL000, &(Alltrim(SEE->EE_FORMBC1)), oCourier08:oFont, 0, 00 }) //-- Linha 7 Mensagem Boleto
        Endif

		If !Empty(SEE->EE_FORMBC2)
			aAdd(aCampos, { 330, 000, 340, 450, lNoBox, STRBOL000, &(Alltrim(SEE->EE_FORMBC2)), oCourier08:oFont, 0, 00 }) //-- Linha 7 Mensagem Boleto
        Endif


		If !Empty(SEE->EE_FORMBC3)
			aAdd(aCampos, { 340, 000, 350, 450, lNoBox, STRBOL000, &(Alltrim(SEE->EE_FORMBC3)), oCourier08:oFont, 0, 00 }) //-- Linha 7 Mensagem Boleto
        Endif

    Endif
	aAdd(aCampos, { 255, 450, 275, 600, lBox  , STRBOL019, STRBOL000            , oArial10:oFont,   1, 08 }) //-- "(-) Descontos/Abatimentos"
	aAdd(aCampos, { 275, 450, 295, 600, lBox  , STRBOL020, STRBOL000            , oArial10:oFont,   1, 08 }) //-- "(-) Outras Deduï¿½ï¿½es"
	aAdd(aCampos, { 295, 450, 315, 600, lBox  , STRBOL021, STRBOL000            , oArial10:oFont,   1, 08 }) //-- "(+) Multa/Mora"
	aAdd(aCampos, { 315, 450, 335, 600, lBox  , STRBOL022, STRBOL000            , oArial10:oFont,   1, 08 }) //-- "(+) Outros Acrï¿½scimos"
	aAdd(aCampos, { 335, 450, 355, 600, lBox  , STRBOL023, STRBOL000            , oArial10:oFont,   1, 08 }) //-- "(=) Valor Cobrado"

	aAdd(aCampos, { 355, 000, 400, 600, lBox  , STRBOL000, STRBOL000            , oArial10:oFont,   0, 08 }) //-- ""
	aAdd(aCampos, { 355, 000, 370, 300, lNoBox, STRBOL024, aSacado[SAC_NOME]    , oArial10:oFont,   0, 05 }) //-- "Pagador:"
	aAdd(aCampos, { 355, 300, 370, 450, lNoBox, STRBOL025, aSacado[SAC_CNPJ]    , oArial10:oFont,   0, 05 }) //-- "CNPJ/CPF:"
	aAdd(aCampos, { 370, 000, 385, 600, lNoBox, STRBOL026, aSacado[SAC_END]     , oArial10:oFont,   0, 05 }) //-- "Endereï¿½o:"
	aAdd(aCampos, { 385, 000, 400, 300, lNoBox, STRBOL027, aAvalista[AVA_NOME]  , oArial10:oFont,   0, 05 }) //-- "Sacador/Avalista:"
	aAdd(aCampos, { 385, 300, 400, 450, lNoBox, STRBOL025, aAvalista[AVA_CNPJ]  , oArial10:oFont,   0, 05 }) //-- "CNPJ/CPF:"
	aAdd(aCampos, { 385, 450, 400, 600, lNoBox, STRBOL028, STRBOL000            , oArial10:oFont,   0, 05 }) //-- "Cï¿½digo de Baixa:"
	aAdd(aCampos, { 400, 420, 415, 605, lNoBox, STRBOL000, STRBOL031            , oArial06n:oFont,  1, 00 }) //-- "" # "Autenticaï¿½ï¿½o Mecï¿½nica / FICHA DE COMPENSAï¿½ï¿½O"

	For nLinha := 1 To Len(aCampos)
		If	aCampos[nLinha,5] //-- Se executa o Box
			oBoleto:Box( nLinIni+aCampos[nLinha,1], nColIni+aCampos[nLinha,2], nLinIni+aCampos[nLinha,3],nColIni+aCampos[nLinha,4], cPixel)
		EndIf

		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
		//ï¿½ Impressao do Rotulo                                   ï¿½
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		oBoleto:Say( nLinIni+aCampos[nLinha,1]+005, nColIni+aCampos[nLinha,2]+003, aCampos[nLinha,6], oArial06:oFont)

		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
		//ï¿½Para conteudo dos campos utilizado SayAlign()          ï¿½
		//ï¿½para Alinhamentos a Direita de Valores e Centralizados ï¿½
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		nLI      := nLinIni+(aCampos[nLinha,1]+aCampos[nLinha,10])
		nCI      := nColIni+(aCampos[nLinha,2]+03)
		nLF      := nLinIni+aCampos[nLinha,3]
		nCF      := nColIni+(aCampos[nLinha,4]-05)
		nLargura := ((nCF - nCI) - 5)
		nAltura  := (nLF - nLI)

		oBoleto:SayAlign( nLI, nCI, aCampos[nLinha,7], aCampos[nLinha,8] , nLargura, nAltura, , aCampos[nLinha,9], 1 )

	Next nLinha

	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
	//ï¿½ Marcacao  do Picote                                   ï¿½
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
    For x := nColIni To nColIni+600 Step 10
		oBoleto:Line(  nLinIni+145, x ,  nLinIni+145, x + 5, 0 , cPixel )
		oBoleto:Line(  nLinIni+450, x ,  nLinIni+450, x + 5, 0 , cPixel )
	Next x

 //	oBoleto:SayBitmap( -002,001,"lgbco"+cBCO_NUMBCO+".bmp",060,015, , )//Logotipo Recibo do Pagador  // aBanco[BCO_NUMBCO] - Paola - 10/06/2015
//	oBoleto:SayBitmap(  128,001,"lgbco"+cBCO_NUMBCO+".bmp",060,015, , )//Logotipo Ficha Compensacao

	oBoleto:FwMsBar( "INT25", nLinBar+034, nColIni, aTitulo[TIT_CODBAR], oBoleto, .F., , , ,1.0, , , , .F. )

	nLinBar += 039	//-- Linha Inicial do Quadro
	nLinIni += 460	//-- Linha Inicial do Quadro

	lExistBol := .T.

//	Next nImp

	oBoleto:EndPage() //-- Finaliza a pï¿½gina

Return()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³F001IniImp ³ Autor ³ Fabio Briddi         ³ Data ³ Nov/2013 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Inicializa Objetos de Impressao e de Setup de Impressao    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ @oBoleto - Objeto de Impressao do Boleto                   ³±±
±±³          ³ @oSetup  - Objeto comas as Configuracoes de Impressao      ³±±
±±³          ³ lExistBol-                                                 ³±±
±±³          ³ lBlind   - Controla se a rotina esta sendo chamada via WS  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ lRet  - .T. se Confirmado o Dialogo de Configuracao        ³±±
±±³          ³         .F. se Cancelado o Dialogo de Configuracao         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TRSF001                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function F001IniImp( oBoleto, oSetup, lExistBol, lBlind, aBanco, aTitulo, aSacado )

	Local lRet       := .T.
	Local cFilePrint := "BOLETO_"+DTOS(MsDate())+StrTran(Time(),":","")+strtran(alltrim(str(seconds() )),".","")
	Local aDevice    := {}
	Local cSession   := GetPrinterSession()

	If lBlind
		Public cNomArq := cFilePrint
	EndIf

	aAdd(aDevice,"DISCO") // 1
	aAdd(aDevice,"SPOOL") // 2
	aAdd(aDevice,"EMAIL") // 3
	aAdd(aDevice,"EXCEL") // 4
	aAdd(aDevice,"HTML" ) // 5
	aAdd(aDevice,"PDF"  ) // 6

	nLocal       	:= If(GetProfString(cSession,"LOCAL","SERVER",.T.)=="SERVE",1,2 )
	nOrientation 	:= If(GetProfString(cSession,"ORIENTATION","PORTRAIT",.T.)=="PORTRAIT",1,2)
	cDevice	     	:= GetProfString(cSession,"PRINTTYPE","SPOOL",.T.)
	nPrintType      := aScan(aDevice,{|x| x == cDevice })
	cPathInServer   := "\spool\"

	lAdjustToLegacy := .F.
	lDisableSetup   := .T.
	lViewPDF        := !(lBlind)	//--	.T. Apresenta Preview / .F. Nao Apresenta
	lPdfAsPng       := .T.		//--	.T. Pdf

	If oBoleto == Nil

		oBoleto := FWMSPrinter():New( cFilePrint , IMP_PDF , lAdjustToLegacy , cPathInServer , lDisableSetup , , , , lPdfAsPng , , , lViewPDF )
		// FWMsPrinter
		//
		//oDANFE := FWMSPrinter():New(cFilePrint, IMP_PDF, .F. /*lAdjustToLegacy*/, /*cPathInServer*/, .T.)



		If !lBlind// Se nao estiver sendo chamado via Web Service

			// ----------------------------------------------
			// Cria e exibe tela de Setup Customizavel
			// OBS: Utilizar include "FWPrintSetup.ch"
			// ----------------------------------------------
			nFlags := PD_ISTOTVSPRINTER + PD_DISABLEPAPERSIZE + PD_DISABLEPREVIEW + PD_DISABLEMARGIN
			oSetup := FWPrintSetup():New( nFlags , cFilePrint )

			// ----------------------------------------------
			// Define saida
			// ----------------------------------------------
			oSetup:SetPropert(PD_PRINTTYPE   , nPrintType)
			oSetup:SetPropert(PD_ORIENTATION , nOrientation)
			oSetup:SetPropert(PD_DESTINATION , nLocal)
			oSetup:SetPropert(PD_MARGIN      , {60,60,60,60})
			oSetup:SetPropert(PD_PAPERSIZE   , 2)

			// ----------------------------------------------
			// Pressionado botï¿½o OK na tela de Setup
			// ----------------------------------------------
			If oSetup:Activate() == PD_OK // PD_OK =1
				
				//+--------------------------------+
				//| Salva os Parametros no Profile |
				//+--------------------------------+
		        WriteProfString( cSession, "LOCAL"      , If(oSetup:GetProperty(PD_DESTINATION)==1 ,"SERVER"    ,"CLIENT"    ), .T. )
		        WriteProfString( cSession, "PRINTTYPE"  , If(oSetup:GetProperty(PD_PRINTTYPE)==1   ,"SPOOL"     ,"PDF"       ), .T. )
		        WriteProfString( cSession, "ORIENTATION", If(oSetup:GetProperty(PD_ORIENTATION)==1 ,"PORTRAIT"  ,"LANDSCAPE" ), .T. )

				If oSetup:GetProperty(PD_ORIENTATION) == 2

					MsgInfo("Use Orientacao Retrato")
					lRet := .F.

				EndIf

			Else

				MsgInfo("Relatorio cancelado pelo usuario.")
				lRet := .F.

			EndIf

		EndIf

		If	lRet

			// Ordem obrigï¿½toria de configuraï¿½ï¿½o do relatï¿½rio
			oBoleto:SetResolution(78) //Tamanho estipulado para o Boleto
			oBoleto:SetPortrait()
			oBoleto:SetPaperSize(DMPAPER_A4)
			oBoleto:SetMargin(60,60,60,60)

			If !lBlind// Se nao estiver sendo chamado via Web Service

				// ----------------------------------------------
				// Define saida de impressï¿½o
				// ----------------------------------------------

				If	oSetup:GetProperty(PD_PRINTTYPE) = IMP_SPOOL

					oBoleto:nDevice := IMP_SPOOL
					// ----------------------------------------------
					// Salva impressora selecionada
					// ----------------------------------------------
					fwWriteProfString(GetPrinterSession(),"DEFAULT", oSetup:aOptions[PD_VALUETYPE], .T.)
					oBoleto:cPrinter := oSetup:aOptions[PD_VALUETYPE]

				ElseIf oSetup:GetProperty(PD_PRINTTYPE) = IMP_PDF

					oBoleto:nDevice := IMP_PDF
					// ----------------------------------------------
					// Define para salvar o PDF
					// ----------------------------------------------
					oBoleto:cPathPDF := oSetup:aOptions[PD_VALUETYPE]

				EndIf

			Else

				oBoleto:nDevice := IMP_PDF
				// ----------------------------------------------
				// Define para salvar o PDF
				// ----------------------------------------------

				cTempPath   := IIf( IsBlind(), "\boletos\tmp\", GetTempPath())
				cBolPath    := "\boletos\"

				If	!File( cBolPath+"." )
					MakeDir( cBolPath )
				EndIf

				If	!File( cTempPath+"." )
					MakeDir( cTempPath )
				EndIf

				oBoleto:cPathPDF := cTempPath //--"\portal_licenciado\boletos\"

			EndIf

		EndIf
	EndIf

	lIniImp := .T.

Return( lRet )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ MenuDef  ³ Autor ³ Fabio Briddi          ³ Data ³ Nov/2013 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Definicao de Menu Funcional Especifico da Rotina           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ aRotina - Array com as Opcoes da Rotina                    ³±±
±±³          ³ 1. Nome que aparecera nas Acoes Relacionadas               ³±±
±±³          ³ 2. Nome da Rotina associada                                ³±±
±±³          ³ 3. Reservado                                               ³±±
±±³          ³ 4. Tipo de Transacao a ser efetuada:                       ³±±
±±³          ³    1 - Pesquisa e Posiciona em um Banco de Dados           ³±±
±±³          ³    2 - Simplesmente Mostra os Campos                       ³±±
±±³          ³    3 - Inclui registros no Bancos de Dados                 ³±±
±±³          ³    4 - Altera o registro corrente                          ³±±
±±³          ³    5 - Remove o registro corrente do Banco de Dados        ³±±
±±³          ³ 5. Nivel de acesso                                         ³±±
±±³          ³ 6. Habilita Menu Funcional                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TRSF001 - Programa Principal                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MenuDef()

	Local aRotina := {}

	aAdd(aRotina,{"Pesquisar"   ,"AxPesqui"   ,0 ,1 })
	aAdd(aRotina,{"Visualizar"  ,"AxVisual"   ,0 ,2 })
	aAdd(aRotina,{"Impr. Boleto","U_TRSF001B" ,0 ,3 })

Return(aRotina)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ F001AjSx1 ³ Autor ³ Fabio Briddi         ³ Data ³ Nov/2013 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Verifica e Cria Grupo de Perguntas SX1 se necessario       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ cPerg - nome do Grupo de Perguntas                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TRSF001                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function F001AjSx1( )

	Local cPerg  := PadR("TRSF001",Len(SX1->X1_GRUPO))
	Local aP     := {}
	Local nI     := 0
	Local cSeq   := ""
	Local cMvCh  := ""
	Local cMvPar := ""
	Local aHelp  := {}

	//--      Texto Pergunta         , Tipo                   , Tam                    , Dec          , G=Get/C=Combo, Val,       F3,                 Def01,              Def02,        Def03, Def04, Def05
	aAdd(aP,{ "Codigo Banco:"        , TamSX3("EE_CODIGO")[3] , TamSX3("EE_CODIGO")[1] , TamSX3("EE_CODIGO")[2] , "G",  "", "SEEBOL",                    "",                 "",           "",    "",    "" })
	aAdd(aP,{ "Codigo Agência:"      , TamSX3("EE_AGENCIA")[3], TamSX3("EE_AGENCIA")[1], TamSX3("EE_AGENCIA")[2], "G",  "",       "",                    "",                 "",           "",    "",    "" })
	aAdd(aP,{ "Codigo Conta:"        , TamSX3("EE_CONTA")[3]  , TamSX3("EE_CONTA")[1]  , TamSX3("EE_CONTA")[2]  , "G",  "",       "",                    "",                 "",           "",    "",    "" })
	aAdd(aP,{ "Codigo Sub-Conta:"    , TamSX3("EE_SUBCTA")[3] , TamSX3("EE_SUBCTA")[1] , TamSX3("EE_SUBCTA")[2] , "G",  "",       "",                    "",                 "",           "",    "",    "" })
	aAdd(aP,{ "Gerar Boleto:"        , "N"                    , 1                      , 0                      , "C",  "",       "",   "Reg Posicionado  ","Cons Par Abaixo  ",           "",    "",    "" })
	aAdd(aP,{ "Do Prefixo:"          , TamSX3("E1_PREFIXO")[3], TamSX3("E1_PREFIXO")[1], TamSX3("E1_PREFIXO")[2], "G",  "",       "",                    "",                 "",           "",    "",    "" })
	aAdd(aP,{ "Ate Prefixo:"         , TamSX3("E1_PREFIXO")[3], TamSX3("E1_PREFIXO")[1], TamSX3("E1_PREFIXO")[2], "G",  "",       "",                    "",                 "",           "",    "",    "" })
	aAdd(aP,{ "Do Titulo:"           , TamSX3("E1_NUM")[3]    , TamSX3("E1_NUM")[1]    , TamSX3("E1_NUM")[2]    , "G",  "",       "",                    "",                 "",           "",    "",    "" })
	aAdd(aP,{ "Ate Titulo:"          , TamSX3("E1_NUM")[3]    , TamSX3("E1_NUM")[1]    , TamSX3("E1_NUM")[2]    , "G",  "",       "",                    "",                 "",           "",    "",    "" })
	aAdd(aP,{ "Do Parcela:"          , TamSX3("E1_PARCELA")[3], TamSX3("E1_PARCELA")[1], TamSX3("E1_PARCELA")[2], "G",  "",       "",                    "",                 "",           "",    "",    "" })
	aAdd(aP,{ "Ate Parcel:"          , TamSX3("E1_PARCELA")[3], TamSX3("E1_PARCELA")[1], TamSX3("E1_PARCELA")[2], "G",  "",       "",                    "",                 "",           "",    "",    "" })
	aAdd(aP,{ "Do Tipo:"             , TamSX3("E1_TIPO")[3]   , TamSX3("E1_TIPO")[1]   , TamSX3("E1_TIPO")[2]   , "G",  "",       "",                    "",                 "",           "",    "",    "" })
	aAdd(aP,{ "Ate Tipo:"            , TamSX3("E1_TIPO")[3]   , TamSX3("E1_TIPO")[1]   , TamSX3("E1_TIPO")[2]   , "G",  "",       "",                    "",                 "",           "",    "",    "" })
	aAdd(aP,{ "Da Emissao:"          , TamSX3("E1_EMISSAO")[3], TamSX3("E1_EMISSAO")[1], TamSX3("E1_EMISSAO")[2], "G",  "",       "",                    "",                 "",           "",    "",    "" })
	aAdd(aP,{ "Ate Emissiao:"         , TamSX3("E1_EMISSAO")[3], TamSX3("E1_EMISSAO")[1], TamSX3("E1_EMISSAO")[2], "G",  "",       "",                    "",                 "",           "",    "",    "" })
	aAdd(aP,{ "Do Vencimento:"       , TamSX3("E1_VENCREA")[3], TamSX3("E1_VENCREA")[1], TamSX3("E1_VENCREA")[2], "G",  "",       "",                    "",                 "",           "",    "",    "" })
	aAdd(aP,{ "Ate Vencimento:"      , TamSX3("E1_VENCREA")[3], TamSX3("E1_VENCREA")[1], TamSX3("E1_VENCREA")[2], "G",  "",       "",                    "",                 "",           "",    "",    "" })
	aAdd(aP,{ "Do Bordero:"          , TamSX3("E1_NUMBOR")[3] , TamSX3("E1_NUMBOR")[1] , TamSX3("E1_NUMBOR")[2] , "G",  "",       "",                    "",                 "",           "",    "",    "" })
	aAdd(aP,{ "Ate Bordero:"         , TamSX3("E1_NUMBOR")[3] , TamSX3("E1_NUMBOR")[1] , TamSX3("E1_NUMBOR")[2] , "G",  "",       "",                    "",                 "",           "",    "",    "" })

	aAdd(aP,{ "Cliente De:"          , TamSX3("A1_COD")[3]	  , TamSX3("A1_COD")[1]    , TamSX3("A1_COD")[2]    , "G",  "",    "SA1",                    "",                 "",           "",    "",    "" })
	aAdd(aP,{ "Loja De:"             , TamSX3("A1_LOJA")[3]   , TamSX3("A1_LOJA")[1]   , TamSX3("A1_LOJA")[2]   , "G",  "",       "",                    "",                 "",           "",    "",    "" })
	aAdd(aP,{ "Cliente Ate:"         , TamSX3("A1_COD")[3]    , TamSX3("A1_COD")[1]    , TamSX3("A1_COD")[2]    , "G",  "",    "SA1",                    "",                 "",           "",    "",    "" })
	aAdd(aP,{ "Loja Ate:"            , TamSX3("A1_LOJA")[3]   , TamSX3("A1_LOJA")[1]   , TamSX3("A1_LOJA")[2]   , "G",  "",       "",                    "",                 "",           "",    "",    "" })

	aAdd(aP,{ "Gerar PDF:"           , "N"                    , 1                      , 0                      , "C",  "",       "",       "Arquivo Unico",       "P/ Cliente",  "P/ Titulo",    "",    "" })
	aAdd(aP,{ "Envia E-mail:"        , "N"                    , 1                      , 0                      , "C",  "",       "",                 "Não",              "Sim",           "",    "",    "" })

	If lForma
		aAdd(aP,{ "Forma Pagto:"      , TamSX3("E1_FORMA")[3]  , 30  , TamSX3("E1_FORMA")[2]  , "G",  "",       "",                    "",                 "",           "",    "",    "" })
	EndIf

	If lSegundaVia
		aAdd(aP,{ "Segunda Via?"      , "N"						  , 1								, 0							 , "C",  "",       "",                  "Não",              "Sim",           "",    "",    "" })
	Endif


	 //           123456789123456789012345678901234567890
    //                   1         2         3         4
	aAdd(aHelp,{"Selecione o Codigo do Banco que serie   ","usado para a geracao do Boleto.         ","Tecla [F3] disponivel para consultar o  ",;
				"Cadastro de Bancos e preencher os       ","proximos Parâmetros 'Codigo da Agência:'",", 'Codigo da Conta:' e 'Codigo da       ",;
				"Sub-Conta:' automaticamente.            " })
	aAdd(aHelp,{"Informe o codigo da Agência que serie    ","usada na geracao do Boleto.             " })
	aAdd(aHelp,{"Informe o codigo da Conta que serie      ","usada na geracao do Boleto.             " })
	aAdd(aHelp,{"Informe o codigo da Sub-Conta que serie  ","usada na geracao do Boleto.             " })
	aAdd(aHelp,{"Informe 'Reg Posicionado' se deseja     ","gerar apenas o Titulo em destaque no    ","no Browse ou Informe os Parâmetros      ",;
				"abaixo com os dados dos Titulos para a  ","selecao no Contas a Receber.            " })
	aAdd(aHelp,{"Informe o prefixo inicial do intervalo  ","de prefixos a serem considerados para a ","a geracao de Boletos                    " })
	aAdd(aHelp,{"Informe o prefixo final do intervalo de ","prefixos a serem considerados para a    ","geracao de Boletos                      " })
	aAdd(aHelp,{"Informe o Titulos inicial do intervalo   ","de titulos a serem considerados para a  ","geracao de Boletos                      " })
	aAdd(aHelp,{"Informe o Titulos final do intervalo de  ","titulos a serem considerados para a     ","geracao de Boletos                      " })
	aAdd(aHelp,{"Informe o Parcela inicial do intervalo  ","de parcelas a serem considerados para a ","geracao de Boletos                      " })
	aAdd(aHelp,{"Informe o Parcela final do intervalo de ","parcelas a serem considerados para a    ","geracao de Boletos                      " })
	aAdd(aHelp,{"Informe o Tipo de Titulos inicial do     ","intervalo de tipos de titulos a ser      ","considerado para a geracao de Boletos.  ",;
				"Tecla <F3> disponivel para consulta a   ","tabela de tipos de titulos.             " })
	aAdd(aHelp,{"Informe o Tipo de Titulo final do       ","intervalo de tipos de titulo a ser      ","considerado para a geracao de Boletos.  ",;
				"Tecla <F3> disponivel para consulta a   ","tabela de tipos de titulos.             " })
	aAdd(aHelp,{"Informe Data Inicial do intervalo de    ","Datas de Emissao a serem considerados   ",;
				"para a geracao de Boletos.              ","Botão 'Calendario' disponivel           " })
	aAdd(aHelp,{"Informe Data Final do intervalo de Datas","de Emissao a serem considerados para a  ",;
				"geracao de Boletos.                     ","Botão 'Calendario' disponivel           " })
	aAdd(aHelp,{"Informe Data Inicial do intervalo de    ","Datas de Vencimento a serem considerados ",;
				"para a geracao de Boletos.              ","Botão 'Calendario' disponivel           " })
	aAdd(aHelp,{"Informe Data Final do intervalo de Datas","de Vencimento a serem considerados para ",;
				"a geracao de Boletos.                   ","Botão 'Calendario' disponivel           " })
	aAdd(aHelp,{"Informe codigo inicial do intervalo de  ","borderos a serem considerados para a    ","geracao de Boletos                      " })
	aAdd(aHelp,{"Informe codigo final do intervalo de    ","borderos serem considerados para a      ","geracao de Boletos                      " })
	aAdd(aHelp,{"Informe codigo inicial do cliente       "})
	aAdd(aHelp,{"Informe codigo inicial da loja			 "})
	aAdd(aHelp,{"Informe codigo final do cliente         "})
	aAdd(aHelp,{"Informe codigo final da loja   	     "})

	aAdd(aHelp,{"Informe se como deseja que seja gerado o","arquivo PDF:                            ",;
				"1-Tecnico                                 ","2-Cliente + Loja                        ","3-Cliente+Loja+Prefixo+Numero Titulo  "})
	aAdd(aHelp,{"Informe se o Boleto sera enviado   ","para o e-mail cadastrado para o Cliente ","após a geração                          ",;
				"Obs.:                                   ",;
				"Os Boletos devem ser impressos em:      ","'PDF p/ Cliente' ou 'PDF p/ Boletos'    ","para serem enviados por email.          ",;
				"                                        ",;
				"O Texto do email devera estar na        ","Pasta: \protheus_data\modelos_html\     ","Arquivo Padrão: trsf001_mod1.html       "})
	If lForma
		aAdd(aHelp,{"Informe a forma de pagamento     "})
	EndIf

	If lSegundaVia
		aAdd(aHelp,{"Informe se sera impressão de segunda via do boleto."})
	EndIf

	For nI := 1 To Len(aP)

		cSeq	:= StrZero(nI,2,0)
		cMvPar	:= "mv_par"+cSeq
		cMvCh	:= "mv_ch"+IIF(nI<=9,Chr(nI+48),Chr(nI+87))

		PutSx1(	cPerg,;							//-- cGrupo
				cSeq,;							//-- cOrdem
				aP[nI,01],aP[nI,01],aP[nI,01],;	//-- cPergunt,cPerSpa,cPerEng
				cMvCh,;							//-- cVar
				aP[nI,02],;						//-- cTipo
				aP[nI,03],;						//-- nTamanho
				aP[nI,04],;						//-- Decimal
				0,;								//-- nPreSel
				aP[nI,05],;						//-- cGSC
				aP[nI,06],;						//-- cValid
				aP[nI,07],;						//-- cF3
				"",;							//-- cGrpSXG
				"",;							//-- cPyme
				cMvPar,;						//-- cVar01
				aP[nI,08],aP[nI,08],aP[nI,08],;	//-- cDef01,cDefSpa1,cDefEng1
				"",;							//-- cCnt01
				aP[nI,09],aP[nI,09],aP[nI,09],;	//-- cDef02,cDefSpa2,cDefEng2
				aP[nI,10],aP[nI,10],aP[nI,10],;	//-- cDef03,cDefSpa3,cDefEng3
				aP[nI,11],aP[nI,11],aP[nI,11],;	//-- cDef04,cDefSpa4,cDefEng4
				aP[nI,12],aP[nI,12],aP[nI,12],;	//-- cDef05,cDefSpa5,cDefEng5
				aHelp[nI],;						//-- aHelpPor
				{},;							//-- aHelpEng
				{},;							//-- aHelpSpa
				"")								//-- cHelp

	Next nI

	//+----------------------------------------------------------------------+
	//| Verifica e Compatibiliza a Consulta Padrao dos Parametros dos Bancos |
	//| Primeiro Verifica se o SX1->X1_F3 esta com o SEEBOL                  |
	//| Segundo Verifica se Existe a Consulta Padrao SEEBOL no SXB           |
	//+----------------------------------------------------------------------+
	dbSelectArea("SX1")
	dbSetOrder(1)
	If	dbSeek(cPerg+"01")
		If	SX1->X1_F3 <> "SEEBOL"
			RecLock("SX1",.F.)
				SX1->X1_F3 := "SEEBOL"
			MsUnLock()
		EndIf
	EndIf

	dbSelectArea("SXB")
	dbSetOrder(1)
	If !dbSeek("SEEBOL")
		F001AjSxb()
	EndIf

Return( cPerg )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ F001AjSxb ³ Autor ³ Fabio Briddi         ³ Data ³ Jan/2014 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Cria Consulta Padrao (SXB)                                 ³±±
±±³          ³ Consulta: SEEBOL - Parametros de Bancos p/ Impr. Boletos   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TRSF001                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function F001AjSxb()

	Local cConPad := "SEEBOL"
	Local aConPad := {}
	Local nInd    := 0

	//--            XB_ALIAS, XB_TIPO, XB_SEQ, XB_COLUNA, XB_DESCRI, XB_DESCSPA, XB_DESCENG, XB_CONTEM
	aAdd( aConPad, { cConPad, "1", "01", "DB", "Bancos / Parâmetros" , "Bancos / Parâmetros" , "Bancos / Parâmetros" , "SEE"            } )
	aAdd( aConPad, { cConPad, "2", "01", "01", "Banco + Agencia + Co", "Banco + Agencia + Cu", "Bank + Bank Office +", ""               } )
	aAdd( aConPad, { cConPad, "4", "01", "01", "Banco"               , "Banco"               , "Bank"                , "EE_CODIGO"      } )
	aAdd( aConPad, { cConPad, "4", "01", "02", "Agencia"             , "Agencia"             , "Bank Office"         , "EE_AGENCIA"     } )
	aAdd( aConPad, { cConPad, "4", "01", "03", "Conta"               , "Cuenta"              , "C. Account"          , "EE_CONTA"       } )
	aAdd( aConPad, { cConPad, "4", "01", "04", "Sub Conta"           , "Subcuenta"           , "Sub Account"         , "EE_SUBCTA"      } )
	aAdd( aConPad, { cConPad, "4", "01", "05", "Operacao"            , "Operacion"           , "Operation"           , "EE_OPER"        } )
	aAdd( aConPad, { cConPad, "5", "01", ""  , ""                    , ""                    , ""                    , "SEE->EE_CODIGO" } )
	aAdd( aConPad, { cConPad, "5", "02", ""  , ""                    , ""                    , ""                    , "SEE->EE_AGENCIA"} )
	aAdd( aConPad, { cConPad, "5", "03", ""  , ""                    , ""                    , ""                    , "SEE->EE_CONTA"  } )
	aAdd( aConPad, { cConPad, "5", "04", ""  , ""                    , ""                    , ""                    , "SEE->EE_SUBCTA" } )

	For nInd := 1 To Len(aConPad)

		RecLock("SXB",.T.)
			SXB->XB_ALIAS   := aConPad[nInd,1]
			SXB->XB_TIPO    := aConPad[nInd,2]
			SXB->XB_SEQ     := aConPad[nInd,3]
			SXB->XB_COLUNA  := aConPad[nInd,4]
			SXB->XB_DESCRI  := aConPad[nInd,5]
			SXB->XB_DESCSPA := aConPad[nInd,6]
			SXB->XB_DESCENG := aConPad[nInd,7]
			SXB->XB_CONTEM  := aConPad[nInd,8]
		MsUnLock()

	Next nInd

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ F001Mail ³ Autor ³ Fabio Briddi          ³ Data ³ Dez/2014 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Gera e-mail apartir de modelo Html                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ F001Email( aCedente, aSacado, aTitMail, cPdf )             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ aCedente - Dados da Empresa/Filial Emitente Boleto         ³±±
±±³          ³ aSacado  - Dados do Devedor do Titulo                      ³±±
±±³          ³ aTitMail - Titulos contidos no Pdf                         ³±±
±±³          ³ cPdf     - Nome do arquivo Pdf para anexar ao e-mail       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ aRet     - Status Envio                                    ³±±
±±³          ³ aRet[1]  - .T. = Envio Ok  - .F. = Falha Envio             ³±±
±±³          ³ aRet[2]  - Mensagem                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ TRSF001 - Impressao de Boletos Bancarios                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function F001Email( aCedente, aSacado, aTitMail, cPdf )

	Local cHtml     := ""
	Local cModPath  := "\modelos_html\"
	Local cNomeArq  := "trsf001_Mod1"
	Local cArqMod   := ""
	Local cError    := ""
	Local cBoleto   := ""
	Local aArqMod   := {}
	Local aConteudo := {}
	Local aRet      := {}
	Local lExiste   := .F.
	Local lOK       := .F.
	Local cTitulos  := ""
	Local nInd      := 0
	Local nI        := 0

	aAdd(aArqMod, cModPath + cNomeArq + cEmpAnt + cFilAnt + ".html")
	aAdd(aArqMod, cModPath + cNomeArq + cEmpAnt + ".html")
	aAdd(aArqMod, cModPath + cNomeArq + ".html") //-- Modelo padrao

	// Cria a pasta, se Não existir
	If	!File( cModPath + "." )
		MakeDir( cModPath )
	EndIf

	// Verifica se ha modelos salvos
	For nI := 1 To Len(aArqMod)

		If	File( aArqMod[nI] )
			cArqMod := aArqMod[nI]
			lExiste := .T.
		EndIf

	Next nI

	// Cria um modelo padrao, se Não existir algum modelo salvo
	If !lExiste
		F001ModHtml( aArqMod[3] )
	EndIf

	//+-------------------------------------------+
	//| Monta a Lista dos Titulos contidos no Pdf |
	//+-------------------------------------------+
 	cTitulos += "<Table border=2 CELLPADDING=5>"
	cTitulos += " <tr>"
	cTitulos += "  <th> Titulo  	 </th>"
	cTitulos += "  <th> Vencimento  </th>"
	cTitulos += "  <th> Valor       </th>"
	cTitulos += "  <th> Banco       </th>"
	cTitulos += " </tr>"

	For nInd := 1 To Len(aTitmail)

		cTitulos += " <tr>"
		cTitulos += "  <td> " + aTitMail[nInd,1] + "</td>"
		cTitulos += "  <td> " + aTitMail[nInd,2] + "</td>"
		cTitulos += "  <td> " + aTitMail[nInd,3] + "</td>"
		cTitulos += "  <td> " + aTitMail[nInd,4] + "</td>"
		cTitulos += " </tr>"

		cBoleto += aTitMail[nInd,1] + If( nInd != Len(aTitmail), ", ", "" )

	Next nInd

	cTitulos += "</table><br>"

	//+------------------------------------------------------------+
	//| Monta o Array com as Variveis no Html a serem substituidas |
	//+------------------------------------------------------------+
	aAdd( aConteudo,{ "%cContato%"    , aSacado[SAC_CONTATO] } )
	aAdd( aConteudo,{ "%cNomeSacado%" , aSacado[SAC_NOME]    } )
	aAdd( aConteudo,{ "%cCnpjSacado%" , aSacado[SAC_CNPJ]    } )
	aAdd( aConteudo,{ "%cEmitente%"   , aCedente[CED_NOME]   } )
	aAdd( aConteudo,{ "%cTitulos%"    , cTitulos             } )

	cAssunto := AllTrim(aCedente[CED_NOME]) + " - Boleto Cobrança " + cBoleto

	If File( cArqMod )

		//+----------------------------------------------------------------------+
		//| Le Arquivo Modelo substituindo as macros pelo conteudo das variaveis |
		//+----------------------------------------------------------------------+
		cHtml  := F001MontaHtml( cArqMod, aConteudo )
		cEmail := aSacado[SAC_EMAIL]

		//+-------------------------------+
		//| Envia o Email apos a montagem |
		//+-------------------------------+
		aRet  := F001EnviaMail( cHTML, cEmail, cAssunto, cPdf )

	Else

		cError := "- Arquivo modelo Não encontrado. " + CRLF
		cError += "Caminho: " + cArqMod + CRLF
		aRet:= {.F. , cError}

	Endif

Return( aRet )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ F001MontaHtml ³ Autor ³ Fabio Briddi     ³ Data ³ Dez/2014 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Insere informacoes no Arquivo HTML                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ F001MontaHtml( cExp1, aExp1 )                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cExp1 - Caminho do Arquivo modelo HTML                     ³±±
±±³          ³ aExp1 - Variavel com o conteudo a ser apendada             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ cHtml - String HTML modificada                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ TRSF001 - Impressao de Boletos Bancarios                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function F001MontaHtml( cArqMod, aConteudo, cPdf )

	Local nA        := 0
	Local cHtml     := ""
	Local cLinha    := ""
	Local cLinhaNew := ""

	FT_FUse(cArqMod)
	FT_FGOTOP()

	Do While !FT_FEOF()

		cLinha := FT_FREADLN()

		nAchou := AT('%',cLinha)// Verifica se a Linha Tem Campo a Substituir

		If nAchou > 0

			For nA := 1 To Len(aConteudo)

				nAchou := AT(Upper(aConteudo[nA,1]),Upper(cLinha))
				cLinhaNew := ""

				If nAchou > 0
					cLinhaNew := Substr(cLinha,1,nAchou-1)
					cLinhaNew += aConteudo[nA,2]
					cLinhaNew += Substr(cLinha,nAchou+Len(aConteudo[nA,1]))
					cLinha    := cLinhaNew
				Endif

			Next

		Endif

		cHtml += cLinha
		FT_FSKIP()

	EndDo

Return( cHtml )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao  ³ A040EnviaMail ³ Autor ³ Jeferson Dambros ³ Data ³ 16/10/2014 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Gera o arquivo HTML e  envia o e-mail com a liberacao      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ A040GeraEmail( cExp1, cExp2 )                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cExp1 -  Tabela posicionada                                ³±±
±±³          ³ cExp2 -  endereco de e-mail                                ³±±
±±³          ³ cExp3 -  Indica a tabela que esta sendo utilizada          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Especifico Cliente S.C Internacional                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³                          ULTIMAS ALTERACOES                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ Motivo da Alteracao                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function F001EnviaMail( cHTML, cTo, cSubject, cPdf )

	Local cError     := ""
	Local cMsg       := ""
	Local lOK        := .F.
	Local lMsgError  := .T.
	Local lAuth      := GetMv( "MV_RELAUTH" )
	Local cServer    := GetMv( "MV_RELSERV" )
	Local cAccount   := GetMv( "MV_RELACNT" )
	Local cPassword  := GetMv( "MV_RELPSW"  )
	Local aFiles     := { cPdf }

	// conectando-se com o servidor de e-mail
	CONNECT SMTP SERVER cServer ACCOUNT cAccount PASSWORD cPassword RESULT lResult

		// Fazendo autenticacao
		If lResult .And. lAuth

			lResult := MailAuth( cAccount,cPassword )
			If !lResult

				If lMsgError// Erro na conexao com o SMTP Server

					GET MAIL ERROR cError
					cMsg += "- Erro na autenticacao da conta do e-mail. " + cError + CRLF
					lOK:= .F.

				EndIf

			EndIf

		Else

			If !lResult

				If lMsgError//Erro na conexao com o SMTP Server

					GET MAIL ERROR cError
					cMsg += "- Erro de conexao com servidor SMTP. " + cError + CRLF
					lOK:= .F.

				EndIf

			EndIf

		EndIf

		If !lResult

			GET MAIL ERROR cError
			cMsg += "- Erro ao conectar a conta de e-mail. " + cError
			lOK:= .F.

		Else

			SEND MAIL FROM cAccount TO cTo SUBJECT cSubject BODY cHTML ATTACHMENT aFiles[1] RESULT lResult

			If !lResult

				GET MAIL ERROR cError
				cMsg := "- Erro no Envio do e-mail. " + cError + CRLF
				lOK  := .F.

			EndIf

			lOK := .T.

		EndIf

		DISCONNECT SMTP SERVER

Return( {lOK, cMsg} )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ F001ModHtml   ³ Autor ³ Fabio Briddi     ³ Data ³ Dez/2014 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Insere informacoes no Arquivo HTML                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ F001ModHtml( cExp1, aExp1 )                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cExp1 - Caminho do Arquivo modelo HTML                     ³±±
±±³          ³ aExp1 - Variavel com o conteudo a ser apendada             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ cHtml - String HTML modificada                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ TRSF001 - Impressao de Boletos Bancarios                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function F001ModHtml( cArqMod )

	Local cHtml := ''

	cHtml += ' <!DOCTYPE HTML> ' + CRLF
	cHtml += ' <html> ' + CRLF
	cHtml += ' 	<body> ' + CRLF
	cHtml += ' 	<style type="text/css"> ' + CRLF
	cHtml += ' 	body{ ' + CRLF
	cHtml += ' 		  font-family: Arial Narrow;	 ' + CRLF
	cHtml += ' 		  font-size: 16	   ' + CRLF
	cHtml += ' 		} ' + CRLF
	cHtml += ' 	p{ ' + CRLF
	cHtml += ' 	  font-family: Arial Narrow; ' + CRLF
	cHtml += ' 	  line-height:100%; ' + CRLF
	cHtml += ' 	  white-space: pre-line ' + CRLF
	cHtml += ' 	 } ' + CRLF
	cHtml += ' 	 span{ ' + CRLF
	cHtml += ' 	  font-family: Arial Narrow ' + CRLF
	cHtml += ' 		 } ' + CRLF
	cHtml += ' 	  ' + CRLF
	cHtml += ' 	<!-- ' + CRLF
	cHtml += ' 	</span><img src="https://urldefense.com/v3/__http://downloads.empresamodelo.com.br/header_empresa_modelo.jpg__;!!LpKI!0Nig3gVL1mtzb2YRYopucVmctRgZJSC2ytYDPYbRp8w127FvXR3aTX9Hhp3K5Ci66A$ [downloads[.]empresamodelo[.]com[.]br]" height="76" width="588"><br> ' + CRLF
	cHtml += ' 	--> ' + CRLF
	cHtml += '  ' + CRLF
	cHtml += ' 	</style><span style="font-weight: bold;"><br><br> ' + CRLF
	cHtml += ' 	Prezado(a) %cContato%:</span><br> ' + CRLF
	cHtml += ' 	<p> ' + CRLF
	cHtml += ' 	Segue em anexo o(s) boletos(s) bancário(s) enviados pelo emitente %cEmitente%, conforme detalhados abaixo: ' + CRLF
	cHtml += ' 	</p> ' + CRLF
	cHtml += ' 		Sacado: %cNomeSacado% <br> ' + CRLF
	cHtml += ' 		CNPJ: %cCnpjSacado%<br> ' + CRLF
	cHtml += ' 	</p> ' + CRLF
	cHtml += ' 	%cTitulos% ' + CRLF
	cHtml += ' 	</p> ' + CRLF
	cHtml += ' 	</p> ' + CRLF
	cHtml += ' 	</p> ' + CRLF

	cHtml += ' 	<span style="font-weight: bold;"> ' + CRLF
	cHtml += ' 	Em caso de dúvida ou alterações no cadastro, entre em contato com nosso departamento financeiro: ' + CRLF
	cHtml += ' 	<br> ' + CRLF
	cHtml += ' 	<span style="font-weight: bold;"; color: rgb(51, 102, 255);"> ' + CRLF
	cHtml += ' 	Telefone: (51) 99858-5441   (51) 3470-9682<br> ' + CRLF
	cHtml += ' 	fin01@refrijet.com.br<br> ' + CRLF
	cHtml += ' 	<a href="https://urldefense.com/v3/__http://www.refrijet.com.br__;!!LpKI!0Nig3gVL1mtzb2YRYopucVmctRgZJSC2ytYDPYbRp8w127FvXR3aTX9Hhp3UZR-dKw$ [refrijet[.]com[.]br]" target="_blank">https://urldefense.com/v3/__http://www.refrijet.com.br__;!!LpKI!0Nig3gVL1mtzb2YRYopucVmctRgZJSC2ytYDPYbRp8w127FvXR3aTX9Hhp3UZR-dKw$ [refrijet[.]com[.]br]</a><br> ' + CRLF
	cHtml += ' 	<p> ' + CRLF
	cHtml += ' 	Atenciosamente,<br> ' + CRLF
	cHtml += ' 	%cEmitente% ' + CRLF

	cHtml += ' 	<!-- ' + CRLF
	cHtml += ' 	</span><img src="https://urldefense.com/v3/__http://downloads.empresamodelo.com.br/footer_empresa_modelo.jpg__;!!LpKI!0Nig3gVL1mtzb2YRYopucVmctRgZJSC2ytYDPYbRp8w127FvXR3aTX9Hhp2KFSee-A$ [downloads[.]empresamodelo[.]com[.]br]" height="76" width="588"><br> ' + CRLF
	cHtml += ' 	--> ' + CRLF

	cHtml += ' 	</span> ' + CRLF
	cHtml += ' 	</body> ' + CRLF
	cHtml += ' </html> ' + CRLF

	MemoWrite( cArqMod, cHtml  )

	//alert(cHtml)

Return( )

/*
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
*/

Static Function F001FormVal( nValor )

	cVlrFornat	:= TransForm( nValor, PICT_VALOR )

Return( cVlrFornat )

/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
	±±³Fun‡…o    ³SumAbatRec³ Autor ³ Wagner Xavier         ³ Data ³ 23/03/93 ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Adpatacao ³SumAbatRec³ Analis³ Fabio Briddi          ³ Data ³ Dez/2014 ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Descri‡…o ³Soma titulos de abatimento relacionado a um determinado titu³±±
	±±³          ³lo a receber                                                ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Sintaxe   ³SumAbatRec()                                                ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Parametros³Prefixo,Numero,Parcela,Moeda,Saldo ou Valor                 ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³ Uso      ³TRSF001                                                     ³±±
	±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function SumAbatRec( cPrefixo, cNumero, cParcela, nMoeda, cCpo, dData, nTotAbImp, nTotIrAbt, nTotCsAbt, nTotPisAbt, nTotCofAbt, nTotInsAbt, nTotIssAbt, nTotTitAbt )

	Local cAlias   := Alias()
	Local nTotAbat := 0
	Local nRec     := RecNo()
	Local cCliLj   := ""
	Local lPccBxCr		:= FPccBxCr()

	cFilAbat       := xFilial("SE1")
	dData  := IIf( dData  == Nil , dDataBase, dData)
	nMoeda := IIf( nMoeda == Nil , 1, nMoeda)

	cCampo := IIf( cCpo == "V", "E1_VALOR" , "E1_SALDO" )

	cCliLj := SE1->(E1_CLIENTE+E1_LOJA)

	If Select("__SE1") == 0
		ChkFile("SE1",.F.,"__SE1")
	Else
		dbSelectArea("__SE1")
	EndIf

	dbSetOrder( 1 )
	dbSeek( cFilAbat + cPrefixo + cNumero + cParcela )

	While	!Eof()					.And.;
			E1_FILIAL  == cFilAbat	.And.;
			E1_PREFIXO == cPrefixo	.And.;
			E1_NUM     == cNumero	.And.;
			E1_PARCELA == cParcela

		If E1_CLIENTE+E1_LOJA == cCliLj
			If E1_TIPO $ MVABATIM+"/"+MVIRABT+"/"+MVINABT+"/"+MVCSABT+"/"+MVCFABT+"/"+MVPIABT
				nTotAbat+=xMoeda(&cCampo.,E1_MOEDA, nMoeda,dData)
			EndIf
			If E1_TIPO $ MVIRABT+"/"+MVINABT+"/"+MVCSABT+"/"+MVCFABT+"/"+MVPIABT+"/"+MVISABT+"/"+MVFUABT
				nTotAbImp +=xMoeda(&cCampo,E1_MOEDA, nMoeda,dData)
			EndIf
			//--	Irrf
			If E1_TIPO $ MVIRABT .And. E1_TIPO $ MVABATIM
				nTotIrAbt +=xMoeda(&cCampo,E1_MOEDA, nMoeda,dData)
			EndIf
			//--	Csll
			If E1_TIPO $ MVCSABT .And. E1_TIPO $ MVABATIM
				nTotCsAbt +=xMoeda(&cCampo,E1_MOEDA, nMoeda,dData)
			EndIf
			//--	PIS
			If E1_TIPO $ MVPIABT .And. E1_TIPO $ MVABATIM
				nTotPisAbt +=xMoeda(&cCampo,E1_MOEDA, nMoeda,dData)
			EndIf
			//--	COFINS
			If E1_TIPO $ MVCFABT .And. E1_TIPO $ MVABATIM
				nTotCofAbt +=xMoeda(&cCampo,E1_MOEDA, nMoeda,dData)
			EndIf
			//--	INSS
			If E1_TIPO $ MVINABT .And. E1_TIPO $ MVABATIM
				nTotInsAbt +=xMoeda(&cCampo,E1_MOEDA, nMoeda,dData)
			EndIf

			//--	ISS
			If E1_TIPO $ MVISABT .And. E1_TIPO $ MVABATIM
				nTotIssAbt +=xMoeda(&cCampo,E1_MOEDA, nMoeda,dData)
			EndIf

			//--	AB-
			If E1_TIPO $ "AB-" .And. E1_TIPO $ MVABATIM
				nTotTitAbt +=xMoeda(&cCampo,E1_MOEDA, nMoeda,dData)
			EndIf

		EndIf

		dbSkip()

	EndDo

	dbSelectArea( cAlias )
	dbGoTo(nRec)

	IF lPccBxCr	    // PCC na baixa
		nTotAbat+= xMoeda(SE1->E1_PIS+SE1->E1_COFINS+SE1->E1_CSLL,SE1->E1_MOEDA,nMoeda,dData)
		nTotCsAbt :=xMoeda(SE1->E1_CSLL,SE1->E1_MOEDA, nMoeda,dData)
		nTotPisAbt:=xMoeda(SE1->E1_PIS, SE1->E1_MOEDA, nMoeda,dData)
		nTotCofAbt:=xMoeda(SE1->E1_COFINS,SE1->E1_MOEDA, nMoeda,dData)
	EndIf
Return (NoRound(nTotAbat))

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³F001ValImp³ Autor ³Giovanni Melo          ³ Data ³27/02/2015³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Valida a reimpressao do boleto                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³F001ValImp(aTitulo, aBanco)                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³aTitulo                                                     ³±±
±±³          ³aBanco                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³lImprime                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function F001ValImp(aTitulo, aBanco)

	Local lImprime := .F.

	dbSelectArea("SE1")
	SE1->(dbGoTo(aTitulo[TIT_RECSE1]))

	If Empty(SE1->E1_PORTADO) .And. Empty(SE1->E1_NUMBCO)
		lImprime := .T.
	Else
		If aBanco[BCO_NUMBCO] = AllTrim(SE1->E1_PORTADO)
			lImprime := .T.
		EndIf
	EndIf

Return(lImprime)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³F001TEMP  ³ Autor ³ Paola                 ³ Data ³08/07/2015³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Copia logo para pasta temporaria                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³F001TEMP ( @Boleto )                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO01 - Objeto de impressao                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function F001TEMP ( oBoleto )

	Local clogo	:= ""
	Local nX		:= 0
	Local cTempPath   := IIf( IsBlind(), "\boletos\bmp", GetTempPath())
	Local aTemp	:= { cTempPath, cTempPath+"\bmp\" }
	Local aLinha	:= { -002, 153 }

   	cLogo := "lgbco"+cBCO_NUMBCO+".bmp"

	For nX	:= 1 to Len(aTemp)

		If	!File( aTemp[nX] + "." )
			MakeDir( aTemp[nX] )
		EndIf

		__CopyFile( "\system\" + clogo, aTemp[nX] + cLOGO )

		oBoleto:SayBitmap( aLinha[nX],001, aTemp[nX] + cLOGO ,060,015)//Logotipo Ficha Compensacao

	Next nX

Return ( Nil )

/*
|============================================================================|
|============================================================================|
|||-----------+----------+-------+-----------------------+------+----------|||
||| Funcao    |BCCLI  | Autor | Samuel Schneider      | Data |13/11/2018   |||
|||-----------+----------+-------+-----------------------+------+----------|||
||| Descricao | Monta Joins para Query para regra de um  cliente           |||
|||-----------+------------------------------------------------------------|||
||| Sintaxe   | BCCLI()                                                    |||
|||-----------+------------------------------------------------------------|||
||| Parametros| tipo = 'INNER'                                             |||
|||-----------+------------------------------------------------------------|||
||| Retorno   | 								                           |||
|||-----------+------------------------------------------------------------|||
|============================================================================|
|============================================================================|*/
Static Function BCCLI(cTipo)
	Local cRet := ""

	If cTipo == 'INNER'

		cRet := " INNER JOIN "+RetSqlName("SEE")+" SEE ON "+ CRLF
		cRet += " SEE.EE_FILIAL = '"+xFilial("SEE")+"'    "+ CRLF
		cRet += " AND SEE.EE_CODIGO = SA1.A1_BCO1         "+ CRLF
		cRet += " AND SEE.D_E_L_E_T_ <> '*'               "+ CRLF

	EndIf


Return cRet


/*/
+----------+----------+-------+-----------------------+------+----------+
|Funcao    |  Mod113791       | Autor                 | Data |          |
+----------+----------+-------+-----------------------+------+----------+
|Descricao | Calculo Modulo 11 Base de 3791								|
+----------+------------------------------------------------------------+
|Uso       | TRSF001                                                    |
+----------+------------------------------------------------------------+
/*/
static function Mod11756( cString )

	local nStr   := len(cString)
	local nSoma  := 0
	local nPeso  := 3
	local nDV    := 0

	while nStr > 0
		nSoma += Val( subStr( cString, nStr, 1 ) ) * nPeso
		If nPeso == 3
		   nPeso:= 7
		elseIf nPeso == 7
		   nPeso:=9
		elseif nPeso == 9
		   nPeso:= 1
		elseif nPeso == 1
			nPeso:= 3
		Endif
 		//nPeso := iIf(nPeso > 9, 2, nPeso )
		nStr--
	endDo

	nResto := Mod(nSoma,11)	//-- Resto da Divisao
	
	if	nResto = 0
		nDV := 0
	elseIf nResto = 1
		nDv := 0
    elseIf nResto = 10
		nDv := 1
	else
		nDV := (11 - nResto)
	endIf
	
	
return( allTrim(Str(nDv)) )
