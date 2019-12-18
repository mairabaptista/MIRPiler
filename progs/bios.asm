
main:
0:	addi	$sp, $sp, 3
1:	li	$t0, 0
2:	sw	$t0, -1($sp)
3:	lw	$s0, -1($sp)
4:	mov	$a0, $s0
5:	lhd	$t1, $a0
6:	sw	$t1, 0($sp)
.L1	
7:	lw	$s0, -1($sp)
8:	li	$t2, 1024
9:	neq	$t3, $s0, $t2
10:	beq	$t3, $rzero, L2
11:	lw	$s1, 0($sp)
12:	mov	$a0, $s1
13:	mov	$a1, $s0
14:	smem	$a0, $a1
15:	addi	$t4, $s0, 1
16:	sw	$t4, -1($sp)
17:	lw	$s0, -1($sp)
18:	mov	$a0, $s0
19:	lhd	$t5, $a0
20:	sw	$t5, 0($sp)
21:	lw	$s1, 0($sp)
22:	j	L1
.L2	
23:	lw	$s0, 0($sp)
24:	mov	$a0, $s0
25:	lw	$s1, -1($sp)
26:	mov	$a1, $s1
27:	smem	$a0, $a1
28:	li	$a0, 8
29:	lcd	$a0
30:	mov	$a0, $s1
31:	nop	
32:	out	$a0
33:	li	$a0, 99
34:	nop	
35:	out	$a0
36:	subi	$sp, $sp, 3
37:	hlt	
