
teste:
0:	addi	$sp, $sp, 3
1:	sw	$a0, 0($sp)
2:	jr	$ra

test:
3:	addi	$sp, $sp, 3
4:	lw	$s0, 0($sp)
5:	mov	$v0, $s0
6:	jr	$ra

main:
7:	addi	$sp, $sp, 4
8:	li	$t0, 10
9:	sw	$t0, -1($sp)
10:	lw	$s0, -1($sp)
11:	mov	$a0, $s0
12:	setpc	$a0
13:	lw	$s1, 0($sp)
14:	addi	$t1, $s1, 3
15:	sw	$t1, 0($sp)
16:	lw	$s1, 0($sp)
17:	mov	$a0, $s1
18:	nop	
19:	out	$a0
20:	getpc	
21:	mov	$s2, $v1
22:	sw	$s2, 0($sp)
23:	lw	$s1, 0($sp)
24:	mov	$a0, $s1
25:	nop	
26:	out	$a0
27:	subi	$sp, $sp, 4
28:	hlt	
