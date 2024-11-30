.data #SEGMENTO DE DADOS: ONDE SAO DECLARADAS AS VARIAVEIS
MsgPos: .asciiz "Insira a posição do último termo: "
MsgErro: .asciiz "Quantidade inválida!\n"
MsgSeq: .asciiz "Sequência: 0"
MsgVirg: .asciiz ", "
MsgFim: .asciiz "\n\nFim do programa."

.text #SEGMENTO DE TEXTO: ONDE ESTÃO AS INTRUCOES
j Main

fibo:
	#$S0 CONTEM A QUANTIDADE DE TERMOS
	li $s1,2 # CONTADOR
	li $t0,0 # PRIMEIRO TERMO
	li $t1,1 # SEGUNDO TERMO

	laco:
		bgt $s1,$s0,fimLaco # QUANDO PASSAR DO TAMANHO PEDIDO, ENCERRA

		#INSERE A VIRGULA
		li $v0,4
		la $a0,MsgVirg
		syscall
	
		#DESCOBRE O PROXIMO TERMO
		add $t2,$t1,$t0

		#EXIBE O VALOR DESCOBERTO
		li $v0,1
		move $a0,$t2
		syscall

		#PASSA OS VALORES UMA POSICAO PARA A FRENTE
		move $t0,$t1
		move $t1, $t2

		#INCREMENTA O CONTADOR
		add $s1,$s1,1

		j laco

	fimLaco:
		jr $ra


Erro:
li $v0,4
la $a0,MsgErro
syscall

Main:
#MENSAGME DE SOLICITACAO
li $v0,4
la $a0,MsgPos
syscall

li $v0,5
syscall

blt $v0, 0,Erro #N < 0
move $s0,$v0 # ARMAZENA A ESCOLHA

#EXIBE A MENSAGEM ONDE ESTARA A SEQUENCIA, JA MOSTRANDO F[0]=0
li $v0,4
la $a0,MsgSeq
syscall

beq $s0,0,Fim # SE N = 0, JA PODE ENCERRAR

#EXIBE A SEQUENCIA COM F[1]=1
li $v0,4
la $a0,MsgVirg
syscall

#F[1] = 1
li $v0,1
li $a0,1
syscall

bgt $s0,1,Calculo #SO CHAMA A FUNCAO F[N] SE N>1
j Fim

#CHAMADA DA FUNCAO
Calculo:
jal fibo

#ENCERRAMENTO
Fim:

li $v0,4
la $a0,MsgFim
syscall

li $v0,10
syscall


