
main:
0:	addi	$sp, $sp, 7
1:	nop	
2:	sysin	
3:	nop	
4:	lw	$t0, $t0
5:	sw	$t0, -5($sp)
6:	li	$t1, 2
7:	sw	$t1, -2($sp)
8:	lw	$s0, -5($sp)
9:	lw	$s1, -2($sp)
10:	mult	$t2, $s0, $s1
11:	sw	$t2, -4($sp)
12:	li	$t3, 3
13:	sw	$t3, -1($sp)
14:	lw	$s2, -1($sp)
15:	mult	$t4, $s0, $s2
16:	sw	$t4, -3($sp)
17:	lw	$s3, -4($sp)
18:	add	$t5, $s0, $s3
19:	lw	$s4, -3($sp)
20:	add	$t6, $t5, $s4
21:	div	$t7, $t6, $s1
22:	sw	$t7, 0($sp)
23:	lw	$s5, 0($sp)
24:	mov	$a0, $s5
25:	nop	
26:	sysout	
27:	nop	
28:	subi	$sp, $sp, 7
29:	sysend	
30:	nop	
