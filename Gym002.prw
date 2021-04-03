#include 'protheus.ch'
#include 'parmtype.ch'

user function GYM002()
    Local cAlias        := "ZZB"
    Local aCores        := {}
    Local cFiltra       := "ZZB_FILIAL == '"+xFilial('ZZB')+"' .And. ZZB_STATUS <> ''"
    Private cCadastro   := "SIGAFIT - Cadastro de planos"   
    Private aRotina     := {}
    Private aIndexZZB   := {}
    Private bFiltraBrw  := {||  FilBrowse(cAlias,@aIndexZZB,@cFiltra)}


    AADD(aRotina, {"Pesquisa"       ,   "AxPesqui"      ,0,1})
    AADD(aRotina, {"Visualizar"     ,   "AxVisual"      ,0,2})
    AADD(aRotina, {"Incluir"        ,   "U_DInclui"     ,0,3})
    AADD(aRotina, {"Alterar"        ,   "U_DAltera"     ,0,4})
    AADD(aRotina, {"Excluir"        ,   "U_DDeleta"     ,0,5})
    AADD(aRotina, {"Legenda"        ,   "U_DLegenda"    ,0,6})

    //Acores - Legenda

    AADD(aCores,{"Alltrim(ZZB_STATUS) == 'ATIVO'"       ,   "BR_VERDE"      })
    AADD(aCores,{"Alltrim(ZZB_STATUS) == 'INATIVO'"     ,   "BR_VERMELHO"   })

    dbSelectArea(cAlias)
    dbSetOrder(1)

    Eval(bFiltraBrw)

    dbGoTop()
    mBrowse(6,1,22,75,cAlias,,,,,,aCores)

    EndFilBrw(cAlias,aIndexZZB)

return
/*-------------------------------------------
==========Fun��o Cinclui - Inclus�o==========
--------------------------------------------*/
user function DINCLUI(cAlias,nReg,nOpc)
    Local nOpcao := 0
    nOpcao := AxInclui(cAlias,nReg,nOpc)
        If nOpcao == 1
            Msginfo("Inclus�o efetuada com sucesso!")
        Else
            MsgAlert("Inclus�o Cancelada!")    
        EndIf 
return Nil
/*-------------------------------------------
==========Fun��o CAltera - Altera��o==========
--------------------------------------------*/
user function DALTERA(cAlias,nReg,nOpc)
    Local nOpcao := 0
    nOpcao := AxAltera(cAlias,nReg,nOpc)
        If nOpcao == 1
            Msginfo("Altera��o efetuada com sucesso!")
        Else
            MsgAlert("Altera��o Cancelada!")    
        EndIf 
return Nil
/*-------------------------------------------
==========Fun��o CDeleta - Inclus�o==========
--------------------------------------------*/
user function DDELETA(cAlias,nReg,nOpc)
    Local nOpcao := 0
    nOpcao := AxDeleta(cAlias,nReg,nOpc)
        If nOpcao == 1
            Msginfo("Exclus�o efetuada com sucesso!")
        Else
            MsgAlert("Exclus�o Cancelada!")    
        EndIf 
return Nil
/*-------------------------------------------
==========Fun��o CLegenda - Legenda==========
--------------------------------------------*/
user function DLEGENDA()
    Local aLegenda := {}

    AADD(aLegenda,{"BR_VERDE"       ,   "Ativo"   })
    AADD(aLegenda,{"BR_VERMELHO"    ,   "Inativo" })

    BrwLegenda(cCadastro,"Legenda", aLegenda)

return
