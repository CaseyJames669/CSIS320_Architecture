# Mips assembly hello world program PCSpim
# https://www.youtube.com/watch?v=8dyibkAtaTM

main:
	.text
	
	la $a0,str
	li $v0,4
	syscall
	
	li $v0,10
	syscall
	
		.data
str:	.asciiz "Hello World\nMy name is Casey.\nFollow me for a trip... ;)"
