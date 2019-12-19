
main:
0:	addi	$sp, $sp, 3
1:	li	$t0, 1
2:	sw	$t0, 0($sp)
3:	nop	
4:	sysin	
5:	nop	
6:	lw	$t1, $t1
7:	sw	$t1, -1($sp)
.L1	
8:	lw	$s0, -1($sp)
9:	li	$t2, 0
10:	gt	$t3, $s0, $t2
11:	beq	$t3, $rzero, L2
12:	mult	$t4, $s0, $s0
13:	sw	$t4, 0($sp)
14:	subi	$t5, $s0, 1
15:	sw	$t5, -1($sp)
16:	lw	$s0, -1($sp)
17:	j	L1
.L2	
18:	lw	$s0, 0($sp)
19:	mov	$a0, $s0
20:	nop	
21:	sysout	
22:	nop	
23:	subi	$sp, $sp, 3
24:	sysend	
25:	nop	
