#include "protheus.ch"

User Function GYM004()

Private  cMd2valid := ""
Private aSize      := {}
Private aObjects   := {}
Private aPosObj    := {}
Private aInfo      := {}
Private nOp        := 3 

aSize := MsAdvSize()
AAdd( aObjects, { 70, 20,  .T., .T. })
AAdd( aObjects, { 100, 40, .T., .T. })
AAdd( aObjects, { 100, 40, .T., .T. })
AAdd( aObjects, { 100, 40, .T., .T. })

aInfo   := { aSize[1], aSize[2], aSize[3], aSize[4], aSize[5], 5, 5, 5, 5 }
aPosObj := MsObjSize( aInfo, aObjects, .T., .F.)

//+-----------------------------------------------+
//� Montando aHeader para a Getdados              �
//+-----------------------------------------------+
dbSelectArea("Sx3")
dbSetOrder(1)

dbSeek("ZZC")
nUsado  := 0
aHeader := {}

While !Eof() .And. (x3_arquivo == "ZZC")    
//    If (AllTrim(X3_CAMPO)=="ZZC_MATRIC") 
//        SX3->(dbSkip()) 
//        Loop
//    Endif
    If X3USO(x3_usado) .AND. cNivel >= x3_nivel 
        nUsado := nUsado+1
        If Findfunction("MD2VALID")
            cMd2valid := "ExecBlock('Md2valid',.f.,.f.)"
        Endif        
        AADD(aHeader , {TRIM(x3_titulo),x3_campo,x3_picture,x3_tamanho,x3_decimal,cMd2valid,x3_usado,x3_tipo, x3_arquivo, x3_context} ) 
    Endif 
    dbSkip()
EndDo 

//+-----------------------------------------------+
//� Montando aCols para a GetDados                �
//+-----------------------------------------------+
aCols := Array(1,nUsado+1)

dbSelectArea("SX3")
dbSeek("ZZC")

nUsado := 0

While !Eof() .And. (x3_arquivo == "ZZC")    
    IF X3USO(x3_usado) .AND. cNivel >= x3_nivel       
        nUsado := nUsado+1 
        IF nOp == 3 
            IF     x3_tipo == "C" 
                aCOLS[1][nUsado] := SPACE(x3_tamanho)                
            Elseif x3_tipo == "N"                    
                aCOLS[1][nUsado] := 0                
            Elseif x3_tipo == "D" 
                aCOLS[1][nUsado] := dDataBase                
            Elseif x3_tipo == "M" 
                aCOLS[1][nUsado] := ""                
            Else                    
                aCOLS[1][nUsado] := .F.                
            Endif 
        Endif        
    Endif   
    dbSkip()
EndDo 
aCOLS[1][nUsado+1] := .F.

//+----------------------------------------------+
//� Variaveis do Cabecalho do Modelo 2           �
//+----------------------------------------------+

//cCliente := Space(10)
//cLoja    := Space(2)
//dData    := Date()
 cMat   := Space(10)
 cAlu   := Space(40)
 dData  := Date()
//+----------------------------------------------+
//� Variaveis do Rodape do Modelo 2
//+----------------------------------------------+
nLinGetD := 0

//+----------------------------------------------+
//� Titulo da Janela                             �
//+----------------------------------------------+
cTitulo := "Avalia��o F�sica"

//+----------------------------------------------+
//� Array com descricao dos campos do Cabecalho  �
//+----------------------------------------------+
aC:={}
//#IFDEF WINDOWS 
    AADD(aC,{"cMat" ,{15,10} ,"Mat. do Cliente","@!",'ExecBlock(.F.,.F.)',"ZZA",})
    AADD(aC,{"cAlu"    ,{15,200},"Aluno","@!",,,})
    AADD(aC,{"dData"    ,{27,10} ,"Data de Emissao",,,,})
    //AADD(aC,{"cCliente" ,{15,10} ,"Cod. do Cliente","@!",'ExecBlock(.F.,.F.)',"SA1",}) 
    //AADD(aC,{"cLoja"    ,{15,200},"Loja","@!",,,}) 
    //AADD(aC,{"dData"    ,{27,10} ,"Data de Emissao",,,,})
//#ELSE 
//    AADD(aC,{"cCliente" ,{6,5} ,"Cod. do Cliente","@!",'ExecBlock("MD2VLCLI",.F.,.F.)',"SA1",}) 
//    AADD(aC,{"cLoja"    ,{6,40},"Loja","@!",,,}) 
//    AADD(aC,{"dData"    ,{7,5} ,"Data de Emissao",,,,})
//#ENDIF

//+-------------------------------------------------+
//� Array com descricao dos campos do Rodape        �
//+-------------------------------------------------+
aR := {}

#IFDEF WINDOWS 
    AADD(aR , {"nLinGetD" ,{120,10},"Linha na GetDados","@E 999",,,.F.})
#ELSE 
    AADD(aR , {"nLinGetD" ,{ 19,05},"Linha na GetDados","@E 999",,,.F.})
#ENDIF

//+------------------------------------------------+
//� Array com coordenadas da GetDados no modelo2   �
//+------------------------------------------------+
#IFDEF WINDOWS    
    aCGD := {44,5,118,315}
//  aCGD := {aSize[7],aSize[1],aSize[6],aSize[5]}
#ELSE    
    aCGD := {10,04,15,73}
#ENDIF


//+----------------------------------------------+
//� Validacoes na GetDados da Modelo 2           �
//+----------------------------------------------+
cLinhaOk := IIF(Findfunction("Md2LinOk"),"ExecBlock('Md2LinOk',.f.,.f.)",".T.")
cTudoOk  := IIF(Findfunction("Md2TudOk"),"ExecBlock('Md2TudOk',.f.,.f.)",".T.")


//+----------------------------------------------+
//� Chamada da Modelo2                           �
//+----------------------------------------------+
//lRet = .t. se confirmou
//lRet = .f. se cancelou

lRet   := Modelo2(cTitulo,aC,aR,aCGD,nOp  ,cLinhaOk,cTudoOk,,,,,,,.T.)
//lRet := Modelo2(cTitulo,aC,aR,aCGD,nOpcx,cLinhaOk,cTudoOk,,,,,aSize,,,.T.)
//lRet := Modelo2(cTitulo,aC,aR,aCGD,nOpcx,cLinhaOk,cTudoOk)

_nDatm  := aScan(aHeader , {|x| x[2]=="ZZC_DATMED"})
_nPeso  := aScan(aHeader , {|x| x[2]=="ZZC_PESO  "})
_nIMC   := aScan(aHeader , {|x| x[2]=="ZZC_IMC   "})
_nCOMOB := aScan(aHeader , {|x| x[2]=="ZZC_COMOB "})
_nBRAE  := aScan(aHeader , {|x| x[2]=="ZZC_BRACOE"})
_nBRAD  := aScan(aHeader , {|x| x[2]=="ZZC_BRACOD"})
_nOMBR  := aScan(aHeader , {|x| x[2]=="ZZC_OMBRO "})
_nPEIT  := aScan(aHeader , {|x| x[2]=="ZZC_PEITO "})
_nABDM  := aScan(aHeader , {|x| x[2]=="ZZC_ABDOM "})
_nCOXE  := aScan(aHeader , {|x| x[2]=="ZZC_COXAE "})
_nCOXD  := aScan(aHeader , {|x| x[2]=="ZZC_COXAD "})
_nPANE  := aScan(aHeader , {|x| x[2]=="ZZC_PANTUE"})
_nPAND  := aScan(aHeader , {|x| x[2]=="ZZC_PANTUD"})

If lRet // Gravacao. . .
    For _l := 1 To Len(aCols)
        If !aCols[_l,Len(aHeader)+1]
            dbSelectArea("ZZC")
            RecLock("ZZC",.T.)
            ZZC->ZZC_FILIAL  := xFilial("ZZC")
            ZZC->ZZC_MATRIC  := cMat 
			ZZC->ZZC_DATMED  := aCols[_l,_nDatm]
			ZZC->ZZC_PESO    := aCols[_l,_nPeso]
			ZZC->ZZC_IMC     := aCols[_l,_nIMC]
			ZZC->ZZC_COMOB   := aCols[_l,_nCOMOB]
			ZZC->ZZC_BRACOE  := aCols[_l,_nBRAE]
			ZZC->ZZC_BRACOD  := aCols[_l,_nBRAD]
			ZZC->ZZC_OMBRO   := aCols[_l,_nOMBR]
			ZZC->ZZC_PEITO   := aCols[_l,_nPEIT]
			ZZC->ZZC_ABDOM   := aCols[_l,_nABDM]
			ZZC->ZZC_COXAE   := aCols[_l,_nCOXE]
			ZZC->ZZC_COXAD   := aCols[_l,_nCOXD]
			ZZC->ZZC_PANTUE  := aCols[_l,_nPANE]
			ZZC->ZZC_PANTUD  := aCols[_l,_nPAND]
            MsUnLock()
        EndIf
    Next _l
Endif

Return
