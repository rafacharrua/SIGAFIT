#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 09/06/00
#include "Protheus.ch"

User Function TreinoInc()        // incluido pelo assistente de conversao do AP5 IDE em 09/06/00

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("COPCAO,NOPCE,NOPCG,NUSADO,AHEADER,ACOLS")
SetPrvt("_NI,_NPOSCTA,_NPOSDES,_NPOSITEM,_NPOSDEL,CTITULO")
SetPrvt("CALIASENCHOICE,CALIASGETD,CLINOK,CTUDOK,CFIELDOK,ACPOENCHOICE")
SetPrvt("_LRET,NNUMIT,NIT,")

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇�袴袴袴袴袴佶袴袴袴袴藁袴袴袴錮袴袴袴袴袴袴袴袴袴袴箇袴袴錮袴袴袴袴袴袴敲굇
굇튡rograma  � FASBINC  � Autor � Luiz Carlos Vieira � Data 쿘on  28/09/98볍�
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴袴袴묽�
굇튒escri뇙o � Programa de Inclusao do plano de Contas FASB               볍�
굇勁袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴묽�
굇튧so       � Espec죉ico para ESPN Brasil. Usado por CADFASB.PRX         볍�
굇훤袴袴袴袴賈袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴선�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Opcoes de acesso para a Modelo 3                             �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

cOpcao := "INCLUIR"


Do Case
    Case cOpcao == "INCLUIR"    ; nOpcE := 3 ; nOpcG := 3
    Case cOpcao == "ALTERAR"    ; nOpcE := 3 ; nOpcG := 3
    Case cOpcao == "VISUALIZAR" ; nOpcE := 2 ; nOpcG := 2
EndCase

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Cria variaveis M->????? da Enchoice                          �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
RegToMemory("ZZD",(cOpcao == "INCLUIR"))

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Cria aHeader e aCols da GetDados                             �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

nUsado  := 0
dbSelectArea("SX3")
dbSeek("ZZE")
aHeader := {}
While !Eof().And.(x3_arquivo=="ZZE")
    If Upper(AllTrim(X3_CAMPO)) == "ZZE_COD"
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
        aCols[1,_ni] := If(AllTrim(Upper(aHeader[_ni,2]))=="ZZE_CODI",StrZero(_nI,2),CriaVar(aHeader[_ni,2]))
	Next
Else
	aCols:={}
    dbSelectArea("ZZE")
	dbSetOrder(1)
    dbSeek(xFilial()+M->ZZD_MAT)
    While !eof() .and. xFilial() == ZZE->ZZE_FILIAL .And. ;
          ZZE->ZZE_COD == M->ZZD_MAT

		AADD(aCols,Array(nUsado+1))
		For _ni:=1 to nUsado
			aCols[Len(aCols),_ni]:=FieldGet(FieldPos(aHeader[_ni,2]))
		Next 
		aCols[Len(aCols),nUsado+1]:=.F.
		dbSkip()

	End
Endif

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Variaveis de posicionamento no aCols                                �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

_nPosCta  := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZZE_FILIAL" })
_nPosDes  := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZZE_TREINO" })
//_nPosItem := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="Z2_ITEM" })
_nPosDel  := Len(aHeader) + 1

If Len(aCols)>0
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Executa a Modelo 3                                           �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
    cTitulo        := "Cadastro de treinos"
    cAliasEnchoice := "ZZD"
    cAliasGetD     := "ZZE"
    //cLinOk         := 'ExecBlock("FASBVLD",.F.,.F.)'
    cLinOk         := 'AllwaysTrue()'
    cTudOk         := "AllwaysTrue()"
    cFieldOk       := "AllwaysTrue()"
    aCpoEnchoice   := {"ZZD_MAT"}

    While .T.
        _lRet := Modelo3(cTitulo,cAliasEnchoice,cAliasGetD,aCpoEnchoice,cLinOk,cTudOk,nOpcE,nOpcG,cFieldOk)

        If _lRet
            If Empty(M->ZZD_MAT) //.Or. Empty(M->Z1_DESC) .Or. Empty(M->Z1_CLASSE)
                Help("",1,"OBRIGAT")
                Loop
            Else
                Grava()
                Exit
            Endif
        Else
            Exit
        Endif
    EndDo

Endif

Return

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇�袴袴袴袴袴佶袴袴袴袴藁袴袴袴錮袴袴袴袴袴袴袴袴袴袴箇袴袴錮袴袴袴袴袴袴敲굇
굇튔un뇙o    � GRAVA    � Autor � Luiz Carlos Vieira � Data 쿘on  28/09/98볍�
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴袴袴묽�
굇튒escri뇙o � Executa a gravacao dos dados.                              볍�
굇勁袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴묽�
굇튧so       � Espec죉ico para ESPN Brasil.                               볍�
굇훤袴袴袴袴賈袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴선�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

// Substituido pelo assistente de conversao do AP5 IDE em 09/06/00 ==> Function Grava
Static Function Grava()

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Gravacao do Cabecalho - SZ1                                         �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

dbSelectArea("ZZD")
RecLock("ZZD",.T.)
ZZD->ZZD_FILIAL := xFilial()
ZZD->ZZD_MAT    := M->ZZD_MAT
ZZD->ZZD_NOME   := M->ZZD_NOME
ZZD->ZZD_OBJET  := M->ZZD_OBJET
MsUnLock()
ConfirmSx8()

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Gravacao dos itens - SZ2                                            �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

nNumIt := 1

For nIt := 1 To Len(aCols)
    If !aCols[nIt,_nPosDel]
        dbSelectArea("ZZE")
        dbSetOrder(1)
        RecLock("ZZE",.T.)
        ZZE->ZZE_FILIAL     := xFilial()
        ZZE->ZZE_CODI       := aCols[nIt,7]
        ZZE->ZZE_TREINO     := aCols[nIt,1]
        ZZE->ZZE_MEMBRO     := aCols[nIt,2]
        ZZE->ZZE_GRUPO      := aCols[nIt,3]
        ZZE->ZZE_EXEC       := aCols[nIt,4]
        ZZE->ZZE_REPET      := aCols[nIt,5]
        ZZE->ZZE_INTESI     := aCols[nIt,6]
        nNumIt              := nNumIt + 1
        MsUnLock()
    Endif
Next nIt

dbSelectArea("ZZD")

Return
