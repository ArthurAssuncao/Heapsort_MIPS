#HEAPSORT
.data
vetor: .word 63, 9, 85, 66, 71
.text
la $a0, vetor #2
addi $a1, $zero, 5 #tam #2

subi $sp, $sp, 4 #8
sw $ra, 0($sp) #10
jal HEAPSORT #6
lw $ra, 0($sp) #10
addi $sp, $sp, 4 #2

li $v0, 10 #syscall 10 (terminate)
syscall

# void heapsort(int* vetor, int tam)
.globl HEAPSORT
HEAPSORT:
  #la $a0, vetor
  subi $sp, $sp, 8 #8
  sw $a1, 0($sp) #10
  sw $ra, 4($sp) #10
  subi $a1, $a1, 1 #tam-1 #8
  jal CONSTROI #6
  lw $a1, 0($sp) #10
  lw $ra, 4($sp) #10
  addi $sp, $sp, 8 #2
  li $s0, 0 #esq #2
  subi $s1, $a1, 1 #dir = tam-1 #2
  H_WHILE:
    slt $t0, $zero, $s1 #0 < dir #8*5
    beq $t0, $zero, EXIT_H_WHILE #6*5
      lw $t0, 0($a0) #aux = vetor[0] #2*4
      sll $t1, $s1, 2 # dir * 4 #8*4
      add $t1, $a0, $t1 #vetor[dir] #8*4
      lw $t2, 0($t1) #10*4
      sw $t2, 0($a0) #vetor[0] = vetor[dir]; #2*4
      sw $t0, 0($t1) #vetor[dir] = aux; #2*4
      subi $s1, $s1, 1 #2*4

      #la $a0, vetor
      subi $sp, $sp, 8 #8*4
      sw $a1, 0($sp) #10*4
      sw $ra, 4($sp) #2*4
      add $a1, $s0, $zero #2*4
      add $a2, $s1, $zero #8*4
      jal REFAZ #6*4
      lw $a1, 0($sp) #10*4
      lw $ra, 4($sp) #10*4
      addi $sp, $sp, 8 #8*4
      j H_WHILE #6*5
  EXIT_H_WHILE:
  add $v0, $zero, $a0 #8
  jr $ra #6


# void constroi(int* vetor, int tam)
.globl CONSTROI
CONSTROI:
  sra $s2, $a1, 1 #div 2 #esq #8
  addi $s2, $s2, 1 #8
  C_WHILE:
    slt $t0, $zero, $s2 # 0 < esq #8*4
    beq $t0, $zero, EXIT_C_WHILE #6*4
      subi $s2, $s2, 1 #2*3
      subi $sp, $sp, 8 #8*3
      sw $a1, 0($sp) #10*3
      sw $ra, 4($sp) #2*3
      add $a2, $a1, $zero #2*3
      add $a1, $s2, $zero #8*3
      jal REFAZ #6*3
      lw $a1, 0($sp) #10*3
      lw $ra, 4($sp) #10*3
      addi $sp, $sp, 8 #8*3
      j C_WHILE #6*4
  EXIT_C_WHILE:
  add $v0, $zero, $a0 #8
  jr $ra #6


# void refaz(int* vetor, int esq, int dir)
.globl REFAZ
REFAZ:
  add $s3, $zero, $a1 #i = esq #8*7
  sll $s4, $s3, 1 #j = i * 2 #2*7

  sll $t0, $s3, 2 #vetor[i] #8*7
  add $t0, $t0, $a0 #vetor[i] #8*7
  lw $s5, 0($t0) #x = vetor[i] #2*7

  R_WHILE:
    slt $t0, $a2, $s4 #dir < j #8*13
    bne $t0, $zero, EXIT_R_WHILE #j <= dir #6*13
      slt $t0, $s4, $a2 #j < dir #8*12
      beq $t0, $zero, EXIT_R_IF_1 #j < dir #6*12
        sll $t1, $s4, 2 #vetor[j] #8*7
        add $t1, $t1, $a0 #vetor[j] #8*7
        lw $t1, 0($t1) #vetor[j] #2*7

        addi $t2, $s4, 1 #8*7
        sll $t2, $t2, 2 #vetor[j+1] #8*7
        add $t2, $t2, $a0 #vetor[j+1] #8*7
        lw $t2, 0($t2) #vetor[j+1] #10*7

        slt $t0, $t1, $t2 #vetor[j] < vetor[j+1] #8*7
        beq $t0, $zero, EXIT_R_IF_1_1 #vetor[j] < vetor[j+1] #6*7
          addi $s4, $s4, 1 #j++ #8*5
        EXIT_R_IF_1_1:
      EXIT_R_IF_1:
    sll $t1, $s4, 2 #vetor[j] #8*12
    add $t1, $t1, $a0 #vetor[j] #8*12
    lw $t1, 0($t1) #vetor[j] #10*12
    slt $t0, $s5, $t1 #x < vetor[j] #8*12
    beq $t0, $zero, EXIT_R_WHILE #x >= vetor[j] #6*12
    sll $t0, $s3, 2 #vetor[i] #8*9
    add $t0, $t0, $a0 #vetor[i] #8*9
    sw $t1, 0($t0) #vetor[i] = vetor[j] #2*9
    add $s3, $zero, $s4 #i=j #8*9
    sll $s4, $s3, 1 #j=i*2 #8*9
    j R_WHILE #6*9
  EXIT_R_WHILE:
  sll $t0, $s3, 2 #vetor[i] #8*7
  add $t0, $t0, $a0 #vetor[i] #8*7
  sw $s5, 0($t0) #vetor[i] = x #2*7

  add $v0, $zero, $a0 #8*7
  jr $ra #6*7