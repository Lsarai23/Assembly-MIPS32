.data #Segmento de dados, onde s�o declaradas as vari�veis do programa

MsgSenha: .asciiz "Informe a senha: "
MsgValida: .asciiz "\nSenha v�lida!\n"
MsgInvalida: .asciiz "\nSenha inv�lida. Tente de novo.\n"
MsgEncerramento: .asciiz "\nFim do programa."

.text #Segmento de texto, onde s�o escritas as instru��es

Main: # Execu��o principal do programa

#Solicitando a senha

#Exibindo mensagem de solicita��o
li $v0,4
la $a0,MsgSenha
syscall

#Recebendo valor do teclado
li $v0,5
syscall

move $t0,$v0 # Armazenando a senha inserida.
li $t1,12345 # Armazenando no registrador a senha correta.

beq $t0,$t1,Encerrar # Analisa se a senha � v�lida por bitwise.

#Exibe que a senha n�o � v�lida.
li $v0,4
la $a0,MsgInvalida
syscall

#Retorna ao in�cio.
j Main

Encerrar: # Instru��es para finalizar o programa.

#Exibe que a senha correspondeu, e ent�o, encerra o programa.
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
