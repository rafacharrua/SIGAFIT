#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 09/06/00

User Function TreinoExc()        // incluido pelo assistente de conversao do AP5 IDE em 09/06/00

//���������������������������������������������������������������������Ŀ
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//�����������������������������������������������������������������������

SetPrvt("COPCAO,NOPCE,NOPCG,NUSADO,AHEADER,ACOLS")
SetPrvt("_NI,CCPO,_NPOSCTA,_NPOSDES,_NPOSDEL,_NPOSITEM")
SetPrvt("N,CTITULO,CALIASENCHOICE,CALIASGETD,CLINOK,CTUDOK")
SetPrvt("CFIELDOK,ACPOENCHOICE,_LRET,_NIT,")

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � FASBEXC  � Autor � Luiz Carlos Vieira � Data �Mon  28/09/98���
�������������������������������������������������������������������������͹��
���Descri��o � Programa de Visualizacao do plano de contas FASB           ���
�������������������������������������������������������������������������͹��
���Uso       � Espec�fico para ESPN Brasil. Usado por CADFASB.PRX         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

dbSelectArea("SZ1")
If BOF() .And. EOF()
    Help("",1,"ARQVAZIO")
    Return
Endif

//��������������������������������������������������������������Ŀ
//� Opcoes de acesso para a Modelo 3                             �
//����������������������������������������������������������������

cOpcao := "VISUALIZAR"


Do Case
    Case cOpcao == "INCLUIR"    ; nOpcE := 3 ; nOpcG := 3
    Case cOpcao == "ALTERAR"    ; nOpcE := 3 ; nOpcG := 3
    Case cOpcao == "VISUALIZAR" ; nOpcE := 2 ; nOpcG := 2
EndCase

//��������������������������������������������������������������Ŀ
//� Cria variaveis M->????? da Enchoice                          �
//����������������������������������������������������������������
RegToMemory("SZ1",(cOpcao == "INCLUIR"))

//��������������������������������������������������������������Ŀ
//� Cria aHeader e aCols da GetDados                             �
//����������������������������������������������������������������

nUsado  := 0
dbSelectArea("SX3")
dbSeek("SZ2")
aHeader := {}
While !Eof().And.(x3_arquivo=="SZ2")
    If Upper(AllTrim(X3_CAMPO)) == "Z2_CODIGO"
        dbSkip()
        Loop
    Endif
    If X3USO(x3_usado) .And. cNivel >= x3_nivel
    	nUsado:=nUsado+1
        Aadd(aHeader,{ TRIM(x3_titulo), x3_campo, x3_picture,;
             x3_tamanho, x3_decimal,X3_VALID,;
    	     x3_usado, x3_tipo, x3_arquivo, x3_context } )
	Endif
    dbSkip()
End

If cOpcao == "INCLUIR"
    aCols := {Array(nUsado+1)}
	aCols[1,nUsado+1]:=.F.
	For _ni:=1 to nUsado
		aCols[1,_ni]:=CriaVar(aHeader[_ni,2])
	Next
Else
	aCols:={}
    dbSelectArea("SZ2")
	dbSetOrder(1)
    dbSeek(xFilial()+M->Z1_CODIGO)
    While !eof() .and. xFilial() == SZ2->Z2_FILIAL .And. ;
          SZ2->Z2_CODIGO == M->Z1_CODIGO

		AADD(aCols,Array(nUsado+1))
		For _ni:=1 to nUsado
            If Upper(AllTrim(aHeader[_ni,10])) != "V" // Campo Real
                aCols[Len(aCols),_ni] := FieldGet(FieldPos(aHeader[_ni,2]))
            Else // Campo Virtual
                cCpo := AllTrim(Upper(aHeader[_nI,2]))
                Do Case
                Case cCpo == "Z2_ITEM"
                    aCols[Len(aCols),_ni] := StrZero(Len(aCols),2)
                Case cCpo == "Z2_DESC"
                    aCols[Len(aCols),_ni] := GetAdvFVal("SI1","I1_DESC",xFilial("SI1")+SZ2->Z2_CONTA,1,"DESCRICAO NAO ENCONTRADA!!")
                Case cCpo == "Z2_DC"
                    aCols[Len(aCols),_ni] := GetAdvFVal("SI1","I1_NORMAL",xFilial("SI1")+SZ2->Z2_CONTA,1,"X")
                OtherWise
                    aCols[Len(aCols),_ni] := CriaVar(aHeader[_ni,2])
                EndCase
            Endif
		Next 
		aCols[Len(aCols),nUsado+1]:=.F.
		dbSkip()

	End
Endif

//���������������������������������������������������������������������Ŀ
//� Variaveis de posicionamento no aCols                                �
//�����������������������������������������������������������������������

_nPosCta  := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="Z2_CONTA" })
_nPosDes  := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="Z2_DESC" })
_nPosDel  := Len(aHeader) + 1
_nPosItem := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="Z2_ITEM"})

If Len(aCols)<=0
    AADD(aCols,Array(nUsado+1))
    n := 1
    For _ni:=1 to nUsado
        aCols[1,_ni] := CriaVar(aHeader[_ni,2])
    Next _ni
    aCols[1,_nPosItem] := "01"
    aCols[1,nUsado+1]  := .T. // Define como deletado
Endif

//��������������������������������������������������������������Ŀ
//� Executa a Modelo 3                                           �
//����������������������������������������������������������������
cTitulo        := "Plano de Contas FASB - Excluir"
cAliasEnchoice := "SZ1"
cAliasGetD     := "SZ2"
cLinOk         := "AllwaysTrue()"
cTudOk         := "AllwaysTrue()"
cFieldOk       := "AllwaysTrue()"
aCpoEnchoice   := {"Z1_CODIGO"}

_lRet := Modelo3(cTitulo,cAliasEnchoice,cAliasGetD,aCpoEnchoice,cLinOk,cTudOk,nOpcE,nOpcG,cFieldOk)

If _lRet
    //���������������������������������������������������������������������Ŀ
    //� Exclui os itens                                                     �
    //�����������������������������������������������������������������������
    For _nIt := 1 To Len(aCols)
        dbSelectArea("SZ2")
        dbSetOrder(1)
        If dbSeek(xFilial()+M->Z1_CODIGO+aCols[_nIt,_nPosCta])
            RecLock("SZ2",.F.)
            dbDelete()
            MsUnLock()
            dbSelectArea("SX2")
            dbSeek("SZ2")
            RecLock("SX2",.F.)
            SX2->X2_DELET := SX2->X2_DELET + 1
            MsUnLock()
        Endif
    Next _nIt

    //���������������������������������������������������������������������Ŀ
    //� Exclui o cabecalho                                                  �
    //�����������������������������������������������������������������������

    dbSelectArea("SZ1")
    dbSetOrder(1)
    If dbSeek(xFilial()+M->Z1_CODIGO)
        RecLock("SZ1",.F.)
        dbDelete()
        MsUnLock()
        dbSelectArea("SX2")
        dbSeek("SZ1")
        RecLock("SX2",.F.)
        SX2->X2_DELET := SX2->X2_DELET + 1
        MsUnLock()
    Endif

Endif

Return