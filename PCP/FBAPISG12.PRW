#INCLUDE 'totvs.ch'
#INCLUDE 'restful.ch'

USER Function FBAPISG12()

    Local CCODPRO	:= ''
	Local jResponse := JsonObject():New()

	//CCODPRO := UPPER(IIF(!Empty(Self:CCODPRO),Self:CCODPRO,""))
    //self:SetContentType('application/json')

    if !empty(CCODPRO)
        jResponse:=U_FB102PCP(CCODPRO, 1)

    elseif !empty(CDESCPROD)
        jResponse:=U_FB102PCP(CCODPRO, 2)
    else
        jResponse:=U_FB102PCP("", 3)
    endif

    if jResponse <> Nil
        CONOUT(jResponse:tojson())
        self:setresponse(jResponse:tojson())
    else
        self:setresponse("Estrutura nao encontrada.")
    endif



RETURN .T.
