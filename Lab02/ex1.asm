# INTEGRANTES 
#
# Nome: ENZO RIBEIRO	                RA: 10418262
# Nome: LUCAS PIRES DE CAMARGO SARAI	RA: 10418013
#
#TURMA: 03D11
#ORGANIZACAO DE COMP.
#PROF. DR. JEAN M. LAINE

.data #SEGMENTO DE DADOS: ONDE SÃO DECLARADAS AS VARIAVEIS

#MENSAGENS A SEREM EXIBIDAS
MsgN1: .asciiz "Insira o valor (inteiro e positivo): "
MsgErro: .asciiz "O valor deve ser positivo!\n\n"
MsgR: .asciiz "Resultado: "	
MsgFim: .asciiz "\n\nFim do programa."

.text #SEGMENTO DE TEXTO: ONDE SAO ESCRITAS AS INSTRUCOES
j Main

#FUNCAO QUE CALCULA O FATORIAL DO VALOR PASSADO EM $a0
fatorial:
	li $v0,1 # O RESULTADO COMEÇA EM 1
	li $s0,1 # RECEBERA CADA FATOR ATE CHEGAR NO VALOR FORNECIDO
	ble $a0,$s0,fimLaco # CASO O VALOR FORNECIDO SEJA 0 OU 1

	laco: # MULTIPLICANDO ATE CHEGAR NO VALOR PASSADO
		bgt $s0,$a0,fimLaco
		mul $v0,$v0,$s0
		add $s0,$s0,1
		j laco

	fimLaco: # FINALIZANDO A FUNCAO E RETORNANDO PARA A MAIN
		jr $ra


#VALOR NEGATIVO EH PROIBIDO!
Erro:
li $v0,4
la $a0,MsgErro
syscall	

Main:
#PASSANDO O VALOR
li $v0,4
la $a0,MsgN1
syscall

li $v0,5
syscall

blt $v0,0,Erro #VALIDACAO DA ENTRADA

#CHAMADA DA FUNCAO
move $a0,$v0
jal fatorial
move $t0,$v0 #RESULTADO ARMAZENADO EM $t0

#EXIBINDO O RESULTADO
li $v0,4
la $a0,MsgR
syscall

li $v0,1
move $a0,$t0
syscall


#ENCERRAMENTO
fim:
li $v0,4
la $a0,MsgFim
syscall

li $v0,10
syscall
