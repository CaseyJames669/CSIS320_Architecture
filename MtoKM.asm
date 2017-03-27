	.Ltext0:
             		.section	.rodata
             	.LC0:
  		.string	"Enter Distance in Miles: "
      
.LC1:
  		.string	"%f"
             	.LC3:
 		.string	"Distance in KM is: %.2f \n"
      
 		#.align 8
             	.LC4:
		.string	"Enter Y/y to continue or any other key to stop."

             	.LC5:
		.string	" %c"
             		.text
             		.globl	main
             	main:
             	.LFB0:
             		.cfi_startproc
      		#pushq	%rbp
             		.cfi_def_cfa_offset 16
             		.cfi_offset 6, -16
  		#movq	%rsp, %rbp
             		.cfi_def_cfa_register 6
 		#subq	$16, %rsp
             	.L2:
             	.LBB2:
  		#movl	$.LC0, %edi

  		movl	$0, %eax
  		call	printf

 		leaq	-8(%rbp), %rax
   		movq	%rax, %rsi
 		movl	$.LC1, %edi

 		movl	$0, %eax

 		call	scanf
     
 		movss	-8(%rbp), %xmm0
     
   		unpcklps	%xmm0, %xmm0 
   		cvtps2pd	%xmm0, %xmm0
  		movsd	.LC2(%rip), %xmm1

  		mulsd	%xmm1, %xmm0
  		unpcklpd	%xmm0, %xmm0
  		cvtpd2ps	%xmm0, %xmm2
  		movss	%xmm2, -4(%rbp)
     
  		movss	-4(%rbp), %xmm0
     
    		cvtps2pd	%xmm0, %xmm0
  		movl	$.LC3, %edi
     
  		movl	$1, %eax
     
  		call	printf
     
  		movl	$.LC4, %edi

 		movl	$0, %eax
     
  		call	printf
     
  		leaq	-9(%rbp), %rax
    		movq	%rax, %rsi
  		movl	$.LC5, %edi


     
 		call	scanf
     
             	.LBE2:
  		movzbl	-9(%rbp), %eax
      		cmpb	$121, %al
  		je	.L2
     
  		movzbl	-9(%rbp), %eax
      		cmpb	$89, %al
  		je	.L2
     
  		movl	$0, %eax
     
       		leave
             		.cfi_def_cfa 7, 8
      		ret
             		.cfi_endproc
             	.LFE0:
             		.section	.rodata
  		.align 8
             	.LC2:
  		.long	3367254360
  		.long	1073331830
             		.text
             	.Letext0:
