
gcd:
0:	addi	$sp, $sp, 4
1:	sw	$a0, -1($sp)
2:	sw	$a1, 0($sp)
3:	lw	$s0, 0($sp)
4:	li	$t0, 0
5:	eq	$t1, $s0, $t0
6:	beq	$t1, $rzero, L1
7:	lw	$s1, -1($sp)
8:	mov	$v0, $s1
9:	jr	$ra
10:	j	L2
.L1	
11:	lw	$s0, 0($sp)
12:	mov	$a0, $s0
13:	lw	$s1, -1($sp)
14:	div	$t2, $s1, $s0
15:	mult	$t3, $t2, $s0
16:	sub	$t4, $s1, $t3
17:	mov	$a1, $t4
18:	sw	$ra, -2($sp)
19:	jal	gcd
20:	subi	$sp, $sp, 4
21:	lw	$ra, -2($sp)
22:	mov	$s0, $v0
23:	mov	$v0, $s0
24:	jr	$ra
.L2	
25:	jr	$ra

main:
26:	addi	$sp, $sp, 3
27:	nop	
28:	sysin	
29:	nop	
30:	lw	$t0, $t0
31:	sw	$t0, -1($sp)
32:	nop	
33:	sysin	
34:	nop	
35:	lw	$t1, $t1
36:	sw	$t1, 0($sp)
37:	lw	$s0, -1($sp)
38:	mov	$a0, $s0
39:	lw	$s1, 0($sp)
40:	mov	$a1, $s1
41:	sw	$ra, -2($sp)
42:	jal	gcd
43:	subi	$sp, $sp, 4
44:	lw	$ra, -2($sp)
45:	mov	$s0, $v0
46:	mov	$a0, $s0
47:	nop	
48:	sysout	
49:	nop	
50:	subi	$sp, $sp, 3
51:	sysend	
