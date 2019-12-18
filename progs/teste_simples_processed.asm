
main:
0:	addi	$sp, $sp, 4
1:	nop	
2:	sysin	
3:	nop	
4: nop
5: sw  $v1, -1($sp)
6:	lw	$s0, -1($sp)
7:	addi	$t1, $s0, 13
8:	sw	$t1, -1($sp)
9:	lw	$s0, -1($sp)
10: mov  $v1, $s0
11:	nop	
12:	sysout	
13:	nop	
14:	subi	$sp, $sp, 4
15:	sysend	
16:	nop	
