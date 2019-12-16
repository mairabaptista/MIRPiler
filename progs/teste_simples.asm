
main:
0:	addi	$sp, $sp, 4
1:	li	$t0, 5
2:	sw	$t0, -2($sp)
3:	lw	$s0, -2($sp)
4:	addi	$t1, $s0, 80
5:	sw	$t1, 0($sp)
6:	lw	$s1, 0($sp)
7:	mov	$a0, $s1
8:	out	$a0
9:	subi	$sp, $sp, 4
10:	hlt	
