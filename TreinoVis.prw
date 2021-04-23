#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 09/06/00

User Function TreinoVis()        // incluido pelo assistente de conversao do AP5 IDE em 09/06/00
Local _ni := 0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
//?Declaracao de variaveis utilizadas no programa atraves da funcao    ?
//?SetPrvt, que criara somente as variaveis definidas pelo usuario,    ?
//?identificando as variaveis publicas do sistema utilizadas no codigo ?
//?Incluido pelo assistente de conversao do AP5 IDE                    ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?

SetPrvt("COPCAO,NOPCE,NOPCG,NUSADO,AHEADER,ACOLS")
SetPrvt("N,_NI,CCPO,_NPOSITEM,CTITULO,CALIASENCHOICE")
SetPrvt("CALIASGETD,CLINOK,CTUDOK,CFIELDOK,ACPOENCHOICE,_LRET")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
±± ÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±?rograma  ?FASBVIS  ?Autor ?Luiz Carlos Vieira ?Data ?on  28/09/98º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±?escri‡„o ?Programa de Visualizacao do plano de contas FASB           º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±?so       ?Espec?ico para ESPN Brasil. Usado por CADFASB.PRX         º±?
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß?
/*/

dbSelectArea("ZZD")
If EOF() .And. BOF()
    Help("",1,"ARQVAZIO")
    Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//?Opcoes de acesso para a Modelo 3                             ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cOpcao := "VISUALIZAR"


Do Case
    Case cOpcao == "INCLUIR"    ; nOpcE := 3 ; nOpcG := 3
    Case cOpcao == "ALTERAR"    ; nOpcE := 3 ; nOpcG := 3
    Case cOpcao == "VISUALIZAR" ; nOpcE := 2 ; nOpcG := 2
EndCase

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//?Cria variaveis M->????? da Enchoice                          ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RegToMemory("ZZD",(cOpcao == "INCLUIR"))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//?Cria aHeader e aCols da GetDados                             ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nUsado  := 0
dbSelectArea("SX3")
dbSeek("ZZE")
aHeader := {}
While !Eof().And.(x3_arquivo=="ZZE")
    If Upper(AllTrim(X3_CAMPO)) == "ZZE_CODI"
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
    n     := 1
	For _ni:=1 to nUsado
		aCols[1,_ni]:=CriaVar(aHeader[_ni,2])
	Next
Else
	aCols:={}
    dbSelectArea("ZZE")
	dbSetOrder(2)
    dbSeek(xFilial("ZZE")+ZZD->ZZD_MAT)
    While !eof() //.and. xFilial() == ZZE->ZZE_FILIAL 

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

If Len(aCols)>0
    _nPosItem := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZZE_CODI"})
    AADD(aCols,Array(nUsado+1))
    n := 1
    For _ni:=1 to nUsado
        aCols[1,_ni] := CriaVar(aHeader[_ni,2])
    Next _ni
    aCols[1,_nPosItem] := "01"
    aCols[1,nUsado+1]  := .T. // Define como deletado
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//?Executa a Modelo 3                                           ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cTitulo        := "Cadastro de treinos - Visualizar"
cAliasEnchoice := "ZZD"
cAliasGetD     := "ZZE"
cLinOk         := "AllwaysTrue()"
cTudOk         := "AllwaysTrue()"
cFieldOk       := "AllwaysTrue()"
aCpoEnchoice   := {"ZZD_MAT"}

_lRet := Modelo3(cTitulo,cAliasEnchoice,cAliasGetD,aCpoEnchoice,cLinOk,cTudOk,nOpcE,nOpcG,cFieldOk)


Return
