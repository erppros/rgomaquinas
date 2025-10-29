#INCLUDE "PROTHEUS.CH"
/*/{Protheus.doc} FB101COM
Gatilho para conta contábil
@type user function
@author Rogério Duarte
@since 11/11/2024
@version 1.0
@param cCodCLi, character, M->A1_COD+MA->A1_LOJA ou M->A2_COD+MA->A2_LOJA
@return cItCtb, character, conta contábil
@example
U_FB101COM(00000101)
@see (links_or_references)
/*/
User Function FB101COM(cCodCLi,nOperation, cRet)
	Local lRet := .T.
	Local cItCtb := ""
	// Vem da Rotina padrão - OU - Vem da API e passou pelo PE do Fornecedor
	if FWISINCALLSTACK("MATA020") .OR. FWISINCALLSTACK("U_CUSTOMERVENDOR")
		cItCtb:= "F"+cCodCLi
		lRet := fExecAuto(cItCtb,"SA2",nOperation)

	elseif FWISINCALLSTACK("U_CRMA980") .OR. FWISINCALLSTACK("MATA030")
		cItCtb:= "C"+cCodCLi
		lRet := fExecAuto(cItCtb,"SA1",nOperation)

	ENDIF

	if lRet
		cRet := cItCtb
	endif

Return lRet


Static Function fExecAuto(cItCtb,cTabela,nOperation)
	Local lRet := .T.
	Local cDesc01 := IIF(cTabela == "SA1","A1_NOME","A2_NOME")
	Local cNormal := IIF(cTabela == "SA1","1","2")
	Local cConta  := IIF(cTabela == "SA1","A1_ITEMCON","A2_ITEMCON")

	DBSELECTAREA("CTD")
	CTD->(DBSETORDER(1))
	IF !CTD->(MSSEEK(FWXFILIAL("CTD")+cItCtb)) .AND. nOperation == 3
		if 	RecLock('CTD', .T.)
				CTD->CTD_FILIAL := xFilial('CTD')
				CTD->CTD_ITEM := AllTrim(cItCtb)
				CTD->CTD_CLASSE := '2'
				CTD->CTD_NORMAL := iIf(cTabela == 'SA1', '2', '1')
				CTD->CTD_DESC01	:= ALLTRIM(M->&(cDesc01))
				CTD->CTD_BLOQ := '2'
				CTD->CTD_DTEXIS := CriaVar('CTD_DTEXIS')
				CTD->CTD_ACCLVL := CriaVar('CTD_ACCLVL')
				CTD->CTD_CLOBRG := CriaVar('CTD_CLOBRG')
			CTD->(MsUnlock())
		else
			lRet := .F.
			MsgAlert('Erro ao travar registro em CTD; processo abortado', 'Atenção')
		endif

	elseiF CTD->(MSSEEK(FWXFILIAL("CTD")+cItCtb)) .AND. nOperation == 5
		If	RecLock('CTD', .F.)
				CTD->(DbDelete())
			CTD->(MsUnlock())
		else
			lRet := .F.
			MsgAlert('Erro ao travar registro em CTD; processo abortado', 'Atenção')
		endif

	ENDIF

Return lRet
