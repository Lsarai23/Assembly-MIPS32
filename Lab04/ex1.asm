# INTEGRANTES 
#
# Nome: ENZO RIBEIRO	                RA: 10418262
# Nome: GABRIEL KEN KAZAMA GERONAZZO    RA: 10418247
# Nome: LUCAS PIRES DE CAMARGO SARAI	RA: 10418013
# Nome: LUCAS ZANINI                    RA: 10417361
#
# TURMA: 03D11
# ORGANIZACAO DE COMP.
# PROF. DR. JEAN M. LAINE


.data  # Segmento de dados, onde são inicializadas as variáveis
MsgInp: .asciiz "Insira o valor do raio, em Km: "
MsgErro: .asciiz "ERRO: Raio deve ser > 0(Km)! Repita.\n\n"
MsgInfo: .asciiz "***** Infomraïcoes sobre o satelite *****\n"
MsgVel: .asciiz "  Velocidade (Km/seg):  "
MsgRaio: .asciiz "\n  Raio (Km):  "
MsgT: .asciiz "\n  Periodo da orbita (seg):  "
MsgFimInfo: "\n****************************************"

g: .float 6.674
m: .float 5.972
pi: .float 3.14159265
zero: .float 0.0
resultPot10: .float 100.0
.text # Segmento de texto, onde se armazena as instruções

# Regs:
# $t0 = aux. de $f16
# $f0 = Raio lido
# $f2 = velocidade calculada
# $f4 = perioodo (T) calculado
# $f6 = G
# $f8 = M
# $f10 = GM
# $f14 = constante Pi
# $f16 = 4.0f -> constante na formula do periodo
# $f18 = r^3
# $f20 = 0.0f -> valor de validacao
# $f22 = 100.0f -> resultado das potencias de 10

j main

# Validacao para evitar entradas negativas
erroR:
li $v0,4
la $a0,MsgErro
syscall
j input

# Execucao principal do programa
main:

l.s $f6,g # G = 6.674 (10^11 nao eh armazenado)
l.s $f8,m # M = 5.972 (10^24 nao eh armazenado)
l.s $f14,pi # pi = 3.14159265 aprox.

#Valor 4.0 constante do período
li $t0,4 # Recebe como inteiro
mtc1 $t0,$f16 # Passa para o Coproc 1
cvt.s.w $f16,$f16 # Convert para float

l.s $f20,zero # Zero em float
l.s $f22, resultPot10 # Valor 100 resultante do calculo com as potencias de 10
mul.s $f10,$f6,$f8 # GM -> produto muito utilizado nas contas

#Solicitando valor
input:
li $v0,4
la $a0,MsgInp
syscall

li $v0,6
syscall

# Validar se entrada nao eh negativa
c.le.s $f0,$f20
bc1t erroR


#Exibindo mensagenm inicial 
li $v0,4
la $a0,MsgInfo
syscall

#Calculando velocidade orbital
div.s $f12,$f10,$f0
sqrt.s $f12,$f12
mul.s $f12,$f12,$f22 # Multiplicando pelo valor 100

#Exibindo resultado
li $v0,4
la $a0,MsgVel
syscall

li $v0,2
syscall

#Exibindo raio recebido
li $v0,4
la $a0,MsgRaio
syscall

li $v0,2
mov.s $f12,$f0
syscall

#Calculando o periodo 
li $v0,4
la $a0,MsgT
syscall

#Armazenando r^3
mul.s $f18,$f0,$f0
mul.s $f18,$f18,$f0

#Armazenando pi^2
mul.s $f14,$f14,$f14

#Calculando forrmula
mul.s $f4, $f16,$f14
mul.s $f4, $f4, $f18
div.s $f4, $f4, $f10
sqrt.s $f12,$f4
div.s $f12,$f12,$f22 # Dividindo pelo valor 100

# Exibindo resultado
li $v0,2
syscall

#Eixbindo mensagem do final
li $v0,4
la $a0,MsgFimInfo
syscall

#Encerrando
li $v0,10
syscall





