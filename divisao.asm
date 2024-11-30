.data

Msg: .asciiz "Div = "
z: .float 0.0
.text
lwc1 $f3,z


li $v0,6
syscall

mov.d $f4,$f0

li $v0,6
syscall

mov.d $f6,$f0

div.d $f12,$f4,$f6

li $v0,4
la $a0,Msg
syscall

li $v0,3
syscall

li $v0,10
syscall