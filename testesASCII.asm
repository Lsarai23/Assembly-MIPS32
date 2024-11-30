.data 
input: .space 32

.text

li $t1,1

li $v0,8
la $a0,input
li $a1,32
syscall

la $a0,input
lb $t0,0($a0)
li $v0,1
move $a0,$t0
syscall
