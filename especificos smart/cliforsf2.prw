#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"

/*=================================================================================================
* Programa...: CLIFORSF2.PRW  
* Descricao..: Função para identificar no Browse o Cliente ou o Fornecedor
* Obs........: conforme o tipo da Nota de Saida  
* Autor......: Rafael Gottardo 
* Data.......: Fev/2023
*--------------------------------------------------------------------------------------------------
*/

USER FUNCTION FORCLISF2()

Local cAreaAnt := alias()
Local cSf2Nome    := ''
aAreaSA1       :=SA1->(Getarea())
aAreaSA2       :=SA2->(Getarea())


IF SF2->F2_TIPO $ 'B\D'
		   
	DBSELECTAREA("SA2")
	DBSETORDER(1)
	DBSEEK(XFILIAL("SA2")+SF2->F2_CLIENTE+SF2->F2_LOJA)

		cSf2Nome := UPPER(LEFT(SA2->A2_NOME,60))

Else

	DBSELECTAREA("SA1")
	DBSETORDER(1)
	DBSEEK(XFILIAL("SA1")+SF2->F2_CLIENTE+SF2->F2_LOJA)

		cSf2Nome := UPPER(LEFT(SA1->A1_NOME,60))

Endif


// Restaura o ambiente
Restarea(aAreaSA1)
Restarea(aAreaSA2)
dbSelectArea(cAreaAnt) 

Return (cSf2Nome)
