# Sources: 
# http://stackoverflow.com/questions/7831834/mips-ackermann-function-in-floating-point



.data 
 askForM: .asciiz   "Please enter a m value: "
 askForN: .asciiz   "Please enter a n value: "
 result:  .asciiz   "The Result is: " 
 newline: .asciiz   "\n" 
 one: .double 1
 negOne: .double -1
 zero: .double 0
 .text 

  .globl main

la $t1, one
l.d $f26, 0($t1) 

la $t3, zero
l.d $f28, 0($t3)

la $t5, negOne
l.d $f24, 0($t5)

 main:   
addi $sp, $sp, -16  # make stack.
sw   $ra, 0($sp)      
sw   $s0, 4($sp)      
sw   $s1, 8($sp)      
sw   $s2, 12($sp)



la $a0, askForM # ask for m
li $v0, 4     
syscall

li $v0, 7 # Read input 
syscall
mov.d $f16, $f0  # m = s2

la $a0, askForN # ask for n
li $v0, 4       
syscall

li $v0, 7 # Read input 
syscall
mov.d $f18, $f0  # n = s1

# Ackermann parameter setup
mov.d $f4, $f16   # m 
mov.d $f6, $f18   # n
# Call Ackerman
mov.d $f2, $f0 #$V0
jal Ackermann




#----------Print-----------# 
# m = $s0  
# n = $s1  
#move value
mov.d  $f12, $f2
addi $sp, $sp, -4  #make stack
sw $a0, 0($sp)   

la $a0, result #The result is
li $v0, 4     
syscall

#move $a0, $a2  #Print value
li $v0, 3     
syscall

la $a0, newline# newline
li $v0, 4     
syscall

l.d $f4, 0($sp) # restore 
addi $sp, $sp, 4  

lw $ra, 0($sp) # restore stack
lw $s0, 4($sp)  
lw $s1, 8($sp) 
lw $s2, 12($sp)
addi $sp, $sp, 16   

# exit system call 
li $v0, 10 
syscall 

   #--------------------------------------Ackermann-

  Ackermann:  # make stack
        addi $sp, $sp, -16         
        # save reg
        swc1 $f16, 8($sp)
        # save address           
        sw $ra, 0($sp)   

        #$f24 = -1
        #$f26 = 1
        #f28 = 0


  misZero:    #  m==0
        # if not check n
        c.le.d  $f4, $f28
        bc1f  nisZero
        #  n+1
        add.d  $f2, $f6, $f26
        j end #finish the call

      nisZero:    # check whether n==0 if not both are greater
        c.le.d 1 $f6, $f28
        bc1f 1 bothGreater
        #A(m-1,1)
        #m-1 and 1 
        add.d $f4, $f4, $f24
        add.d $f6, $f28, $f26   #simplified this
        # Ackermann
        jal   Ackermann      
        j end

   bothGreater:# Save m for second call
        add.d $f16, $f4, $f28
        #A(m,(n - 1))
        add.d $f6, $f6, $f24
        jal Ackermann
        #A(m-1,A(m, (n - 1)))
        add.d  $f4, $f16, $f24
        add.d $f6, $f2, $f28
        jal Ackermann
        j   end

      end:        # restore 
        lwc1 $f16, 8($sp)
        # restore return address 
        lw $ra, 0($sp)
        # restore stack pointer
        addi $sp, $sp, 16
        # return
        jr $ra