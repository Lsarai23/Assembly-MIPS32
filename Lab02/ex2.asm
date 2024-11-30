# INTEGRANTES 
#
# Nome: ENZO RIBEIRO	                RA: 10418262
# Nome: LUCAS PIRES DE CAMARGO SARAI	RA: 10418013
#
#TURMA: 03D11
#ORGANIZACAO DE COMP.
#PROF. DR. JEAN M. LAINE


.data #SEGMENTO DE DADOS: ONDE SAO CRIADAS AS VARIAVEIS
Digite: .asciiz "Digite a quantidade de termos da sequência: "
Sequencia: .asciiz "\nSequência: "
Erro: .asciiz "ERRO! A quantidade deve ser >0.\n\n"
Virgula: .asciiz ", "
FimDoPrograma: .asciiz "\n\nFim do programa."

.text #SEGMENTO DE TEXTO: ONDE ESTAO AS INSTRUCOES
j main

fibonacci:
# VALORES INICIAIS
li $t1,0
li $t2,1
li $t3,0

# CASO O TAMANHO DA SEQUENCIA SEJA 1
beq $t0,$t2,nEh1
j nao1

nEh1:
# IMPRIMINDO O VALOR
li $v0, 1
move $a0, $t1
syscall
j fimLaco
	
nao1:
# IMPRIMINDO O PRIMEIRO VALOR
li $v0, 1
move $a0, $t1
syscall

# IMPRIMINDO A VIRGULA
li $v0, 4
la $a0, Virgula
syscall

# IMPRIMINDO O SEGUNDO VALOR
li $v0, 1
move $a0, $t2
syscall

# IMPRIMINDO A VIRGULA
li $v0, 4
la $a0, Virgula
syscall

# DECREMENTANDO O CONTADOR
sub $t0,$t0,2

# ESTRUTURA DE REPETICAO
laco:
# CONDICAO DE PARADA
beq $t0,$zero,fimLaco	

# GERANDO O VALOR DA SEQUENCIA
add $t3,$t1,$t2
	
# IMPRIMINDO VALOR DA SEQUENCIA
li $v0, 1
move $a0, $t3
syscall
	
# IMPRIMINDO A VIRGULA, EVITANDO A ULTIMA
beq $t0, 1, pularVirgula
li $v0, 4
la $a0, Virgula
syscall
pularVirgula:

# ATRIBUINDO AOS VALORES
move $t1,$t2
move $t2,$t3

# SUBTRACAO DO TERMO DE PARADA
sub $t0,$t0,1

# RETORNO AO LAÇO
j laco

fimLaco:
jr $ra

# NAO EH PERMITIDO QUANTIDADE <= 0
erro:
li $v0,4
la $a0,Erro
syscall

main:
# IMPRIMINDO A STRING
li $v0, 4
la $a0, Digite
syscall

# RECEBENDO O TAMANHO DA SEQUENCIA
li $v0, 5
syscall
move $t0, $v0

# CASO O TAMANHO DA SEQUENCIA SEJA <=0
ble $t0,$zero,erro


# STRING DE MENSAGEM DE SEQUENCIA
li $v0, 4
la $a0, Sequencia
syscall

#CHAMADA DA FUNCAO
jal fibonacci


# FIM DO PROGRAMA
fim:
# STRING DO FIM DO PROGRAMA
li $v0, 4
la $a0, FimDoPrograma
syscall
	
# FIM DO PROGRAMA
li $v0, 10
syscall
