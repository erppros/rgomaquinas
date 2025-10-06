#INCLUDE "protheus.ch"
#INCLUDE "totvs.ch"

User Function FA040FIN()

	if !SE1->E1_TIPO $ MVABATIM;
			.and. GETMV("MV_TPCOMIS") == "O" ;
			.and. !lDesdobr ;
			.And. FunName() <>  "FINA280";
			.And. !IsinCallStack("FINA280") ;
			.And. !IsInCallStack("FINA460") ;
			.And. !IsInCallStack("FINA630")
		IF SE1->E1_TIPO $ MVRECANT
			RecLock("SE3",.T.)
			SE3->E3_BASE    := SE1->E1_VALOR
			SE3->E3_COMIS   := (SE1->E1_COMIS1*SE1->E1_VALOR/100)
			SE3->E3_FILIAL  := xFilial()
			SE3->E3_VEND    := SE1->E1_VEND1
			SE3->E3_NUM     := SE1->E1_NUM
			SE3->E3_SERIE   := SE1->E1_SERIE
			SE3->E3_PORC    := SE1->E1_COMIS1
			SE3->E3_CODCLI  := SE1->E1_CLIENTE
			SE3->E3_LOJA    := SE1->E1_LOJA
			SE3->E3_EMISSAO := SE1->E1_EMISSAO
			SE3->E3_PREFIXO := SE1->E1_PREFIXO
			SE3->E3_PARCELA := SE1->E1_PARCELA
			SE3->E3_TIPO    := SE1->E1_TIPO
			SE3->E3_ORIGEM  := "E"
			SE3->E3_VENCTO  := SE1->E1_VENCTO
			MsUnlock()
		ENDIF
	ENDIF

Return
