.data #Segmento de dados, onde são declaradas as variáveis do programa

#Mensagens exibidas ao longo do programa:

MsgN1: .asciiz "Digite o 1° número: "
MsgN2: .asciiz "Digite o 2° número: "
MsgN3: .asciiz "Digite o 3° número: "
MsgMax: .asciiz "\n\nMaior valor: "
MsgMed: .asciiz "\nValor intermediário: "
MsgMin: .asciiz "\nMenor valor: "

.text #Segmento de texto, onde são escritas as instruções

#Abaixo teremos instruções semelhantes baseadas nas chamadas Syscall
#Clique em (?) para mais informações

#Registradores:
# $t0 = N1
# $t1 = N2
# $t2 = N3
# $t3 = maior valor
# $t4 = valor intermediário
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
move $t4,$t0 #N1 = valor intermediário
move $t5,$t1 #N2 = menor valor
j Resultados #Exibição do resultado

N1Maior: #Armazena N1 como o maior valor.
move $t3,$t0

#N2 >= N3 ?
Possibilidade2:
beq $t0,$t3,Possibilidade3 #N1 = MAIOR?
bge $t1,$t2,Possibilidade5 #N2 >= N3 ?

#N3>=N2>=N1
move $t3,$t2 #N3 = maior valor
move $t4,$t1 #N2 = valor intermediário
move $t5,$t0 #N1 = menor valor
j Resultados #Exibição do resultado

#N1 = MAIOR, mas N2>=N3 ?
Possibilidade3:
bge $t1,$t2,Possibilidade4 # N2>=N3 ?

#N1>=N3>=N2
move $t4,$t2 # N3 = valor intermediário
move $t5,$t1 # N2 = menor valor
j Resultados #Exibição do resultado

#N1>=N2>=N3
Possibilidade4:
move $t4,$t1 # N2 = valor intermediário
move $t5,$t2 # N3 = menor valor
j Resultados #Exibição do resultado

#N2 = MAIOR, N1 >= N3 ?
Possibilidade5:
move $t3,$t1 #N2 = MAIOR
bge $t0,$t2,Possibilidade6

#N2>=N3>=N1
move $t4,$t2 #N3 = valor intermediário
move $t5,$t0 #N1 = menor valor
j Resultados #Exibição do resultado

#N2>=N1>=N3
Possibilidade6:
move $t4,$t0 #N1 = valor intermediário
move $t5,$t2 #N3 = menor valor
	
Resultados:
#Exibindo as respostas

#Max
#Exibição da mensagem.
li $v0,4
la $a0,MsgMax
syscall

#Exibição do valor
li $v0,1
move $a0,$t3
syscall

#Med
#Exibição da mensagem.
li $v0,4
la $a0,MsgMed
syscall

#Exibição do valor
li $v0,1
move $a0,$t4
syscall

#Min
#Exibição da mensagem.
li $v0,4
la $a0,MsgMin
syscall

#Exibição do valor
li $v0,1
move $a0,$t5
syscall

#Fim
li $v0,10
syscall
