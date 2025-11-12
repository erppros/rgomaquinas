
USER FUNCTION MT120ISC
    Local aArea := GetArea()
    Local nX := 0
    
    If nTipoPed != 2
        aCols[n][gdFieldPos("C7_ZFINALI")] := SC1->C1_ZFINALI
    Endif
    
    RestArea(aArea)
RETURN
