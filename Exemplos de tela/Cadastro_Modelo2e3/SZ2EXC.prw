/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � SZ2EXC   � Autor �Walter Caetano da Silva� Data � 30/08/00 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Rotina de exclusao de espeficicacoes Modelo 2              ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/ 
User Function SZ2EXC

If !( Eof() .And. Bof() )
	
	//��������������������������������������������������������������Ŀ
	//� Opcao de acesso para o Modelo 2                              �
	//����������������������������������������������������������������
	// 3,4 Permitem alterar getdados e incluir linhas
	// 6 So permite alterar getdados e nao incluir linhas
	// Qualquer outro numero so visualiza
	
    nOpcx  := 5
	
	_nItem := 0
	_nProp := 0
	_nUm   := 0
	_nNorm := 0
	_nEspe := 0
	
	//��������������������������������������������������������������Ŀ
	//� Montando aHeader                                             �
	//����������������������������������������������������������������
	dbSelectArea("SX3")
	dbSetOrder(1)
	dbSeek("SZ2")
	nUsado  := 0
	aHeader := {}
	While !Eof() .And. (x3_arquivo == "SZ2")
		If AllTrim(X3_CAMPO)=="Z2_FILIAL" .Or. AllTrim(X3_CAMPO)=="Z2_CODIGO";
				.Or. AllTrim(X3_CAMPO)=="Z2_REVOBS"
			dbSkip()
			Loop
		Endif
		IF X3USO(x3_usado) .AND. cNivel >= x3_nivel
			nUsado:=nUsado+1
			aAdd(aHeader,{ TRIM(x3_titulo), AllTrim(x3_campo), x3_picture,;
				x3_tamanho, x3_decimal,,;
				x3_usado, x3_tipo, x3_arquivo, x3_context } )
		Endif
		dbSkip()
	End
	
	//��������������������������������������������������������������Ŀ
	//� Montando aCols                                               �
	//����������������������������������������������������������������
	
	dbSelectArea("SZ2")
	dbSetOrder(1)
	cProduto := SZ2->Z2_CODIGO
	dbSeek(xFilial("SZ2")+cProduto)
	
	dbSelectArea("SB1")
	dbSetOrder(1)
	dbSeek(xFilial("SB1")+cProduto)
	
	//��������������������������������������������������������������Ŀ
	//� Variaveis do Cabecalho do Modelo 2                           �
	//����������������������������������������������������������������
	
    cLocal   := SB1->B1_LOCPAD
	cDescr   := SB1->B1_DESC
	
	//��������������������������������������������������������������Ŀ
	//� Variaveis do Rodape do Modelo 2                              �
	//����������������������������������������������������������������
	
	cObs := SZ2->Z2_REVOBS
	
	dbSelectArea("SZ2")
	aCols := {}
	
	While !EOF() .And. cProduto==SZ2->Z2_CODIGO
		aAdd(aCols,{SZ2->Z2_ITEM,SZ2->Z2_PROPRIE,SZ2->Z2_UM,Z2_NORMA,Z2_ESPEC,.F.})
		dbSkip()
	EndDo
	
	//��������������������������������������������������������������Ŀ
	//� Titulo da Janela                                             �
	//����������������������������������������������������������������
	
	cTitulo:="Cadastro de Especifica��es"
	
	//��������������������������������������������������������������Ŀ
	//� Array com descricao dos campos do Cabecalho do Modelo 2      �
	//����������������������������������������������������������������
	aC := {}
	// aC[n,1] = Nome da Variavel Ex.:"cCliente"
	// aC[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
	// aC[n,3] = Titulo do Campo
	// aC[n,4] = Picture
	// aC[n,5] = Validacao
	// aC[n,6] = F3
	// aC[n,7] = Se campo e' editavel .t. se nao .f.
	
	aAdd(aC,{"cProduto" ,{05,03} ,"C�d. do Produto"   ,"@!"           ,,,.F.})
    aAdd(aC,{"cLocal"   ,{05,42} ,"Local"             ,"@!"           ,,,.F.})
	aAdd(aC,{"cDescr"   ,{06,03} ,"Descri��o"         ,"@!"           ,,,.F.})
	
	//��������������������������������������������������������������Ŀ
	//� Array com descricao dos campos do Rodape do Modelo 2         �
	//����������������������������������������������������������������
	aR := {}
	// aR[n,1] = Nome da Variavel Ex.:"cCliente"
	// aR[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
	// aR[n,3] = Titulo do Campo
	// aR[n,4] = Picture
	// aR[n,5] = Validacao
	// aR[n,6] = F3
	// aR[n,7] = Se campo e' editavel .t. se nao .f.
	aAdd(aR,{"cObs" ,{20,03},"Observa��o"    ,"@!",,,.F.})
	
	//��������������������������������������������������������������Ŀ
	//� Array com coordenadas da GetDados no modelo2                 �
	//����������������������������������������������������������������
	aCGD := {08,04,16,74}

	//��������������������������������������������������������������Ŀ
	//� Validacoes na GetDados da Modelo 2                           �
	//����������������������������������������������������������������
	cLinhaOk := ""
	cTudoOk  := ""

	//��������������������������������������������������������������Ŀ
	//� Chamada da Modelo2                                           �
	//����������������������������������������������������������������
	// lRetMod2 = .t. se confirmou
	// lRetMod2 = .f. se cancelou
	_nItem   := aScan(aHeader,{|x| x[2]=="Z2_ITEM"})
	
	lRetMod2 := Modelo2(cTitulo,aC,aR,aCGD,nOpcx,cLinhaOk,cTudoOk)
	
	If lRetMod2 // Exclusao. . .
		For _l := 1 To Len(aCols)
			dbSelectArea("SZ2")
			dbSetOrder(1)
			If dbSeek(xFilial("SZ2")+cProduto+aCols[_l,_nItem])
				RecLock("SZ2",.F.)
				dbDelete()
				MsUnLock()
			Endif
		Next _l
	Endif
	
	dbGoTop()
	
Endif

Return
