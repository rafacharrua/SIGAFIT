#include "Protheus.ch"


/**************************************************************************************************
BEGINDOC

Fun��o:
BILOJA820

Autor:
Tiago Bandeira Brasiliano

Data:
23/05/2008

Descri��o:
Rotina de Lista de Anivers�rio/Casamento

Par�metros:
Nenhum

Retorno:
Nenhum

ENDDOC
**************************************************************************************************/
User Function BILOJA821()
Private aRotina := MenuDef()

cCadastro := "Manutencao da Lista de Anivers�rio/Casamento"

//������������������������������������������������������������������������Ŀ
//�Endereca para a funcao MBrowse                                          �
//��������������������������������������������������������������������������
mBrowse(06,01,22,75,"SZ1")

Return


/**************************************************************************************************
BEGINDOC

Fun��o:
BI821Man

Autor:
Tiago Bandeira Brasiliano

Data:
25/05/2008

Descri��o:
Manuten��o do cadastro da Lista de Anivers�rio/Casamento

Par�metros:
cAlias		-	Alias do Arquivo
nReg		-	Numero do Registro
nOpc		-	Opcao do aRotina
	
Retorno:
Nenhum

ENDDOC
**************************************************************************************************/
User Function BI821Man(cAlias,nReg,nOpc,lConsulta)

Local aArea     := GetArea()
Local nSaveSx8  := GetSx8Len()
Local aPosObj   := {}
Local aObjects  := {}
Local aSize     := {}
Local aInfo     := {}
Local nUsado    := 0
Local nOpcA     := 0
Local nI        := 0
Local nX        := 0                      
Local cDescricao:= ""
Local cCadastro := "Manutencao da Lista de Anivers�rio/Casamento"
Local oDlg
Local oGetD

Private aHeader := {}
Private aCols   := {}
Private aTELA[0][0],aGETS[0]                             

DEFAULT INCLUI := .F.
	
//��������������������������������������������������������������Ŀ
//� Monta o Array aHeader.                                       �
//����������������������������������������������������������������
dbSelectArea("SX3")
SX3->(dbSetOrder(1))
SX3->(msSeek("SZ2"))
While !SX3->(Eof()) .And. SX3->X3_ARQUIVO == "SZ2"
	If X3USO(SX3->X3_USADO) .And. cNivel >= SX3->X3_NIVEL			
		Aadd(aHeader,{ AllTrim(SX3->X3_TITULO),;
		               SX3->X3_CAMPO,;
		               SX3->X3_PICTURE,;
		               SX3->X3_TAMANHO,;
		               SX3->X3_DECIMAL,;
		               SX3->X3_VALID,;
		               SX3->X3_USADO,;
		               SX3->X3_TIPO,;
		               SX3->X3_ARQUIVO,;
		               SX3->X3_CONTEXT,;
		               SX3->X3_NIVEL,;
		               SX3->X3_RELACAO,;
		               Trim(SX3->X3_INIBRW)})
		nUsado++
	Endif
	SX3->(dbSkip())
EndDo
	
//��������������������������������������������������������������Ŀ
//� Monta o Array aCols.                                         �
//����������������������������������������������������������������
If !INCLUI

	dbSelectArea("SZ2")
	SZ2->(dbSetOrder(1))
	SZ2->(dbSeek(xFilial("SZ2")+SZ1->Z1_COD))
		
	While !Eof() .And. SZ2->Z2_FILIAL+SZ2->Z2_COD == xFilial("SZ2")+SZ1->Z1_COD
		Aadd(aCols,Array(nUsado+1))

		For nX := 1 To nUsado
			If ( aHeader[nX,10] !=  "V" )
				aCOLS[Len(aCols)][nX] := SZ2->(FieldGet(FieldPos(aHeader[nX,2])))
			Else
				aCOLS[Len(aCols)][nX] := CriaVar(aHeader[nX,2],.T.)
			EndIf
		Next nX
		aCols[Len(aCols)][nUsado+1] := .F.			
		SZ2->(dbSkip())
	EndDo			
Endif		

If Empty(aCols)
	Aadd(aCols,Array(nUsado+1))
	For nX := 1 To nUsado
		If AllTrim(aHeader[nX,2]) == "Z2_ITEM"
			aCOLS[Len(aCols)][nX] := StrZero(1,Len(SZ2->Z2_ITEM))
		Else
			aCOLS[Len(aCols)][nX] := CriaVar(aHeader[nX,2],.T.)
		EndIf
	Next nX
	aCols[Len(aCols)][nUsado+1] := .F.
EndIf
dbSelectArea("SZ1")

//������������������������������������������������������������������������Ŀ
//�Inicializa as variaveis da Enchoice                                     �
//��������������������������������������������������������������������������
If INCLUI
	RegToMemory("SZ1",.T.,.F.)
ElseIf ALTERA .OR. nOpc == 5
	RegToMemory("SZ1",.F.,.F.)	
EndIf

//������������������������������������������������������Ŀ
//� Faz o calculo automatico de dimensoes de objetos     �
//��������������������������������������������������������
aSize := MsAdvSize()
AAdd( aObjects, { 100, 100, .T., .T. } )
AAdd( aObjects, { 200, 200, .T., .T. } )
aInfo 	:= { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 5, 5 }
aPosObj	:= MsObjSize( aInfo, aObjects,.T.)

DEFINE MSDIALOG oDlg TITLE cCadastro From aSize[7],0 To aSize[6],aSize[5] of oMainWnd PIXEL
EnChoice("SZ1", nReg, nOpc,,,,,aPosObj[1],,3)	
oGetD := MsGetDados():New(aPosObj[2,1],aPosObj[2,2],aPosObj[2,3],aPosObj[2,4],nOpc,,,"+Z2_ITEM",.T.,,1)		
ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{|| nOpcA := 1, If(oGetd:TudoOk(),oDlg:End(),nOpcA := 0)},{||oDlg:End()})

//��������������������������������������������������������������Ŀ
//�Rotina de Gravacao da Tabela de preco                         �
//����������������������������������������������������������������
If nOpcA == 1 .And. nOpc <> 2
	BI821Grv(nOpc)
	While (GetSx8Len() > nSaveSx8 )
		ConfirmSx8()
	EndDo		
Else
	If nOpc <> 2                   
		While (GetSx8Len() > nSaveSx8 )		
			RollBackSx8()	
		Enddo		
	Endif				
EndIf

//��������������������������������������������������������������Ŀ
//�Restaura a entrada da Rotina                                  �
//����������������������������������������������������������������
RestArea(aArea)
Return(nOpcA)


/**************************************************************************************************
BEGINDOC

Fun��o:
MenuDef

Autor:
Tiago Bandeira Brasiliano

Data:
25/05/2008

Descri��o:
Utilizacao de menu Funcional

Par�metros:
Parametros do array a Rotina:
1. Nome a aparecer no cabecalho
2. Nome da Rotina associada
3. Reservado
4. Tipo de Transa��o a ser efetuada:
		1 - Pesquisa e Posiciona em um Banco de Dados
    2 - Simplesmente Mostra os Campos
    3 - Inclui registros no Bancos de Dados
    4 - Altera o registro corrente
    5 - Remove o registro corrente do Banco de Dados
5. Nivel de acesso
6. Habilita Menu Funcional

Retorno:
Array com opcoes da rotina.

ENDDOC
**************************************************************************************************/
Static Function MenuDef()
     
Private aRotina := {{ "Pesquisar" ,"AxPesqui"		,0,1,0,.F.},;	//"Pesquisar"
					{ "Visualizar","U_BI821Man"		,0,2,0,NIL},;	//"Visualizar"
					{ "Incluir"   ,"U_BI821Man"		,0,3,0,NIL},;	//"Incluir"
					{ "Alterar"   ,"U_BI821Man"		,0,4,0,NIL},;	//"Alterar"
					{ "Excluir"   ,"U_BI821Man"		,0,5,0,NIL}}	//"Excluir"
					//{ OemToAnsi(STR0005),"U_BI821Man"		,0,5,0,NIL}}	//"Excluir"
					//{ OemtoAnsi(STR0015),"U_BI821Leg"		,0,2,0,.F.} }	//"Legenda"
Return aRotina 


/**************************************************************************************************
BEGINDOC

Fun��o:
BI821Grv

Autor:
Tiago Bandeira Brasiliano

Data:
25/05/2008

Descri��o:
Grava a lista de anivers�rio/casamento

Par�metros:
nOpc - Op��o

Retorno:
Nenhum

ENDDOC
**************************************************************************************************/
Static Function BI821Grv(nOpc)
Local aArea     := GetArea()
Local aRegistro := {}
Local cQuery    := ""
Local nCntFor   := 0
Local nCntFor2  := 0
Local nUsado    := Len(aHeader)
Local nPMEMO    := aScan(aHeader,{|x| AllTrim(x[2])=="Z1_OBSERV"})

Alert(Str(nOpc))
           
//+----------------------------------------------------------------+     
//| Guarda os registros em um array para atualizacao               |
//+----------------------------------------------------------------+
dbSelectArea("SZ2")
SZ2->(dbSetOrder(1))

dbSeek(xFilial("SZ2")+M->Z1_COD)
While ( !SZ2->(Eof()) .And. xFilial("SZ2") == SZ2->Z2_FILIAL .And. M->Z1_COD == SZ2->Z2_COD )
	aadd(aRegistro,SZ2->(RecNo()))
	SZ2->(dbSkip())
EndDo

Do Case
//+----------------------------------------------------------------+     
//|  Inclusao / Alteracao                                          |
//+----------------------------------------------------------------+
Case nOpc == 3 .OR. nOpc == 4
	//+----------------------------------------------------------------+     
	//| Atualizacao do cabecalho                                       |
	//+----------------------------------------------------------------+
	dbSelectArea("SZ1")
	SZ1->(dbSetOrder(1))
	If SZ1->(dbSeek(xFilial("SZ1")+M->Z1_COD))
		RecLock("SZ1",.F.)
	Else 
		RecLock("SZ1",.T.)
	EndIf
		
	For nCntFor := 1 To SZ1->(FCount())
		If ( FieldName(nCntFor)!="Z1_FILIAL" )
			FieldPut(nCntFor,M->&(FieldName(nCntFor)))
		Else
			SZ1->Z1_FILIAL := xFilial("SZ1")
		EndIf
	Next nCntFor
	//+--------------------------------+     
	//| Grava o campo Memo             |
	//+--------------------------------+
	If Empty(SZ1->Z1_CODOBS)	// Inclusao	
		MSMM(,TamSx3("Z1_OBSERV")[1],,M->Z1_OBSERV,1,,,"SZ1","Z1_CODOBS")
	Else						// Alteracao
		MSMM(SZ1->Z1_CODOBS,TamSx3("Z1_OBSERV")[1],,M->Z1_OBSERV,1,,,"SZ1","Z1_CODOBS")
	Endif	
	SZ1->(MsUnLock())
    
	//+----------------------------------------------------------------+     
	//| Atualizacao dos itens                                          |
	//+----------------------------------------------------------------+
	For nCntFor := 1 To Len(aCols)
		If ( nCntFor > Len(aRegistro) )
			If ( !aCols[nCntFor][nUsado+1] )
				RecLock("SZ2",.T.)
			EndIf
		Else
			SZ2->(dbGoto(aRegistro[nCntFor]))
			RecLock("SZ2",.F.)
		EndIf
		If ( !aCols[nCntFor][nUsado+1] )
			For nCntFor2 := 1 To nUsado
				If ( aHeader[nCntFor2][10] != "V" ) 
					FieldPut(FieldPos(aHeader[nCntFor2][2]),aCols[nCntFor][nCntFor2])
				EndIf 
			Next nCntFor2
			//+----------------------------------------------------------------+     
			//| Grava os campos obrigatorios                                   |
			//+----------------------------------------------------------------+
			SZ2->Z2_FILIAL := xFilial("SZ2")
			SZ2->Z2_COD := M->Z1_COD			
		Else    
			If ( nCntFor <= Len(aRegistro) )
				SZ2->(dbDelete())				
	 		EndIf
		EndIf
		SZ2->(MsUnLock())
	Next nCntFor
//+----------------------------------------------------------------+     
//| Exclusao                                                       |
//+----------------------------------------------------------------+
OtherWise
	If SZ1->(dbSeek(xFilial("SZ1")+M->Z1_COD))		
		RecLock("SZ1",.F.) 
		SZ1->(dbDelete())
		MSMM(SZ1->Z1_CODOBS,,,,2)
		SZ1->(MsUnLock())		
	EndIf	 

	For nCntFor := 1 To Len(aRegistro)
		SZ2->(dbGoto(aRegistro[nCntFor]))
		RecLock("SZ2",.F.) 
		SZ2->(dbDelete())
		SZ2->(MsUnLock())		
	Next nCntFor           
EndCase

//+----------------------------------------------------------------+     
//|   Restaura integridade da rotina                               |
//+----------------------------------------------------------------+
RestArea(aArea)
Return( .T. )