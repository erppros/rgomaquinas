#INCLUDE 'totvs.ch'
#INCLUDE 'restful.ch'

WSRESTFUL customProduct DESCRIPTION "Produtos"

	WSDATA CCODPRO	 As String
	WSDATA CCAMPOS	 As String

	WSMETHOD GET findProduct DESCRIPTION "Busca Produto" WSSYNTAX "/findProduct" PATH "/findProduct" PRODUCES APPLICATION_JSON
	WSMETHOD POST insertProduct DESCRIPTION "Grava Produto" WSSYNTAX "/insertProduct" PATH "/insertProduct" PRODUCES APPLICATION_JSON

END WSRESTFUL


WSMETHOD GET findProduct WSRECEIVE CCODPRO,CCAMPOS WSSERVICE customProduct

	Private lSuccess := .T.

	CCODPRO := UPPER(IIF(!Empty(Self:CCODPRO),Self:CCODPRO,""))
	CCAMPOS := UPPER(IIF(!Empty(Self:CCAMPOS),Self:CCAMPOS,""))
	self:SetContentType('application/json')

	if !empty(CCODPRO) .AND. !EMPTY(CCAMPOS)
		jResponse:=U_FB104PCP(CCODPRO,CCAMPOS, 1)
	elseIF !EMPTY(CCAMPOS)
		jResponse:=U_FB104PCP(CCODPRO,CCAMPOS, 2)
	ELSE
		jResponse:='{"FB104PCP":"Favor informar os campos a serem exibidos no parametro ccampos"}'
	endif

	iF !lSuccess
		::SetStatus(404)
	ELSE
		::SetStatus(200)
	ENDIF

	self:setresponse(jResponse)

Return .T.

WSMETHOD POST insertProduct WSSERVICE customProduct

	Local oJson, oResponse
	Local cError:= ""
	Private lSuccess := .T.

	oJson := JsonObject():New()
	cError  := oJson:fromJson( self:getContent() )

	Begin Transaction
		If Empty(cError)
			//Grava Estrutura
			oResponse:=U_FB106PCP(oJson)
		EndIf

		self:setresponse(oResponse)

		iF !lSuccess
			::SetStatus(400)
		ELSE
			::SetStatus(200)
		ENDIF

	END TRANSACTION



Return .T.
