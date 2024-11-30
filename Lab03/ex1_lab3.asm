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
vetor: .space 40

MsgMenu: .asciiz "\n\n***MENU INTERATIVO***\n1. Preencher o vetor\n2. Informações sobre o vetor\n3. Sair\n Opção: "
MsgErroOpc: .asciiz "Opção inválida! Repita.\n"
MsgEl: .asciiz "Elemento: "
MsgErroEl: .asciiz "Vetor não preenchido! Repita.\n"
MsgMax: .asciiz "\nMaior: "
MsgMin: .asciiz "\nMenor: "
MsgPar: .asciiz "\nQtd. Pares: "
MsgImp: .asciiz "\nQtd. Impares: "
MsgOrd: .asciiz "\nVetor ordenado: "
MsgSep: .asciiz "; "




.text# Segmento de texto, onde são armazenadas as instruções

#Registradores:
# $t1: loop2 = índice 'i' / loop3 = v[i]
# $t2: loop2 = menor valor / loop3 = v[i+1]
# $t3 = maior valor
# $t4: loop2 = v[i]
# $s0: loop2 = contador par / loop3 = índice 'i'
# $s1: loop2 = contador impar/ loop3 = índice 'j'
# $s2 = verificado par/impar
# $s3 = divisor 2
# $s4 = auxiliar (troca)
# $s5 = sentinela

j main

#Funções do programa
preencher:
	la $t0, vetor #v[0]
	li $t1,0 # i=0

	lp:
		beq $t1,10,fLp

		#Ler valor
		li $v0,4
		la $a0,MsgEl
		syscall
		
		
		li $v0,5
		syscall

		#Armazenar
		sw $v0,0($t0)

		#Atualizar
		addi $t0,$t0,4

		#i++
		addi $t1,$t1,1
		j lp

	fLp:
		jr $ra

info:
	li $t1,0 # i =1
	li $s3,2 # divisor 2
	li $s0,0 # Contador impar
	li $s1,0 # Contador par
	la $t0,vetor # v[0]
	lw $t2,($t0) # t2 = v[0] -> min
	lw $t3,($t0) # t3 = v[0] -> max

	lp2:
		beq $t1,10,fLp2

		lw $t4,($t0) # t4 = v[1]

		blt $t4,$t2,trocarMin # novo min
		bgt $t4,$t3,trocarMax # novo max
		voltar:
		#par ou impar
		divu $t4,$s3
		mfhi $s2# resto 0 ou 1
		beq $s2,$zero,par
		addi $s1,$s1,1 # aumenta contador de impares
		voltar2:
		addi $t0,$t0,4 # Atualizar endereço
		addi $t1,$t1,1 # ++i
		j lp2

	trocarMin:
		move $t2,$t4 # Novo valor menor
		j voltar

	trocarMax:
		move $t3,$t4 # Novo maior valor
		j voltar

	par:
		addi $s0,$s0,1 # Aumenta contador de pares
		j voltar2
	fLp2:
	#Exibe os valores
	
	#Maior valor
	li $v0,4
	la $a0,MsgMax
	syscall
	
	
	li $v0,1
	move $a0,$t3
	syscall
	
	#Menor valor
	li $v0,4
	la $a0,MsgMin
	syscall
	
	li $v0,1
	move $a0,$t2
	syscall
	
	#Contagem de pares
	li $v0,4
	la $a0,MsgPar
	syscall
	
	li $v0,1
	move $a0,$s0
	syscall
	
	#Contagem de impares
	li $v0,4
	la $a0,MsgImp
	syscall
	
	li $v0,1
	move $a0,$s1
	syscall
	
	#Mensagem inicial do vetor
	li $v0,4
	la $a0,MsgOrd
	syscall
	
	li $s0,0 # i = 0
	li $s5,1 # Sentinela
	
	j lp3
	
	#Troca dois valores consecutivos de posição
	troca:
	move $s4,$t1 # aux = a
	move $t1,$t2 # a = b
	move $t2,$s4 # b = aux
	sw $t1,($t0) # Armazena a
	sw $t2,4($t0) # Armazena b
	li $s5,1 # Sentinela = 1
	j voltar3
	
	#Ordenação: Bubble sort
	lp3:
		beq $s0,10,flp3
		beq $s5,0,flp3
		li $s5,0 # Sentinela = 0 
		li $s1,0 # j = 0
		la $t0, vetor # endereço de v[i]
		lw $t1,($t0) # valor de v[i]
		lw $t2,4($t0)# valor de v[i+1]
		lp4:
			beq $s1,9,flp4
			bgt $t1,$t2,troca
			voltar3:
			
			addi $t0,$t0,4 #endereço de v[i+1]
			lw $t1,($t0) # valor de v[i+1]
			lw $t2, 4($t0) # valor de v[i+2]
			addi $s1,$s1,1 # ++j
			j lp4
		flp4:
		addi $s0,$s0,1 # ++i
		j lp3
	flp3:
	la $t0,vetor # endereço de v[0]
	li $t1,0 # i = 0
	
	#Exibir o vetor ordenado
	lpExibir:
   		lw $t2, ($t0)       # Carrega o próximo elemento do vetor
   		
   		#Exibe o valor
    		li $v0, 1           
   		move $a0, $t2      
    		syscall           

   		addi $t1, $t1, 1    # ++i
   		addi $t0,$t0,4
  		blt $t1, 10, separar  # Se não for o último elemento, imprime separador

    	j flpExibir

	separar:
		# Imprime separador
   		 li $v0, 4           
   		 la $a0, MsgSep      
   		 syscall         
   		 j lpExibir

	flpExibir:
	jr $ra

#Opção inválida
erroOpc:
li $v0,4
la $a0,MsgErroOpc
syscall
j main

#Pular opção 1 e ir na opção 2
erroEl:
li $v0,4
la $a0,MsgErroEl
syscall


main:
#Menu
li $v0,4
la $a0,MsgMenu
syscall

#Opção escolhida
li $v0,5
syscall

#Analisa a opção
beq $v0,3,fim
beq $v0,1,opc1
beq $v0,2,verifyop2
j erroOpc

#Para a opção 2, deve verificar se já passou pela opção 1 -> $t6 = 1 (V)
verifyop2:
beq $t6,1,opc2
j erroEl

opc1:
li $t6,1
jal preencher
j main

opc2:
jal info
j main

#Fim do programa
fim:
li $v0,10
syscall
