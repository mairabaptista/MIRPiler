
opa:
0:	addi	$sp, $sp, 3
1:	lw	$s0, 0($sp)
2:	addi	$t0, $s0, 10
3:	sw	$t0, 0($sp)
4:	lw	$s0, 0($sp)
5:	jr	$ra

main:
6:	addi	$sp, $sp, 4
7:	nop	
8:	sysin	
9:	nop	
10: nop
11: sw  $v1, -1($sp)
12:	sw	$ra, -3($sp)
13:	jal	opa
14:	subi	$sp, $sp, 3
15:	lw	$ra, -3($sp)
16:	mov	$s0, $v0
17:	lw	$s1, -2($sp)
18: mov  $v1, $s1
19:	nop	
20:	sysout	
21:	nop	
22:	subi	$sp, $sp, 4
23:	sysend	
