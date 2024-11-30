# N1 >= N2 ?
bge $t0,$t1,possibilidade1
j possibilidade2

#N1 >= N3 ?
possibilidade1:
bge $t0,$t2,N1Maior #N1>=N2 e N1>=N3 -> N1 = MAIOR

#N1 >= N2, mas N1 < N3 -> Portanto, N3>N1>N2
move $t3,$t2 
move $t4,$t0
move $t5,$t1
j resultados #Assim como nas linhas idênticas a essa, pula para a exibição dos resultados.

#N1 = MAIOR
N1Maior:
move $t3,$t0
j possibilidade2 

#N2 >= N3 ?
possibilidade2:
beq $t0,$t3,possibilidade5 # N1 = MAIOR ? -> Essa label possibilidade2 é lida sendo N1 o maior ou não.
bge $t1,$t2,possibilidade3 # N1 < N2, mas N2>=N3

#N1 < N2 e N2 < N3 -> N3>N2>N1
move $t3,$t2
move $t4,$t1
move $t5,$t0
j resultados 	

#N2 = MAIOR, mas N1 >= N3 ?
possibilidade3:
move $t3,$t1 # N2 = MAIOR
bge $t0,$t2,possibilidade4 # N1 >= N3 ?

#N2 = MAIOR e N1 < N3 -> Portanto, N2>N3>N1
move $t4,$t2
move $t5,$t0
j resultados

#N1 = MAIOR, mas N2 >= N3 ?
possibilidade4:
bge $t1,$t2,possibilidade6 # N2 >= N3

#N1 = MAIOR e N2 < N3, N1>N3>N2
move $t4,$t2
move $t5,$t1
j resultados

# N1>N2>N3
possibilidade5:
move $t4,$t1
move $t5,$t2
j resultados

#N1>N3>N2
possibilidade6:
move $t4,$t2
move $t5,$t1
