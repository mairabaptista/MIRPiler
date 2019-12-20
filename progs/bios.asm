
main:
0:	addi	$sp, $sp, 5
1:	li	$a0, 10
2:	lcd	$a0
3:	nop	
4:	in	$t0
5:	sw	$t0, 0($sp)
6:	lw	$s0, 0($sp)
7:	addi	$t1, $s0, 2
8:	sw	$t1, 0($sp)
9:	lw	$s0, 0($sp)
10:	mov	$a0, $s0
11:	out	$a0
12:	li	$t2, 0
13:	sw	$t2, -3($sp)
.L1	
14:	lw	$s0, -3($sp)
15:	li	$t3, 1024
16:	neq	$t4, $s0, $t3
17:	beq	$t4, $rzero, L2
18:	mov	$a0, $s0
19:	lhd	$t5, $a0
20:	sw	$t5, -2($sp)
21:	lw	$s1, -2($sp)
22:	mov	$a0, $s1
23:	mov	$a1, $s0
24:	smem	$a0, $a1
25:	addi	$t6, $s0, 1
26:	sw	$t6, -3($sp)
27:	lw	$s0, -3($sp)
28:	j	L1
.L2	
29:	li	$a0, 11
30:	lcd	$a0
31:	nop	
32:	in	$t7
33:	sw	$t7, -1($sp)
34:	subi	$sp, $sp, 5
35:	hlt	
