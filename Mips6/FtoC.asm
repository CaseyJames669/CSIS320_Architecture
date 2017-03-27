#http://sourcecodemania.com/converting-celsius-to-fahrenheit-and-fahrenheit-to-celsius-using-mips-assembly/

.data
inputc:	.asciiz	"Press 1 to convert Celcius into Farenheit"
inputf:	.asciiz	"\nPress 2 to convert Farenheit into Celcius"
ch:	.asciiz	"\nEnter your choice: "
in:	.asciiz	"Enter Value: "
result:	.asciiz	"Result is: "
f:	.float 0.555555
c:	.float 1.8
m:	.float 32.0

.text
.globl main
main:
	la $a0,	inputc
	li $v0, 4
	syscall
	
	la $a0,	inputf
	li $v0, 4
	syscall
	
	la $a0,	ch
	li $v0, 4
	syscall
	
	li $v0,5
	syscall
	
	move $t0,$v0
		
	beq $t0,1,Celcius
	beq $t0,2,Farenheit
	
Celcius:
	la $a0,	in
	li $v0, 4
	syscall
	
	li $v0,6
	syscall
	
	mov.s $f3,$f0	
	l.s $f4,c
	mul.s $f5,$f3,$f4
	l.s $f6,m
	add.s $f7,$f5,$f6
	
	la $a0,	result
	li $v0, 4
	syscall
	
	mov.s $f12,$f7
	li $v0,2
	syscall
	
	li $v0,10
	syscall
		
Farenheit:
	la $a0,	in
	li $v0, 4
	syscall
	
	li $v0,6
	syscall
	
	mov.s $f3,$f0	
	l.s $f4,m
	sub.s $f5,$f3,$f4
	l.s $f6,f
	mul.s $f7,$f5,$f6
	
	la $a0,	result
	li $v0, 4
	syscall
	
	mov.s $f12,$f7
	li $v0,2
	syscall
	
	li $v0,10
	syscall