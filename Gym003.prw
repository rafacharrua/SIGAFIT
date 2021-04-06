#INCLUDE "protheus.ch"

//+--------------------------------------------------------------------+
//| Rotina | MBRWMOD3| Autor |                      |Data | 01.01.2017 |
//+--------------------------------------------------------------------+
//| Descr. | EXEMPLO DE UTILIZACAO DA MODELO3().                      |
//+--------------------------------------------------------------------+
//| Uso    | CURSO DE ADVPL                                           |
//+--------------------------------------------------------------------+

User Function MbrwMod3()

Private cCadastro      := "Pedidos de Venda"
Private aRotina        := {}
Private cDelFunc       := ".T." // Validacao para a exclusao. Pode-se utilizar ExecBlock
Private cAlias         := "SC5"
Private nOpc   
Private nOpcE          := Nil
Private nOpcG          := Nil
     

AADD(aRotina,{ "Pesquisa"    ,"AxPesqui"      ,0,1})
AADD(aRotina,{ "Visualiza"   ,"U_Mod3All"     ,0,2})
AADD(aRotina,{ "Inclui"      ,"U_Mod3All"     ,0,3})
AADD(aRotina,{ "Altera"      ,"U_Mod3All"     ,0,4})
AADD(aRotina,{ "Exclui"      ,"U_Mod3All"     ,0,5})

Do Case	
    Case nOpc=="INCLUIR"; nOpcE:=3 ; nOpcG:=3	
    Case nOpc=="ALTERAR"; nOpcE:=3 ; nOpcG:=3	
    Case nOpc=="VISUALIZAR"; nOpcE:=2 ; nOpcG:=2
EndCase

dbSelectArea(cAlias)
dbSetOrder(1)
mBrowse(6,1,25,75,cAlias)

Return

////////////////////////////////////////
User Function Mod3All(cAlias,nReg,nOpcx)
////////////////////////////////////////
Local cTitulo    := "Cadastro de Pedidos de Venda"
Local cAliasE    := "Z01"
Local cAliasG    := "SC6"
Local cLinOk     := "AllwaysTrue()"
Local cTudOk     := "AllwaysTrue()"
Local cFieldOk   := "AllwaysTrue()"
Local aCposE     := {}
Local nUsado     := 0
Local cNivel     := 1 
Local nX         := 0

dbSelectArea("SX3")
dbSetOrder(1)
dbSeek("Z02")

aHeader:={}

While !Eof().And.(x3_arquivo=="Z02")

     If Alltrim(x3_campo)=="Z02_ITEM"
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

If nOpcx==3 // Incluir

     aCols:={Array(nUsado+1)}
     aCols[1,nUsado+1]:=.F.

     For nX:=1 to nUsado

          aCols[1,nX]:=CriaVar(aHeader[nX,2])

     Next

Else
     aCols:={}
     dbSelectArea("Z02")
     dbSetOrder(1)
     dbSeek(xFilial()+Z01->Z01_NUM)

     While !eof().and.Z02->Z02_NUM==Z01->Z01_NUM

          AADD(aCols,Array(nUsado+1))

          For nX:=1 to nUsado
               aCols[Len(aCols),nX]:=FieldGet(FieldPos(aHeader[nX,2]))

          Next 

          aCols[Len(aCols),nUsado+1]:=.F.
          dbSkip()
     End
Endif

If Len(aCols)>0
     /////////////////////////////////////////////////////////////////
     // Executa a Modelo 3                                           ?
     /////////////////////////////////////////////////////////////////

    M->Z01_CLIENTE := SPACE(6)
    M->Z01_LOJACLI := SPACE(6)
    M->Z01_TIPO    := SPACE(2)
    M->Z01_CONDPAG := SPACE(3)

     aCposE := {"Z01_CLIENTE","Z01_LOJACLI","Z01_TIPO","Z01_CONDPAG"}

     

     lRetMod3 := Modelo3(cTitulo, cAliasE, cAliasG,, cLinOk, cTudOk,nOpcE,nOpcG,cFieldOk)
     /////////////////////////////////////////////////////////////////
     // Executar processamento                                       /
     /////////////////////////////////////////////////////////////////
     If lRetMod3
          Aviso("Modelo3()","Confirmada operacao!",{"Ok"})
     Endif
Endif

Return 