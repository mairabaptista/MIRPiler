
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
28:	in	$t0
29:	sw	$t0, -1($sp)
30:	nop	
31:	in	$t1
32:	sw	$t1, 0($sp)
33:	lw	$s0, -1($sp)
34:	mov	$a0, $s0
35:	lw	$s1, 0($sp)
36:	mov	$a1, $s1
37:	sw	$ra, -2($sp)
38:	jal	gcd
39:	subi	$sp, $sp, 4
40:	lw	$ra, -2($sp)
41:	mov	$s0, $v0
42:	mov	$a0, $s0
43:	out	$a0
44:	subi	$sp, $sp, 3
45:	hlt	
