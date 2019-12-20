
main:
0:	addi	$sp, $sp, 9
1:	li	$t0, 5
2:	sw	$t0, -2($sp)
3:	li	$t1, 0
4:	sw	$t1, -1($sp)
5:	li	$t2, 0
6:	sw	$t2, 0($sp)
7:	la	$s0, -7($sp)
8:	li	$t3, 10
9:	sw	$t3, 0($s0)
10:	li	$t4, 20
11:	sw	$t4, 1($s0)
12:	li	$t5, 30
13:	sw	$t5, 2($s0)
14:	li	$t6, 40
15:	sw	$t6, 3($s0)
16:	li	$t7, 50
17:	sw	$t7, 4($s0)
.L1	
18:	lw	$s0, -1($sp)
19:	lw	$s1, -2($sp)
20:	lt	$t8, $s0, $s1
21:	beq	$t8, $rzero, L2
22:	la	$s2, -7($sp)
23:	add	$t9, $s2, $s0
24:	lw	$t9, 0($t9)
25:	lw	$s3, 0($sp)
26:	add	$t0, $s3, $t9
27:	sw	$t0, 0($sp)
28:	lw	$s3, 0($sp)
29:	addi	$t1, $s0, 1
30:	sw	$t1, -1($sp)
31:	lw	$s0, -1($sp)
32:	j	L1
.L2	
33:	lw	$s0, 0($sp)
34:	lw	$s1, -2($sp)
35:	div	$t2, $s0, $s1
36:	sw	$t2, 0($sp)
37:	lw	$s0, 0($sp)
38: mov  $v1, $s0
39:	nop	
40:	sysout	
41:	nop	
42:	subi	$sp, $sp, 9
43:	sysend	
44:	nop	
