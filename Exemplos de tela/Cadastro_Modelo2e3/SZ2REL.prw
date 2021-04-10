/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � SZ2REL   � Autor �  Luiz Carlos Vieira   � Data � 26/05/97 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Relatorio de especificacoes de produtos                    ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Petronyl                                                   ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function SZ2REL()

//��������������������������������������������������������������Ŀ
//� Define Variaveis											 �
//����������������������������������������������������������������
CbTxt			 := ""
cDesc1           := "Este programa tem como objetivo imprimir relatorio de especificacoes"
cDesc2           := "de produtos. Especifico para Petronyl Ind. Com. de Poliamida Ltda."
cDesc3			 := ""
cString          := "SZ2"
imprime 		 := .T.
cPict			 := ""
aOrd			 := {}
cTexto			 := ""
j				 := 0
tamanho 		 := "M"
limite			 := 80
nomeprog         := "Y1REL"
mv_tabpr		 := ""
nTipo			 := 18
aReturn          := { "Zebrado", 1,"Administracao", 2, 2, 1,"",1}
nLastKey		 := 0
titulo           := "Relatorio de Especificacao Tecnica de Produto"
nlin			 := 80
cPerg            := "Y1REL"
nItem			 := 1
lContinua        := .T.

//��������������������������������������������������������������Ŀ
//� Variaveis utilizadas para Impressao do Cabecalho e Rodape	 �
//����������������������������������������������������������������
cbtxt	   := Space(10)
cbcont	   := 00
CONTFL	   := 01
m_pag	   := 01
imprime    := .T.

//��������������������������������������Ŀ
//� Verifica as perguntas				 �
//����������������������������������������

//����������������������������������������������������������������������Ŀ
//� Perguntas do programa:												 �
//����������������������������������������������������������������������Ĵ
//� mv_par01             ->        Do Produto            ?               �
//� mv_par02             ->        Ate o Produto         ?               �
//������������������������������������������������������������������������

Pergunte(cPerg,.F.)

//���������������������������������������������Ŀ
//� Tela padrao de impressao					�
//�����������������������������������������������

wnrel := "Y1REL"
cString := "SZ2"

wnrel := SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.T.) //,.T.,aOrd,,Tamanho)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

//��������������������������������������������������������������Ŀ
//� Verifica Posicao do Formulario na Impressora				 �
//����������������������������������������������������������������

VerImp()

//��������������������������������������������������������������Ŀ
//� Prepara o cabecalho padrao para o relatorio 				 �
//����������������������������������������������������������������

Cabec1 := "|         E S P E C I F I C A C A O   T E C N I C A   D E   P R O D U T O        |"
//         0         1         2         3         4         5         6         7         8
//         01234567890123456789012345678901234567890123456789012345678901234567890123456789012
Cabec2 := "|Codigo do produto   : "
Cabec3 := "|Descricao do produto: "
Cabec4 := "|--------------------------------------------------------------------------------|"
Cabec5 := "|            Propriedade             | Unid. |     Norma       |  Especificacao  |"
Cabec6 := "|------------------------------------|-------|-----------------|-----------------|"
//         |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX | XXXXXX| XXXXXXXXXXXXXXX | XXXXXXXXXXXXXXX |

dbSelectArea("SZ2")
dbSetOrder(1)
dbSeek(xFilial("SZ2")+mv_par01,.T.)

SetRegua(Val(mv_par02)-Val(mv_par01))

While !EOF() .And. xFilial("SZ2")==SZ2->Z2_FILIAL .And. SZ2->Z2_CODIGO <= mv_par02 .And. lContinua

	IncRegua()

    cCodigo := SZ2->Z2_CODIGO
    nLin    := 80
    nItem   := 1

    While !EOF() .And. xFilial("SZ2")==SZ2->Z2_FILIAL .And. SZ2->Z2_CODIGO == cCodigo

        Inkey()
        If LastKey()==286 // ALT + A
            Exit
        Endif

		If nLin > 60
			ImpCabec()
		Endif

        @ nLin,00 PSay "|" + AllTrim(SZ2->Z2_PROPRIE)
        @ nLin,37 PSay "|" + AllTrim(SZ2->Z2_UM)
        @ nLin,45 PSay "|" + AllTrim(SZ2->Z2_NORMA)
        @ nLin,63 PSay "|" + AllTrim(SZ2->Z2_ESPEC)
        @ nLin,81 PSay "|"
		nLin := nLin + 1
		dbSkip()

	EndDo

	#IFNDEF WINDOWS
		If LastKey()==286 // ALT + A
            @PRow(),00 PSay "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif
	#ELSE
		If lAbortPrint
            @PRow(),00 PSay "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif
	#ENDIF

	ImpRoda()

EndDo

Set Device to Screen

If aReturn[5]==1
	Set Printer to
	OurSpool(wnrel)
endif

return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o	 � IMPCABEC � Autor �  Luiz Carlos Vieira	� Data � 23/05/97 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Imprime o cabecalho do relatorio.						  ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Especifico - Y1Rel.prg                                     ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function ImpCabec

nLin := 0
@ nLin,00 PSay "|"+Replic("-",80)+"|"
nLin := nLin + 1
@ nlin,00 PSay Cabec1
nLin := nLin + 1
@ nLin,00 PSay PADR(Cabec2+cCodigo,81)+"|"
_sAlias := Alias()

dbSelectArea("SB1")
dbSetOrder(1)
dbSeek(xFilial("SB1")+cCodigo)
dbSelectArea(_sAlias)
nLin := nLin + 1
@ nLin,00 PSay PADR(Cabec3+SB1->B1_DESC,81)+"|"
nLin := nLin + 1
@ nLin,00 PSay Cabec4
nLin := nLin + 1
@ nLin,00 PSay Cabec5
nLin := nLin + 1
@ nLin,00 PSay Cabec6
nLin := nLin + 1

Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � IMPRODA  � Autor �  Luiz Carlos Vieira   � Data � 23/05/97 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Imprime o rodape do relatorio.                             ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Especifico - Requis.prx                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function ImpRoda
For _i := nLin To 47
    @_i,00 PSay "|                                    |       |                 |                 |"
Next _i
nLin := 48
@nLin,00 PSay "|"+Replic("-",80)+"|"
nLin := nLin + 1
@nLin,00 PSay "|"+Replic("-",80)+"|"
nLin := nLin + 1
@nLin,00 PSay "|   Revisao   |                        Motivo                         |   Data   |"
nLin := nLin + 1
@nLin,00 PSay "|-------------|-------------------------------------------------------|----------|"
nLin := nLin + 1
@nLin,00 PSay "|______1______|_______________________________________________________|__________|"
nLin := nLin + 1
@nLin,00 PSay "|______2______|_______________________________________________________|__________|"
nLin := nLin + 1
@nLin,00 PSay "|______3______|_______________________________________________________|__________|"
nLin := nLin + 1
@nLin,00 PSay "|______4______|_______________________________________________________|__________|"
nLin := nLin + 2
@nLin,00 PSay "|"+Replic("-",80)+"|"
nLin := nLin + 1
@nLin,00 PSay "|"+Replic(" ",80)+"|"
nLin := nLin + 1
@nLin,00 PSay "|Preparado: _________________ ___/___/___ Aprovado: _________________ ___/___/___|"
nLin := nLin + 1
@nLin,00 PSay "|"+Replic(" ",80)+"|"
nLin := nLin + 1
@nLin,00 PSay "|"+Replic("-",80)+"|"
nLin := 00
@nLin,00 PSay ""

Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o	 � VERIMP	� Autor �  Luiz Carlos Vieira	� Data � 23/05/97 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Verifica posicionamento de papel na Impressora			  ���
�������������������������������������������������������������������������Ĵ��
���Uso		 � Especifico - Requis.prx									  ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function VerImp

li:= 0				  // Contador de Linhas
nLinIni:=0
If aReturn[5]==2
	nOpc	   := 1
    cCor       := "B/BG"
	While .T.
		SetPrc(0,0)
		dbCommitAll()

        @ li ,000 PSay " "
        @ li ,004 PSay "*"
        @ li ,022 PSay "."

        Set Device to Screen
        DrawAdvWindow(" Formulario ",10,25,14,56)
        SetColor(cCor)
//        @ 12,27 Say "Formulario esta posicionado?"
        nOpc:=Menuh({"Sim","Nao","Cancela Impressao"},14,26,"b/w,w+/n,r/w","SNC","",1)
        Set Device to Print
		Do Case
			Case nOpc==1
				lContinua:=.T.
				Exit
			Case nOpc==2
				Loop
			Case nOpc==3
				lContinua:=.F.
				Return
		EndCase
	End
Endif

Set Device to Print
@ li,00 PSay ""

Return