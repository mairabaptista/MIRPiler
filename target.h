#ifndef _TARGET_H_
#define _TARGET_H_

#include "cgen.h"

typedef enum opcode {
	_ADD, _ADDI, _SUB, _SUBI, _MULT, _DIV, 
	_AND, _OR, _XOR, _NOT, 
	_EQ, _NEQ, _GT, _GET, _LT, _LET,
	_MOV, _LW, _LI, _LA, _SW,
	_IN, _OUT, 
	_BEQ,
	_J, _JAL, _JR, 
	_HALT,
	_NOP, //from here, new instructions for OS
	_LW_HD, _SW_HD, _LW_MEM, _SW_MEM,
	_LCD, _SW_MEM_PROC, _CH_WRT, _CH_RD,
	_SYS_IN, _SYS_OUT, _SYS_END, _GET_PC, 
	_SET_PROC_PC, _SPRC
} Opcode;

typedef enum function {
	_DONT_CARE
} Functions;

/*registradores:
$rzero: register zero
$vX: function return register
$out: output register
$aX: function parameter register
$sX: saved registers
$tX: temporary registers
$sp: stack pointer
$ra: reseverd register -> $31
*/

typedef enum registerName {
	$rzero, $v0, $v1, $out1, $out2, $gp,
	$a0, $a1, $a2, $a3,
	$s0, $s1, $s2, $s3, $s4, $s5, $s6, $s7, $s8, $s9,
	$t0, $t1, $t2, $t3, $t4, $t5, $t6, $t7, $t8, $t9,
	$sp, $ra
} RegisterName;

typedef enum type {
	TYPE_R, TYPE_I, TYPE_J
} Type;

typedef enum addrType {
	IMED, REGI, INDEX, LABEL
} AddrType;

typedef struct objectiveOperand {
	union {
		int immediate;
		RegisterName regis;
		struct {
			RegisterName regis;
			int offset;
		} indexed;
		char *label;
	} addressing;
	AddrType addrKind;
	RegisterName regName;
	int offset;
} *ObjectiveOperand;

typedef struct scopezera {
	int argumentRegCounter;
	int savedRegCounter;
	int temporaryRegCounter;
	int paramQuantity;
	int variableQuantity;
	int memBlockSize;
	const char *name;
	int usedRegisters[10];
	struct scopezera *next;
} *Scopezera;

typedef struct regis {
	Operand op;
	RegisterName regisName;
	ObjectiveOperand objectiveOp;
	int isAddress;
} Regis;

typedef struct object {
	Opcode ops;
	Functions funct;
	Type type;
	ObjectiveOperand op1;
	ObjectiveOperand op2;
	ObjectiveOperand op3;
	struct object *next;
} *Object;

typedef struct label {
	char *name;
	int line;
	struct label *next;
} *Label;

void pushScopezera(Scopezera sc);
Scopezera createScopezera(const char *name);
Object createTargInstruction(Opcode opcode, Type type, ObjectiveOperand op1, ObjectiveOperand op2, ObjectiveOperand op3);
Object insertTargInstruction(Object obj);
ObjectiveOperand getOperandRegName(Operand op);
ObjectiveOperand getImmeadiate(int howMany);
void printCode(Object instruction);

#endif