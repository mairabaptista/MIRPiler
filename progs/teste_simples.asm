
main:
0:	addi	$sp, $sp, 4
1:	li	$t0, 1
2:	sw	$t0, -2($sp)
3:	li	$t1, 2
4:	sw	$t1, -1($sp)
5:	lw	$s0, -2($sp)
6:	mov	$a0, $s0
7:	nop	
8:	snd	$t2
9:	lw	$s1, -1($sp)
10:	mov	$a0, $s1
11:	rcv	$a0
12:	subi	$sp, $sp, 4
13:	hlt	
