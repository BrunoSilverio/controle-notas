.data # indica ao SPIM que as proximas linhas sao dados
msg1: .asciiz "[Projeto 01]-Controle de notas de laboratorio de Arquitetura de Computadores."
msg2: .asciiz "\n 1) Cadastrar Notas\n 2) Alterar Notas.\n 3) Exibir Notas.\n 4) Exibir Media da  Turma.\n 5) Exibir aprovados.\n 0) Sair\n"
msgMenuCadastro:    .asciiz " 1) Atividade 1\n 2) Atividade 2\n 3) Atividade 3\n 4) Atividade 4\n 5) Atividade 5\n 6) Projeto 1\n 7) Projeto 2\n"
msgRA:              .asciiz "\n [Digite os RA's dos 5 alunos]"
msgRAaltera:        .asciiz "\n Digite o RA >> "
msgNota:            .asciiz "\n Digite a nota >> "
msgMedia:           .asciiz "\n Media da Turma : "
msgAprovados:       .asciiz " Aprovado!\n"
msgReprovados:      .asciiz " Reprovado!\n"
msgRAordenador:     .asciiz "\n RA["
msgRAordenador2:    .asciiz "]"
msgdoisPontos:      .asciiz ": "
msgLinha:           .asciiz "\n"
msgSpace:           .asciiz " "
notasCabecalho:     .asciiz "          A1 ,  A2 ,  A3 ,  A4 ,  A5 , P1 , P2 , M\n"
msgAluno:           .asciiz " Aluno "
msgespacoVirgula:   .asciiz ", "
msgContinue:           .asciiz " * Aperte a tecla ENTER para continuar. . . *\n"
msgOpcao:           .asciiz " Opcao >> "
# Array com 5 RA's:    RA1, RA2, RA3, RA4, RA5
arrayRA:        .word    0,0,0,0,0
# Matriz Notas:     ativ1, ativ2, ativ3, ativ4, ativ5, proj1, proj2
mNotas:     .float  0.0,0.0,0.0,0.0,0.0,0.0,0.0, # Aluno 1
                    0.0,0.0,0.0,0.0,0.0,0.0,0.0, # Aluno 2
                    0.0,0.0,0.0,0.0,0.0,0.0,0.0, # Aluno 3
                    0.0,0.0,0.0,0.0,0.0,0.0,0.0, # Aluno 4
                    0.0,0.0,0.0,0.0,0.0,0.0,0.0, # Aluno 5

.text							# indica que as linhas seguintes contem instrucoes
.globl main 					# define o simbolo main como sendo global

main:       					# Main
	la      $s1, arrayRA		# $s1 = arrayRA
    la      $s2, mNotas         # $s2 = mNotas
    addi    $s3, $zero, 5       # $s3 = 5; tamanho do array de RA
    addi    $s4, $zero, 7       # $s4 = 7; tamanho da linha da mNotas

    add     $a1, $zero, $s1     # move $s1 para $a1
    add     $a2, $zero, $s3     # move $s3 para $a2
    jal     inputRA
    
    move    $a0, $s1
    move    $a1, $s3 
    jal     bubble  

    jal     menu

    li      $v0, 10
    syscall
# ================================= Input RAs - recebe 5 RA's ===================================
inputRA:                        
    li      $v0,    4        		    # Print "\n [Digite os RA's dos 5 alunos]"
    la      $a0,    msgRA      	        
    syscall
loopInputRA:
    li      $v0,    4        		    # Print "\n RA["
    la      $a0,    msgRAordenador	        
    syscall
    addi    $t0,    $t1,    1           # Print count para melhor visualizacao    
    move    $a0,    $t0                 # Prepara argumento para print de inteiro (move pra a0)
    li      $v0,    1                   # Codigo syscall para escrever inteiro
    syscall
    li      $v0,    4        		    # Print "]"
    la      $a0,    msgRAordenador2	    
    syscall
    li      $v0,    4        		    # Print ": "
    la      $a0,    msgdoisPontos	        
    syscall
    li      $v0,    5                   # Ler int
    syscall
    sll     $t2,    $t1,    2           # t2 recebe countesima palavra do array
    add     $t2,    $a1,    $t2         # t2 recebe endereco da countesima palavra
    sw      $v0,    0($t2)              # Guarda o valor lido na countesima
    addi    $t1,    $t1,    1           # Count ++
    slt     $t0,    $t1,    $a2         # Count < tamanho?
    bne     $t0,    $zero,  loopInputRA # Count >=, sai
    jr      $ra
# ======================================== BUBBLESORT ==============================================
swap:
    sll     $t1,    $a1,    2       # t1 = j * 4 ==> jtésima palavra do array
    add     $t1,    $a0,    $t1     # t1 recebe endereço de v[j]
    lw      $t0,    0($t1)          # t0 recebe v[j]
    lw      $t2,    4($t1)          # t2 recebe v[j+1]
    sw      $t2,    0($t1)          # v[j] recebe t2 (v[j+1])
    sw      $t0,    4($t1)          # v[j+1] recebe t0 (v[j])
    jr      $ra                     # retorna ao loop
bubble:
    move    $t5,    $a0             # Endereço do array é salvo em t5
    move    $t6,    $a1             # Tamanho do array é salvo em t6
    move    $t7,    $zero           # t7 é o i. i = 0
forExterno:
    slt     $t0,    $t7,    $t6     # i ≥ n?
    beq     $t0,    $zero,  exit1   # Se i < n, vai para exit1
    addi    $t8,    $t7,    -1      # t8 é o j. j = i – 1
forInterno:
    slti    $t0,    $t8,    0       # j < 0?
    bne     $t0,    $zero,  exit2   # se j < 0, vai para exit2
    sll     $t1,    $t8,    2       # t1 = j * 4 ==> jtésima palavra do array
    add     $t2,    $t5,    $t1     # t2 recebe o endereço de v[j]
    lw      $t3,    0($t2)          # t3 recebe v[j]
    lw      $t4,    4($t2)          # t4 recebe v[j+1]
    slt     $t0,    $t4,    $t3     # v[j+1] < v[j] ?
    beq     $t0,    $zero,  exit2   # v[j+1] > v[j], vai para exit2

    addi    $sp,    $sp,    -4      # sobe pilha
    sw      $ra,    0($sp)          # salva endereço de retorno do método pai

    move    $a0,    $t5             # v[j+1] < v[j] é verdadeiro. garante o a0 como endereço do array
    move    $a1,    $t8             # a1 recebe j
    jal     swap                    # troca v[j] e v[j+1]

    lw      $ra,    0($sp)          # recupera endereço de retorno do método pai
    addi    $sp,    $sp,    4       # desce pilha
  
    addi    $t8,    $t8,    -1      # j--
    j       forInterno              # vai para forInterno (iterando o j)
exit2:
    addi    $t7,    $t7,    1       # i++
    j       forExterno              # volta para forExterno (interando o i)
exit1:
    jr      $ra                     
# ================================================= MENU ====================================================
menu:
    li      $v0,    4        # Print "\n"
    la      $a0,    msgLinha		            
    syscall
    li      $v0,    4        # Print "\n 1) Cadastrar Notas\n 2) Alterar Notas.\n..."
    la      $a0,    msg2			            
    syscall
    li      $v0,    4        # Print " Opcao >> "
    la      $a0,    msgOpcao		            
    syscall
    li      $v0,    5        # Ler int
    syscall
    
    slti    $t9,    $v0,    1                   # Para comparacao do menu (para sair, opcao = 0)
    bne     $t9,    $zero,  exit1               # Vai para exit1 (jr ra)
    slti    $t9,    $v0,    2                   # Para comparacao do menu (para cadastrar, opcao = 1)
    bne     $t9,    $zero,  cadastrar           # Vai para menu de cadastramento
    slti    $t9,    $v0,    3                   # Para comparacao do menu (para alterarNota, opcao = 2)
    bne     $t9,    $zero,  alterarNota         # Vai para menu de alteração de nota
    slti    $t9,    $v0,    4                   # Para comparacao do menu (para exibirNotas, opcao = 3)
    bne     $t9,    $zero,  visualizarNota      # Vai para menu exibição notas/médias
    slti    $t9,    $v0,    5                   # Para comparacao do menu (para exibirMedia, opcao = 4)
    bne     $t9,    $zero,  visualizarMedia     # Vai para menu exibição média da sala
    slti    $t9,    $v0,    6                   # Para comparacao do menu (para exibirAprovados, opcao = 5)
    bne     $t9,    $zero,  visualizarAprovados # Vai para menu de aprovados
    
    j       menu
# ============================== 1) cadastrar nota de atividade e de projeto =================================
cadastrar:
    li      $v0,    4        		      # Print "\n"
    la      $a0,    msgLinha		            
    syscall
    li      $v0,    4                     # Print " 1) Atividade 1\n 2) Atividade 2\n 3) Atividade 3..."
    la      $a0,    msgMenuCadastro            
    syscall
    li      $v0,    4        		      # Print " Opcao >> "
    la      $a0,    msgOpcao		            
    syscall
    li      $v0,    5                     # Ler int
    syscall
    addi    $t0,    $v0,    -1            # Salva opção
    move    $t1,    $zero                 # Count = 0
    li      $v0,    4        		      # Print "\n"
    la      $a0,    msgLinha		            
    syscall
loopCadastrar:
    sll     $t2,    $t1,    2
    add     $t2,    $s1,    $t2
    lw      $a0,    0($t2)
    li      $v0,    1                     # Escrever inteiros
    syscall
    li      $v0,    4                     # Print ": "
    la      $a0,    msgdoisPontos                  
    syscall
    li      $v0,    6                     # Ler float
    syscall
    mul     $t2,    $t1,    $s4           # Multiplica a linha por tamanho da matriz nota
    addu    $t2,    $t2,    $t0           # Adiciona qual coluna que é
    sll     $t2,    $t2,    2             # Alinhamento 
    add     $t2,    $t2,    $s2           # Coloca no inicio
    s.s     $f0,    0($t2)                # Guarda float
    addi    $t1,    $t1,    1             # Count ++
    slt     $t3,    $t1,    $s3           # Validar que o count < tamanho?
    bne     $t3,    $zero,  loopCadastrar # Validar saida do loop
    j       menu
# ======================================= 2) alterar nota ============================================
alterarNota:
    li      $v0,    4        		      # Print "\n Digite o RA >> "
    la      $a0,    msgRAaltera	          
    syscall
    li      $v0,    5                     # Ler int
    syscall

    move    $t1,    $v0                   # Guarda RA($t1)
    move    $t5,    $zero                 # Zerar count
loopProcuraRA:
    sll     $t2,    $t5,    2             # t2 recebe countesima palavra do array
    add     $t2,    $s1,    $t2           # t2 recebe endereço da countesima palavra
    lw      $v0,    0($t2)                # guarda o valor lido na countesima
    beq     $v0,    $t1,    pegarNota
    addi    $t5,    $t5,    1
    slt     $t3,    $t5,    $s3           # count < tamanho?
    bne     $t3,    $zero,  loopProcuraRA # count >=, sai
    j       menu
pegarNota:
    li      $v0,    4                     # Print " 1) Atividade 1\n 2) Atividade 2\n 3) Atividade 3..."
    la      $a0,    msgMenuCadastro       
    syscall
	li      $v0,    4        			  # Print " Opcao >> "
    la      $a0,    msgOpcao		            
    syscall
    li      $v0,    5                     # Ler int
    syscall
    addi    $t3,    $v0,    -1            # Salva opção
    li      $v0,    4                     # Print "\n Digite a nota >> "
    la      $a0,    msgNota               
    syscall
    li      $v0,    6                     # Código syscall para ler float (e guardar no f0)
    syscall
    mul     $t2,    $t5,    $s4           # Multiplica a linha por tamanho da matriz nota
    addu    $t2,    $t2,    $t3           # Adiciona qual coluna que é
    sll     $t2,    $t2,    2             # Alinhamento (float = 4 bytes)
    add     $t2,    $t2,    $s2           # Adiciona ao inicio do vetor/matriz
    s.s     $f0,    0($t2)                # Guarda float
    j       menu 

    li      $v0,    4                     # Print " * Aperte a tecla ENTER para continuar. . . *\n"
    la      $a0,    msgContinue
    syscall
    li      $v0,    12                    # Ler ENTER
    syscall
    j       menu   
# ===================================== 3) exibir notas ==============================================
visualizarNota:
    li      $v0,    4        		    # Print "\n"
    la      $a0,    msgLinha		            
    syscall
    li      $v0,    4                   # Print "          A1 ,  A2 ,  A3 ,  A4 ,  A5 , P1 , P2 , M\n"
    la      $a0,    notasCabecalho
    syscall
    move    $t8,    $zero               # Zera count

loopNota2:
    li      $v0,    4                   # Print " Aluno "
    la      $a0,    msgAluno                       
    syscall
    sll     $t2,    $t8,    2           # Prepara memoria 
    add     $t2,    $t2,    $s1         # Soma com o inicio do array aluno
    lw      $a0,    0($t2)              # Pega RA
    li      $v0,    1                   # Print inteiro
    syscall
    li      $v0,    4                   # Print ": "
    la      $a0,    msgdoisPontos                  
    syscall
    move    $t9,    $zero               # Zera count
    sub.s   $f9,    $f9,    $f9         # Zera somatorio
loopNota1:
    mul     $t2,    $t8,    $s4         # Multiplica a linha por tamanho da matriz nota
    addu    $t2,    $t2,    $t9         # Adiciona qual coluna que é
    sll     $t2,    $t2,    2           # Alinhamento 
    add     $t2,    $t2,    $s2         # Coloca no inicio
    l.s     $f12,    0($t2)             # Guarda float
    li      $v0,    2                   # Print  nota
    syscall
    li      $v0,    4                   # Print ", "
    la      $a0,    msgespacoVirgula
    syscall
    slti    $t0,    $t9,    5           # Se for primeiras 5 notas (atividade), t0 = 1
    beq     $t0,    $zero,  notaProjeto
    li      $t0,    2                   # Peso da atividade em t0
    mtc1    $t0,    $f11                # Move 
    cvt.s.w $f11,   $f11                # Converte int to float
    mul.s   $f0,    $f12,   $f11        # Nota * peso
    j       finalizaLoopNota1
notaProjeto:
    li      $t0,    5                   # Peso do projeto 
    mtc1    $t0,    $f11                # Move 
    cvt.s.w $f11,   $f11                # Converte int to float
    mul.s   $f0,    $f12,   $f11        # Nota * peso
finalizaLoopNota1:
    add.s   $f9,    $f9,    $f0         # Soma nota para o somador total
    addi    $t9,    $t9,    1           # Count++
    slt     $t0,    $t9,    $s4         # Condicional
    bne     $t0,    $zero,  loopNota1   # While
    li      $t0,    20                  # Peso total
    mtc1    $t0,    $f11                # Move
    cvt.s.w $f11,   $f11                # Converte int to float
    div.s   $f12,   $f9,   $f11         # Word to float
    li      $v0,    2                   # Print media
    syscall
    li      $v0,    4
    la      $a0,    msgLinha            # Print "\n"
    syscall
    addi    $t8,    $t8,    1           # count++
    slt     $t0,    $t8,    $s3         # Condicional
    bne     $t0,    $zero,  loopNota2   # While
    li      $v0,    4                   # Print " * Aperte a tecla ENTER para continuar. . . *\n"
    la      $a0,    msgContinue
    syscall
    li      $v0,    12                  # Ler ENTER
    syscall
    j       menu   
# ========================= 4) exibir média aritmética das médias da turma ================================
visualizarMedia:
    move    $t8,    $zero                       # count = 0
    sub.s   $f7,    $f7,    $f7                 # Somatório  = 0
loopMediaExterna:
    sll     $t2,    $t8,    2                   # Arrumando memoria
    add     $t2,    $t2,    $s1                 # Soma com o inicio do array aluno
    move    $t9,    $zero                       # count  = 0
    sub.s   $f9,    $f9,    $f9                 # Somatório  = 0
loopMediaInterna:
    mul     $t2,    $t8,    $s4                 # Multiplica a linha por tamanho da matriz nota
    addu    $t2,    $t2,    $t9                 
    sll     $t2,    $t2,    2                   # Memoria
    add     $t2,    $t2,    $s2                 
    l.s     $f12,    0($t2)                     
    slti    $t0,    $t9,    5                   # Peso igual das primeiras atividades
    beq     $t0,    $zero,  notaProjetoMedia
    li      $t0,    2                           # Peso da atividade em t0
    mtc1    $t0,    $f11                        # Move 
    cvt.s.w $f11,   $f11                        # Word to float
    mul.s   $f0,    $f12,   $f11                # Nota * peso
    j       completaMediaInterna
notaProjetoMedia:
    li      $t0,    5                           # Peso do projeto em t0
    mtc1    $t0,    $f11                        # Move 
    cvt.s.w $f11,   $f11                        # Word to float
    mul.s   $f0,    $f12,   $f11                # Nota * peso
completaMediaInterna:
    add.s   $f9,    $f9,    $f0                 # Nota mais somador
    addi    $t9,    $t9,    1                   # count ++
    slt     $t0,    $t9,    $s4                 # Condicional
    bne     $t0,    $zero,  loopMediaInterna    # Condicional
    li      $t0,    20                          # Peso total
    mtc1    $t0,    $f11                        # Move 
    cvt.s.w $f11,   $f11                        # Int to float
    div.s   $f12,   $f9,    $f11                # Word to float
    add.s   $f7,    $f7,    $f12
    addi    $t8,    $t8,    1                   # Incrementa count de aluno
    slt     $t0,    $t8,    $s3                 # Condicional
    bne     $t0,    $zero,  loopMediaExterna    # Condicional
    mtc1    $s3,    $f11                        # Move 
    cvt.s.w $f11,   $f11                        # Int to float
    div.s   $f12,   $f7,    $f11                # Word to float
    li      $v0,    4                           # Print "\n Media da Turma : "
    la      $a0,    msgMedia
    syscall
    li      $v0,    2                           # Print "\n"
    syscall
    li      $v0,    4
    la      $a0,    msgLinha                    # Print 
    syscall
    li      $v0,    4
    la      $a0,    msgContinue
    syscall
    li      $v0,    12                           # Ler ENTER
    syscall
    j       menu  
# ================================= 5) exibir a relação dos aprovados =====================================
visualizarAprovados:
	li      $v0,    4                           # Print "\n"
    la      $a0,    msgLinha		            
    syscall
    move    $t8,    $zero                       # count de aluno = 0
loopAprovadoExterna:
    li      $v0,    4                           # Print " Aluno "
    la      $a0,    msgAluno                    
    syscall
    sll     $t2,    $t8,    2                   # Prepara String
    add     $t2,    $t2,    $s1                
    lw      $a0,    0($t2)                      # Pega RA 
    li      $v0,    1                           
    syscall
    li      $v0,    4                           # Print ": "
    la      $a0,    msgdoisPontos                  
    syscall
    move    $t9,    $zero                       # count  = 0
    sub.s   $f9,    $f9,    $f9                 # Somatório = 0
loopAprovadoInterna:
    mul     $t2,    $t8,    $s4                 # Multiplica a linha por tamanho da matriz nota
    addu    $t2,    $t2,    $t9                 # Adiciona qual coluna que é
    sll     $t2,    $t2,    2                   # Alinhamento (float = 4 bytes)
    add     $t2,    $t2,    $s2                 # Coloca no inicio
    l.s     $f12,    0($t2)                     # Guarda float
    slti    $t0,    $t9,    5                   # Se for primeiras 5 notas (atividade), t0 = 1
    beq     $t0,    $zero,  notaProjetoAprovado
    li      $t0,    2                           # Peso da atividade em t0
    mtc1    $t0,    $f11                        # Move
    cvt.s.w $f11,   $f11                        # Word para float
    mul.s   $f0,    $f12,   $f11                # Nota * Peso
    j       completaAprovadoInterna
notaProjetoAprovado:
    li      $t0,    5                           # Peso do projeto em t0
    mtc1    $t0,    $f11                        # Move
    cvt.s.w $f11,   $f11                        # Word para float
    mul.s   $f0,    $f12,   $f11                # Nota * Peso
completaAprovadoInterna:
    add.s   $f9,    $f9,    $f0                 # Soma nota para o somador total
    addi    $t9,    $t9,    1                   # Count ++
    slt     $t0,    $t9,    $s4                 # Condicional
    bne     $t0,    $zero,  loopAprovadoInterna # While
    li      $t0,    20                          # Peso total
    mtc1    $t0,    $f11                        # Move
    cvt.s.w $f11,   $f11                        # int to float
    div.s   $f12,   $f9,    $f11                # Word para float
    li      $t0,    5                           # Média minima para ser aprovado
    mtc1    $t0,    $f11                        # Move
    cvt.s.w $f11,   $f11                        # Word para float
    c.lt.s  $f12,   $f11
    bc1t    printReprovado
    li      $v0,    4                           # Print " Aprovado!\n"
    la      $a0,    msgAprovados                 
    syscall
    j       fimPrint
printReprovado:
    li      $v0,    4                           # Print " Reprovado!\n"
    la      $a0,    msgReprovados                 
    syscall
fimPrint:
    addi    $t8,    $t8,    1                   # count ++
    slt     $t0,    $t8,    $s3                 # Condicional
    bne     $t0,    $zero,  loopAprovadoExterna # While
    li      $v0,    4
    la      $a0,    msgContinue
    syscall
    li      $v0,    12                           # Ler ENTER
    syscall
    j       menu