# INTEGRANTES 
#
# Nome: ENZO RIBEIRO	                RA: 10418262
# Nome: GABRIEL KEN KAZAMA GERONAZZO    RA: 10418247
# Nome: LUCAS PIRES DE CAMARGO SARAI	RA: 10418013
# Nome: LUCAS ZANINI                    RA: 10417361
#
#TURMA: 03D11
#ORGANIZACAO DE COMP.
#PROF. DR. JEAN M. LAINE

.data # Segmento de dados, onde s�o inicializadas as vari�veis

MsgMenu: .asciiz "\n***** SISTEMA DE CONTROLE DE ESTOQUE *****\n 1.Inserir um novo item no estoque\n 2.Excluir um item do estoque\n 3.Buscar um item pelo c�digo\n 4.Atualizar quantidade em estoque\n 5.Imprimir os produtos em estoque\n 6.Sair\nOp��o: "
MsgErroOpc: .asciiz "Op��o inv�lida!Repita.\n"

MsgCod: .asciiz "\nPasse o c�digo do item: "
MsgErroCod: .asciiz "Produto n�o encontrado.\n\n"
MsgErroCodRep: .asciiz "C�digo j� cadastrado!  Use outro c�digo.\n\n"

MsgQtd: .asciiz "Passe a quantidade do produto: "
MsgErroQtd: .asciiz "Quantidade inv�lida. Repita!\n\n"

MsgListaVazia: .asciiz "\nN�o h� produtos.\n"

MsgOpc1: .asciiz "\n***** INSERIR PRODUTO *****\n"
MsgOpc2: .asciiz "\n***** EXCLUIR PRODUTO *****\n"
MsgOpc3: .asciiz "\n***** BUSCAR PRODUTO *****\n"
MsgOpc4: .asciiz "\n***** ATUALIZAR PRODUTO *****\n"
MsgOpc5: .asciiz "\n***** EXIBIR PRODUTOS *****"

MsgProdCod: .asciiz "\n\nC�digo = "
MsgProdQtd: .asciiz "\nQuantidade em Estoque = "
MsgProdEstoqueS: .asciiz "\nEst� em estoque!\n"
MsgProdEstoqueN: .asciiz "Fora de estoque!\n"

MsgFim: .asciiz "\nFim do programa."

.text # Segmento de texto, onde se armazena as instru��es

# Registradores:
# $t0 = c�digo a armazenar
# $t1 = quantidade
# $t2 = c�digo a procurar
# $s0 = endere�o de Head.c�digo
# $s1 = endere�o do c�digo de um N�
# $s2 = endere�o do bloco next do n� anterior
# $s3 = op��o escolhida
# $s4 = endere�o de sa�da da fun��o

j main

#Fun��es do programa
inserir:
	move $s4,$ra # Salvando o endere�o de sa�da da fun��o
	jal buscar # Buscando o c�digo para ver se n�o � repetido
	move $ra,$s4 # Devolvendo o endere�o correto de sa�da da fun��o
	
	beq $v0,1,erroCodRep # Caso o c�digo passado j� esteja cadastrado
	
	#Caso seja um c�digo n�o repetido, armazena-o
	move $t0,$t2

	#Recebendo a quantidade
	li $v0,4
	la $a0,MsgQtd
	syscall

	li $v0,5
	syscall

	move $t1,$v0

	#Alocando mem�ria para o N�
	li $v0,9
	la $a0,12
	syscall

	beq $s0,$zero,listaVazia
	move $s1,$v0 # Armazenando o endere�o inicial do N�
	sw $s1, ($s2) #Armazenando o endere�o inicial em "Next" do N� anterior

	sw $t0,($s1) # Armazenando o c�digo
	sw $t1,4($s1) # Armazenando a quantidade

	addi $s2, $s1, 8 # Armazenando o endere�o do bloco Next
	j fimInserir

	listaVazia:
		move $s0,$v0 # Armazenando e endere�o inicial de Head
		sw $t0,($s0) # Armazenando o c�digo
		sw $t1,4($s0) # Armazenando a quantidade
		addi $s2,$s0,8 # Armazenando o endere�o do bloco Next

	fimInserir:
		jr $ra

excluir:
	move $s4,$ra # Armazenando o local(endere�o de instru��o) de sa�da da fun��o em "main"
	jal buscar
	move $ra,$s4 # Devolvendo para $ra o local de sa�da em "main"
	
	beq $v0,1,fimExcluir # Se existir o produto
	jr $ra # Se n�o existir

	fimExcluir:
		sw $zero,($s1) #Zerando o c�digo do produto exclu�do
		lw $s1,8($s1) # Recebendo o endere�o inicial do pr�ximo N�
		#Rompendo as conex�es ao N� exclu�do
		sw $s1,($s2) # Conectando o N� anterior ao exclu�do ao pr�ximo N�
		
		
		jr $ra
		
buscar:
	#Recebendo o c�digo do produto procurado
	li $v0,4
	la $a0,MsgCod
	syscall

	li $v0,5
	syscall
	
	move $t2,$v0 # Armazenando o c�digo a procurar
	
	# Lista vazia (head = 0 = null)
	beq $s0,0,naoExiste 

	move $s1, $s0 # Recebendo o endere�o inicial de Head
	lw $t0, ($s1) # Recebendo o primeiro c�digo

	loop:
		beq $t0,$t2,encontrado
		
		addi $s2,$s1,8 # Recebendo o endere�o do bloco Next do N� atual
		lw $s1, ($s2) # Recebendo o endere�o inicial do pr�ximo N� (poss�vel N� procurado)
		
		beq $s1,$zero,naoExiste
		
		lw $t0, ($s1) # Recebendo o pr�ximo c�digo (poss�vel c�digo procurado)

		j loop

	naoExiste:
		beq $s3,1,retornarCod # Para a op��o 1, n�o exibe a mensagem, mas retorna tamb�m o c�digo
		li $v0,4
		la $a0,MsgErroCod
		syscall
		j retornoFalso # Op��es 2,3 e 4 n�o precisa retornar o c�digo
		
		retornarCod:
			move $v1,$t2 # Op��o 1: Retornar o c�digo
		
		retornoFalso:
			li $v0,0 # Retorno Falso
			j fimBuscar1

	encontrado:
	
		li $v0,1 # Retorno verdadeiro
	
	fimBuscar1:
		beq $s3,3,fimBuscar2 # Se a op��o escolhida era 3, precisa exibir o produto procurado
		jr $ra # Caso contr�rio, s� retornar o valor booleano
		
	fimBuscar2:
		beq $v0,1,emEstoque
		
		#Exibindo que n�o est� em estoque.
		li $v0,4
		la $a0,MsgProdEstoqueN
		syscall
		
		jr $ra
		
		emEstoque:
			#Exibindo que est� em estoque
			li $v0,4
			la $a0,MsgProdEstoqueS
			syscall
		
			#Exibindo a mensagem da quantidade
			li $v0,4
			la $a0,MsgProdQtd
			syscall
		
			lw $t1, 4($s1) # Armazenando a quantidade
		
			#Exibindo o valor da quantidade
			li $v0,1
			move $a0,$t1
			syscall
			
			jr $ra




atualizar:
	move $s4,$ra # Armazenando o local(endere�o de instru��o) de sa�da da fun��o em "main"
	jal buscar
	move $ra,$s4 # Devolvendo para $ra o local de sa�da em "main"
	
	beq $v0,1,fimAtualizar
	jr $ra
	
	fimAtualizar:

	#Recebendo a quantidade
	li $v0,4
	la $a0,MsgQtd
	syscall

	li $v0,5
	syscall

	validacaoQtd:
		blt $v0,$zero,erroQtd
 
	sw $v0,4($s1) # Armazenando a nova quantidade
	jr $ra 

exibir:
	beq $s0,$zero,erroListaVazia 
	move $s1,$s0 #Armazena o endere�o inicial de Head

	loopEx:
		beq $s1,$zero,fimLpEx

		#Exibe o c�digo
		li $v0,4
		la $a0,MsgProdCod
		syscall

		li $v0,1
		lw $a0, ($s1)
		syscall

		#Exibe a quantidade
		li $v0,4
		la $a0,MsgProdQtd
		syscall

		li $v0,1
		lw $a0,4($s1)
		syscall

		#Passa para o pr�ximo n�
		lw $s1,8($s1)

		j loopEx

	fimLpEx:
		jr $ra
		
#Erro de c�digo repetido
erroCodRep:
li $v0,4
la $a0,MsgErroCodRep
syscall
j inserir


#Op��o inv�lida
erroOpc:
li $v0,4
la $a0,MsgErroOpc
syscall
j main


#Quantidade inv�lida
erroQtd:
li $v0,4
la $a0,MsgErroQtd
syscall
j validacaoQtd

#Tentar exibir a lista vazia
erroListaVazia:
li $v0,4
la $a0,MsgListaVazia
syscall


main:

#Menu
li $v0,4
la $a0,MsgMenu
syscall

li $v0,5
syscall

move $s3,$v0 # Armazenando op��o escolhida

beq $s3,6,fim # Op��o de sa�da

#Tratamento de entrada: op��o
blt $s3,1,erroOpc
bgt $s3,6,erroOpc

#Op��es v�lidas
beq $s3,1,opc1
beq $s3,2,opc2
beq $s3,3,opc3
beq $s3,4,opc4
beq $s3,5,opc5

#Para cada caso, chama-se a fun��o apropriada
opc1:
li $v0,4
la $a0,MsgOpc1
syscall
jal inserir
j main

opc2:
li $v0,4
la $a0,MsgOpc2
syscall
jal excluir
j main

opc3:
li $v0,4
la $a0,MsgOpc3
syscall
jal buscar
j main

opc4:
li $v0,4
la $a0,MsgOpc4
syscall
jal atualizar
j main

opc5:
li $v0,4
la $a0,MsgOpc5
syscall
jal exibir
j main


#Encerramento do programa
fim:
li $v0,4
la $a0,MsgFim
syscall

li $v0,10
syscall
