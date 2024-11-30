.data

N1: .asciiz "n1: "
N2: .asciiz "n2: "
MsgSoma: .asciiz "\nSoma = "
MsgSub: .asciiz "\nSubtracao = "
MsgMul: .asciiz "\nMultiplicacao = "
MsgDiv: .asciiz "\nDivisao = "

.text

#N1
li $v0,4
la $a0,N1
syscall

li $v0,5
syscall

move $t0,$v0

#N2
li $v0,4
la $a0,N2
syscall

li $v0,5
syscall

move $t1,$v0

#Soma

add $t2, $t1, $t0

li $v0,4
la $a0,MsgSoma
syscall


li $v0,1
move $a0,$t2
syscall

#Sub

sub $t2, $t0, $t1

li $v0,4
la $a0,MsgSub
syscall


li $v0,1
move $a0,$t2
syscall

#Mul

mul $t2,$t1,$t0

li $v0,4
la $a0,MsgMul
syscall

li $v0, 1
move $a0,$t2
syscall

#Div

div $t2, $t0, $t1

li $v0,4
la $a0,MsgDiv
syscall

li $v0, 1
move $a0,$t2
syscall

#Encerramento
li $v0,10
syscall
