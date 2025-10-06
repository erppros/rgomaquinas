#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"

/*=================================================================================================
* Programa...: CLIFORSF1.PRW  
* Descricao..: Função para identificar no Browse o Cliente ou o Fornecedor
* Obs........: conforme o tipo da Nota de Entrada  
* Autor......: Rafael Gottardo 
* Data.......: Fev/2023
*--------------------------------------------------------------------------------------------------
*/

USER FUNCTION CLIFORSF1()

Local cAreaAnt := alias()
Local CSf1Nome    := ''
aAreaSA1       :=SA1->(Getarea())
aAreaSA2       :=SA2->(Getarea())


IF SF1->F1_TIPO $ 'N\I\P\C'

   DBSELECTAREA("SA2")
   DBSETORDER(1)
   DBSEEK(XFILIAL("SA2")+SF1->F1_FORNECE+SF1->F1_LOJA)

				cSf1Nome := UPPER(LEFT(SA2->A2_NOME,60))

Else

	DBSELECTAREA("SA1")
	DBSETORDER(1)
	DBSEEK(XFILIAL("SA1")+SF1->F1_FORNECE+SF1->F1_LOJA)

				cSf1Nome := UPPER(LEFT(SA1->A1_NOME,60))

Endif


// Restaura o ambiente
Restarea(aAreaSA1)
Restarea(aAreaSA2)
dbSelectArea(cAreaAnt) 

Return (cSf1Nome)
