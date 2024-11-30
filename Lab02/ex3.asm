# INTEGRANTES 
#
# Nome: ENZO RIBEIRO	                RA: 10418262
# Nome: LUCAS PIRES DE CAMARGO SARAI	RA: 10418013
#
#TURMA: 03D11
#ORGANIZACAO DE COMP.
#PROF. DR. JEAN M. LAINE

.data #SEGMENTO DE DADOS: ONDE SAO DECLARADAS AS VARIAVEIS
MsgValor: .asciiz "Insira um decimal positivo: "
MsgR: .asciiz "Resultado: "
MsgE: .asciiz "ERRO! Entrada negativa! Repita.\n\n"
MsgFim: .asciiz "\n\nFim do programa."
binario: .space 32


.text #SEGMENTO DE TEXTO, ONDE SAO ESCRITAS AS INSTRUCOES
j main

decimal_para_binario:
move $t0,$a0 #VALOR DECIMAL
li $s0,2 # DIVISOR 2 PARA GERAR O VALOR BINARIO
move $t1, $zero #INDICE

#MONTANDO O VALOR BINARIO
laco:
beq $t0,1,preencherResp
divu $t0, $s0 #RECEBENDO O PROXIMO DIGITO BINÁRIO
mflo $t0 #QUOCIENTE
mfhi $s1 #RESTO(BINARIO)
sb $s1, binario($t1) # ARMAZENANDO O DIGITO BINARIO EM UM VETOR
addi $t1,$t1,1 #INCREMENTA O INDICE
j laco

#ESCREVENDO O VALOR BINARIO
preencherResp:
sb $t0,binario($t1) # ARMAZENANDO O ULTIMO DIGITO
move $t2,$t1 

laco2:
blt $t1,$zero,fimLaco2
lb $a0,binario($t1) # ARMAZENANDO NO ARGUMENTO PARA EXIBICAO
subi $t1,$t1,1 #INCREMENTA O INDICE
li $v0,1#EXIBE UM DIGITO POR VEZ
syscall
j laco2

fimLaco2:
jr $ra
	

#CASO DE ERRO: ENTRADA NEGATIVA
erro:
li $v0,4
la $a0,MsgE
syscall

main:
#RECEBENDO VALOR DECIMAL
li $v0,4
la $a0,MsgValor
syscall

li $v0,5
syscall

#VALIDANDO ENTRADA
blt $v0,0,erro

move $t0,$v0 #ARMAZENANDO A ENTRADA

#EXIBINDO A MENSAGEM ONDE ESTARA A REPOSTA
li $v0,4
la $a0,MsgR
syscall

bgt $t0,1,calculando

#SE O VALOR PEDIDO EH 0 OU 1, JA EXIBE
li $v0,1
move $a0,$t0
syscall
j fim

calculando:
#CHAMANDO A FUNCAO COM O VALOR DECIMAL COMO ARGUMENTO
move $a0,$t0
jal decimal_para_binario


#ENCERRAMENTO
fim:
li $v0,4
la $a0,MsgFim
syscall

li $v0,10
syscall
