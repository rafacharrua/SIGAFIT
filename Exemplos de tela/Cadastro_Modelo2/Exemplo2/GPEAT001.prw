#include "PROTHEUS.CH"
#INCLUDE "COLORS.CH"
#INCLUDE "TMKDEF.CH"
#Include "MsOle.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPEAT001  º Autor ³ Paulo Bindo        º Data ³  13/05/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Cadastro de Entidades X Contratos                          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP7 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function GPEAT001()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cCadastro := "Cadastro de Entidades X Contratos"
Private cEntida,cLoja
//GRAVA O NOME DA FUNCAO NO Z03(PARA MUDANCA DE NOMES E MENUS)
//Private cFuncao1 := substr(procname(3),at("'",procname(3))+1,10)
//cFuncao1 := StrTran(cFuncao1,"()","")
//U_COFRD001(cFuncao1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta um aRotina proprio                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cString := "Z01"

dbSelectArea("Z01")
dbSetOrder(1)

Private aRotina := { {"Pesquisar","AxPesqui",0,1} ,;
{"Visualizar","U_GPEAT1Vis",0,2},;
{"Incluir","U_GPEAT1Inc"   ,0,3} ,;
{"Alterar","U_GPEAT1Alt"   ,0,4} ,;
{"Excluir","U_GPEAT1Exc"   ,0,5},;
{"Imprimir","U_GPERL001"   ,0,0},;
{"Legenda","U_GPEATLEG1",0,0}}


aCores := {;
{'Z01_TAREFA == "S"', 'BR_AZUL'},;
{'(Z01_DTVENC - dDataBase)>30 ', 'ENABLE'},;
{'(Z01_DTVENC - dDataBase)>0 .And. (Z01_DTVENC - dDataBase)<=30 ' , 'BR_AMARELO'},;
{'(Z01_DTVENC - dDataBase)<=0' , 'DISABLE'}}

dbSelectArea("Z01")
mBrowse( 6,1,22,75,cString,,,,,,aCores)


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPEAT1Vis ºAutor  ³Paulo Bindo         º Data ³  13/05/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Visualisa os contratos da entidade                          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GPEAT1Vis(cAlias,nReg,nOpcX)
Private NUSADO,AHEADER,ACOLS,CCLIENTE,CLOJA
Private DDATA,NLINGETD,CTITULO,AC,AR,ACGD
Private CLINHAOK,CTUDOOK,LRETMOD2
Private nTotaNota := 0
aArea := GetArea()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Opcao de acesso para o Modelo 2                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// 3,4 Permitem alterar getdados e incluir linhas
// 6 So permite alterar getdados e nao incluir linhas
// Qualquer outro numero so visualiza
nOpcx:=2
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montando aHeader                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dbSelectArea("Sx3")
dbSetOrder(1)
dbSeek("Z01")
nUsado:=0
aHeader:={}
aGetSD := {}
While !Eof() .And. (x3_arquivo == "Z01")
	IF X3USO(x3_usado) .AND. cNivel >= x3_nivel .And. Trim(SX3->X3_CAMPO) <> "Z01_CODIGO" .And. ;
		Trim(SX3->X3_CAMPO) <> "Z01_CODCON" .And. Trim(SX3->X3_CAMPO) <> "Z01_NOMCON";
		.And. Trim(SX3->X3_CAMPO) <> "Z01_ENTIDA"
		nUsado++
		AADD(aHeader,{ TRIM(x3_titulo), x3_campo, x3_picture,;
		x3_tamanho, x3_decimal,x3_valid,;
		x3_usado, x3_tipo, x3_arquivo, x3_context } )
		Aadd( aGetSD, X3_CAMPO)
	Endif
	dbSkip()
End
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montando aCols                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCOLS := Array(1,Len(aHeader)+1)

For i:=1 to Len(aHeader)
	cCampo:=Alltrim(aHeader[i,2])
	If alltrim(aHeader[i,2])=="Z01_ITEM"
		aCOLS[1][i] := "01"
	Else
		aCols[1][i]   := CRIAVAR(alltrim(aHeader[i][2]))
	Endif
Next i

aCOLS[1][Len(aHeader)+1] := .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis do Cabecalho do Modelo 2                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cCodigo := Z01->Z01_CODIGO
cCodCon	:= Z01->Z01_CODCON
cNomCon := Z01->Z01_NOMCON
cEntida := Z01->Z01_ENTIDA
nCnt := 0

//CONTA O NUMERO DE REGISTROS PARA MONTAR A ACOLS
dbSelectArea("Z01")
dbSetOrder(4)
dbGotop()
If dbSeek(xFilial()+cCodigo)
	While !EOF() .And. Z01_CODIGO ==  cCodigo
		nCnt:=nCnt+1
		dbSkip()
	End
EndIf
aCols:=Array(nCnt,Len(aHeader)+1)

nCnt := 0

dbSelectArea("Z01")
dbSetOrder(4)
dbGotop()
If dbSeek(xFilial()+cCodigo)
	While !EOF() .And. Z01_CODIGO = cCodigo
		nCnt:=nCnt+1
		For nB:=1 To Len(aHeader)
			cVar      := AScan( aHeader, { |x| AllTrim( x[2] ) == AllTrim(aHeader[nB][2]) } )
			cCampo := AllTrim(aHeader[nB][2])
			aCols[nCnt, cVar] := &cCampo
		Next
		aCOLS[nCnt][Len(aHeader)+1] := .F.
		dbSelectArea("Z01")
		dbSkip()
	End
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis do Rodape do Modelo 2                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLinGetD:=0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com descricao dos campos do Cabecalho do Modelo 2      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aC:={}
// aC[n,1] = Nome da Variavel Ex.:"cCliente"
// aC[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aC[n,3] = Titulo do Campo
// aC[n,4] = Picture
// aC[n,5] = Validacao
// aC[n,6] = F3
// aC[n,7] = Se campo e' editavel .t. se nao .f.

AADD(aC,{"cCodCon  ",{15,010} ,"Contato        :"	,"@R 99999999",,,.F.})
AADD(aC,{"cNomCon "	,{30,010} ,"Nome            :"	,             ,,,.F.})
AADD(aC,{"cEntida "	,{30,250} ,"Entidade        :"	,             ,,,.F.})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com descricao dos campos do Rodape do Modelo 2         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aR:={}
// aR[n,1] = Nome da Variavel Ex.:"cCliente"
// aR[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aR[n,3] = Titulo do Campo
// aR[n,4] = Picture
// aR[n,5] = Validacao
// aR[n,6] = F3
// aR[n,7] = Se campo e' editavel .t. se nao .f.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com coordenadas da GetDados no modelo2                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCordW :={125,100,600,735}
aCGD:={45,5,228,310}
aGetEdit := {}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Validacoes na GetDados da Modelo 2                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cLinhaOk:="AlwaysTrue()"
cTudoOk:="AlwaysTrue()"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chamada da Modelo2                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// lRetMod2 = .t. se confirmou
// lRetMod2 = .f. se cancelou
lRetMod2:=U_Mde2(cCadastro,aC,aR,aCGD,nOpcx,cLinhaOk,cTudoOk,aGetSD,,"+Z01_ITEM",,aCordW,.F.)
// No Windows existe a funcao de apoio CallMOd2Obj() que retorna o
// objeto Getdados Corrente
dbSelectArea("Z01")
dbSetOrder(1)
RestArea(aArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPEAT1Inc ºAutor  ³Paulo Bindo         º Data ³  13/05/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Inclusao de contratos                                       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function GPEAT1Inc(cAlias,nReg,nOpcX)

Private NUSADO,AHEADER,ACOLS,CCLIENTE,CLOJA
Private DDATA,NLINGETD,CTITULO,AC,AR,ACGD
Private CLINHAOK,CTUDOOK,LRETMOD2,cCodigo
Private nTotaNota := 0
aArea := GetArea()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Opcao de acesso para o Modelo 2                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// 3,4 Permitem alterar getdados e incluir linhas
// 6 So permite alterar getdados e nao incluir linhas
// Qualquer outro numero so visualiza
nOpcx:=3
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montando aHeader                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("Sx3")
dbSetOrder(1)
dbSeek("Z01")
nUsado:=0
aHeader:={}
aGetSD := {}
While !Eof() .And. (x3_arquivo == "Z01")
	IF X3USO(x3_usado) .AND. cNivel >= x3_nivel .And. Trim(SX3->X3_CAMPO) <> "Z01_CODIGO" .And. ;
		Trim(SX3->X3_CAMPO) <> "Z01_CODCON" .And. Trim(SX3->X3_CAMPO) <> "Z01_NOMCON";
		.And. Trim(SX3->X3_CAMPO) <> "Z01_ENTIDA"
		nUsado++
		AADD(aHeader,{ TRIM(x3_titulo), x3_campo, x3_picture,;
		x3_tamanho, x3_decimal,x3_valid,;
		x3_usado, x3_tipo, x3_arquivo, x3_context } )
		Aadd( aGetSD, X3_CAMPO)
	Endif
	dbSkip()
End
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montando aCols                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCOLS := Array(1,Len(aHeader)+1)

For i:=1 to Len(aHeader)
	cCampo:=Alltrim(aHeader[i,2])
	If alltrim(aHeader[i,2])=="Z01_ITEM"
		aCOLS[1][i] := "01"
	Else
		aCols[1][i]   := CRIAVAR(alltrim(aHeader[i][2]))
	Endif
Next i
aCOLS[1][Len(aHeader)+1] := .F.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis do Cabecalho do Modelo 2                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cCodigo := GETSX8NUM("Z01","Z01_CODIGO")
cCodCon	:= Space(06)
cNomCon := Space(30)
cEntida := Space(03)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis do Rodape do Modelo 2                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLinGetD:=0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com descricao dos campos do Cabecalho do Modelo 2      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aC:={}
// aC[n,1] = Nome da Variavel Ex.:"cCliente"
// aC[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aC[n,3] = Titulo do Campo
// aC[n,4] = Picture
// aC[n,5] = Validacao
// aC[n,6] = F3
// aC[n,7] = Se campo e' editavel .t. se nao .f.

AADD(aC,{"cCodCon  ",{15,010} ,"Contato        :"	,"@R 99999999","U_GPEAT1Ver()","Z01",.T.})
AADD(aC,{"cNomCon "	,{30,010} ,"Nome            :"	,             ,,,.F.})
AADD(aC,{"cEntida "	,{30,250} ,"Entidade        :"	,             ,,,.F.})


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com descricao dos campos do Rodape do Modelo 2         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aR:={}
// aR[n,1] = Nome da Variavel Ex.:"cCliente"
// aR[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aR[n,3] = Titulo do Campo
// aR[n,4] = Picture
// aR[n,5] = Validacao
// aR[n,6] = F3
// aR[n,7] = Se campo e' editavel .t. se nao .f.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com coordenadas da GetDados no modelo2                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCordW :={125,100,600,735}
aCGD:={45,5,228,310}
aGetEdit := {}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Validacoes na GetDados da Modelo 2                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cLinhaOk:="U_GPEAT1Li()"
cTudoOk:=".T."
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chamada da Modelo2                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// lRetMod2 = .t. se confirmou
// lRetMod2 = .f. se cancelou
lRetMod2:=U_Mde2(cCadastro,aC,aR,aCGD,nOpcx,cLinhaOk,cTudoOk,aGetSD,,"+Z01_ITEM",,aCordW,.T.)
// No Windows existe a funcao de apoio CallMOd2Obj() que retorna o
// objeto Getdados Corrente
If lRetMod2
	For nA:=1 To Len(aCols)
		If !( aCols[nA][Len(aHeader)+1] )
			nI	:= aScan(aHeader,{|x| UPPER(AllTrim(x[2]))=="Z01_DATA" })
			If  !Empty(aCols[nA,nI])
				RecLock("Z01",.T.)
				Z01_CODIGO := cCodigo
				Z01_CODCON := cCodCon
				Z01_NOMCON := cNomCon
				Z01_ENTIDA := cEntida
				For nB:=1 To Len(aHeader)
					cVar      := AScan( aHeader, { |x| AllTrim( x[2] ) == AllTrim(aHeader[nB][2]) } )
					xConteudo := aCols[ nA, cVar ]
					cCampo := AllTrim(aHeader[nB][2])
					Replace &cCampo With xConteudo
				Next
				ConfirmSX8()
				MsUnlock("Z01")
			EndIf
		EndIf
	Next
Else
	RollBackSX8()
EndIf
//SELECIONA O ULTIMO NUMERO SEQUENCIAL DE CONTRATO NO Z01
cQuery2 := " SELECT MAX(SUBSTRING(Z01_CONTRA,8,4)) AS NUM FROM Z01010 WHERE  D_E_L_E_T_ <> '*'"

MemoWrit("GPEAT1Inc.sql",cQuery2)
dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery2),'TRB2', .F., .T.)

COUNT TO nRecCount2
If nRecCount2 >0
	dbSelectArea("TRB2")
	dbGoTop()
	While ! EOF()
		cNumSeq := TRB2->NUM
		cNumSeq := Val(cNumSeq)+1
		cNumSeq := StrZero(cNumSeq,4)
		dbSkip()
	End
	TRB2->(dbCloseArea())
	SX6->(PutMV("MV_NUMZ01",cNumSeq))
EndIf
dbSelectArea("Z01")
dbSetOrder(1)
RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPAET1Alt ºAutor  ³Paulo Bindo         º Data ³  13/05/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Altera a tabela de Entidades X Contratos                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GPEAT1Alt(cAlias,nReg,nOpcX)
Private NUSADO,AHEADER,ACOLS,CCLIENTE,CLOJA
Private DDATA,NLINGETD,CTITULO,AC,AR,ACGD
Private CLINHAOK,CTUDOOK,LRETMOD2,cCodigo
Private nTotaNota := 0
aArea := GetArea()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Opcao de acesso para o Modelo 2                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// 3,4 Permitem alterar getdados e incluir linhas
// 6 So permite alterar getdados e nao incluir linhas
// Qualquer outro numero so visualiza
nOpcx:=4
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montando aHeader                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("Sx3")
dbSetOrder(1)
dbSeek("Z01")
nUsado:=0
aHeader:={}
aGetSD := {}
While !Eof() .And. (x3_arquivo == "Z01")
	IF X3USO(x3_usado) .AND. cNivel >= x3_nivel .And. Trim(SX3->X3_CAMPO) <> "Z01_CODIGO" .And. ;
		Trim(SX3->X3_CAMPO) <> "Z01_CODCON" .And. Trim(SX3->X3_CAMPO) <> "Z01_NOMCON";
		.And. Trim(SX3->X3_CAMPO) <> "Z01_ENTIDA"
		nUsado++
		AADD(aHeader,{ TRIM(x3_titulo), x3_campo, x3_picture,;
		x3_tamanho, x3_decimal,x3_valid,;
		x3_usado, x3_tipo, x3_arquivo, x3_context } )
		Aadd( aGetSD, X3_CAMPO)
	Endif
	dbSkip()
End
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montando aCols                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCOLS := Array(1,Len(aHeader)+1)

For i:=1 to Len(aHeader)
	cCampo:=Alltrim(aHeader[i,2])
	If alltrim(aHeader[i,2])=="Z01_ITEM"
		aCOLS[1][i] := "01"
	Else
		aCols[1][i]   := CRIAVAR(alltrim(aHeader[i][2]))
	Endif
Next i
aCOLS[1][Len(aHeader)+1] := .F.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis do Cabecalho do Modelo 2                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cCodigo := Z01->Z01_CODIGO
cCodCon	:= Z01->Z01_CODCON
cNomCon := Z01->Z01_NOMCON
cEntida := Z01->Z01_ENTIDA
nCnt := 0

dbSelectArea("Z01")
dbSetOrder(4)
If dbSeek(xFilial()+cCodigo)
	While !EOF() .And. Z01_CODIGO ==  cCodigo
		nCnt:=nCnt+1
		dbSkip()
	End
EndIf
If nCnt == 0
	Help(" ",1,"NOITENS")
	Return
EndIf

aCols		:=	Array(nCnt,Len(aHeader)+1)
aRecnos	:=	Array(nCnt)

nCnt := 0
dbSelectArea("Z01")
dbSetOrder(4)
If dbSeek(xFilial()+cCodigo)
	While !EOF() .And. Z01_CODIGO ==  cCodigo
		nCnt:=nCnt+1
		For nB:=1 To Len(aHeader)
			cVar      := AScan( aHeader, { |x| AllTrim( x[2] ) == AllTrim(aHeader[nB][2]) } )
			cCampo := AllTrim(aHeader[nB][2])
			aCols[nCnt, cVar] := &cCampo
		Next
		aCOLS[nCnt][Len(aHeader)+1] := .F.
		dbSelectArea("Z01")
		dbSkip()
	End
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis do Rodape do Modelo 2                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLinGetD:=0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com descricao dos campos do Cabecalho do Modelo 2      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aC:={}
// aC[n,1] = Nome da Variavel Ex.:"cCliente"
// aC[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aC[n,3] = Titulo do Campo
// aC[n,4] = Picture
// aC[n,5] = Validacao
// aC[n,6] = F3
// aC[n,7] = Se campo e' editavel .t. se nao .f.

AADD(aC,{"cCodCon  ",{15,010} ,"Contato        :"	,"@R 99999999",,,.F.})
AADD(aC,{"cNomCon "	,{30,010} ,"Nome            :"	,             ,,,.F.})
AADD(aC,{"cEntida "	,{30,250} ,"Entidade        :"	,             ,,,.F.})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com descricao dos campos do Rodape do Modelo 2         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aR:={}
// aR[n,1] = Nome da Variavel Ex.:"cCliente"
// aR[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aR[n,3] = Titulo do Campo
// aR[n,4] = Picture
// aR[n,5] = Validacao
// aR[n,6] = F3
// aR[n,7] = Se campo e' editavel .t. se nao .f.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com coordenadas da GetDados no modelo2                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCordW :={125,100,600,735}
aCGD:={45,5,228,310}
aGetEdit := {}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Validacoes na GetDados da Modelo 2                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cLinhaOk:="U_GPEAT1Li()"
cTudoOk:=".T."
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chamada da Modelo2                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// lRetMod2 = .t. se confirmou
// lRetMod2 = .f. se cancelou
lRetMd2:=U_Mde2(cCadastro,aC,aR,aCGD,nOpcx,cLinhaOk,cTudoOk,aGetSD,,"+Z01_ITEM",,aCordW,)
// No Windows existe a funcao de apoio CallMOd2Obj() que retorna o
// objeto Getdados Corrente
If lRetMd2
	nI	:= aScan(aHeader,{|x| UPPER(AllTrim(x[2]))=="Z01_ITEM" })
	cItem := aCols[1,nI]
	dbSelectArea("Z01")
	dbSetOrder(4)
	dbSeek(xFILIAL()+cCodigo+cItem)
	While !EOF() .And. cCodigo== Z01->Z01_CODIGO
		For nA:=1 To Len(aCols)
			nD	:= aScan(aHeader,{|x| UPPER(AllTrim(x[2]))=="Z01_DATA" })
			If  !Empty(aCols[nA,nD]) .And. !aCols[nA,Len(aCols[nA])]       /// Se NAO esta Deletado
				nI	:= aScan(aHeader,{|x| UPPER(AllTrim(x[2]))=="Z01_ITEM" })
				If aCols[nA,nI] == Z01->Z01_ITEM .And. !Empty(Z01->Z01_ITEM)
					If !( aCols[nA][Len(aHeader)+1] )	//GRAVA OS CAMPOS DA LINHA
						RecLock("Z01",.F.)
						For nB:=1 To Len(aHeader)
							cVar      := AScan( aHeader, { |x| AllTrim( x[2] ) == AllTrim(aHeader[nB][2]) } )
							cCampo := AllTrim(aHeader[nB][2])
							If cCampo == "Z01_TAREFA" .Or. cCampo == "Z01_SOCIO" .Or. cCampo == "Z01_STATUS";
								.Or. cCampo == "Z01_DTVENC" .Or. cCampo == "Z01_ASSPRE";
								.Or. cCampo == "Z01_ASSDIR" .Or. cCampo == "Z01_ASSTS1" .Or. cCampo == "Z01_ASSTS2";
								.Or. cCampo == "Z01_ASSTS3" .Or. cCampo == "Z01_SEGURO" .Or. cCampo == "Z01_MODELO"
								xConteudo := aCols[ nA, cVar ]
								Replace &cCampo With xConteudo
							EndIf
						Next
						MsUnlock("Z01")
					Else	//CASO A LINHA ESTEJA DELETADA NO ACOLS APAGA DA BASE
						dbSelectArea("Z01")
						dbSetOrder(4)
						If dbSeek(xFILIAL()+cCodigo+aCols[nA,nI])
							RecLock("Z01",.F.)
							dbDelete()
							dbUnLock()
						EndIf
					EndIf
					dbSelectArea("Z01")
					dbSkip()
					Loop
				Else	//INCLUI O NOVO REGISTRO
					RecLock("Z01",.T.)
					Z01_CODIGO := cCodigo
					Z01_CODCON := cCodCon
					Z01_NOMCON := cNomCon
					Z01_ENTIDA := cEntida
					If !( aCols[nA][Len(aHeader)+1] )
						For nB:=1 To Len(aHeader)
							cVar      := AScan( aHeader, { |x| AllTrim( x[2] ) == AllTrim(aHeader[nB][2]) } )
							xConteudo := aCols[ nA, cVar ]
							cCampo := AllTrim(aHeader[nB][2])
							Replace &cCampo With xConteudo
						Next
					EndIf
					MsUnlock("Z01")
					dbSelectArea("Z01")
					dbSkip()
					Loop
				EndIf
			EndIf
		Next
	End
EndIf
//SELECIONA O ULTIMO NUMERO SEQUENCIAL DE CONTRATO NO Z01
cQuery2 := " SELECT MAX(SUBSTRING(Z01_CONTRA,8,4)) AS NUM FROM Z01010 WHERE  D_E_L_E_T_ <> '*'"

MemoWrit("GPEAT1Inc.sql",cQuery2)
dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery2),'TRB2', .F., .T.)

COUNT TO nRecCount2
If nRecCount2 >0
	dbSelectArea("TRB2")
	dbGoTop()
	While ! EOF()
		cNumSeq := TRB2->NUM
		cNumSeq := Val(cNumSeq)+1
		cNumSeq := StrZero(cNumSeq,4)
		dbSkip()
	End
	TRB2->(dbCloseArea())
	SX6->(PutMV("MV_NUMZ01",cNumSeq))
EndIf
dbSelectArea("Z01")
dbSetOrder(1)
RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPEAT1Exc ºAutor  ³Paulo Bindo         º Data ³  13/05/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Exclusao de dados no Z01                                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function GPEAT1Exc(cAlias,nReg,nOpcX)

Private NUSADO,AHEADER,ACOLS,CCLIENTE,CLOJA
Private DDATA,NLINGETD,CTITULO,AC,AR,ACGD
Private CLINHAOK,CTUDOOK,LRETMOD2
Private nTotaNota := 0
aArea := GetArea()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Opcao de acesso para o Modelo 2                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// 3,4 Permitem alterar getdados e incluir linhas
// 6 So permite alterar getdados e nao incluir linhas
// Qualquer outro numero so visualiza
nOpcx:=5
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montando aHeader                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("Sx3")
dbSetOrder(1)
dbSeek("Z01")
nUsado:=0
aHeader:={}
aGetSD := {}
While !Eof() .And. (x3_arquivo == "Z01")
	IF X3USO(x3_usado) .AND. cNivel >= x3_nivel .And. Trim(SX3->X3_CAMPO) <> "Z01_CODIGO" .And. ;
		Trim(SX3->X3_CAMPO) <> "Z01_CODCON" .And. Trim(SX3->X3_CAMPO) <> "Z01_NOMCON";
		.And. Trim(SX3->X3_CAMPO) <> "Z01_ENTIDA"
		nUsado++
		AADD(aHeader,{ TRIM(x3_titulo), x3_campo, x3_picture,;
		x3_tamanho, x3_decimal,x3_valid,;
		x3_usado, x3_tipo, x3_arquivo, x3_context } )
		Aadd( aGetSD, X3_CAMPO)
	Endif
	dbSkip()
End
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montando aCols                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCOLS := Array(1,Len(aHeader)+1)

For i:=1 to Len(aHeader)
	cCampo:=Alltrim(aHeader[i,2])
	If alltrim(aHeader[i,2])=="Z01_ITEM"
		aCOLS[1][i] := "01"
	Else
		aCols[1][i]   := CRIAVAR(alltrim(aHeader[i][2]))
	Endif
Next i
aCOLS[1][Len(aHeader)+1] := .F.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis do Cabecalho do Modelo 2                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cCodigo := Z01->Z01_CODIGO
cCodCon	:= Z01->Z01_CODCON
cNomCon := Z01->Z01_NOMCON
cEntida := Z01->Z01_ENTIDA
nCnt := 0

dbSelectArea("Z01")
dbSetOrder(4)
If dbSeek(xFilial()+cCodigo)
	While !EOF() .And. Z01_CODIGO ==  cCodigo
		nCnt:=nCnt+1
		dbSkip()
	End
EndIf
aCols:=Array(nCnt,i)

nCnt := 0
dbSelectArea("Z01")
dbSetOrder(4)
If dbSeek(xFilial()+cCodigo)
	While !EOF() .And. Z01_CODIGO ==  cCodigo
		nCnt:=nCnt+1
		For nB:=1 To Len(aHeader)
			cVar      := AScan( aHeader, { |x| AllTrim( x[2] ) == AllTrim(aHeader[nB][2]) } )
			cCampo := AllTrim(aHeader[nB][2])
			aCols[nCnt, cVar] := &cCampo
		Next
		dbSelectArea("Z01")
		dbSkip()
	End
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis do Rodape do Modelo 2                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLinGetD:=0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com descricao dos campos do Cabecalho do Modelo 2      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aC:={}
// aC[n,1] = Nome da Variavel Ex.:"cCliente"
// aC[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aC[n,3] = Titulo do Campo
// aC[n,4] = Picture
// aC[n,5] = Validacao
// aC[n,6] = F3
// aC[n,7] = Se campo e' editavel .t. se nao .f.

AADD(aC,{"cCodCon  ",{15,010} ,"Contato        :"	,"@R 99999999",,,.F.})
AADD(aC,{"cNomCon "	,{30,010} ,"Nome            :"	,             ,,,.F.})
AADD(aC,{"cEntida "	,{30,250} ,"Entidade        :"	,             ,,,.F.})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com descricao dos campos do Rodape do Modelo 2         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aR:={}
// aR[n,1] = Nome da Variavel Ex.:"cCliente"
// aR[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aR[n,3] = Titulo do Campo
// aR[n,4] = Picture
// aR[n,5] = Validacao
// aR[n,6] = F3
// aR[n,7] = Se campo e' editavel .t. se nao .f.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com coordenadas da GetDados no modelo2                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCordW :={125,100,600,735}
aCGD:={45,5,228,310}
aGetEdit := {}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Validacoes na GetDados da Modelo 2                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cLinhaOk:="AlwaysTrue()"
cTudoOk:="AlwaysTrue()"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chamada da Modelo2                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// lRetMod2 = .t. se confirmou
// lRetMod2 = .f. se cancelou
lRetMod2:=Modelo2(cCadastro,aC,aR,aCGD,nOpcx,cLinhaOk,cTudoOk,aGetSD,,,,aCordW,.F.)
// No Windows existe a funcao de apoio CallMOd2Obj() que retorna o
// objeto Getdados Corrente

If lRetMod2
	dbSelectArea("Z01")
	dbSetOrder(4)
	IF dbSeek(xFilial()+cCodigo)
		While !Eof() .and. Z01_CODIGO == cCodigo
			RecLock("Z01",.F.)
			dbDelete()
			dbUnLock()
			dbSkip()
		End
	EndIf
EndIf
dbSelectArea("Z01")
dbSetOrder(1)
RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPEAT1Ver ºAutor  ³Paulo Bindo         º Data ³  06/23/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Verifica se ja existe um registro com o mesmo numero de     º±±
±±º          ³prestador ou fornecedor                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function GPEAT1Ver()
Local lRet := .T.
cQuery1 := " SELECT * FROM Z01010"
cQuery1 += " WHERE Z01_CODCON = '"+cCodCon+"' AND Z01_ENTIDA = '"+cEntida+"' AND D_E_L_E_T_ <> '*'"

cQuery1  := ChangeQuery(cQuery1)
MemoWrit("GPEAT1Ver.sql",cQuery1)
dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery1),'TRB1', .F., .T.)

COUNT TO nRecCount1
TRB1->(dbCLoseArea())

If nRecCount1 > 0
	MsgStop("Este código já está sendo utulizado!")
	lRet := .F.
	Return(lRet)
EndIf

Return(lRet)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPEATLEG1 ºAutor  ³Microsiga           º Data ³  05/17/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GPEATLEG1()
BRWLEGENDA(cCADASTRO,"Legenda",{;
{"ENABLE"     ,"Prazo maior que 30 dias"},;
{"BR_AMARELO" ,"Prazo menor que 30 dias"},;
{"BR_AZUL"    ,"Somente agendamento"},;
{"BR_PRETO"    ,"Contrato em fase de Assinatura"},;
{"DISABLE"    ,"Prazo Vencido"}})

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPEAT1Li  ºAutor  ³PAulo Bindo         º Data ³  03/19/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Valida a linha da digitacao de desempenho                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GPEAT1Li()
Local nN      	:= 0
Local nC      	:= 0
Local lPgto   	:= .F.
Local cCatFun
Local cIdent  	:= ""
Local cNumSeq 	:= GetMv("MV_NUMZ01")
Local lRet	  	:= .T.
Local cMensagem := ""
Local cMensagem1:= ""

//CASO ESTEJA DELETADO SAI DA ROTINA
If aCols[n,Len(aCols[n])]
	Return(lRet)
EndIf

For nA:=1 To Len(aHeader)
	nNum   := 0
	cCampo := ""
	//ITEM DOS CONTRATOS
	If Alltrim(aHeader[nA][2])=="Z01_ITEM"
		nNum  := nA
		cItem := aCols[n][nNum]
	EndIf
	//FILIAL
	If Alltrim(aHeader[nA][2])=="Z01_CODFIL"
		nC	    := nA
		cCodFil := aCols[n][nC]
		If Empty(cCodFil)
			cMensagem += "Filial, "
		EndIf
	EndIf
	//CODIGO DA ENTIDADE
	If Alltrim(aHeader[nA][2])=="Z01_CODENT"
		nE  	:= nA
		cCampo	:= aCols[n][nE]
		If Empty(cCampo) .And. cEntida $ "SRA"
			cMensagem += "Fornecedor, "
		EndIf
	EndIf
	//NOME DO FORNECEDOR, EM CASO DE FREE OU FORNECEDOR UTILIZA O NOME DO SOCIO
	If Alltrim(aHeader[nA][2])=="Z01_NOMENT"
		nNen      := nA
		cNomEnt   := aCols[ n, nNen]
	EndIf
	//TIPO DO CONTRATO
	If Alltrim(aHeader[nA][2])=="Z01_TPCONT"
		nNum  := nA
		cCampo:= aCols[n][nNum]
		If Empty(cCampo) .And. cEntida $ "SRASA2Z02"
			cMensagem += "Tipo Contrato, "
		EndIf
	EndIf
	//MODELO DE CONTRATO(FREE-LANCER/FORNECEDOR/PRESTADOR)
	If Alltrim(aHeader[nA][2])=="Z01_MODCON"
		nNum     := nA
		cModeloC := aCols[ n, nNum]
		If Empty(cModeloC) .And. cEntida $ "SRASA2Z02"
			cMensagem += "Modelo Contrato, "
		EndIf
	EndIf
	//TIPO DE DOCUMENTO
	If Alltrim(aHeader[nA][2])=="Z01_TPDOC"
		nNum   := nA
		cCampo := aCols[ n, nNum]
		If Empty(cCampo) .And. cEntida $ "SRASA2Z02"
			cMensagem += "Tipo Documento, "
		EndIf
	EndIf
	//INFORMA SE O PRESTADOR E SOCIO OU NAO DA EMPRESA
	If Alltrim(aHeader[nA][2])=="Z01_SOCIO"
		nNum     := nA
		cSocio   := aCols[ n, nNum]
		If Empty(cSocio) .And. cEntida $ "SRASA2"
			cMensagem += "Socio, "
		EndIf
	EndIf
	//DATA DO CONTRATO
	If Alltrim(aHeader[nA][2])=="Z01_DATA"
		nNum     := nA
		dData    := aCols[ n,nNum]
	EndIf
/*	//STATUS DO PAGAMENTO
	If Alltrim(aHeader[nA][2])=="Z01_STATUS"
		nS    := nA
		cPgto := aCols[n][nS]
		If Empty(cPgto) .And. cEntida $ "SRASA2"
			cMensagem += "Pagto, "
		EndIf
	EndIf
*/
	//DATA VENCIMENTO DO CONTRATO
	If Alltrim(aHeader[nA][2])=="Z01_DTVENC"
		nV      := nA
	EndIf
	//DATA DO CONTRATO
	If Alltrim(aHeader[nA][2])=="Z01_CONTRA"
		nR	     := nA
		cContra  := aCols[ n, nR]
	EndIf
	//CATEGORIA DO FUNCIONARIO
	If Alltrim(aHeader[nA][2])=="Z01_CATFUN"
		nCatF     := nA
		cCatFun   := aCols[ n, nCatF ]
	EndIf
	//TAREFAS
	If Alltrim(aHeader[nA][2])=="Z01_TAREFA"
		nTar      := nA
	EndIf
	//RESPONSAVEL
	If Alltrim(aHeader[nA][2])=="Z01_RESPON"
		nNum      := nA
		cCampo:= aCols[n][nNum]
		If Empty(cCampo)
			cMensagem1 += "Responsável"
		EndIf
	EndIf
	//PROXIMA EXECUCAO
	If Alltrim(aHeader[nA][2])=="Z01_PROXEX"
		nPrxE      := nA
	EndIf
	
Next
//AVISA QUAIS CAMPOS ESTA EM BRANCO, NAO PODEM ESTAR BLOQUEADOS VIA SX3
If !Empty(cMensagem) .And. (Empty(aCols[ n, nTar]) .Or. aCols[ n, nTar]=="N")
	MsgStop("Os Campos "+SubStr(cMensagem,1,Len(cMensagem)-2)+" não foram preenchidos!")
	lRet := .F.
	Return(lRet)
ElseIf 	!Empty(cMensagem1) .And. (!Empty(aCols[ n, nTar]) .And. aCols[ n, nTar]=="S")
	MsgStop("O Campo "+AllTrim(cMensagem1)+" não foi preenchido!")
	lRet := .F.
	Return(lRet)
EndIf

//VERIFICA A EXISTENCIA DE DUPLICIDADE
For nT:= 1 To Len(aCols)
	If !aCols[nT,Len(aCols[nT])]       /// Se NAO esta Deletado
/*		//VERIFICA CONTRATOS DE UMA MESMA FILIAL COM PAGAMENTO ATIVO
		If cPgto == aCols[nT][nS] .And. nT <> n .And. cCodFil == aCols[nT][nC] .And. cPgto == "1";
			.And.(aCols[nT][nV] - dDataBase)>=0 .And. cEntida #"Z02"
			lRet := .F.
			MsgStop("Já existe um contrato nesta filial com Pagamento ativo.","ITEM DUPLICADO!")
			Return(lRet)
		EndIf
		//VERIFICA SE NAO EXISTE PAGAMENTO INATIVO
		If aCols[nT][nS]=="1" .And. (!Empty(aCols[nT][nE]).Or. cModeloC $ "FR").And.(aCols[nT][nV] - dDataBase)>=0
			lPgto := .T.
		EndIf
*/		
		cVar :=SubStr(aCols[ nT, nR ],4,2)
		If (cVar = "00" .Or. Val(cVar) > Val(cIdent)) .And. nT <> n .And. aCols[nT][nC] == cCodFil
			cIdent := SubStr(aCols[ nT, nR ],4,2)
		EndIf
		//BLOQUEIA QUANDO O NUMERO DE CONTRATO FOR IGUAL
		If cContra == aCols[ nT, nR ].And. nT <> n
			MsgStop("Este número de contrato já existe para este cadastro!")
			lRet := .F.
			Return (lRet)
		EndIf
	EndIf
Next

If Empty(cIdent)
	cIdent := "00"
Else
	cIdent := StrZero(Val(cIdent)+1,2)
EndIf
//VERIFICA SE FOI SELECIONADO UM FORNECEDOR OU UMA INSTITUICAO DE ENSINO PARA PRESTADORES
If Empty(aCols[n][nE]) .And. cModeloC $ "P" .And. cEntida $ "SRA"
	lRet := .F.
	MsgStop("Selecione um Fornecedor ou uma Instituição de Ensino")
	Return(lRet)
EndIf
/*
//VERIFICA SE EXISTEM CONTRATOS VENCIDOS COM PAGAMENTO ATIVO
If !Empty(aCols[n][nC]).And.(aCols[n][nV] - dDataBase)<0 .And. aCols[n][nS]== "1"  .And. !aCols[n,Len(aCols[n])] .And. cEntida #"Z02"
	lRet := .F.
	MsgStop("Este contrato já perdeu sua validade, inative o pagamento")
	Return(lRet)
EndIf
If !lPgto .And. !aCols[n,Len(aCols[n])] .And. cEntida #"Z02" .And. aCols[ n, nTar]#"S"
	MsgStop("Nâo existe um contrato com Pagamento ATIVO.")
EndIf
*/
If !cEntida $"SA2Z02" .And. cModeloC $ "FRI" //VERIFICA SE A ENTIDADE E UM FORNECEDOR E O MODELO ESTA CONDIZENTE
	MsgStop("Não é permitido um contrato Free-Lancer, Instituiçâo ou Fornecedores para Prestadores ativos!")
	lRet := .F.
	Return(lRet)
ElseIf (cEntida =="SA2" .And. !cModeloC $ "FR") .Or. (cEntida == "Z02" .And. cModeloC # "I")
	MsgStop("O Modelo utilizado não está correto!")
	lRet := .F.
	Return(lRet)
EndIf

If cModeloC $ "FRI"  .And. Empty(cContra)//CASO FOR UM FORNECEDOR
	cCatFun := cModeloC
	//INSERE O NOME DO SOCIO NO CAMPO DE NOME DO FORNECEDOR
	If cEntida == "SA2"
		aCols[n][nNen]:= Posicione("SA2",1,xFILIAL("SA2")+cCodCon,"A2_REPCONT")
	EndIf
ElseIf cModeloC == "P"
	//BUSCA AO TIPO DE CONTRATO NO SRA E VERIFICA SE A FILIAL ESTA CORRETA
	cQuery1 := " SELECT RA_CATFUNC FROM SRA"+cCodFil+"0 "
	cQuery1 += " WHERE RA_MAT = '"+cCodCon+"' AND D_E_L_E_T_ <> '*'"
	
	cQuery1  := ChangeQuery(cQuery1)
	MemoWrit("GPEAT1Li.sql",cQuery1)
	dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery1),'TRB1', .F., .T.)
	
	COUNT TO nRecCount1
	dbSelectArea("TRB1")
	dbGoTop()
	While ! EOF()
		cCatFun := TRB1->RA_CATFUNC
		dbSkip()
	End
	TRB1->(dbCloseArea())
	aCols[ n, nCatF ]:= cCatFun
	//CASO SEJA UM PRESTADOR OU UM FREE-LANCER VERIFICA SE E SOCIO OU NAO
	If !cCatFun $ " EG" .And. Empty(cSocio) .And. cModeloC $ "PF"
		MsgStop("O campo Socio deve estar preenchido para Prestador e Free-Lancer!")
		lRet := .F.
		Return(lRet)
	EndIf
	If Empty(cCatFun) .And. cEntida $ "SRA"
		MsgStop("A filial utilizada para este funcionàrio està incorreta!")
		lRet := .F.
		Return(lRet)
	EndIf
EndIf
//FAZ O NOVO NUMERO DO CONTRATO
If cSocio == "S" .Or. cModeloC $ "FRI" .Or. cCatFun $ "EG"
	
	If Empty(cContra)
		//ARMAZENA NO ACOLS O NUMERO DO CONTRATO
		aCols[n][nR] := cCodFil+cCatFun+cIdent+SubStr(dToc(dData),7,2)+cNumSeq
		cNumSeq := Val(cNumSeq)+1
		cNumSeq :=StrZero(cNumSeq,4)
		SX6->(PutMV("MV_NUMZ01",cNumSeq))
	Else
		cQuery2 := " SELECT Z01_CONTRA, Z01_CODFIL FROM Z01010"
		cQuery2 += " WHERE Z01_CONTRA = '"+cContra+"' AND D_E_L_E_T_ <> '*' AND Z01_ITEM <> '"+cItem+"'"
		
		cQuery2  := ChangeQuery(cQuery2)
		MemoWrit("GPEAT1Li1.sql",cQuery2)
		dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery2),'TRB2', .F., .T.)
		Count To nRecCount2
		If nRecCount2 >0 .And. TRB2->Z01_CODFIL #cCodFil
			lRet := .F.
			TRB2->(dbCloseArea())
			MsgStop("Este número de contrato é desta mesma empresa, porém a filial é diferente!")
			Return(lRet)
		EndIf
		TRB2->(dbCloseArea())
	EndIf
Else
	aCols[n][nR] := Space(11)
EndIf
//INSERE DATA DE EXECUCAO DA TAREFA       W
If !Empty(aCols[n,nTar])
	aCols[n,nPrxE]:= dData
EndIf

Return(lRet)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³GPEAT1Cnt   ³ Autor ³ Paulo Bindo           ³ Data ³17/05/04  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Busca os funcionarios de todas as empresas, os fornecedores   ³±±
±±³			 ³e as instituicoes de ensino                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso		 ³GPE                   		   					            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function GPEAT1Cnt()
Local aArea := GetArea()
Local aEntidades:= {}								// Array com as entidades que possuem contatos
Local aOpcoes   := {}								// Array com as entidades que possuem contatos
Local nEnt		:= 1								// Numero da Entidades selecionada que possuem contatos
Local oDlg											// Janela
Local oEntidade										// Objeto que exibira as entidades para a escolha
Local oPanel										// Panel que contem o radio
Local bBlock										// Bloco para setar a variavel para o radio
Local oPesq											// Pesquisar alias
Local oInc											// Inclusao
Local oEnd											// Finaliza
Local aCpoRetOld:= aCpoRet
Private cContato:= ""
Private oLbx
Private aCont    :={}
Private cCliente := ""
Private cLoja    := ""
Private cDesc    := ""
Private cContato := "SRA"
Private nContato := 0
Private nOpca    := 0
Private aEntShow
Private aRas     := {}


cDesc    := ""

Aadd(aEntidades,{"SRA","Prestadores"})
Aadd(aEntidades,{"SA2","Fornecedores"})
Aadd(aEntidades,{"Z02","Faculdades"})

AEval( aEntidades, { |x| AAdd( aOpcoes, x[2] ) } )

DEFINE MSDIALOG oDlg FROM  300,20 TO 580,330 TITLE OemToAnsi("Selecione a Entidade")  PIXEL OF oMainWnd //"Selecione a entidade"

DEFINE SBUTTON FROM 05,125 TYPE 15 	ENABLE OF oDlg ACTION (DbSelectArea(aEntidades[nEnt,1]), nOpca:=IIf(aEntidades[nEnt,1]="SRA",Seleciona(),IIf(Conpad1("","","",aEntidades[nEnt,1],,.F.),1,0)),IIf(nOpca == 1,oDlg:End(),""))

DEFINE SBUTTON FROM 25,125 TYPE 2 	ENABLE OF oDlg ACTION (oDlg:End())

@05,03 MSPANEL oPanel VAR "" OF oDlg  SIZE 120,132 LOWERED
bBlock := &("{||nEnt:= oEntidade:nOption }")
oEntidade:= TRadMenu():New(05, 05, aOpcoes,;
bSETGET(nEnt), oPanel , Nil ,bBlock ,;
Nil, Nil, Nil, .T., Nil,;
100, Len(aOpcoes)*5, Nil, .T., .T., .T. )

ACTIVATE MSDIALOG oDlg CENTERED
If (nOpca == 1) .And. aEntidades[nEnt,1] # "SRA"
	aMsRel := MsRelation()
	
	If !Empty( nScan := AScan( aMsRel, { |x| x[1] == aEntidades[nEnt,1] } ) )
		cCodCon	:= aMsRel[ nScan,2, 1 ]
		cLoja   := aMsRel[ nScan,2, 2 ]
		cNomCon := Posicione("SA2",1,xFILIAL("SA2")+&cCodCon+&cLoja,"A2_NOME")
	EndIf
	If aEntidades[nEnt,1] = "Z02"
		cCodCon := Z02_CODIGO
		cNomCon := Z02_NOME
		aCpoRet  := aCpoRetOld			//RETORNA OS CAMPOS ORIGINAIS, FUNCIONA PARA OS CASOS EM QUE A CONSULTA NAO FAZ PARTE DO aMsRel
	EndIf
	
	cEntida := aEntidades[nEnt,1]
ElseIf (nOpca == 0) .And. aEntidades[nEnt,1] # "SRA"
	cCodCon 		:= ""
	cNomCon 		:= ""
ElseIf 	(nOpca == 1) .And. aEntidades[nEnt,1] == "SRA"
	cEntida := aEntidades[nEnt,1]
Endif


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Restaura o ambiente salvo.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RestArea(aArea)
Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³SELECIONA ºAutor  ³Paulo Bindo         º Data ³  08/04/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Seleciona as empresas no SX5                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function SELECIONA()
Local aEmp := {}
Local nOp  := 0
Local oDlg1
//BUSCA EMPRESAS VALIDAS NO SX5

DbSelectArea("SX5")
DbSetorder(1)
DbSeek(xFilial("SX5")+"ZY"+"01")
While !Eof() .And. X5_TABELA == "ZY"
	aAdd(aEmp,{AllTrim(X5_CHAVE)+"0"})
	dbSkip()
End

//SELECIONA OS DADOS NAS TABELAS DE CADA EMPRESA

For na:=1 To Len(aEmp)
	
	cQuery := " SELECT RA_MAT,RA_NOME, X5_DESCRI FROM SRA"+aEmp[na,1]+" AS RA"
	cQuery += " INNER JOIN SX5"+aEmp[na,1]+"  AS X5"
	cQuery += " ON X5_TABELA = '28' AND X5_CHAVE = RA_CATFUNC AND RA_CATFUNC IN ('A','E','G')"
	cQuery += " AND RA. D_E_L_E_T_ <> '*' AND RA_DEMISSA = ' ' AND X5.D_E_L_E_T_ <> '*'	"
	
	MemoWrit("GPEAT1Cnt.sql",cQuery)
	dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery),'TRB', .F., .T.)
	
	COUNT TO nRecCount
	dbSelectArea("TRB")
	dbGoTop()
	While ! EOF()
		nPos := aScan(aRas,{|x| x[1]==TRB->RA_MAT})
		If nPos == 0
			cCateg := TRB->X5_DESCRI
			aAdd(aRas,{TRB->RA_MAT, TRB->RA_NOME, cCateg})
		EndIf
		dbSkip()
	End
	TRB->(dbCloseArea())
Next
If Len(aRas) == 0
	aAdd(aRas,{"","",""})
EndIf

aSort(aRas,,,{|x,y|x[2]<y[2]})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Mostra dados dos Contatos 								    		  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

DEFINE MSDIALOG oDlg1 FROM  48,171 TO 230,795 TITLE OemToAnsi("Colaboradores/CLT/Estagiários") + " - " + cDesc  PIXEL


@  3,2 TO  73, 310 LABEL OemtoAnsi("Colaboradores/CLT/Estagiários"+":") OF oDlg1  PIXEL //"Cadastro de Contatos"
@ 10,5 LISTBOX oLbx FIELDS ;
HEADER ;
OemToAnsi("C¢digo"),OemToAnsi("Nome"),;//"C¢digo","Nome",
OemToAnsi("Tipo");
SIZE 303,60  NOSCROLL OF oDlg1 PIXEL ;
ON DBLCLICK(nOpca:= 1,nContato:= oLbx:nAt,oDlg1:End())

oLbx:SetArray(aRas)
oLbx:bLine:={||{aRas[oLbx:nAt,1],;
aRas[oLbx:nAt,2],;
aRas[oLbx:nAt,3]}}

DEFINE SBUTTON FROM 74,252 TYPE 1  	ENABLE OF oDlg1 ACTION (nOp:= 1,nContato:= oLbx:nAt,oDlg1:End())
DEFINE SBUTTON FROM 74,282 TYPE 2  	ENABLE OF oDlg1 ACTION (nOp:= 0,oDlg1:End())


ACTIVATE MSDIALOG oDlg1 CENTER
If (nOp == 1)
	cCodCon 		:= aRas[nContato,1]
	cNomCon 		:= aRas[nContato,2]
Else
	cCodCon 		:= ""
	cNomCon 		:= ""
Endif



Return(nOp)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³GPEAT1C2    ³ Autor ³ Paulo Bindo           ³ Data ³01/07/04  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Busca os fornecedores e as instituicoes de ensino             ³±±
±±³			 ³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso		 ³GPE                   		   					            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function GPEAT1C2()
Local aArea := GetArea()
Local aEntidades:= {}								// Array com as entidades que possuem contatos
Local aOpcoes   := {}								// Array com as entidades que possuem contatos
Local nEnt		:= 1								// Numero da Entidades selecionada que possuem contatos
Local oDlg											// Janela
Local oEntidade										// Objeto que exibira as entidades para a escolha
Local oPanel										// Panel que contem o radio
Local bBlock										// Bloco para setar a variavel para o radio
Local oPesq											// Pesquisar alias
Local oInc											// Inclusao
Local oEnd											// Finaliza
Local aCpoRetOld:= aCpoRet                          //Armazena o MsRel original
Local nC:=0;nL:=0;nN:=0     
Private cContato:= ""
Private oLbx
Private aCont    :={}
Private cCliente := ""
Private cLoja    := ""
Private cDesc    := ""
Private nOpca    := 0
Private aEntShow
Private aRas     := {}
cCod1 := Space(06)

Aadd(aEntidades,{"SA2","Fornecedores"})
Aadd(aEntidades,{"Z02","Faculdades"})

AEval( aEntidades, { |x| AAdd( aOpcoes, x[2] ) } )

DEFINE MSDIALOG oDlg FROM  300,20 TO 580,330 TITLE OemToAnsi("Selecione a Entidade")  PIXEL OF oMainWnd //"Selecione a entidade"

DEFINE SBUTTON FROM 05,125 TYPE 15 	ENABLE OF oDlg ACTION (DbSelectArea(aEntidades[nEnt,1]), nOpca:=IIf(Conpad1("","","",aEntidades[nEnt,1],,.F.),1,0),IIf(nOpca == 1,oDlg:End(),""))

DEFINE SBUTTON FROM 25,125 TYPE 2 	ENABLE OF oDlg ACTION (oDlg:End())

@05,03 MSPANEL oPanel VAR "" OF oDlg  SIZE 120,132 LOWERED
bBlock := &("{||nEnt:= oEntidade:nOption }")
oEntidade:= TRadMenu():New(05, 05, aOpcoes,;
bSETGET(nEnt), oPanel , Nil ,bBlock ,;
Nil, Nil, Nil, .T., Nil,;
100, Len(aOpcoes)*5, Nil, .T., .T., .T. )

ACTIVATE MSDIALOG oDlg CENTERED
If (nOpca == 1)
	aMsRel := MsRelation()
	
	If !Empty( nScan := AScan( aMsRel, { |x| x[1] == aEntidades[nEnt,1] } ) )
		cCod1 := aMsRel[ nScan,2, 1 ]
		cCod1 := &cCod1
		cCod2 := aMsRel[ nScan,2, 2 ]
		cCod2 := &cCod2
		cCod3 := Posicione("SA2",1,xFILIAL("SA2")+cCod1+cCod2,"A2_NOME")
	EndIf
	If aEntidades[nEnt,1] = "Z02"
		cCod1 := Z02_CODIGO
		cCod2 := ""
		cCod3 := Z02_NOME
		aCpoRet 	  := aCpoRetOld			//RETORNA OS CAMPOS ORIGINAIS, FUNCIONA PARA OS CASOS EM QUE A CONSULTA NAO FAZ PARTE DO aMsRel
	EndIf
	If !( aCols[n][Len(aHeader)+1] )
		For nB:=1 To Len(aHeader)
			cCampo := AllTrim(aHeader[nB][2])
			If cCampo == "Z01_CODENT"
				cVar      := AScan( aHeader, { |x| AllTrim( x[2] ) == AllTrim(aHeader[nB][2]) } )
				aCols[ n, cVar ] := cCod1
			ElseIf cCampo == "Z01_LOJA"
				cVar      := AScan( aHeader, { |x| AllTrim( x[2] ) == AllTrim(aHeader[nB][2]) } )
				aCols[ n, cVar ] := cCod2
			ElseIf cCampo == "Z01_NOMENT"
				cVar      := AScan( aHeader, { |x| AllTrim( x[2] ) == AllTrim(aHeader[nB][2]) } )
				aCols[ n, cVar ] := cCod3
			EndIf
		Next
	EndIf
	
ElseIf (nOpca == 0)
	cCod1 := Space(06)
	cCod2 := Space(02)
	cCod3 := Space(30)
	If aEntidades[nEnt,1] = "Z02"
		aCpoRet 	  := aCpoRetOld			//RETORNA OS CAMPOS ORIGINAIS, FUNCIONA PARA OS CASOS EM QUE A CONSULTA NAO FAZ PARTE DO aMsRel
	EndIf
Endif



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Restaura o ambiente salvo.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RestArea(aArea)
Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³GPEAT1Rel ³ Autor ³ Paulo Bindo           ³ Data ³ 01/06/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do WORD para impreesão de contratos                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso 	 ³						              				          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Revis„o  ³								            ³ Data ³  		  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function GPEAT1Rel()
Local cTipo
Local col := 1
Local lResp := .F.
Local cFile := ""
//ARMAZENA AS INFORMACOES DO ARRAY
DbSelectArea("Z01")

cCdE     := AScan( aHeader, { |x| AllTrim( x[2] ) == "Z01_CODENT" } )
cCodEnt  := aCols[n][cCde]
cLj      := AScan( aHeader, { |x| AllTrim( x[2] ) == "Z01_LOJA" } )
cLoja    := aCols[n][cLj]
cCtr     := AScan( aHeader, { |x| AllTrim( x[2] ) == "Z01_CONTRA" } )
cContra  := aCols[n][cCtr]
dDt		 := AScan( aHeader, { |x| AllTrim( x[2] ) == "Z01_DATA" } )
dData    := aCols[n][dDt]
cDatImp  := "Sao Paulo, "+StrZero(Day(dData),2)+ " de "+MesExtenso(dData)+" de "+ StrZero(Year(dData),4)+"."
cIt      := AScan( aHeader, { |x| AllTrim( x[2] ) == "Z01_ITEM" } )
cItem    := aCols[n][cIt]
nFl      := AScan( aHeader, { |x| AllTrim( x[2] ) == "Z01_CODFIL" } )
cFilial  := aCols[n][nFl]
nCF      := AScan( aHeader, { |x| AllTrim( x[2] ) == "Z01_CATFUN" } )
cCatFun  := aCols[n][nCF]


//VERIFICA SE JA FOI UTILIZADO UM ARQUIVO ATERIORMENTE
dbSelectArea("Z01")
dbSetOrder(4)
If dbSeek(xFILIAL()+cCodigo+cItem)
	cFile := AllTrim(Z01_MODELO)
EndIf

If !Empty(cFile) .And. At(".DOT",Upper(cFile))>0
	If !MsgYESNO("Deseja utilizar o mesmo arquivo ("+cFile+") usado anteriormente?")
		cTipo :=         "Modelo Word (*.DOT)        | *.DOT | "
		cFile := cGetFile(cTipo,"Dialogo de Selecao de Arquivos")
		If !Empty(cFile)
			Aviso("Arquivo Selecionado",cFile,{"Ok"})
		Else
			Aviso("Cancelada a Selecao!","Voce cancelou a selecao do arquivo.",{"Ok"})
			Return
		Endif
	EndIf
Else
	cTipo :=         "Modelo Word (*.DOT)        | *.DOT | "
	cFile := cGetFile(cTipo,"Dialogo de Selecao de Arquivos")
	If !Empty(cFile)
		Aviso("Arquivo Selecionado",cFile,{"Ok"})
	Else
		Aviso("Cancelada a Selecao!","Voce cancelou a selecao do arquivo.",{"Ok"})
		Return
	Endif
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criando link de comunicacao com o word                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

hWord := OLE_CreateLink()
OLE_SetProperty ( hWord, oleWdVisible, .T.)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seu Documento Criado no Word                                          ³
//³ A extensao do documento tem que ser .DOT                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ARMAZENA O NOME DO ARQUIVO
For nA := 1  To Len(cFile)
	cCaract := SubStr(cFile,col,1)
	If  cCaract == "\"
		cArqDot := ""
	Else
		cArqDot += cCaract
	EndIf
	Col := Col +1
Next

cPathDot := cFile


//Local HandleWord
Private cPathEst:= "C:\DIRDOC\" // PATH DO ARQUIVO A SER ARMAZENADO NA ESTACAO DE TRABALHO
MontaDir(cPathEst)

// Caso encontre arquivo ja gerado na estacao
//com o mesmo nome apaga primeiramente antes de gerar a nova impressao
If File( cPathEst + cArqDot )
	Ferase( cPathEst + cArqDot )
EndIf

CpyS2T(cPathDot,cPathEst,.T.) // Copia do Server para o Remote, eh necessario
//para que o wordview e o proprio word possam preparar o arquivo para impressao e
// ou visualizacao .... copia o DOT que esta no ROOTPATH Protheus para o PATH da
// estacao , por exemplo C:\WORDTMP

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gerando novo documento do Word na estacao                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
OLE_NewFile( hWord, cPathEst + cArqDot)

If cEntida $ "SA2SRA" .And. !cCatFun $"EG"
	//BUSCA DADOS DO FORNECEDOR
	cQuery3 := "SELECT * FROM SA2010"
	cQuery3 += "WHERE A2_COD ='"+cCodEnt+"' AND A2_LOJA = '"+cLoja+"' AND D_E_L_E_T_ <> '*'"
	//BUSCA DADOS DA INSTITUICAO DE ENSINO E DO ESTAGIARIO
ElseIf cEntida == "SRA" .And. cCatFun $"EG"
	cQuery3 := " SELECT RA_ENDEREC,RA_CEP,RA_CIC,RA_MUNICIP,RA_ESTADO,RA_NOME,RA_RG,RA_CURSO,Z02_NOME, Z02_ENDERE, "
	cQuery3 += " Z02_MUNIC, Z02_UF, Z02_CEP, Z02_CGC FROM SRA"+cFilial+"0 AS SRA"
	cQuery3 += " INNER JOIN Z02010 AS Z02 ON Z02_CODIGO = '"+cCodEnt+"'
	cQuery3 += " WHERE RA_MAT = '"+cCodCon+"' AND SRA.D_E_L_E_T_ <> '*' AND Z02.D_E_L_E_T_ <> '*'"
EndIf

cQuery3  := ChangeQuery(cQuery3)
MemoWrit("GPEAT1Rel.sql",cQuery3)
dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery3),'TRB3', .F., .T.)


dbSelectArea("TRB3")
dbGoTop()
While !EOF()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Gerando variaveis do documento                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SM0")
	dbSetOrder(1)
	dbSeek(cFilial+"01",.T.)
	//DADOS DA CONTRATANTE
	OLE_SetDocumentVar(hWord, "cNomEmp"  	,AllTrim(Capital(SM0->M0_NOMECOM)) )				//NOME COMPLETO DA EMPRESA
	OLE_SetDocumentVar(hWord, "cNabrvEmp"  	,AllTrim(SM0->M0_NOME))								//NOME ABREVIADO DA EMPRESA
	OLE_SetDocumentVar(hWord, "cEndEmp"   	,AllTrim(Capital(SM0->M0_ENDENT)))       			//ENDERECO DA EMPRESA
	OLE_SetDocumentVar(hWord, "cCidEmp"		,AllTrim(Capital(SM0->M0_CIDENT)))              	//CIDADE DA EMPRESA
	OLE_SetDocumentVar(hWord, "cUFEmp"  	,AllTrim(SM0->M0_ESTENT))                        	//ESTADO DA EMPRESA
	OLE_SetDocumentVar(hWord, "cCEPEmp"   	,Transform(SM0->M0_CEPENT,"@R 99999-999"))         	//CEP DA EMPRESA
	OLE_SetDocumentVar(hWord, "cCNPJEmp"    ,Transform(SM0->M0_CGC,"@R 99.999.999/9999-99"))  	//CNPJ DA EMPRESA
	//DADOS DA CONTRATADA
	If cEntida $ "SA2SRA" .And. !cCatFun $"EG"
		OLE_SetDocumentVar(hWord, "cNome"  	,AllTrim(Capital(TRB3->A2_NOME)) )  					//NOME FORNECEDOR
		OLE_SetDocumentVar(hWord, "cEnd"   	,AllTrim(Capital(TRB3->A2_END)))						//ENDERECO FORNECEDOR
		OLE_SetDocumentVar(hWord, "cCidade" ,AllTrim(Capital(TRB3->A2_MUN)))                      	//CIDADE FORNECEDOR
		OLE_SetDocumentVar(hWord, "cUF"  	,AllTrim(TRB3->A2_EST))                                	//ESTADO FORNECEDOR
		OLE_SetDocumentVar(hWord, "cCEP"   	,Transform(TRB3->A2_CEP,"@R 99999-999"))           		//CEP FORNECEDOR
		OLE_SetDocumentVar(hWord, "cCNPJ"   ,Transform(TRB3->A2_CGC,"@R 99.999.999/9999-99"))		//CNPJ FORNECEDOR
	ElseIf cEntida == "SRA" .And. cCatFun $"EG"
		//DADOS DA PESSOA CONTRATADA/ESTAGIARIO
		OLE_SetDocumentVar(hWord, "cNomEst" ,AllTrim(Capital(TRB3->RA_NOME)))						//NOME ESTAGIARIO
		OLE_SetDocumentVar(hWord, "cEndEst" ,AllTrim(Capital(TRB3->RA_ENDEREC)))					//ENDERECO ESTAGIARIO
		OLE_SetDocumentVar(hWord, "cCPFEst" ,Transform(TRB3->RA_CIC,"@R 999.999.999-99"))			//CPF ESTAGIARIO
		OLE_SetDocumentVar(hWord, "cCEPEst" ,Transform(TRB3->RA_CEP,"@R 99999-999"))				//CEP ESTAGIARIO
		OLE_SetDocumentVar(hWord, "cCidadeEst" ,AllTrim(Capital(TRB3->RA_MUNICIP)))				//CIDADE ESTAGIARIO
		OLE_SetDocumentVar(hWord, "cUFEst" ,TRB3->RA_ESTADO)										//ESTADO ESTAGIARIO
		OLE_SetDocumentVar(hWord, "cRGEst" ,Transform(TRB3->RA_RG,"@R 99.999.999-99"))				//RG ESTAGIARIO
		OLE_SetDocumentVar(hWord, "cCursoEst" ,AllTrim(Capital(TRB3->RA_CURSO)))					//CURSO DO ESTAGIARIO
		//DADOS DA INSTITUICAO DE ENSINO
		OLE_SetDocumentVar(hWord, "cNomFac"   	,AllTrim(Capital(TRB3->Z02_NOME)))					//NOME FACULDADE
		OLE_SetDocumentVar(hWord, "cEndFac"   	,AllTrim(Capital(TRB3->Z02_ENDERE)))				//ENDERECO FACULDADE
		OLE_SetDocumentVar(hWord, "cCidadeFac" ,AllTrim(Capital(TRB3->Z02_MUNIC)))					//CIDADE FACULDADE
		OLE_SetDocumentVar(hWord, "cUFFac"  	,AllTrim(TRB3->Z02_UF))								//ESTADO FACULDADE
		OLE_SetDocumentVar(hWord, "cCEPFac"   	,Transform(TRB3->Z02_CEP,"@R 99999-999"))			//CEP FACULDADE
		OLE_SetDocumentVar(hWord, "cCNPJFac"   ,Transform(TRB3->Z02_CGC,"@R 99.999.999/9999-99"))	//CNPJ FACULDADE
	EndIf
	//DADOS COMUNS
	OLE_SetDocumentVar(hWord, "cContra" ,AllTrim(cContra))										//NUMERO DO CONTRATO
	OLE_SetDocumentVar(hWord, "cDatImp" ,AllTrim(cDatImp))										//DATA DO CONTRATO
	OLE_SetDocumentVar(hWord, "cContato" ,AllTrim(Capital(Z01->Z01_NOMCON)))					//NOME DO CONTRATADO
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Atualizando variaveis do documento                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("TRB3")
	DbSkip()
Enddo
OLE_UpdateFields(hWord)
While !lResp
	If MsgYESNO("A impressão saiu corretamente?")
		If At("PROTOCOLO",Upper(cFile)) ==0
			dbSelectArea("Z01")
			dbSetOrder(4)
			If dbSeek(xFILIAL()+cCodigo+cItem)
				RecLock("Z01",.F.)
				Z01_MODELO := cFile
				MsUnlock("Z01")
			EndIf
		EndIf
		lResp := .T.
	EndIf
End
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecha Documento Criado no Word                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
OLE_CLOSEFILE(hWord)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Encerra link de comunicacao com o word                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
OLE_CLOSELINK(hWord)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Apaga arquivos tempor rios							         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRB3->(dbCloseArea())


Return


/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	  ³ Modelo2  ³ Autor ³ Juan Jose Pereira    ³ Data ³ 18/09/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o  ³ Exibe Formulario Modelo 2 								  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ cTitulo=Titulo da Janela					 			  ³±±
±±³			  ³ aC=Array com campos do cabecalho						  ³±±
±±³			  ³ aR=Array com campos do rodape					  		  ³±±
±±³			  ³ aCGD=Array com coordenadas da GetDados	 			   	  ³±±
±±³			  ³ nOpcx=Modo de operacao 					                  ³±±
±±³			  ³ cLineOk=Validacao de linha da GetDados			          ³±±
±±³			  ³ cAllOkk=Validacao de toda GetDados 					 	  ³±±
±±³			  ³ aGetsD=Array com gets editaveis 						  ³±±
±±³			  ³ bF4=bloco de codigo para tecla F4						  ³±±
±±³			  ³ cIniCpos=string com nome dos campos que devem ser inicia- ³±±
±±³			  ³			 lizados ao teclar seta para baixo. 			  ³±±
±±³			  ³ lDelGetD=determina se as linhas da Getdados podem ser de- ³±±
±±³			  ³			 letadas ou nao.								  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		  ³ Generico												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function Mde2(cTitulo,aC,aR,aCGD,nOpcx,cLineOk,cAllOk,aGetsGD,bF4,cIniCpos,nMax,aCordW,lDelGetD)
Local aButtons
Local   nOpca:=0, i,lAllOk,;
oDlg, cCampo, nX, nY, cCaption, cPict, cValid, cF3, cWhen, nLargSay, nLargGet, uConteudo, oSay, oGet
Local   cBlkGet,cBlkWhen,cBlkVld, oSaveGetdad := Nil, aSvRot := Nil
Private  cLineOk := cLineOk
Private cAllOk  := cAllOk
Private nCOunt := 0
Private nOpcx	:= nOpcx
Private aCGD	:= aCGD
Private lDelGetD := .T.
Private aCordW   := aCordW

cIniCpos := Iif(cIniCpos==Nil,"",cIniCpos)
nCount++
__cLineOk := cLineOK
__nOpcx	 := nOpcx
If nCount > 1
	oSaveGetdad := oGetDados
	oSaveGetdad:lDisablePaint := .t.
EndIf
oGets := {}
If Type("aRotina") == "A"
	aSvRot := aClone(aRotina)
EndIf
aRotina := {}
For nX := 1 to nOpcX
	AADD(aRotina,{"","",0,nOpcx})
Next


aCordW :=Iif(aCordW==Nil,{125,0,400,635},aCordW)

DEFINE MSDIALOG oDlg TITLE OemToAnsi(cTitulo) FROM aCordW[1],aCordW[2] TO aCordW[3],aCordW[4] PIXEL OF oMainWnd

For i:=1 to Len(aC)
	If Len(aC[i])==7
		cCampo:=aC[i,1]
		nX:=aC[i,2,1]
		nY:=aC[i,2,2]
		cCaption:=Iif(Empty(aC[i,3])," ",aC[i,3])
		cPict:=Iif(Empty(aC[i,4]),Nil,aC[i,4])
		cValid:=Iif(Empty(aC[i,5]),".t.",aC[i,5])
		cF3:=Iif(Empty(aC[i,6]),NIL,aC[i,6])
		cWhen:=Iif(aC[i,7]==NIL,".t.",Iif(aC[i,7],".t.",".f."))
		cWhen := Iif(!(Str(nOpcx,1,0)$"346"),".f.",cWhen)
		cBlKSay := "{|| OemToAnsi('"+cCaption+"')}"
		oSay := TSay():New( nX-1, nY, &cBlkSay,oDlg,,, .F., .F., .F., .T.,,,,, .F., .F., .F., .F., .F. )
		nLargSay := GetTextWidth(0,cCaption) / 1.8  // estava 2.2
		cCaption := oSay:cCaption
		
		cBlkGet := "{ | u | If( PCount() == 0, "+cCampo+","+cCampo+":= u ) }"
		cBlKVld := "{|| "+cValid+"}"
		cBlKWhen := "{|| "+cWhen+"}"
		
		oGet := TGet():New( nX, nY+nLargSay,&cBlKGet,oDlg,,,cPict, &(cBlkVld),,,, .F.,, .T.,, .F., &(cBlkWhen), .F., .F.,, .F., .F. ,cF3,(cCampo))
		AADD(oGets,oGet)
	EndIf
Next


oGetDados:=MSGetDados():New(aCGD[1],aCGD[2],aCGD[3],aCGD[4],nOpcX,"U_MD2LineOK()",".T.()",cIniCpos,lDelGetD,aGetsGD, , ,nMax ,"U_FldOk()")

For i:=1 to Len(aR)
	If Len(aR[i])==7
		cCampo:=aR[i,1]
		nX:=aR[i,2,1]
		nY:=aR[i,2,2]
		cCaption:=Iif(Empty(aR[i,3])," ",aR[i,3])
		cPict:=Iif(Empty(aR[i,4]),NIL,aR[i,4])
		cValid:=Iif(Empty(aR[i,5]),".t.",aR[i,5])
		cF3:=Iif(Empty(aR[i,6]),NIL,aR[i,6])
		cWhen:=Iif(aR[i,7]==NIL,".t.",Iif(aR[i,7],".t.",".f."))
		cWhen := Iif(!(Str(nOpcx,1,0)$"346"),".f.",cWhen)
		cBlKSay := "{|| OemToAnsi('"+cCaption+"')}"
		oSay := TSay():New( nX-1, nY, &cBlkSay,oDlg,,, .F., .F., .F., .T.,,,,, .F., .F., .F., .F., .F. )
		nLargSay := GetTextWidth(0,cCaption) / 1.8
		cCaption := oSay:cCaption
		
		cBlkGet := "{ | u | If( PCount() == 0, "+cCampo+","+cCampo+":= u ) }"
		cBlKVld := "{|| "+cValid+"}"
		cBlKWhen := "{|| "+cWhen+"}"
		
		oGet := TGet():New( nX, nY+nLargSay,&cBlKGet,oDlg,,,cPict, &(cBlkVld),,,, .F.,, .T.,, .F., &(cBlkWhen), .F., .F.,, .F., .F. ,cF3,(cCampo))
		AADD(oGets,oGet)
	EndIf
Next
aButtons:={}
AAdd(aButtons, { "SOLICITA" ,{|| U_GPEAT1Rel()}, "Impressão de Contratos"} )
ACTIVATE MSDIALOG oDlg ON INIT Eval({ ||EnchoiceBar(oDlg,{||nOpca:=1,lAllOk:=U_Md2OK(cAllOk),Iif(lAllOk,oDlg:End(),nOpca:=0)},{||oDlg:End()},.F.,aButtons)  })

nCount--
If nCount > 0
	oGetDados := oSaveGetDad
	oGetDados:lDisablePaint := .f.
EndIf
If ValType(aSvRot) == "A"
	aRotina := aClone(aSvRot)
EndIf


Return (nOpca==1)

User Function Md2LineOk()
Local lRet:=.t. , ni
If Str(__nOpcx,1,0)$"346"
	lRet := &__cLineOK
	For ni:= 1 to Len(oGets)
		oGets[ni]:Refresh()
	Next
EndIf
Return lRet

User Function Md2Ok(cAllOK)
Local lRet
lRet := U_Md2LineOk()
If lRet
	lRet := &cAllOk
EndIf
Return lRet

User Function CallMod2Obj()
Return oGetDados

User Function FldOk()
Local ni
For ni:= 1 to Len(oGets)
	oGets[ni]:Refresh()
Next
Return .t.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPERD002  ºAutor  ³Paulo Bindo         º Data ³  05/17/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Faz a conta da data de vencimento do contrato               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GPERD002()

Local aArea := GetArea()
Local dData := ("  /  /  ")

cTPer     := AScan( aHeader, { |x| AllTrim( x[2] ) == "Z01_TPPERI" } )
cTpPeri   := aCols[ n, cTPer ]
dDat      := AScan( aHeader, { |x| AllTrim( x[2] ) == "Z01_DATA" } )
dData    := aCols[ n, dDat ]
cPer      := AScan( aHeader, { |x| AllTrim( x[2] ) == "Z01_PERIOD" } )
cPeriodo  := aCols[ n, cPer ]


If cTpPeri == "1"
	dData := Val(cPeriodo)+ dData
ElseIf cTpPeri == "2"
	dData := (Val(cPeriodo)*7)+ dData
ElseIf cTpPeri == "3"
	dData := (Val(cPeriodo)*15)+ dData
ElseIf cTpPeri == "4"
	dData := (Val(cPeriodo)*30)+ dData
ElseIf cTpPeri == "5"
	dData := (Val(cPeriodo)*60)+ dData
ElseIf cTpPeri == "6"
	dData := (Val(cPeriodo)*90)+ dData
ElseIf cTpPeri == "7"
	dData := (Val(cPeriodo)*120)+ dData
ElseIf cTpPeri == "8"
	dData := (Val(cPeriodo)*180)+ dData
ElseIf cTpPeri == "9"
	dData := (Val(cPeriodo)*365)+ dData
EndIf

RestArea(aArea)
Return(dData)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPERD003  ºAutor  ³Paulo Bindo         º Data ³  23/06/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Verifca se ja existe um contrato em aberto de uma mesma     º±±
±±º          ³empresa e preenche o acols com os dados                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GPERD003()

Local aArea  := GetArea()
Local dDataV := ("  /  /  ")
Local cCatFun:= ""
nDat     := AScan( aHeader, { |x| AllTrim( x[2] ) == "Z01_DTVENC" } )
dDataV   := aCols[ n, nDat ]
nFor     := AScan( aHeader, { |x| AllTrim( x[2] ) == "Z01_CODENT" } )
cFornece := aCols[ n, nFor ]
nLj      := AScan( aHeader, { |x| AllTrim( x[2] ) == "Z01_LOJA" } )
cLoja    := aCols[ n, nLj ]
nFl      := AScan( aHeader, { |x| AllTrim( x[2] ) == "Z01_CODFIL" } )
cFil     := aCols[ n, nFl ]

If Empty(cLoja)
	Return(cFornece)
EndIf
If Empty(cFil)
	MsgStop("Digite a Filial deste Contato!")
	Return(cFornece)
EndIf
cQuery1 := " SELECT RA_CATFUNC FROM SRA"+cFil+"0 "
cQuery1 += " WHERE RA_MAT = '"+cCodCon+"' AND D_E_L_E_T_ <> '*'"

cQuery1  := ChangeQuery(cQuery1)
MemoWrit("GPEAT1Li1.sql",cQuery1)
dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery1),'TRB1', .F., .T.)

COUNT TO nRecCount1
If nRecCount1 == 0
	MsgStop("A Filial deste Contato está incorreta!")
	TRB1->(dbCloseArea())
	RestArea(aArea)
	Return(cFornece)
Else
	dbSelectArea("TRB1")
	dbGoTop()
	While ! EOF()
		cCatFun := TRB1->RA_CATFUNC
		dbSkip()
	End
EndIf
TRB1->(dbCloseArea())

If !cCatFun $ "EG"   //CASO NAO FOR ESTAGIARIO
	cQuery := " SELECT * FROM Z01010"
	cQuery += " WHERE Z01_CODENT = '"+cFornece+"' AND Z01_LOJA = '"+cLoja+"' AND Z01_DTVENC > '"+Dtos(dDataBase)+"'"
	cQuery += " AND Z01_CODFIL = '"+cFil+"'AND D_E_L_E_T_ <> '*'"
	
	cQuery  := ChangeQuery(cQuery)
	MemoWrit("GPERD002.sql",cQuery)
	dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery),'TRB2', .F., .T.)
	TcSetField("TRB2","Z01_DTVENC","D",8,0)
	TcSetField("TRB2","Z01_DATA","D",8,0)
	COUNT TO nRecCount
	dbSelectArea("TRB2")
	dbGoTop()
	If nRecCount >0
		If !( aCols[n][Len(aHeader)+1] )
			For nB:=1 To Len(aHeader)
				cCampo := AllTrim(aHeader[nB][2])
				If cCampo == "Z01_TPCONT"
					cCampo := "TRB2->"+cCampo
					cVar      := AScan( aHeader, { |x| AllTrim( x[2] ) == AllTrim(aHeader[nB][2]) } )
					aCols[ n, cVar ] := &cCampo
				ElseIf cCampo == "Z01_MODCON"
					cCampo := "TRB2->"+cCampo
					cVar      := AScan( aHeader, { |x| AllTrim( x[2] ) == AllTrim(aHeader[nB][2]) } )
					aCols[ n, cVar ] := &cCampo
				ElseIf cCampo == "Z01_CONTRA"
					cCampo := "TRB2->"+cCampo
					cVar      := AScan( aHeader, { |x| AllTrim( x[2] ) == AllTrim(aHeader[nB][2]) } )
					aCols[ n, cVar ] := &cCampo
				ElseIf cCampo == "Z01_DATA"
					cCampo := "TRB2->"+cCampo
					cVar      := AScan( aHeader, { |x| AllTrim( x[2] ) == AllTrim(aHeader[nB][2]) } )
					aCols[ n, cVar ] := &cCampo
				ElseIf cCampo == "Z01_TPPERI"
					cCampo := "TRB2->"+cCampo
					cVar      := AScan( aHeader, { |x| AllTrim( x[2] ) == AllTrim(aHeader[nB][2]) } )
					aCols[ n, cVar ] := &cCampo
				ElseIf cCampo == "Z01_PERIOD"
					cCampo := "TRB2->"+cCampo
					cVar      := AScan( aHeader, { |x| AllTrim( x[2] ) == AllTrim(aHeader[nB][2]) } )
					aCols[ n, cVar ] := &cCampo
				ElseIf cCampo == "Z01_DTVENC"
					cCampo := "TRB2->"+cCampo
					cVar      := AScan( aHeader, { |x| AllTrim( x[2] ) == AllTrim(aHeader[nB][2]) } )
					aCols[ n, cVar ] := &cCampo
				ElseIf cCampo == "Z01_MODELO"
					cCampo := "TRB2->"+cCampo
					cVar      := AScan( aHeader, { |x| AllTrim( x[2] ) == AllTrim(aHeader[nB][2]) } )
					aCols[ n, cVar ] := &cCampo
				EndIf
			Next
		EndIf
	EndIf
	TRB2->(dbCLoseArea())
EndIf

RestArea(aArea)
Return(cFornece)
