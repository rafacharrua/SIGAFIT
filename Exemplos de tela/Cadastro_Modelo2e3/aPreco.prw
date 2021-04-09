#INCLUDE "RWMAKE.CH"
#INCLUDE "topconn.ch" 

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ aPreco   º Autor ³ Sergio Lavor       º Data ³ 25/12/2008  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina de Cadastro de Kit x Caixas.                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Orthoneuro                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function aPreco()

Private aRotina   := {}
Private cCadastro := "KIT X CAIXAS"

aAdd(aRotina, {"Pesquisar" , "AxPesqui"    , 0, 1})
aAdd(aRotina, {"Visualizar", "U_APRECO1(2)", 0, 2})
aAdd(aRotina, {"Incluir"   , "U_APRECO1(3)", 0, 3})
aAdd(aRotina, {"Alterar"   , "U_APRECO1(4)", 0, 4})
aAdd(aRotina, {"Excluir"   , "U_APRECO1(5)", 0, 5})

dbSelectArea("SZA")
dbSetOrder(1)									// --> Indice: ZA_CODIGO + ZA_SERIE
dbGoTop()

mBrowse(,,,,"SZA")

Return Nil     



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ aPreco1  º Autor ³ Sergio Lavor       º Data ³ 25/12/2008  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Orthoneuro                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function APRECO1(nOpcX)

Local nW     := 0
Local nX     := 0

Local _nItem := 0
Local _nCodg := 0
Local _nSeri := 0
Local _nCodI := 0
Local _nDesc := 0
Local _nData := 0

// --> Opcoes de acesso para a Modelo 3.
If     nOpcX == 3						// INCLUIR
	nOpcE := 3
	nOpcG := 3
ElseIf nOpcX == 4						// ALTERAR
	nOpcE := 3
	nOpcG := 3
ElseIf nOpcX == 2						// VISUALIZAR
	nOpcE := 2
	nOpcG := 2
ElseIf nOpcX == 5						// EXCLUIR
	nOpcE := 2
	nOpcG := 2
EndIf

// --> Cria variaveis M->????? da Enchoice.
RegToMemory("SZA",(nOpcX==3))			// nOpcX==3: INCLUIR

// --> Cria aHeader e aCols da GetDados.
nUsado  := 0
dbSelectArea("SX3")
dbSeek("SZB")
aHeader := {}
While !Eof() .And. (X3_ARQUIVO=="SZB")
	If AllTrim(X3_CAMPO)=="ZB_CODIGO" .Or. AllTrim(X3_CAMPO)=="ZB_SERIE"
		dbSkip()
		Loop
	EndIf

	If X3USO(X3_USADO) .And. cNivel>=X3_NIVEL
		nUsado := nUsado+1
		aAdd(aHeader,{ Trim(X3_TITULO) , X3_CAMPO   , X3_PICTURE      , ;
					   X3_TAMANHO      , X3_DECIMAL , "AllwaysTrue()" , ;
					   X3_USADO        , X3_TIPO    , X3_ARQUIVO      , ;
					   X3_F3           , X3_CONTEXT } )
	EndIf
	dbSkip()
EndDo

If nOpcX == 3							// INCLUIR
	aCols := {Array(nUsado+1)}
	aCols[1,nUsado+1] := .F.
	For _ni:=1 To nUsado
		aCols[1,_ni]  := CriaVar(aHeader[_ni,2])
	Next
Else
	aCols := {}
	dbSelectArea("SZB")
	dbSetOrder(1)								// --> Indice: ZB_FILIAL + ZB_CODIGO + ZB_SERIE + ZB_ITEM
	dbSeek(xFilial()+M->ZA_CODIGO+M->ZA_SERIE)
	While !Eof() .And. ZB_CODIGO==M->ZA_CODIGO .And. ZB_SERIE==M->ZA_SERIE
		aAdd(aCols,Array(nUsado+1))
		For _nI:=1 To nUsado
			aCols[Len(aCols),_nI]  := FieldGet(FieldPos(aHeader[_nI,2]))
		Next
		aCols[Len(aCols),nUsado+1] := .F.
		dbSkip()
	EndDo
EndIf

If Len(aCols)>0
	// --> Executa a Modelo 3.
	cTitulo			:= "Cadastro de Kit x Caixas"
	cAliasEnchoice	:= "SZA"
	cAliasGetD		:= "SZB"
	aCpoEnchoice	:= {"ZA_CODIGO"}
	cLinOk			:= "AllwaysTrue()"
	cTudOk			:= "AllwaysTrue()"
	cFieldOk		:= "AllwaysTrue()"
	
	_lRet  := Modelo3(cTitulo,cAliasEnchoice,cAliasGetD,aCpoEnchoice,cLinOk,cTudOk,nOpcE,nOpcG,cFieldOk)

	_nItem := aScan(aHeader,{|x| x[2]=="ZB_ITEM   "})
	_nCodg := aScan(aHeader,{|x| x[2]=="ZB_CODIGO "})
	_nSeri := aScan(aHeader,{|x| x[2]=="ZB_SERIE  "})
	_nCodI := aScan(aHeader,{|x| x[2]=="ZB_CODITEN"})
	_nDesc := aScan(aHeader,{|x| x[2]=="ZB_DESCRIC"})
	_nData := aScan(aHeader,{|x| x[2]=="ZB_DATA   "})

	If _lRet .And. nOpcX <> 2				// VISUALIZAR
		// --> Executa processamento (Inclusão/Alteração/Exclusão) do CABEÇALHO.
		dbSelectArea("SZA")
		dbSetOrder(1)	 							// --> Indice: ZA_FILIAL + ZA_CODIGO + ZA_SERIE
		If    nOpcX == 3					// INCLUIR
			RecLock("SZA",.T.)
			SZA->ZA_FILIAL  := xFilial("SZA")
			SZA->ZA_CODIGO  := M->ZA_CODIGO
			SZA->ZA_SERIE   := M->ZA_SERIE
			SZA->ZA_DESCRIC := M->ZA_DESCRIC
			SZA->ZA_ULTSAID := M->ZA_ULTSAID
			SZA->ZA_ULTRETO := M->ZA_ULTRETO
			SZA->ZA_OBS     := M->ZA_OBS
			MsUnLock()
		ElseIf nOpcX == 4					// ALTERAR
			RecLock("SZA",.F.)
			SZA->ZA_FILIAL  := xFilial("SZA")
			SZA->ZA_CODIGO  := M->ZA_CODIGO
			SZA->ZA_SERIE   := M->ZA_SERIE
			SZA->ZA_DESCRIC := M->ZA_DESCRIC
			SZA->ZA_ULTSAID := M->ZA_ULTSAID
			SZA->ZA_ULTRETO := M->ZA_ULTRETO
			SZA->ZA_OBS     := M->ZA_OBS
			MsUnLock()
	    ElseIf nOpcX == 5					// EXCLUIR
			If dbSeek(xFilial("SZA")+M->ZA_CODIGO+M->ZA_SERIE)
				RecLock("SZA",.F.)
				dbDelete()
				MsUnLock()
			EndIf
			dbSelectArea("SZB")
			dbSetOrder(1)							// --> Indice: ZB_FILIAL + ZB_CODIGO + ZB_SERIE + ZB_ITEM
			For nW := 1 To Len(aCols)
				If dbSeek(xFilial("SZB")+M->ZA_CODIGO+M->ZA_SERIE+aCols[nW][_nItem])
					RecLock("SZB",.F.)
					dbDelete()
					MsUnLock()
				EndIf
			Next nW
		EndIf

		// --> Executa processamento (Inclusão/Alteração/Exclusão) dos ITENS.
	    If nOpcX <> 2 .And. nOpcX <> 5				// VISUALIZAR   ##   EXCLUIR
			For nX := 1 To Len(aCols)
				If !aCols[nX][Len(aHeader)+1]
					dbSelectArea("SZB")
					dbSetOrder(1)					// --> Indice: ZB_FILIAL + ZB_CODIGO + ZB_SERIE + ZB_ITEM
					If !dbSeek(xFilial("SZB")+M->ZA_CODIGO+M->ZA_SERIE+aCols[nX][_nItem])
						RecLock("SZB",.T.)
					Else
						RecLock("SZB",.F.)
					EndIf
					SZB->ZB_FILIAL  := xFilial("SZB")
					SZB->ZB_ITEM    := aCols[nX][_nItem]
					SZB->ZB_CODIGO  := M->ZA_CODIGO
					SZB->ZB_SERIE   := M->ZA_SERIE
					SZB->ZB_CODITEN := aCols[nX][_nCodI]
					SZB->ZB_DESCRIC := aCols[nX][_nDesc]
					SZB->ZB_DATA    := aCols[nX][_nData]
					MsUnLock()
				Else
					dbSelectArea("SZB")
					dbSetOrder(1)					// --> Indice: ZB_FILIAL + ZB_CODIGO + ZB_SERIE + ZB_ITEM
					If dbSeek(xFilial("SZB")+M->ZA_CODIGO+M->ZA_SERIE+aCols[nX][_nItem])
						RecLock("SZB",.F.)
						dbDelete()
						MsUnLock()
					EndIf
				EndIf
			Next nX
		EndIf
		Aviso("Modelo3()","Confirmada operacao!",{"Ok"})
		n := 1
		
	EndIf

EndIf

Return 



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ OrSomaIt º Autor ³ Sergio Lavor       º Data ³ 25/12/2008  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Contador (soma) do itens do Kit x Caixa.                   º±±
±±º          ³ Funcao colocada no inicializador padrao do campo ZB_ITEM.  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Orthoneuro                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function OrSomaIt()

Local cProxIt := "01"

If INCLUI .And. Type("N")=="U"
	cProxIt := "01"
Else
	If n > 1
		cProxIt := SOMA1(aCols[N-1][1])
	EndIf
EndIf

Return cProxIt
