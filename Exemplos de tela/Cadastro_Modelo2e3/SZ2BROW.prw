/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � SZ2BROW  � Autor �Walter Caetano da Silva� Data � 30/08/00 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Exemplo da fun��o Modelo2                                  ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function SZ2BROW

#IFNDEF WINDOWS
	ScreenDraw("SMT050", 3, 0, 0, 0)
#ENDIF

cCadastro := "Exemplo da Funcao Modelo2"

aRotina   := {	{ "Pesquisar"    ,"AxPesqui" , 0, 1},;
                { "Visualizar"   ,"U_SZ2VIS" , 0, 2},;
                { "Incluir"      ,"U_SZ2INC" , 0, 3},;
                { "Alterar"      ,"U_SZ2ALT" , 0, 4},;
                { "Excluir"      ,"U_SZ2EXC" , 0, 5} }

dbSelectArea("SZ2")
mBrowse( 6, 1,22,75,"SZ2")

Return