.data #Segmento de dados, onde s�o declaradas as vari�veis do programa

#Mensagens exibidas ao longo do programa:

MsgN1: .asciiz "Digite o 1� n�mero: "
MsgN2: .asciiz "Digite o 2� n�mero: "
MsgN3: .asciiz "Digite o 3� n�mero: "
MsgMax: .asciiz "\n\nMaior valor: "
MsgMed: .asciiz "\nValor intermedi�rio: "
MsgMin: .asciiz "\nMenor valor: "

.text #Segmento de texto, onde s�o escritas as instru��es

#Abaixo teremos instru��es semelhantes baseadas nas chamadas Syscall
#Clique em (?) para mais informa��es

#Registradores:
# $t0 = N1
# $t1 = N2
# $t2 = N3
# $t3 = maior valor
# $t4 = valor intermedi�rio
# $t5 = menor valor

#Solicitando os valores

#N1
#Exibindo a mensagem
li $v0,4
la $a0,MsgN1
syscall

#Recebendo o valor
li $v0,5 
syscall

move $t0,$v0 #Armazenando no registrador

#N2
#Exibindo a mensagem
li $v0,4
la $a0,MsgN2
syscall

#Recebendo o valor
li $v0,5
syscall

move $t1,$v0 #Armazenando no registrador

#N3
#Exibindo a mensagem
li $v0,4
la $a0,MsgN3
syscall

#Recebendo o valor
li $v0,5 
syscall

move $t2,$v0 #Armazenando no registrador

#Comparando

#N1 >= N2 ?
bge $t0,$t1,Possibilidade1
j Possibilidade2

#N1 >= N3 ?
Possibilidade1:
bge $t0,$t2,N1Maior

#N3>=N1>=N2
move $t3,$t2 #N3 = maior valor
move $t4,$t0 #N1 = valor intermedi�rio
move $t5,$t1 #N2 = menor valor
j Resultados #Exibi��o do resultado

N1Maior: #Armazena N1 como o maior valor.
move $t3,$t0

#N2 >= N3 ?
Possibilidade2:
beq $t0,$t3,Possibilidade3 #N1 = MAIOR?
bge $t1,$t2,Possibilidade5 #N2 >= N3 ?

#N3>=N2>=N1
move $t3,$t2 #N3 = maior valor
move $t4,$t1 #N2 = valor intermedi�rio
move $t5,$t0 #N1 = menor valor
j Resultados #Exibi��o do resultado

#N1 = MAIOR, mas N2>=N3 ?
Possibilidade3:
bge $t1,$t2,Possibilidade4 # N2>=N3 ?

#N1>=N3>=N2
move $t4,$t2 # N3 = valor intermedi�rio
move $t5,$t1 # N2 = menor valor
j Resultados #Exibi��o do resultado

#N1>=N2>=N3
Possibilidade4:
move $t4,$t1 # N2 = valor intermedi�rio
move $t5,$t2 # N3 = menor valor
j Resultados #Exibi��o do resultado

#N2 = MAIOR, N1 >= N3 ?
Possibilidade5:
move $t3,$t1 #N2 = MAIOR
bge $t0,$t2,Possibilidade6

#N2>=N3>=N1
move $t4,$t2 #N3 = valor intermedi�rio
move $t5,$t0 #N1 = menor valor
j Resultados #Exibi��o do resultado

#N2>=N1>=N3
Possibilidade6:
move $t4,$t0 #N1 = valor intermedi�rio
move $t5,$t2 #N3 = menor valor
	
Resultados:
#Exibindo as respostas

#Max
#Exibi��o da mensagem.
li $v0,4
la $a0,MsgMax
syscall

#Exibi��o do valor
li $v0,1
move $a0,$t3
syscall

#Med
#Exibi��o da mensagem.
li $v0,4
la $a0,MsgMed
syscall

#Exibi��o do valor
li $v0,1
move $a0,$t4
syscall

#Min
#Exibi��o da mensagem.
li $v0,4
la $a0,MsgMin
syscall

#Exibi��o do valor
li $v0,1
move $a0,$t5
syscall

#Fim
li $v0,10
syscall
