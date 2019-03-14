.data
	v:	.word 444, 2000, 6
	tam:	.word 3
	barra:  .asciiz " / "
	vini:	.asciiz "\nVetor inicial: \n"
	vfin:	.asciiz "\nVetor final: \n"
	
.text
	la $s0, v
	la $s1, tam
	
	#INICIO PRINTF DO VETOR
	la $a0, vini
	li $v0, 4
	syscall
	lw $a0, 0($s0) 	
	li $v0, 1
	syscall
	la $a0, barra
	li $v0, 4
	syscall
	lw $a0, 4($s0) 	
	li $v0, 1
	syscall
	la $a0, barra
	li $v0, 4
	syscall
	lw $a0, 8($s0) 	
	li $v0, 1
	syscall
	#FIM DO PRINTF DO VETOR
	
	lw $t1, 0($s1)
	add $a0, $0, $s0	#a0 recebe o endereço de memória do vetor $s0
	add $a1, $0, $t1
	
	jal organizavetor
	
	#INICIO PRINTF DO VETOR
	la $a0, vfin
	li $v0, 4
	syscall
	lw $a0, 0($s0) 	
	li $v0, 1
	syscall
	la $a0, barra
	li $v0, 4
	syscall
	lw $a0, 4($s0) 	
	li $v0, 1
	syscall
	la $a0, barra
	li $v0, 4
	syscall
	lw $a0, 8($s0) 	
	li $v0, 1
	syscall
	#FIM PRINTF DO VETOR
	
	li $v0, 10 		#fechar o programa
	syscall
#Função de organizar o vetor
organizavetor:
	addi $sp, $sp, -4
	sw $t0, 0($sp)
	
	addi $sp, $sp, -4
	sw $t1, 0($sp)
	
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	
	add $t0, $0, $0
	add $t1, $0, $0
	addi $t2, $0, 1		#$t2 = CONTADOR de comparar os valores do vetor
	addi $t3, $0, 1		#$t3 = CONTADOR da quantidade de vezes que teremos que passar no vetor

#Função de iniciar o loop do bubble sort
ini_loop:	
	beq $t2, $a1, fim_loop	#se $t2 = $a1, vai pro fim
		j trocapos

#Função de comparar uma posição com sua sucessora
trocapos:	
	lw $t0, 0($a0) 		#$t0 = v[0]
	lw $t1, 4($a0) 		#$t1 = v[0]
	blt $t1, $t0, trocavalor
	addi $a0, $a0, 4	#$a0 += 4 // Endereço = endereço + 4 (avança uma posição do vetor)
	addi $t2, $t2, 1	#$t2++
		j ini_loop

#Função de trocar o valor caso a posição de vetor sucessora seja maior que a antecessora
trocavalor:
	sw $t0, 4($a0)		#v[0] = v[1]
	sw $t1, 0($a0)		#v[1] = v[0]
	addi $a0, $a0, 4	#$a0 += 4 // Endereço = endereço + 4 (avança uma posição do vetor)
	addi $t2, $t2, 1	#$t2++
		j ini_loop

#Função de resetar os valores para fazer todas as passagens pro vetor, pois no bubble sort deve comparar os valores do vetor a quantidade de vezes do tamanho do vetor	
resetacontador:
	addi $t2, $0, 1		#resetando o contador $t2
	add $a0, $0, $s0	#resetando o endereço de memória
	add $t3, $t3, 1		#$t3++	
		j ini_loop

#Função de comparar se o vetor foi conferido na quantidade de vezes do seu tamanho
fim_loop:
	beq $t3, $a1, end	#se $t3 = $a1, vai pro fim
		j resetacontador	
	
#Aqui é realmente quando acaba o bubblesort
end:	
	#DESALOCANDO / o ultimo que eu aloquei deve ser o primeiro a ser desalocado
	sw $t2, 0($sp)
	addi $sp, $sp, 4
	
	sw $t1, 0($sp)
	addi $sp, $sp, 4
	
	sw $t0, 0($sp)
	addi $sp, $sp, 4
	
	#return to main
	jr $ra
