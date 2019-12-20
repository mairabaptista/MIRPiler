
main:
0:	addi	$sp, $sp, 7
1:	nop	
2:	sysin	
3:	nop	
4: nop
5: sw  $v1, -5($sp)
6:	lw	$s0, -5($sp)
7:	addi	$t1, $s0, 1
8:	sw	$t1, -4($sp)
9:	lw	$s1, -4($sp)
10:	addi	$t2, $s1, 1
11:	sw	$t2, -3($sp)
12:	lw	$s2, -3($sp)
13: mov  $v1, $s2
14:	nop	
15:	sysout	
16:	nop	
17:	subi	$sp, $sp, 7
18:	sysend	
19:	nop	
