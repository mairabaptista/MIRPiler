
main:
0:	addi	$sp, $sp, 4
1:	nop	
2:	sysin	
3:	nop	
4:	lw	$t0, $t0
5:	sw	$t0, -1($sp)
6:	li	$t1, 5
7:	sw	$t1, -2($sp)
8:	lw	$s0, -2($sp)
9:	addi	$t2, $s0, 80
10:	sw	$t2, 0($sp)
11:	lw	$s1, 0($sp)
12:	mov	$v1, $s1
13:	nop	
14:	sysout	
15:	nop	
16:	subi	$sp, $sp, 4
17:	sysend	
