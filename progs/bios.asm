
main:
0:	addi	$sp, $sp, 3
1:	li	$t0, 0
2:	sw	$t0, -1($sp)
.L1	
3:	lw	$s0, -1($sp)
4:	li	$t1, 1024
5:	neq	$t2, $s0, $t1
6:	beq	$t2, $rzero, L2
7:	mov	$a0, $s0
8:	lhd	$t3, $a0
9:	sw	$t3, 0($sp)
10:	lw	$s1, 0($sp)
11:	mov	$a0, $s1
12:	mov	$a1, $s0
13:	smem	$a0, $a1
14:	addi	$t4, $s0, 1
15:	sw	$t4, -1($sp)
16:	lw	$s0, -1($sp)
17:	j	L1
.L2	
18:	li	$a0, 8
19:	lcd	$a0
20:	lw	$s0, -1($sp)
21:	mov	$a0, $s0
22:	nop	
23:	out	$a0
24:	li	$a0, 99
25:	nop	
26:	out	$a0
27:	subi	$sp, $sp, 3
28:	hlt	
