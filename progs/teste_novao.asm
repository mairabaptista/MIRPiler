
main:
0:	addi	$sp, $sp, 4
1:	li	$t0, 4
2:	sw	$t0, -2($sp)
3:	li	$t1, 6
4:	sw	$t1, -1($sp)
5:	lw	$s0, -2($sp)
6:	lw	$s1, -1($sp)
7:	add	$t2, $s0, $s1
8:	sw	$t2, 0($sp)
9:	lw	$s2, 0($sp)
10:	mov	$a0, $s2
11:	nop	
12:	sysout	
13:	nop	
14:	subi	$sp, $sp, 4
15:	sysend	
16:	nop	
