.data # Segmento de dados, onde são declaradas as variáveis do programa

#Mensagens exibidas ao longo do programa:

#Menu.
MsgMenu: .asciiz "\n\nMenu:\n\n"
MsgOpc1: .asciiz "[1]: Soma\n"
MsgOpc2: .asciiz "[2]: Subtração\n"
MsgOpc3: .asciiz "[3]: Multiplicação\n"
MsgOpc4: .asciiz "[4]: Divisão\n"
MsgOpc5: .asciiz "[5]: Sair\n"
MsgSelecao: .asciiz "Escolha a operação (1/2/3/4/5): "
MsgErro: .asciiz "\nOpção inválida!Repita.\n"

#Operandos.
MsgN1: .asciiz "\nInsira o 1° número: "
MsgN2: .asciiz "Insira o 2° número: "

#Resultado das operações.
MsgSoma: .asciiz "\nSoma: "
MsgSub: .asciiz "\nSubtração: "
MsgMul: .asciiz "\nMultiplicação: "
MsgDiv: .asciiz "\nDivisão: "
MsgErroDiv: .asciiz "\nERRO! Divisão por zero. Troque os valores.\n"

#Encerramento.
MsgSaida: .asciiz "\n\nFim do programa. "

.text # Segmento de texto, onde são escritas as instruções

#Abaixo teremos instruções semelhantes baseadas nas chamadas Syscall
#Clique em (?) para mais informações

#Registradores:
# $t0 = N1
# $t1 = N2
# $t2 = N3
# $t3 = maior valor
# $t4 = valor intermediário
# $t5 = menor valor

j inicioMenu # Pula para a label "inicioMenu", onde ocorre a exibição do menu principal

#Caso de input inválido
erroDiv:
li $v0,4
la $a0,MsgErroDiv
syscall

j Operacoes # Pula para a label "Operacoes", onde ocorrem a operacão selecionada

#Caso de opção inválida
erroMenu: 
li $v0,4
la $a0,MsgErro
syscall

j InputOpc # Pula para a label "InputOpc", onde ocorre a escolha da opção
	
inicioMenu: #Exibindo menu
#Linha do título
li $v0,4
la $a0,MsgMenu 
syscall

#Texto da opção 1
li $v0,4
la $a0,MsgOpc1
syscall

#Texto da opção 2
li $v0,4
la $a0,MsgOpc2
syscall

#Texto da opção 3
li $v0,4
la $a0,MsgOpc3
syscall

#Texto da opção 4
li $v0,4
la $a0,MsgOpc4
syscall

#Texto da opção 5
li $v0,4
la $a0,MsgOpc5
syscall

InputOpc: #Seleção da opção

#Mensagem de solicitação
li $v0,4
la $a0,MsgSelecao
syscall

li $v0,5 #Recebimento da opção
syscall

move $t3,$v0 # Armazenando a opção escolhida

#Opção de encerrar
beq $t3,5,Encerramento

#Seleção Inválida: >5 ou <1
bgt $t3,5,erroMenu
blt $t3,1,erroMenu

Operacoes: #Onde são realizadas as operações
#Recebendo N1
#Exibe a mensagem de solicitação
li $v0,4
la $a0,MsgN1
syscall

#Leitura do valor pelo teclado
li $v0,5
syscall

move $t0,$v0 #Armazena N1

#Recebendo N2
#Exibe a mensagem de solicitação
li $v0,4
la $a0,MsgN2
syscall

#Leitura do valor pelo teclado
li $v0,5 
syscall

move $t1,$v0 #Armazena N2

#Selecionando a operação (beq = Branch on equal. Se for verdadeira a igualdade, realisa o pulo para a label indicada
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

#Realisa a operação
add $t2,$t0,$t1

#Exibe o resultado
li $v0,1
move $a0,$t2
syscall

j inicioMenu #Retorna ao menu

#Subtração
opc2:

#Exibe a mensagem
li $v0,4
la $a0,MsgSub
syscall

#Realisa a operação
sub $t2,$t0,$t1

#Exibe o resultado
li $v0,1
move $a0,$t2
syscall

j inicioMenu #Retorna ao menu

#Multiplicação
opc3:

#Exibe a mensagem
li $v0,4
la $a0,MsgSub
syscall

#Realisa a operação
mul $t2,$t0,$t1

#Exibe o resultado
li $v0,1
move $a0,$t2
syscall

j inicioMenu #Retorna ao menu
 
#Divisão
opc4:

beq $t1,$zero,erroDiv #Divisão por zero é proibida!

#Exibe a mensagem
li $v0,4
la $a0,MsgSub
syscall

#Realisa a operação
div $t2,$t0,$t1

#Exibe o resultado
li $v0,1
move $a0,$t2
syscall

j inicioMenu #Retorna ao menu

Encerramento:
#Mensagem de saída
li $v0,4
la $a0,MsgSaida
syscall

#Encerramento adequado
li $v0,10
syscall
