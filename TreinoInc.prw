#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 09/06/00
#include "Protheus.ch"

User Function TreinoInc()        // incluido pelo assistente de conversao do AP5 IDE em 09/06/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("COPCAO,NOPCE,NOPCG,NUSADO,AHEADER,ACOLS")
SetPrvt("_NI,_NPOSCTA,_NPOSDES,_NPOSITEM,_NPOSDEL,CTITULO")
SetPrvt("CALIASENCHOICE,CALIASGETD,CLINOK,CTUDOK,CFIELDOK,ACPOENCHOICE")
SetPrvt("_LRET,NNUMIT,NIT,")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ FASBINC  º Autor ³ Luiz Carlos Vieira º Data ³Mon  28/09/98º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Programa de Inclusao do plano de Contas FASB               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Espec¡fico para ESPN Brasil. Usado por CADFASB.PRX         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Opcoes de acesso para a Modelo 3                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cOpcao := "INCLUIR"


Do Case
    Case cOpcao == "INCLUIR"    ; nOpcE := 3 ; nOpcG := 3
    Case cOpcao == "ALTERAR"    ; nOpcE := 3 ; nOpcG := 3
    Case cOpcao == "VISUALIZAR" ; nOpcE := 2 ; nOpcG := 2
EndCase

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria variaveis M->????? da Enchoice                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RegToMemory("ZZD",(cOpcao == "INCLUIR"))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria aHeader e aCols da GetDados                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

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
        aCols[1,_ni] := If(AllTrim(Upper(aHeader[_ni,2]))=="Z2_ITEM",StrZero(_nI,2),CriaVar(aHeader[_ni,2]))
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

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis de posicionamento no aCols                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

_nPosCta  := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZZE_FILIAL" })
_nPosDes  := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZZE_TREINO" })
//_nPosItem := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="Z2_ITEM" })
_nPosDel  := Len(aHeader) + 1

If Len(aCols)>0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Executa a Modelo 3                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ GRAVA    º Autor ³ Luiz Carlos Vieira º Data ³Mon  28/09/98º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Executa a gravacao dos dados.                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Espec¡fico para ESPN Brasil.                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

// Substituido pelo assistente de conversao do AP5 IDE em 09/06/00 ==> Function Grava
Static Function Grava()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gravacao do Cabecalho - SZ1                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dbSelectArea("ZZD")
RecLock("ZZD",.T.)
ZZD->ZZD_FILIAL := xFilial()
ZZD->ZZD_MAT    := M->ZZD_MAT
ZZD->ZZD_NOME   := M->ZZD_NOME
ZZD->ZZD_OBJET  := M->ZZD_OBJET
MsUnLock()
ConfirmSx8()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gravacao dos itens - SZ2                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nNumIt := 1

For nIt := 1 To Len(aCols)
    If !aCols[nIt,_nPosDel]
        dbSelectArea("ZZD")
        dbSetOrder(1)
        RecLock("ZZD",.T.)
        ZZE->ZZE_FILIAL     := xFilial()
        ZZE->ZZE_COD        := M->ZZE_COD
        ZZE->ZZE_TREINO     := M->ZZE_TREINO
        ZZE->ZZE_MEMBRO     := M->ZZE_MEMBRO
        ZZE->ZZE_GRUPO      := M->ZZE_GRUPO
        ZZE->ZZE_EXEC       := M->ZZE_EXEC
        ZZE->ZZE_REPET      := M->ZZE_REPET
        ZZE->ZZE_INTESI     := M->ZZE_INTESI 
        nNumIt              := nNumIt + 1
        MsUnLock()
    Endif
Next nIt

dbSelectArea("ZZD")

Return
