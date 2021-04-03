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
==========Função Cinclui - Inclusão==========
--------------------------------------------*/
user function DINCLUI(cAlias,nReg,nOpc)
    Local nOpcao := 0
    nOpcao := AxInclui(cAlias,nReg,nOpc)
        If nOpcao == 1
            Msginfo("Inclusão efetuada com sucesso!")
        Else
            MsgAlert("Inclusão Cancelada!")    
        EndIf 
return Nil
/*-------------------------------------------
==========Função CAltera - Alteração==========
--------------------------------------------*/
user function DALTERA(cAlias,nReg,nOpc)
    Local nOpcao := 0
    nOpcao := AxAltera(cAlias,nReg,nOpc)
        If nOpcao == 1
            Msginfo("Alteração efetuada com sucesso!")
        Else
            MsgAlert("Alteração Cancelada!")    
        EndIf 
return Nil
/*-------------------------------------------
==========Função CDeleta - Inclusão==========
--------------------------------------------*/
user function DDELETA(cAlias,nReg,nOpc)
    Local nOpcao := 0
    nOpcao := AxDeleta(cAlias,nReg,nOpc)
        If nOpcao == 1
            Msginfo("Exclusão efetuada com sucesso!")
        Else
            MsgAlert("Exclusão Cancelada!")    
        EndIf 
return Nil
/*-------------------------------------------
==========Função CLegenda - Legenda==========
--------------------------------------------*/
user function DLEGENDA()
    Local aLegenda := {}

    AADD(aLegenda,{"BR_VERDE"       ,   "Ativo"   })
    AADD(aLegenda,{"BR_VERMELHO"    ,   "Inativo" })

    BrwLegenda(cCadastro,"Legenda", aLegenda)

return
