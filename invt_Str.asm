.data

MsgInp: .asciiz "Insira a palavra para inverter: "
MsgOut: .asciiz "A palavra invertida é: "
MsgErro: .asciiz "ERRO! Caractere invalido! Repita "
invert: .space 32
input: .space 32


.text
 j main
  
verify:
	li $s0,0
	laco:
	lb $t0,0($a0)
	beq $t0,10,fimLaco # fim de String
	blt $t0,65,fimLacoE # Fora do intevalo de letras maiusculas  = invalido
	bgt $t0,122,fimLacoE # Fora do intevalo de letras minusculas = invalido
	bgt $t0,90,cond2 #Possivel caractere invalido
	addi $a0,$a0,1
	j laco

	cond2:
	blt $t0,97,fimLacoE # caractere invalido
	addi $a0,$a0,1 #letra minuscula
	j laco

	fimLacoE:
	li $s0,1
	jr $ra

	fimLaco:
	jr $ra

inverter:
	subi $a0,$a0,1
	laco2:
	lb $t0,0($a0)
	beq $t0,0,fimLaco2
	ble $t0,90,mai
	j min
	mai:
	add $t0,$t0,32
	sb $t0,0($a1)
	subi $a0,$a0,1
	addi $a1,$a1,1
	j laco2
	min:
	sub $t0,$t0,32
	sb $t0,0($a1)
	subi $a0,$a0,1
	addi $a1,$a1,1
	j laco2
	fimLaco2:
	jr $ra
	

erro:
li $v0,4
la $a0,MsgErro
syscall

main: 
li $v0,4
la $a0,MsgInp
syscall

li $v0,8
la $a0,input
li $a1,32
syscall


jal verify

beq $s0,1,erro

la $a1,invert
la $a2,invert
jal inverter

li $v0,4
la $a0,MsgOut
syscall

li $v0,4
la $a0,invert
syscall

