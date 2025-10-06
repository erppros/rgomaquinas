#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"

/*=================================================================================================
* Programa...: CLIFORSC5.PRW  
* Descricao..: Função para identificar no Browse o Cliente ou o Fornecedor
* Obs........: conforme o tipo do pedido de venda  
* Autor......: Rafael Gottardo 
* Data.......: Fev/2023
*--------------------------------------------------------------------------------------------------
*/

USER FUNCTION CLIFORSC5()

Local cAreaAnt := alias()
Local CSc5Nome    := ''
aAreaSA1       :=SA1->(Getarea())
aAreaSA2       :=SA2->(Getarea())


IF SC5->C5_TIPO $ 'B\D'
		   
	DBSELECTAREA("SA2")
	DBSETORDER(1)
	DBSEEK(XFILIAL("SA2")+SC5->C5_CLIENTE+SC5->C5_LOJACLI)

		cSc5Nome := UPPER(LEFT(SA2->A2_NOME,60))

Else

	DBSELECTAREA("SA1")
	DBSETORDER(1)
	DBSEEK(XFILIAL("SA1")+SC5->C5_CLIENTE+SC5->C5_LOJACLI)

		cSc5Nome := UPPER(LEFT(SA1->A1_NOME,60))

Endif


// Restaura o ambiente
Restarea(aAreaSA1)
Restarea(aAreaSA2)
dbSelectArea(cAreaAnt) 

Return (cSc5Nome)
