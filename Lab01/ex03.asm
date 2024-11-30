.data #Segmento de dados, onde são declaradas as variáveis do programa

MsgSenha: .asciiz "Informe a senha: "
MsgValida: .asciiz "\nSenha válida!\n"
MsgInvalida: .asciiz "\nSenha inválida. Tente de novo.\n"
MsgEncerramento: .asciiz "\nFim do programa."

.text #Segmento de texto, onde são escritas as instruções

Main: # Execução principal do programa

#Solicitando a senha

#Exibindo mensagem de solicitação
li $v0,4
la $a0,MsgSenha
syscall

#Recebendo valor do teclado
li $v0,5
syscall

move $t0,$v0 # Armazenando a senha inserida.
li $t1,12345 # Armazenando no registrador a senha correta.

beq $t0,$t1,Encerrar # Analisa se a senha é válida por bitwise.

#Exibe que a senha não é válida.
li $v0,4
la $a0,MsgInvalida
syscall

#Retorna ao início.
j Main

Encerrar: # Instruções para finalizar o programa.

#Exibe que a senha correspondeu, e então, encerra o programa.
li $v0,4
la $a0,MsgValida
syscall

#Exibe uma mensagem de encerramento.
li $v0,4
la $a0,MsgEncerramento
syscall

#Fim
li $v0,10
syscall
