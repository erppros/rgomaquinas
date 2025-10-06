#include 'totvs.ch'
 
/*/{Protheus.doc} FA040INC()
 
    A finalidade do ponto de entrada FA040INCé permitir validações de usuário
    na inclusão do Contas a Receber (FINA040), localizado no TudoOK da rotina.
 
    @return lRet - lógico, .T. valida a inclusão e continua o processo,
        caso contrário .F. e interrompe o processo.
/*/
 
User Function FA040INC()
Local lRet := .T.
 
     // Validações de usuário
If M->E1_CLIENTE ='000001' .And. M->E1_LOJA='01' .And. M->E1_VALOR > 5000
        // Mensagem de Help para esclarecer o motivo de interromper a inclusão
        Help( ,, 'ALERTA',, "Valor não liberado para este cliente", 1, 0 )
        lRet := .F.
 
 
        // Alterando lMsErroAuto para .T. (verdadeiro), devido aos casos de integrações ou ExecAuto
        lMsErroAuto := .T.
EndIf
 
Return lRet
