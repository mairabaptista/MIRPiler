
teste:
0:	addi	$sp, $sp, 4
1:	sw	$a0, -1($sp)
2:	sw	$a1, 0($sp)
3:	jr	$ra

main:
4:	addi	$sp, $sp, 4
5:	nop	
6:	in	$t0
7:	sw	$t0, -1($sp)
8:	lw	$s0, -1($sp)
9:	mov	$a0, $s0
10:	li	$a1, 27
11:	sw	$ra, -3($sp)
12:	jal	teste
13:	subi	$sp, $sp, 4
14:	lw	$ra, -3($sp)
15:	mov	$s0, $v0
16:	subi	$sp, $sp, 4
17:	hlt	
