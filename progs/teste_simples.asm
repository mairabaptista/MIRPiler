
teste:
0:	addi	$sp, $sp, 2
1:	li	$a0, 77
2:	nop	
3:	out	$a0
4:	jr	$ra

main:
5:	addi	$sp, $sp, 4
6:	nop	
7:	in	$t0
8:	sw	$t0, -1($sp)
9:	lw	$s0, -1($sp)
10:	addi	$t1, $s0, 13
11:	sw	$t1, -1($sp)
12:	lw	$s0, -1($sp)
13:	mov	$a0, $s0
14:	nop	
15:	out	$a0
16:	sw	$ra, -3($sp)
17:	jal	teste
18:	subi	$sp, $sp, 2
19:	lw	$ra, -3($sp)
20:	mov	$s0, $v0
21:	subi	$sp, $sp, 4
22:	hlt	
