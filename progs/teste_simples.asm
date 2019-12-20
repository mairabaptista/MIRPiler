
main:
0:	addi	$sp, $sp, 4
1:	li	$a0, 1
2:	lw	$s0, -2($sp)
3:	mov	$a1, $s0
4:	li	$a2, 1
5:	sub	$a1, $a1, $a2
6:	chwrt	
7:	lw	$v0, 0($a1)
8:	chwrt	
9:	lw	$s1, 0($sp)
10:	mov	$a0, $s1
11:	out	$a0
12:	li	$a0, 2
13:	mov	$a1, $s0
14:	li	$a2, 2
15:	sub	$a1, $a1, $a2
16:	chwrt	
17:	lw	$v1, 0($a1)
18:	chwrt	
19:	mov	$a0, $s1
20:	out	$a0
21:	li	$a0, 3
22:	mov	$a1, $s0
23:	li	$a2, 3
24:	sub	$a1, $a1, $a2
25:	chwrt	
26:	lw	$out1, 0($a1)
27:	chwrt	
28:	mov	$a0, $s1
29:	out	$a0
30:	li	$a0, 4
31:	mov	$a1, $s0
32:	li	$a2, 4
33:	sub	$a1, $a1, $a2
34:	chwrt	
35:	lw	$out2, 0($a1)
36:	chwrt	
37:	mov	$a0, $s1
38:	out	$a0
39:	li	$a0, 5
40:	mov	$a1, $s0
41:	li	$a2, 5
42:	sub	$a1, $a1, $a2
43:	chwrt	
44:	lw	$gp, 0($a1)
45:	chwrt	
46:	mov	$a0, $s1
47:	out	$a0
48:	li	$a0, 6
49:	mov	$a1, $s0
50:	li	$a2, 6
51:	sub	$a1, $a1, $a2
52:	chwrt	
53:	lw	$a0, 0($a1)
54:	chwrt	
55:	mov	$a0, $s1
56:	out	$a0
57:	li	$a0, 7
58:	mov	$a1, $s0
59:	li	$a2, 7
60:	sub	$a1, $a1, $a2
61:	chwrt	
62:	lw	$a1, 0($a1)
63:	chwrt	
64:	mov	$a0, $s1
65:	out	$a0
66:	subi	$sp, $sp, 4
67:	hlt	
