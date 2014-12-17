#HEAPSORT
.data
vetor: .word 63, 9, 85, 66, 71
.text
addi $a1, $zero, 5 #tam #2
la $a0, vetor #2
#comeca o HEAPSORT
#la $a0, vetor
  subi $t0, $a1, 1 #tam-1 #8
  #comeco do Controi
  sra $s2, $t0, 1 #div 2 #esq #8
  addi $s2, $s2, 1 #8
  C_WHILE:
    slt $t0, $zero, $s2 # 0 < esq #8*4
    beq $t0, $zero, EXIT_C_WHILE #6*4
      subi $s2, $s2, 1 #2*3
      add $t6, $s2, $zero #2*3
      add $t5, $a1, $zero #2*3
      
      #comeca o REFAZ
      add $s3, $zero, $t6 #i = esq #2*3
      sll $s4, $t6, 1 #j = i * 2 #2*3

      sll $t0, $s3, 2 #vetor[i] #8*3
      add $t0, $t0, $a0 #vetor[i] #8*3
      lw $s5, 0($t0) #x = vetor[i] #2*3

      C_R_WHILE:
        slt $t1, $t5, $s4 #dir < j #8*7
        bne $t1, $zero, EXIT_C_R_WHILE #j <= dir #6*7
          slt $t3, $s4, $t5 #j < dir #8*6
          beq $t3, $zero, EXIT_C_R_IF_1 #j < dir #6*6
            sll $t1, $s4, 2 #vetor[j] #2*3
            addi $t2, $s4, 1 #2*3
            add $t1, $t1, $a0 #vetor[j] #2*3
            sll $t2, $t2, 2 #vetor[j+1] #2*3
            lw $t1, 0($t1) #vetor[j] #2*3     
            add $t2, $t2, $a0 #vetor[j+1] #8*3
            lw $t2, 0($t2) #vetor[j+1] #10*3

            slt $t0, $t1, $t2 #vetor[j] < vetor[j+1] #8*3
            beq $t0, $zero, EXIT_C_R_IF_1_1 #vetor[j] < vetor[j+1] #6*3
              addi $s4, $s4, 1 #j++ #8*1
            EXIT_C_R_IF_1_1:
          EXIT_C_R_IF_1:
        sll $t1, $s4, 2 #vetor[j] #8*7
        add $t1, $t1, $a0 #vetor[j] #8*7
        lw $t1, 0($t1) #vetor[j] #10*7
        slt $t0, $s5, $t1 #x < vetor[j] #8*7
        beq $t0, $zero, EXIT_C_R_WHILE #x >= vetor[j] #6*7
        sll $t0, $s3, 2 #vetor[i] #8*4
        add $t0, $t0, $a0 #vetor[i] #8*4
        sw $t1, 0($t0) #vetor[i] = vetor[j] #2*4
        add $s3, $zero, $s4 #i=j #8*4
        sll $s4, $s3, 1 #j=i*2 #8*4
        j C_R_WHILE #6*8
      EXIT_C_R_WHILE:
      sll $t0, $s3, 2 #vetor[i] #8*7
      add $t0, $t0, $a0 #vetor[i] #8*7
      sw $s5, 0($t0) #vetor[i] = x #2*7
      #termina o REFAZ

  j C_WHILE #6*4
  EXIT_C_WHILE:
  #fim Controi
  li $s0, 0 #esq #2
  subi $s1, $a1, 1 #dir = tam-1 #2
  H_WHILE:
    slt $t0, $zero, $s1 #0 < dir #8*5
    beq $t0, $zero, EXIT_H_WHILE #6*5
      lw $t3, 0($a0) #aux = vetor[0] #2*4
      sll $t1, $s1, 2 # dir * 4 #2*4
      subi $s1, $s1, 1 #2*4
      add $t1, $a0, $t1 #vetor[dir] #8*4
      lw $t2, 0($t1) #10*4

      #la $a0, vetor
      sw $t2, 0($a0) #vetor[0] = vetor[dir]; #2*4
      sw $t3, 0($t1) #vetor[dir] = aux; #2*4
      add $t5, $s0, $zero #2*4
      add $t6, $s1, $zero #2*4
      #comeca o REFAZ
      add $s3, $zero, $t5 #i = esq #2*4
      sll $s4, $t5, 1 #j = i * 2 #2*4

      sll $t0, $s3, 2 #vetor[i] #8*4
      add $t0, $t0, $a0 #vetor[i] #8*4
      lw $s5, 0($t0) #x = vetor[i] #2*4

      R_WHILE:
        slt $t0, $t6, $s4 #dir < j #8*7
        bne $t0, $zero, EXIT_R_WHILE #j <= dir #6*7
          slt $t3, $s4, $t6 #j < dir #8*6
          beq $t3, $zero, EXIT_R_IF_1 #j < dir #6*6
            sll $t1, $s4, 2 #vetor[j] #2*4
            addi $t2, $s4, 1 #2*4
            add $t1, $t1, $a0 #vetor[j] #2*4
            sll $t2, $t2, 2 #vetor[j+1] #2*4
            lw $t1, 0($t1) #vetor[j] #2*4     
            add $t2, $t2, $a0 #vetor[j+1] #8*4
            lw $t2, 0($t2) #vetor[j+1] #10*4

            slt $t0, $t1, $t2 #vetor[j] < vetor[j+1] #8*4
            beq $t0, $zero, EXIT_R_IF_1_1 #vetor[j] < vetor[j+1] #6*4
              addi $s4, $s4, 1 #j++ #8*4
            EXIT_R_IF_1_1:
          EXIT_R_IF_1:
        sll $t1, $s4, 2 #vetor[j] #8*6
        add $t1, $t1, $a0 #vetor[j] #8*6
        lw $t1, 0($t1) #vetor[j] #10*6
        slt $t0, $s5, $t1 #x < vetor[j] #8*6
        beq $t0, $zero, EXIT_R_WHILE #x >= vetor[j] #6*6
        sll $t0, $s3, 2 #vetor[i] #8*5
        add $t0, $t0, $a0 #vetor[i] #8*5
        sw $t1, 0($t0) #vetor[i] = vetor[j] #2*5
        add $s3, $zero, $s4 #i=j #8*5
        sll $s4, $s3, 1 #j=i*2 #8*5
        j R_WHILE #6*5
      EXIT_R_WHILE:
      sll $t0, $s3, 2 #vetor[i] #8*4
      add $t0, $t0, $a0 #vetor[i] #8*4
      sw $s5, 0($t0) #vetor[i] = x #8*4
      #termina o REFAZ
  j H_WHILE #6*5
  EXIT_H_WHILE:
#fim do HEAPSORT

li $v0, 10 #syscall 10 (terminate)
syscall