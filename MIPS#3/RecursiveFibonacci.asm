# http://www.cs.usfca.edu/~peter/cs315/code.html

# Program to read a positive integer n, and compute the nth Fibonacci number:
#
#     f_0 = 0
#     f_1 = 1
#     f_n = f_(n-1) + f_(n-2), n >= 2 
#
# This version uses recursion.
#
	.text
	.globl	main
main:
	subu	$sp, $sp, 8 	        # Make additional stck sp.
	sw	$ra, 4($sp)		# Save the return address
	sw	$s0, 0($sp)		# Save $s0 = n

        # Read n
        li      $v0, 5                  # Code to print an int
        syscall                         # Read n
        move    $s0, $v0                

        # Call Fibo function    
        move    $a0, $s0
        jal     fibo

        # Print the result
        move    $a0, $v0                # Put f_n in $a0
        li      $v0, 1                  # Code to print an int
        syscall                         # Print the nth Fibonacci no.

	# Restore the values from the stack, release stack sp.
        sw      $s0, 0($sp)             # Retrieve $s0
     	lw	$ra, 4($sp)		# Retrieve the return address
	addu	$sp, $sp, 8 	        # Make additional stack space.

	# Return in Spim
#	jr	$ra

        # In Mars exit
        li      $v0, 10
        syscall

        #############################################################
        # Fibo Function
        #    $a0 = n
        #
fibo:
        addi    $sp, $sp, -12           # Put $ra, $s0, $s1 on stack
        sw      $ra, 8($sp)
        sw      $s0, 4($sp)
        sw      $s1, 0($sp)

        move    $s0, $a0                # Put n in $s0

        bne     $s0, $zero, not_0       # Go to not_0 if $s0 != 0
        li      $v0, 0                  # n = 0, f_n = 0
        j       done                                     

not_0:  li      $t0, 1
        bne     $s0, $t0, gt_1          # Go to gt_1 if $s0 != 1
        li      $v0, 1
        j       done

gt_1:   addi    $a0, $s0, -1            # Assign $a0 = n-1
        jal     fibo                    # Compute f_(n-1)
        move    $s1, $v0                

        addi    $a0, $s0, -2            # Assign $a0 = n-2
        jal     fibo                    # Compute f_(n-2)
        add     $v0, $s1, $v0           # Add f_(n-1) + f_(n-2)

done:   
        # Retrieve $ra, $s0, $s1 from stack and return
        lw      $ra, 8($sp)
        lw      $s0, 4($sp)
        lw      $s1, 0($sp)
        addi    $sp, $sp, 12            
        jr      $ra