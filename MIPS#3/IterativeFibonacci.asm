# http://www.cs.usfca.edu/~peter/cs315/code.html

# Program to read a positive integer n, and compute the nth Fibonacci number:
#
#     f_0 = 0
#     f_1 = 1
#     f_n = f_(n-1) + f_(n-2), n >= 2 
	.text
	.globl	main
main:
	subu	$sp, $sp, 4 	        # Make additional stack space.
	sw	$ra, 0($sp)		# Save the return address
	
	# Ask the OS to read a number and put it in a temporary register
	li	$v0, 5			# Code for read int.
	syscall				# Ask the system for service.
	move    $t0, $v0                # Put n in a safe place

	# The loop
        li      $t2, 1                  # Initialize f_old to 1
        li      $t1, 0                  # Initialize f_older to 0
        li      $t4, 2                  # Initialize counter i to 2
lp_tst: bgt     $t4, $t0, done          # If $t4 > $t0 (i >  n), 
                                        #    branch out of loop.
                                        #    Otherwise continue.
        add     $t3, $t2, $t1           # Add f_old to f_older
        move    $t1, $t2                # Replace f_older with f_old
        move    $t2, $t3                # Replace f_old with f_new
        addi    $t4, $t4, 1             # Increment i (i++)
        j       lp_tst                  # Go to the loop test

        # Done with the loop, print result
done:   li      $v0, 1                  # Code to print an int
        move    $a0, $t2                # Put f_old in $a0
        syscall                         # Print the string

	# Restore the values from the stack, and release the stack space.
     	lw	$ra, 0($sp)		# Retrieve the return address
	addu	$sp, $sp, 4 	        # Make additional stack space.

	# Return -- go to the address left by the caller.
	# jr	$ra
        li      $v0, 10
        syscall