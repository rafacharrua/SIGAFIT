#include 'protheus.ch'
#include 'parmtype.ch'

user function GYM001()
    Local cAlias        := "ZZA"
    Local aCores        := {}
    Local cFiltra       := "ZZA_FILIAL == '"+xFilial('ZZA')+"'"
    Private cCadastro   := "SIGAFIT - Matrícula de alunos"   
    Private aRotina     := {}
    Private aIndexZZA   := {}
    Private bFiltraBrw  := {||  FilBrowse(cAlias,@aIndexZZA,@cFiltra)}


    AADD(aRotina, {"Pesquisa"       ,   "AxPesqui"      ,0,1})
    AADD(aRotina, {"Visualizar"     ,   "AxVisual"      ,0,2})
    AADD(aRotina, {"Incluir"        ,   "U_CInclui"     ,0,3})
    AADD(aRotina, {"Alterar"        ,   "U_CAltera"     ,0,4})
    AADD(aRotina, {"Excluir"        ,   "U_CDeleta"     ,0,5})
    AADD(aRotina, {"Legenda"        ,   "U_CLegenda"    ,0,6})

    //Acores - Legenda

    AADD(aCores,{"ZZA_SITUA = '1'"     ,   "BR_VERDE"      })
    AADD(aCores,{"ZZA_SITUA = '2'"     ,   "BR_AMARELO"    })
    AADD(aCores,{"ZZA_SITUA = '3'"     ,   "BR_VERMELHO"   })

    dbSelectArea(cAlias)
    dbSetOrder(1)

    Eval(bFiltraBrw)

    dbGoTop()
    mBrowse(6,1,22,75,cAlias,,,,,,aCores)

    EndFilBrw(cAlias,aIndexZZA)

return
/*-------------------------------------------
==========Função Cinclui - Inclusão==========
--------------------------------------------*/
User Function CINCLUI(cAlias,nReg,nOpc)

    Local nOpcao := 0

    nOpcao := AxInclui(cAlias , nReg , nOpc , , , , "U_xValCli()")
    If nOpcao == 1
        Msginfo("Inclusão efetuada com sucesso!")    
    Else
        MsgAlert("Inclusão Cancelada!") 
    EndIf 
           
return Nil


User Function xValCli()

Local lRet := .T. 

    If Type("M->ZZA_CODCLI") <> "U" .And. !Empty(M->ZZA_CODCLI) 
        ZZA->(dbSetOrder(1))
        If ZZA->( dbSeek( xFilial("ZZA") + M->ZZA_CODCLI) )  
            While ZZA->(!Eof()) .And. ZZA->ZZA_CODCLI = M->ZZA_CODCLI
                If ZZA->ZZA_SITUA <> '3'
                    lRet := .F. 
                    MsgAlert("Cliente já possui contrato vigente ou congelado")
                EndIf
                ZZA->(dbSkip()) 
            EndDo
        EndIf    
    EndIf 

Return lRet 


/*-------------------------------------------
==========Função CAltera - Alteração==========
--------------------------------------------*/
user function CALTERA(cAlias,nReg,nOpc)
    Local nOpcao := 0
    nOpcao := AxAltera(cAlias,nReg,nOpc)
        If nOpcao == 1
            Msginfo("Alteração efetuada com sucesso!")
        Else
            MsgAlert("Alteração Cancelada!")    
        EndIf 
return Nil
/*-------------------------------------------
==========Função CDeleta - Exclusão==========
--------------------------------------------*/
user function CDELETA(cAlias,nReg,nOpc)
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
user function CLEGENDA()
    Local aLegenda := {}

    AADD(aLegenda,{"BR_VERDE"       ,   "Vigente"   })
    AADD(aLegenda,{"BR_AMARELO"     ,   "Congelado" })
    AADD(aLegenda,{"BR_VERMELHO"    ,   "Cancelado" })

    BrwLegenda(cCadastro,"Legenda", aLegenda)

return
