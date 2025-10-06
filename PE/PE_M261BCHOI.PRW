#INCLUDE 'PROTHEUS.CH'


USER FUNCTION M261BCHOI()

LOCAL aButtons := {{ 'PRODUTO',{||U_FB101EST()},OEMToAnsi('1º Nivel')}}

Return (aButtons)

