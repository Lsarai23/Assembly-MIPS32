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

.data # Segmento de dados, onde são inicializadas as variáveis

MsgMenu: .asciiz "\n***** SISTEMA DE CONTROLE DE ESTOQUE *****\n 1.Inserir um novo item no estoque\n 2.Excluir um item do estoque\n 3.Buscar um item pelo código\n 4.Atualizar quantidade em estoque\n 5.Imprimir os produtos em estoque\n 6.Sair\nOpção: "
MsgErroOpc: .asciiz "Opção inválida!Repita.\n"

MsgCod: .asciiz "\nPasse o código do item: "
MsgErroCod: .asciiz "Produto não encontrado.\n\n"
MsgErroCodRep: .asciiz "Código já cadastrado!  Use outro código.\n\n"

MsgQtd: .asciiz "Passe a quantidade do produto: "
MsgErroQtd: .asciiz "Quantidade inválida. Repita!\n\n"

MsgListaVazia: .asciiz "\nNão há produtos.\n"

MsgOpc1: .asciiz "\n***** INSERIR PRODUTO *****\n"
MsgOpc2: .asciiz "\n***** EXCLUIR PRODUTO *****\n"
MsgOpc3: .asciiz "\n***** BUSCAR PRODUTO *****\n"
MsgOpc4: .asciiz "\n***** ATUALIZAR PRODUTO *****\n"
MsgOpc5: .asciiz "\n***** EXIBIR PRODUTOS *****"

MsgProdCod: .asciiz "\n\nCódigo = "
MsgProdQtd: .asciiz "\nQuantidade em Estoque = "
MsgProdEstoqueS: .asciiz "\nEstá em estoque!\n"
MsgProdEstoqueN: .asciiz "Fora de estoque!\n"

MsgFim: .asciiz "\nFim do programa."

.text # Segmento de texto, onde se armazena as instruções

# Registradores:
# $t0 = código a armazenar
# $t1 = quantidade
# $t2 = código a procurar
# $s0 = endereço de Head.código
# $s1 = endereço do código de um Nó
# $s2 = endereço do bloco next do nó anterior
# $s3 = opção escolhida
# $s4 = endereço de saída da função

j main

#Funções do programa
inserir:
	move $s4,$ra # Salvando o endereço de saída da função
	jal buscar # Buscando o código para ver se não é repetido
	move $ra,$s4 # Devolvendo o endereço correto de saída da função
	
	beq $v0,1,erroCodRep # Caso o código passado já esteja cadastrado
	
	#Caso seja um código não repetido, armazena-o
	move $t0,$t2

	#Recebendo a quantidade
	li $v0,4
	la $a0,MsgQtd
	syscall

	li $v0,5
	syscall

	move $t1,$v0

	#Alocando memória para o Nó
	li $v0,9
	la $a0,12
	syscall

	beq $s0,$zero,listaVazia
	move $s1,$v0 # Armazenando o endereço inicial do Nó
	sw $s1, ($s2) #Armazenando o endereço inicial em "Next" do Nó anterior

	sw $t0,($s1) # Armazenando o código
	sw $t1,4($s1) # Armazenando a quantidade

	addi $s2, $s1, 8 # Armazenando o endereço do bloco Next
	j fimInserir

	listaVazia:
		move $s0,$v0 # Armazenando e endereço inicial de Head
		sw $t0,($s0) # Armazenando o código
		sw $t1,4($s0) # Armazenando a quantidade
		addi $s2,$s0,8 # Armazenando o endereço do bloco Next

	fimInserir:
		jr $ra

excluir:
	move $s4,$ra # Armazenando o local(endereço de instrução) de saída da função em "main"
	jal buscar
	move $ra,$s4 # Devolvendo para $ra o local de saída em "main"
	
	beq $v0,1,fimExcluir # Se existir o produto
	jr $ra # Se não existir

	fimExcluir:
		sw $zero,($s1) #Zerando o código do produto excluído
		lw $s1,8($s1) # Recebendo o endereço inicial do próximo Nó
		#Rompendo as conexões ao Nó excluído
		sw $s1,($s2) # Conectando o Nó anterior ao excluído ao próximo Nó
		
		
		jr $ra
		
buscar:
	#Recebendo o código do produto procurado
	li $v0,4
	la $a0,MsgCod
	syscall

	li $v0,5
	syscall
	
	move $t2,$v0 # Armazenando o código a procurar
	
	# Lista vazia (head = 0 = null)
	beq $s0,0,naoExiste 

	move $s1, $s0 # Recebendo o endereço inicial de Head
	lw $t0, ($s1) # Recebendo o primeiro código

	loop:
		beq $t0,$t2,encontrado
		
		addi $s2,$s1,8 # Recebendo o endereço do bloco Next do Nó atual
		lw $s1, ($s2) # Recebendo o endereço inicial do próximo Nó (possível Nó procurado)
		
		beq $s1,$zero,naoExiste
		
		lw $t0, ($s1) # Recebendo o próximo código (possível código procurado)

		j loop

	naoExiste:
		beq $s3,1,retornarCod # Para a opção 1, não exibe a mensagem, mas retorna também o código
		li $v0,4
		la $a0,MsgErroCod
		syscall
		j retornoFalso # Opções 2,3 e 4 não precisa retornar o código
		
		retornarCod:
			move $v1,$t2 # Opção 1: Retornar o código
		
		retornoFalso:
			li $v0,0 # Retorno Falso
			j fimBuscar1

	encontrado:
	
		li $v0,1 # Retorno verdadeiro
	
	fimBuscar1:
		beq $s3,3,fimBuscar2 # Se a opção escolhida era 3, precisa exibir o produto procurado
		jr $ra # Caso contrário, só retornar o valor booleano
		
	fimBuscar2:
		beq $v0,1,emEstoque
		
		#Exibindo que não está em estoque.
		li $v0,4
		la $a0,MsgProdEstoqueN
		syscall
		
		jr $ra
		
		emEstoque:
			#Exibindo que está em estoque
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
	move $s4,$ra # Armazenando o local(endereço de instrução) de saída da função em "main"
	jal buscar
	move $ra,$s4 # Devolvendo para $ra o local de saída em "main"
	
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
	move $s1,$s0 #Armazena o endereço inicial de Head

	loopEx:
		beq $s1,$zero,fimLpEx

		#Exibe o código
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

		#Passa para o próximo nó
		lw $s1,8($s1)

		j loopEx

	fimLpEx:
		jr $ra
		
#Erro de código repetido
erroCodRep:
li $v0,4
la $a0,MsgErroCodRep
syscall
j inserir


#Opção inválida
erroOpc:
li $v0,4
la $a0,MsgErroOpc
syscall
j main


#Quantidade inválida
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

move $s3,$v0 # Armazenando opção escolhida

beq $s3,6,fim # Opção de saída

#Tratamento de entrada: opção
blt $s3,1,erroOpc
bgt $s3,6,erroOpc

#Opções válidas
beq $s3,1,opc1
beq $s3,2,opc2
beq $s3,3,opc3
beq $s3,4,opc4
beq $s3,5,opc5

#Para cada caso, chama-se a função apropriada
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
