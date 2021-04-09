#include "rwmake.ch"   

User Function Rdmod3()        

//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³

SetPrvt("AROTINA,COPCAO,NOPCE,NOPCG,NUSADO,AHEADER")
SetPrvt("ACOLS,_NI,CTITULO,CALIASENCHOICE,CALIASGETD,CLINOK")
SetPrvt("CTUDOK,CFIELDOK,ACPOENCHOICE,_LRET,")

aRotina := {{ "Pesquisa", "AxPesqui", 0 , 1},;
            { "Visual"  , "AxVisual", 0 , 2},;
            { "Inclui"  , "AxInclui", 0 , 3},;
            { "Altera"  , "AxAltera", 0 , 4, 20 },;
        	{ "Exclui"  , "AxDeleta", 0 , 5, 21 }}

// --> Opcoes de acesso para a Modelo3
cOpcao := "VISUALIZAR"
Do Case
     Case cOpcao=="INCLUIR"; nOpcE:=3 ; nOpcG:=3
     Case cOpcao=="ALTERAR"; nOpcE:=3 ; nOpcG:=3
     Case cOpcao=="VISUALIZAR"; nOpcE:=2 ; nOpcG:=2
EndCase

//³ Cria variaveis M->????? da Enchoice

RegToMemory("SC5",(cOpcao=="INCLUIR"))

//³ Cria aHeader e aCols da GetDados 
nUsado:=0
dbSelectArea("SX3")
dbSeek("SC6")
aHeader:={}
While !Eof().And.(x3_arquivo=="SC6")
     If Alltrim(x3_campo)=="C6_ITEM"
          dbSkip()
          Loop
     Endif
     If X3USO(x3_usado).And.cNivel>=x3_nivel
        nUsado:=nUsado+1
        Aadd(aHeader,{ TRIM(x3_titulo), x3_campo, x3_picture,;
             x3_tamanho, x3_decimal,"AllwaysTrue()",;
              x3_usado, x3_tipo, x3_arquivo, x3_context } )
     Endif
    dbSkip()
End

If cOpcao=="INCLUIR"
     aCols:={Array(nUsado+1)}
     aCols[1,nUsado+1]:=.F.
     For _ni:=1 to nUsado
          aCols[1,_ni]:=CriaVar(aHeader[_ni,2])
     Next
Else
     aCols:={}
     dbSelectArea("SC6")
     dbSetOrder(1)
     dbSeek(xFilial()+M->C5_NUM)
     While !eof().and.C6_NUM==M->C5_NUM
          AADD(aCols,Array(nUsado+1))
          For _ni:=1 to nUsado
               aCols[Len(aCols),_ni]:=FieldGet(FieldPos(aHeader[_ni,2]))
          Next 
          aCols[Len(aCols),nUsado+1]:=.F.
          dbSkip()
     End
Endif
If Len(aCols)>0
     //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
     //³ Executa a Modelo 3                                           ³
     //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
     cTitulo        := "Teste de Modelo3()"
     cAliasEnchoice := "SC5"
     cAliasGetD		:= "SC6"
     cLinOk			:= "AllwaysTrue()"
     cTudOk			:= "AllwaysTrue()"
     cFieldOk		:= "AllwaysTrue()"
     aCpoEnchoice	:= {"C5_CLIENTE"}

     _lRet := Modelo3(cTitulo,cAliasEnchoice,cAliasGetD,aCpoEnchoice,cLinOk,cTudOk,nOpcE,nOpcG,cFieldOk)

     //³ Executar processamento          
     If _lRet
          Aviso("Modelo3()","Confirmada operacao!",{"Ok"})
     Endif
Endif

Return
