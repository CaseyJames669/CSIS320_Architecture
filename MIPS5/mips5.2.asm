##########################################################
## CSCE 430 Computer Architecture
## Spring 2010
## Team SMASH \\nn// (Sam Way, Kyle Schaffer, Mike Kelly)
## Matrix Multiply Assembly
##########################################################

.data                                               #Start the data section

nsize:     .word     10                             #N X N Size of the Matrix

MatrixA:    .word 7431,-6029,5416,-2521,-5207,3789,-4769,4272,-3923,4885
        .word -5525,-5600,5216,-4102,-7120,6617,-6286,6801,-6802,-2881
        .word 7708,-7174,7179,-1850,1808,-783,2396,6570,-3307,2770
        .word 1589,3307,-8187,-1294,3302,-7034,-6416,-4682,6834,-3338
        .word -4256,-6775,2300,2295,-6363,-4239,7922,771,-483,7044
        .word -7040,1913,-8071,4711,-6622,3799,-4123,4665,-3777,-3572
        .word -3276,-5345,-6448,-3768,1603,-7529,1743,-5006,4309,-5425
        .word 5137,2481,-6442,5636,5116,-1237,5189,4045,4459,4017
        .word -6935,-21,-2177,3940,5154,659,5408,-400,-7843,-375
        .word -2384,-3531,-4266,5343,-6727,7436,-180,1364,6226,2514

MatrixB:    .word 2192,-4804,-7718,-6279,-3812,-3340,8141,-7401,575,366
        .word -7961,897,-8043,4031,7692,-610,-2311,-3009,-1664,-157
        .word -485,6214,1580,5076,-5181,6967,2052,4644,2793,-6739
        .word 6330,948,1787,4018,-3278,-4655,-1747,7740,-974,-4082
        .word -6324,4134,6864,-2668,-1455,-8175,-8066,1417,-6015,-859
        .word -941,6470,3827,1382,-4317,6662,742,4555,-996,2260
        .word 2614,5601,-3258,-509,-4996,2950,149,3731,781,3432
        .word -3362,-6048,-73,-6762,3365,245,-4149,2474,-1718,8071
        .word 7379,-5093,-3962,5386,-5234,362,-7448,2697,-1667,7081
        .word 3183,-5675,3815,3047,366,-6506,5599,7189,4118,-6681

MatrixC:        .word 0,0,0,0,0,0,0,0,0,0
            .word 0,0,0,0,0,0,0,0,0,0
            .word 0,0,0,0,0,0,0,0,0,0
            .word 0,0,0,0,0,0,0,0,0,0
            .word 0,0,0,0,0,0,0,0,0,0
            .word 0,0,0,0,0,0,0,0,0,0
            .word 0,0,0,0,0,0,0,0,0,0
            .word 0,0,0,0,0,0,0,0,0,0
            .word 0,0,0,0,0,0,0,0,0,0
            .word 0,0,0,0,0,0,0,0,0,0

.text                                               #Start the program code section

    j main

mult:
    addi $t7, $zero, 1                      #t7 = 1

    mult $t0, $s0, $s4                      #t0 = n*i
    add  $t0, $t0, $s6                      #t0 = t0 + k
    mult $t0, $t0, $t7                      #t0 = $t0 * 4 (offset of element A[n*i+k])
    add  $t0, $t0, $s1                      #t0 = address of A[n*i+k]
    lw   $t0, 0($t0)                        #t0 = A[n*i+k]
    
    mult $t1, $s0, $s6                      #t1 = n*k
    add  $t1, $t1, $s5                      #t1 = t0 + j
    mult $t1, $t1, $t7                      #t1 = $t1 * 4 (offset of element B[n*k+j])
    add  $t1, $t1, $s2                      #t1 = address of B[n*k+j]
    lw   $t1, 0($t1)                        #t1 = B[n*k+j]
    
    mult $t2, $s0, $s4                      #t2 = n*i
    add  $t2, $t2, $s5                      #t2 = (n*i)+j
    mult $t2, $t2, $t7                      #t2 = $t2 * 4 (offset of element C[n*i+j])
    add  $t2, $t2, $s3                      #t2 = address of C[n*i+j]
    lw   $t3, 0($t2)
    
    mult $t4, $t0, $t1                      #t4 = A[n*i+k] * B[n*k+j]
    add  $t4, $t4, $t3
    sw   $t4, 0($t2)                        #C[n*i+j] = t4
    
    j kincr                                 #mult done
    
kincr:
    addi $s6, $s6, 1                        #k++
    j kloop                                 #Jump to the k loop

kloop:
    beq  $s6, $s0, jincr                    #If k = n branch jincr, else
    j mult                                  #jump to the multiply

jincr:
    addi $s5, $s5, 1                        #j++
    j jloop                                 #Jump to the j loop

jloop:
    beq  $s5, $s0, iincr                    #If j = n branch iincr, else
    addi $s6, $zero, 0
    j kloop                                 #Jump to the k loop
    
iincr:
    addi $s4, $s4, 1                        #i++
    j iloop                                 #Jump to the i loop
    
iloop:
    beq  $s4, $s0, print                    #If i = n print matrix else,
    addi $s5, $zero, 0
    j jloop                                 #Jump to the j loop

ploop:                                      #Elements at C[i*n+i]
    lw $t0, 0($s3)
    lw $t1, 11($s3)
    lw $t2, 22($s3)
    lw $t3, 33($s3)
    lw $t4, 44($s3)
    lw $t5, 55($s3)
    lw $t6, 66($s3)
    lw $t7, 77($s3)
    lw $s0, 88($s3)
    lw $s1, 99($s3)

    add $t0, $t0, $t1
    add $t0, $t0, $t2
    add $t0, $t0, $t3
    add $t0, $t0, $t4
    add $t0, $t0, $t5
    add $t0, $t0, $t6
    add $t0, $t0, $t7
    add $t0, $t0, $s0
    add $t0, $t0, $s1

    j smash

print:
    li $t3, 0
    li $t4, 0
    li $t5, 0 
    j ploop
    
smash:
    addi $lo, $t0, 0
    syscall
    j done

done:
    j done                                 #Loops forever, program complete. GO TEAM SMASH!

main:
la $s0, nsize                           #Load the address of Matrix N x N Size
lw $s0, 0($s0)                                                  #Load the value of Matrix N x N Size
la $s1, MatrixA                         #Load Matrix A
la $s2, MatrixB                         #Load Matrix B
la $s3, MatrixC                         #Load Matrix C
li $s4, 0                               #i value
li $s5, 0                               #j value
li $s6, 0                               #k value
j iloop                                 #start the nested loops