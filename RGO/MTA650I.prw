#include "rwmake.ch"
#include "topconn.ch"


//---------------------------------------------------------------------
/*/{Protheus.doc} MTA650I

PE inclusão de OP

/*/
//---------------------------------------------------------------------

User Function MTA650I()

	
	Local aSC2 := SC2->(GetArea())
	Local aSC5 := SC5->(GetArea())
	Local aSC6 := SC6->(GetArea())
    Local cOBS    := ''
    Local cPEDIDO := ''
    Local cITEMPV := ''
    Local cZCLIENT := ''
    Local cZLOJCLI := ''
    Local cItemCTA := ''
    
	If SC2->C2_SEQUEN <> "001"
        DbSelectArea("SC2")
        DbSetOrder(1)
        if DbSeek(xFilial("SC2")+SC2->C2_NUM+SC2->C2_ITEM+'001')

            cOBS    := SC2->C2_OBS
            cPEDIDO := SC2->C2_PEDIDO
            cITEMPV := SC2->C2_ITEMPV
            cZCLIENT := SC2->C2_ZCLIENT
            cZLOJCLI := SC2->C2_ZLOJCLI
            cItemCTA := SC2->C2_ITEMCTA
        Endif

        //Volta para o registro da Op filha
        RestArea(aSC2)

        Reclock("SC2", .F.)
        
            SC2->C2_OBS := cOBS 
            SC2->C2_PEDIDO := cPEDIDO 
            SC2->C2_ITEMPV := cITEMPV 
            SC2->C2_ZCLIENT := cZCLIENT 
            SC2->C2_ZLOJCLI := cZLOJCLI 
            If Empty(SC2->C2_ZDESC)
                SC2->C2_ZDESC := FBuscacpo("SB1",1,xFilial("SB1")+SC2->C2_PRODUTO,"B1_DESC")
            Endif
        SC2->(msunlock())
	else
               
	EndIf

	RestArea(aSC2)
	RestArea(aSC5)
	RestArea(aSC6)

Return
