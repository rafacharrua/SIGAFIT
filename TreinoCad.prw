#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 09/06/00

User Function TreinoCad()        // incluido pelo assistente de conversao do AP5 IDE em 09/06/00

//���������������������������������������������������������������������Ŀ
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//�����������������������������������������������������������������������

SetPrvt("CCADASTRO,AROTINA,")

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CADFASB  � Autor � Luiz Carlos Vieira � Data �Mon  28/09/98���
�������������������������������������������������������������������������͹��
���Descri��o � Cadastro de contas FASB.                                   ���
�������������������������������������������������������������������������͹��
���Uso       � Espec�fico para ESPN Brasil.                               ���
�������������������������������������������������������������������������͹��
���Arquivos  � SZ1 -> Cabecalho de Contas FASB                            ���
���          � SZ2 -> Itens de contas FASB                                ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

cCadastro := "Cadastro de treinos"

aRotina   := { { "Pesquisar"    ,"AxPesqui" , 0, 1},;
               { "Visualizar"   ,'ExecBlock("FASBVIS",.F.,.F.)' , 0, 2},;
               { "Incluir"      ,"U_TreinoInc", 0, 3},;
               { "Alterar"      ,'ExecBlock("FASBALT",.F.,.F.)' , 0, 4},;
               { "Excluir"      ,'ExecBlock("FASBEXC",.F.,.F.)' , 0, 5} }

//���������������������������������������������������������������������Ŀ
//� No caso do ambiente DOS, desenha a tela padrao de fundo             �
//�����������������������������������������������������������������������

#IFNDEF WINDOWS
    ScreenDraw("SMT050", 3, 0, 0, 0)
    @3,1 Say cCadastro Color "B/W"
#ENDIF

dbSelectArea("ZZD")
dbSetOrder(1)

mBrowse( 6,1,22,75,"ZZD")

Return
