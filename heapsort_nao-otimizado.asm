#HEAPSORT
.data
vetor: .word 63, 9, 85, 66, 71
.text
la $a0, vetor
addi $a1, $zero, 5 #tam

subi $sp, $sp, 4
sw $ra, 0($sp)
jal HEAPSORT
lw $ra, 0($sp)
addi $sp, $sp, 4

li $v0, 10 #syscall 10 (terminate)
syscall

# void heapsort(int* vetor, int tam)
.globl HEAPSORT
HEAPSORT:
  #la $a0, vetor
  subi $sp, $sp, 8
  sw $a1, 0($sp)
  sw $ra, 4($sp)
  subi $a1, $a1, 1 #tam-1
  jal CONSTROI
  lw $a1, 0($sp)
  lw $ra, 4($sp)
  addi $sp, $sp, 8
  li $s0, 0 #esq
  subi $s1, $a1, 1 #dir = tam-1
  H_WHILE:
    slt $t0, $zero, $s1 #0 < dir
    beq $t0, $zero, EXIT_H_WHILE
      lw $t0, 0($a0) #aux = vetor[0]
      sll $t1, $s1, 2 # dir * 4
      add $t1, $a0, $t1 #vetor[dir]
      lw $t2, 0($t1)
      sw $t2, 0($a0) #vetor[0] = vetor[dir];
      sw $t0, 0($t1) #vetor[dir] = aux;
      subi $s1, $s1, 1

      #la $a0, vetor
      subi $sp, $sp, 8
      sw $a1, 0($sp)
      sw $ra, 4($sp)
      add $a1, $s0, $zero
      add $a2, $s1, $zero
      jal REFAZ
      lw $a1, 0($sp)
      lw $ra, 4($sp)
      addi $sp, $sp, 8
    j H_WHILE
  EXIT_H_WHILE:
  add $v0, $zero, $a0
  jr $ra


# void constroi(int* vetor, int tam)
.globl CONSTROI
CONSTROI:
  sra $s2, $a1, 1 #div 2 #esq
  addi $s2, $s2, 1
  C_WHILE:
    slt $t0, $zero, $s2 # 0 < esq
    beq $t0, $zero, EXIT_C_WHILE
      subi $s2, $s2, 1
      subi $sp, $sp, 8
      sw $a1, 0($sp)
      sw $ra, 4($sp)
      add $a2, $a1, $zero
      add $a1, $s2, $zero
      jal REFAZ
      lw $a1, 0($sp)
      lw $ra, 4($sp)
      addi $sp, $sp, 8
    j C_WHILE
  EXIT_C_WHILE:
  add $v0, $zero, $a0
  jr $ra


# void refaz(int* vetor, int esq, int dir)
.globl REFAZ
REFAZ:
  add $s3, $zero, $a1 #i = esq
  sll $s4, $s3, 1 #j = i * 2

  sll $t0, $s3, 2 #vetor[i]
  add $t0, $t0, $a0 #vetor[i]
  lw $s5, 0($t0) #x = vetor[i]

  #codigo abaixo executa N vezes
  R_WHILE:
    slt $t0, $a2, $s4 #dir < j 
    bne $t0, $zero, EXIT_R_WHILE #j <= dir
      slt $t0, $s4, $a2 #j < dir
      beq $t0, $zero, EXIT_R_IF_1 #j < dir
        sll $t1, $s4, 2 #vetor[j]
        add $t1, $t1, $a0 #vetor[j]
        lw $t1, 0($t1) #vetor[j]

        addi $t2, $s4, 1
        sll $t2, $t2, 2 #vetor[j+1]
        add $t2, $t2, $a0 #vetor[j+1]
        lw $t2, 0($t2) #vetor[j+1]

        slt $t0, $t1, $t2 #vetor[j] < vetor[j+1]
        beq $t0, $zero, EXIT_R_IF_1_1 #vetor[j] < vetor[j+1]
          addi $s4, $s4, 1 #j++
        EXIT_R_IF_1_1:
      EXIT_R_IF_1:
    sll $t1, $s4, 2 #vetor[j]
    add $t1, $t1, $a0 #vetor[j]
    lw $t1, 0($t1) #vetor[j]
    slt $t0, $s5, $t1 #x < vetor[j]
    beq $t0, $zero, EXIT_R_WHILE #x >= vetor[j]
    sll $t0, $s3, 2 #vetor[i]
    add $t0, $t0, $a0 #vetor[i]
    sw $t1, 0($t0) #vetor[i] = vetor[j]
    add $s3, $zero, $s4 #i=j
    sll $s4, $s3, 1 #j=i*2
    j R_WHILE
  EXIT_R_WHILE:
  sll $t0, $s3, 2 #vetor[i]
  add $t0, $t0, $a0 #vetor[i]
  sw $s5, 0($t0) #vetor[i] = x

  add $v0, $zero, $a0
  jr $ra