#Include "TOTVS.ch"

User Function T05GTMV()
    Local oModel  := FwModelActive()
    Local cCodMun := IIf(!Empty(M->A1_EST), Posicione("CC2", 2, XFilial("CC2") + Upper(NoAcento(FwFldGet("A1_MUN"))), "CC2_CODMUN"), "")

    If (Empty(M->A1_EST) == .T.)
        Help(NIL, NIL, "ERRO", NIL, "Ausência de Preenchimento",;
        1, 0, NIL, NIL, NIL, NIL, NIL, {"Preencha o campo Estado (A1_EST)"})
    Else
        oModel:GetModel("SA1MASTER"):LoadValue("A1_COD_MUN", cCodMun)
    EndIf
Return (NIL)
