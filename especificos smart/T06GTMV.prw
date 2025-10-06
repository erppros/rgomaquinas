#Include "TOTVS.ch"

User Function T06GTMV()
    Local oModel  := FwModelActive()
    Local cCodMun := IIf(!Empty(M->A2_EST), Posicione("CC2", 2, XFilial("CC2") + Upper(NoAcento(FwFldGet("A2_MUN"))), "CC2_CODMUN"), "")

    If (Empty(M->A2_EST) == .T.)
        Help(NIL, NIL, "ERRO", NIL, "Ausência de Preenchimento",;
        1, 0, NIL, NIL, NIL, NIL, NIL, {"Preencha o campo Estado (A2_EST)"})
    Else
        oModel:GetModel("SA2MASTER"):LoadValue("A2_COD_MUN", cCodMun)
    EndIf
Return (NIL)
