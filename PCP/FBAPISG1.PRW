#INCLUDE 'totvs.ch'
#INCLUDE 'restful.ch'

WSRESTFUL customStructure DESCRIPTION "Estrutura de Produtos"

	WSDATA CCODPRO	 As String
	WSDATA CCAMPOS	 As String
	WSDATA COPTION   AS String

	//WSMETHOD GET findStrTree DESCRIPTION "Busca Estrutura (Árvore)" WSSYNTAX "/findStrTree" PATH "/findStrTree" PRODUCES APPLICATION_JSON
	WSMETHOD GET findStructure DESCRIPTION "Busca Estrutura" WSSYNTAX "/findStructure" PATH "/findStructure" PRODUCES APPLICATION_JSON
	WSMETHOD POST insertStructure DESCRIPTION "Grava Estrutura" WSSYNTAX "/insertStructure" PATH "/insertStructure" PRODUCES APPLICATION_JSON

END WSRESTFUL

//WSMETHOD GET findStrTree WSRECEIVE CCODPRO WSSERVICE customStructure

//  Local CCODPRO	:= ''
//Local jResponse := JsonObject():New()

//	CCODPRO := UPPER(IIF(!Empty(Self:CCODPRO),Self:CCODPRO,""))
//  self:SetContentType('application/json')

//if !empty(CCODPRO)
//  jResponse:=U_FB102PCP(CCODPRO, 1)
//endif

//CONOUT(jResponse:tojson())
//self:setresponse(jResponse:tojson())


//RETURN .T.

WSMETHOD GET findStructure WSRECEIVE CCODPRO,CCAMPOS,COPTION WSSERVICE customStructure

	Local nTipo:=0
	Private lSuccess := .T.


	CCODPRO := UPPER(IIF(!Empty(Self:CCODPRO),Self:CCODPRO,""))
	CCAMPOS := UPPER(IIF(!Empty(Self:CCAMPOS),Self:CCAMPOS,""))
	COPTION := UPPER(IIF(!Empty(Self:COPTION),Self:COPTION,""))

	nTipo := val(COPTION)

	self:SetContentType('application/json')

	if !empty(CCODPRO) .AND. !EMPTY(CCAMPOS)
		jResponse:=U_FB103PCP(CCODPRO,CCAMPOS, 1, nTipo)
	ELSE
		lSuccess :=.F.
		jResponse:='{"FB103PCP":"Favor informar o codigo do produto pai da estrutura ou os campos a serem exibidos no parametro ccampos"}'
	endif

	iF !lSuccess
		::SetStatus(404)
	ELSE
		::SetStatus(200)
	ENDIF

	self:setresponse(jResponse)


Return .T.

WSMETHOD POST insertStructure WSSERVICE customStructure

	Local oJson, oResponse
	Local cError:= ""

	Private lSuccess := .T.

	oJson := JsonObject():New()
	cError  := oJson:fromJson( self:getContent() )

	Begin Transaction
		If Empty(cError)
			//Grava Estrutura
			oResponse:=U_FB105PCP(oJson)
		EndIf

		self:setresponse(oResponse)

		iF !lSuccess
			::SetStatus(400)
		ELSE
			::SetStatus(200)
		ENDIF

	END TRANSACTION



Return .T.
