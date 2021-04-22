#include "rwmake.ch"

User Function TreinoCad()  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CCADASTRO,AROTINA,")

/*/
SIGAFIT - Gestão de academias
Cadastro de treinos
Desenvolvido por Rafael Charrua
Data 21/04/2021
/*/

cCadastro := "Cadastro de treinos"

aRotina   := { { "Pesquisar"    ,"AxPesqui" , 0, 1},;
               { "Visualizar"   ,"U_TreinoVis", 0, 2},;
               { "Incluir"      ,"U_TreinoInc", 0, 3},;
               { "Alterar"      ,"U_TreinoAlt", 0, 4},;
               { "Excluir"      ,"U_TreinoExc", 0, 5} }


#IFNDEF WINDOWS
    ScreenDraw("SMT050", 3, 0, 0, 0)
    @3,1 Say cCadastro Color "B/W"
#ENDIF

dbSelectArea("ZZD")
dbSetOrder(1)

mBrowse( 6,1,22,75,"ZZD")

Return
