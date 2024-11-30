.data # Segmento de dados, onde s�o declaradas as vari�veis do programa

#Mensagens exibidas ao longo do programa:

#Menu.
MsgMenu: .asciiz "\n\nMenu:\n\n"
MsgOpc1: .asciiz "[1]: Soma\n"
MsgOpc2: .asciiz "[2]: Subtra��o\n"
MsgOpc3: .asciiz "[3]: Multiplica��o\n"
MsgOpc4: .asciiz "[4]: Divis�o\n"
MsgOpc5: .asciiz "[5]: Sair\n"
MsgSelecao: .asciiz "Escolha a opera��o (1/2/3/4/5): "
MsgErro: .asciiz "\nOp��o inv�lida!Repita.\n"

#Operandos.
MsgN1: .asciiz "\nInsira o 1� n�mero: "
MsgN2: .asciiz "Insira o 2� n�mero: "

#Resultado das opera��es.
MsgSoma: .asciiz "\nSoma: "
MsgSub: .asciiz "\nSubtra��o: "
MsgMul: .asciiz "\nMultiplica��o: "
MsgDiv: .asciiz "\nDivis�o: "
MsgErroDiv: .asciiz "\nERRO! Divis�o por zero. Troque os valores.\n"

#Encerramento.
MsgSaida: .asciiz "\n\nFim do programa. "

.text # Segmento de texto, onde s�o escritas as instru��es

#Abaixo teremos instru��es semelhantes baseadas nas chamadas Syscall
#Clique em (?) para mais informa��es

#Registradores:
# $t0 = N1
# $t1 = N2
# $t2 = N3
# $t3 = maior valor
# $t4 = valor intermedi�rio
# $t5 = menor valor

j inicioMenu # Pula para a label "inicioMenu", onde ocorre a exibi��o do menu principal

#Caso de input inv�lido
erroDiv:
li $v0,4
la $a0,MsgErroDiv
syscall

j Operacoes # Pula para a label "Operacoes", onde ocorrem a operac�o selecionada

#Caso de op��o inv�lida
erroMenu: 
li $v0,4
la $a0,MsgErro
syscall

j InputOpc # Pula para a label "InputOpc", onde ocorre a escolha da op��o
	
inicioMenu: #Exibindo menu
#Linha do t�tulo
li $v0,4
la $a0,MsgMenu 
syscall

#Texto da op��o 1
li $v0,4
la $a0,MsgOpc1
syscall

#Texto da op��o 2
li $v0,4
la $a0,MsgOpc2
syscall

#Texto da op��o 3
li $v0,4
la $a0,MsgOpc3
syscall

#Texto da op��o 4
li $v0,4
la $a0,MsgOpc4
syscall

#Texto da op��o 5
li $v0,4
la $a0,MsgOpc5
syscall

InputOpc: #Sele��o da op��o

#Mensagem de solicita��o
li $v0,4
la $a0,MsgSelecao
syscall

li $v0,5 #Recebimento da op��o
syscall

move $t3,$v0 # Armazenando a op��o escolhida

#Op��o de encerrar
beq $t3,5,Encerramento

#Sele��o Inv�lida: >5 ou <1
bgt $t3,5,erroMenu
blt $t3,1,erroMenu

Operacoes: #Onde s�o realizadas as opera��es
#Recebendo N1
#Exibe a mensagem de solicita��o
li $v0,4
la $a0,MsgN1
syscall

#Leitura do valor pelo teclado
li $v0,5
syscall

move $t0,$v0 #Armazena N1

#Recebendo N2
#Exibe a mensagem de solicita��o
li $v0,4
la $a0,MsgN2
syscall

#Leitura do valor pelo teclado
li $v0,5 
syscall

move $t1,$v0 #Armazena N2

#Selecionando a opera��o (beq = Branch on equal. Se for verdadeira a igualdade, realisa o pulo para a label indicada
beq $t3,1,opc1
beq $t3,2,opc2
beq $t3,3,opc3
beq $t3,4,opc4

#Soma
opc1:

#Exibe a mensagem
li $v0,4
la $a0,MsgSub
syscall

#Realisa a opera��o
add $t2,$t0,$t1

#Exibe o resultado
li $v0,1
move $a0,$t2
syscall

j inicioMenu #Retorna ao menu

#Subtra��o
opc2:

#Exibe a mensagem
li $v0,4
la $a0,MsgSub
syscall

#Realisa a opera��o
sub $t2,$t0,$t1

#Exibe o resultado
li $v0,1
move $a0,$t2
syscall

j inicioMenu #Retorna ao menu

#Multiplica��o
opc3:

#Exibe a mensagem
li $v0,4
la $a0,MsgSub
syscall

#Realisa a opera��o
mul $t2,$t0,$t1

#Exibe o resultado
li $v0,1
move $a0,$t2
syscall

j inicioMenu #Retorna ao menu
 
#Divis�o
opc4:

beq $t1,$zero,erroDiv #Divis�o por zero � proibida!

#Exibe a mensagem
li $v0,4
la $a0,MsgSub
syscall

#Realisa a opera��o
div $t2,$t0,$t1

#Exibe o resultado
li $v0,1
move $a0,$t2
syscall

j inicioMenu #Retorna ao menu

Encerramento:
#Mensagem de sa�da
li $v0,4
la $a0,MsgSaida
syscall

#Encerramento adequado
li $v0,10
syscall
