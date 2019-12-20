
main:
0:	addi	$sp, $sp, 7
1:	nop	
2:	sysin	
3:	nop	
4:	lw	$t0, $t0
5:	sw	$t0, -5($sp)
6:	lw	$s0, -5($sp)
7:	addi	$t1, $s0, 10
8:	sw	$t1, -4($sp)
9:	lw	$s1, -4($sp)
10:	subi	$t2, $s1, 6
11:	sw	$t2, -3($sp)
12:	lw	$s2, -3($sp)
13:	mov	$a0, $s2
14:	nop	
15:	sysout	
16:	nop	
17:	subi	$sp, $sp, 7
18:	sysend	
19:	nop	
