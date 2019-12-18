#include "globals.h"
#include "target.h"
#include "cgen.h"
#include "symtab.h"
#include "util.h"
//#include "code.h"
#include "util.h"

#define REG_QTY 32

#define PARAM_REG_QTY 4
#define PARAM_REG_BEG 6
#define PARAM_REG_END 9
#define SHIFT_COUNTER_PARAM_REG 6

#define SAVED_REG_BEG 10
#define SAVED_REG_END 19
#define SHIFT_COUNTER_SAVED_REG 10

#define TEMP_REG_BEG 20
#define TEMP_REG_END 29
#define SHIFT_COUNTER_TEMP_REG 20

#define REG_ZERO 0
#define RES_REG 31
#define RTN_REG 1
#define OUT_REG 3
#define SP_REG 30
#define GB_REG 5
#define INVALID_REG 4

#define INDENT indent+=4
#define UNINDENT indent-=4

#define PROGRAMA 1
#define KERNEL 0

CodeType codeInfo;

//object instruction list head
Object objectHead = NULL;

//label ist head
Label labelHead = NULL;

//current scope
Scopezera scopezers = NULL;

//indentation variable
static int indent = 0;

//auxiliary variables
static int line = 0;
static char temps[100];

ObjectiveOperand resOP; //$ra -> $31
ObjectiveOperand rtnOP; //$v0
ObjectiveOperand spOP; 	//$sp
ObjectiveOperand outOP; //$out
ObjectiveOperand zeroOP;//$rzero
ObjectiveOperand gpOP; 	//$gp

Regis registers[REG_QTY];
RegisterName regNames[REG_QTY] = {
	$rzero, $v0, $v1, $out1, $out2, $gp,
	$a0, $a1, $a2, $a3,
	$s0, $s1, $s2, $s3, $s4, $s5, $s6, $s7, $s8, $s9,
	$t0, $t1, $t2, $t3, $t4, $t5, $t6, $t7, $t8, $t9,
	$sp, $ra
};


ObjectiveOperand getMemoLocation(RegisterName regis){
	//array, we have indexed addressing mode
	ObjectiveOperand ops = (ObjectiveOperand) malloc(sizeof(struct objectiveOperand));
	ops->addrKind = INDEX;
	ops->addressing.indexed.offset = 0;
	ops->addressing.indexed.regis = regis;
	return ops;
}

ObjectiveOperand getIndexedMemoLocation(RegisterName regis, int offset){
	//array, we have indexed addressing mode
	ObjectiveOperand ops = (ObjectiveOperand) malloc(sizeof(struct objectiveOperand));
	ops->addrKind = INDEX;
	ops->addressing.indexed.offset = offset;
	ops->addressing.indexed.regis = regis;
	return ops;
}

//get operand location on global stack
ObjectiveOperand getGPLocation(Operand op){
	//get offset value from memory
	int offset = getMemoryLocation(op->contents.variable.name, op->contents.variable.scope);
	/////////o offset era so o offset//////////////////
	//int memloc = getMemoryLocation(op->contents.variable.name, op->contents.variable.scope);
	//int offset = memloc - (getTamanhoBlocoMemoriaEscopoGlobal() - 1);
	//here we have indexed addressing mode
	ObjectiveOperand ops = (ObjectiveOperand) malloc(sizeof(struct objectiveOperand));
	ops->addrKind = INDEX;
	ops->addressing.indexed.offset = offset; ///////////TESTETESTESTETESTETESTESTE
	ops->addressing.indexed.regis = regNames[GB_REG];
	return ops;
}

//get operand location on memory (stack)
ObjectiveOperand getSPLocation(Operand op){
	//we need memloc to calculate offset
	int memloc = getMemoryLocation(op->contents.variable.name, op->contents.variable.scope);
	int offset = memloc - (scopezers->memBlockSize - 1);
	//here we have indexed addressing mode
	ObjectiveOperand ops = (ObjectiveOperand) malloc(sizeof(struct objectiveOperand));
	ops->addrKind = INDEX;
	ops->addressing.indexed.offset = offset;
	ops->addressing.indexed.regis = regNames[SP_REG];
	return ops;
}

//returns stack position based on offset
ObjectiveOperand getStackLocation (int offset){
	//here we have indexed addressing mode
	ObjectiveOperand ops = (ObjectiveOperand) malloc(sizeof(struct objectiveOperand));
	ops->addrKind = INDEX;
	ops->addressing.indexed.offset = offset;
	ops->addressing.indexed.regis = regNames[SP_REG];
	return ops;
}

ObjectiveOperand getUpdateTargetOp(Regis reg, Operand op){
	reg.isAddress = FALSE;
	reg.op->kind = op->kind;
	if(op->kind == String){
		reg.op->contents.variable.name = op->contents.variable.name;
		reg.op->contents.variable.scope = op->contents.variable.scope;
	}
	else{
		reg.op->contents.val = op->contents.val;
	}

	reg.op = op;
	return reg.objectiveOp;
}

ObjectiveOperand getTargetOpByName(char *name){
	int i;

	for(i = 0; i < REG_QTY; i++){
		Regis reg = registers[i];
		char *var = reg.op->contents.variable.name;
		if(var != NULL && !strcmp(name, var)){
			return reg.objectiveOp;
		}
	}
	return NULL;
}

ObjectiveOperand getArgumentReg(int i){
	//we have four function parameter registers, $aX
	ObjectiveOperand ops = (ObjectiveOperand) malloc(sizeof(struct objectiveOperand));
	int pos;
	ops->addrKind = REGI;
	if(i < PARAM_REG_QTY){
		//get register position
		pos = SHIFT_COUNTER_PARAM_REG + i;
		ops->addressing.regis = regNames[pos];
		Regis reg = registers[pos];
		reg.objectiveOp = ops;
		return reg.objectiveOp;
	}
}


ObjectiveOperand getSyscallReg(int i){
	//we have four function parameter registers, $aX
	ObjectiveOperand ops = (ObjectiveOperand) malloc(sizeof(struct objectiveOperand));
	int pos;
	ops->addrKind = REGI;
	ops->addressing.regis = regNames[2];
	Regis reg = registers[2];
	reg.objectiveOp = ops;
	return reg.objectiveOp;
}

ObjectiveOperand getTemporaryReg(Operand op){
	//if we have used all available registers, cycle back to zero
	if(scopezers->temporaryRegCounter > 9){
		scopezers->temporaryRegCounter = 0;
	}
	int pos;
	pos = SHIFT_COUNTER_TEMP_REG + scopezers->temporaryRegCounter++;
	Regis reg = registers[pos];
	return getUpdateTargetOp(reg, op);
}

ObjectiveOperand getSavedReg(Operand op){
	//if we have used all available registers, cycle back to zero
	if(scopezers->savedRegCounter > 9){
		scopezers->savedRegCounter = 0;
	}

	int pos;
	pos = SHIFT_COUNTER_SAVED_REG + scopezers->savedRegCounter++;
	Regis reg = registers[pos];
	return getUpdateTargetOp(reg, op);
}

ObjectiveOperand getOperandRegName(Operand op){
	ObjectiveOperand rs, rt;
	//we have wo options: it's either an operand or an immediate
	if(op->kind == String){ //operand, we must lw

		rs =  getTargetOpByName(op->contents.variable.name); //get rs operand
		if(rs == NULL){
			if(op->contents.variable.scope == NULL){ //if scope is null, then it's a temporary
				//get temporary register

				rs = getTemporaryReg(op);
				rt = getTargetOpByName(op->contents.variable.name);
			}
			else if(op->contents.variable.scope == globalScope){ //we have global scope, we have to use $sX registers and $gp
				
				rs = getSavedReg(op);
				rt = getGPLocation(op);
			}
			else { //read from memory, since it's not global, use $sp
				
				rs = getSavedReg(op);
				rt = getSPLocation(op);
			}
			printCode(insertTargInstruction(createTargInstruction(_LW, TYPE_I, rs, rt, NULL)));
			//printCode(insertTargInstruction(createTargInstruction(_LW, TYPE_I, getSyscallReg(0), rt, NULL))); test to check where is v1
			rs->offset = rt->addressing.indexed.offset;
			rs->regName = rt->addressing.indexed.regis;
		}
		
	}
	else{ //immediate, we must li
		//create operand

		Operand ops = (Operand) malloc(sizeof(struct operand));
		ops->kind = String;
		ops->contents.variable.scope = NULL;

		//since it's and immediate, we only need a temporary register
		rs = getTemporaryReg(ops);
		//operand gets the register name
		ops->contents.variable.name = (char*) toRegName(rs->addressing.regis);
		//get the immediate and store in register
		rt = getImmeadiate(op->contents.val);
		printCode(insertTargInstruction(createTargInstruction(_LI, TYPE_I, rs, rt, NULL)));
	}
	return rs;
}

Label createLabel(char *name, int line){
	Label lbl = (Label) malloc (sizeof(struct label));
	lbl->name = name;
	lbl->line = line;
	lbl->next = NULL;
	return lbl;
}

void insertLabel(char *name, int line){
	Label lbl = createLabel(name, line);
	if(labelHead == NULL){
		labelHead = lbl;
	}
	else {
		Label aux = labelHead;
		while(aux->next != NULL){
			aux = aux->next;
		}
		aux->next = lbl;
	}
}


void initRegs(void){
	int i;
	for(i = 0; i < REG_QTY; i++){
		Regis reg;
		reg.op = (Operand) malloc(sizeof(struct operand));
		reg.op->contents.variable.name = NULL;
		reg.op->contents.variable.scope = NULL;
		reg.objectiveOp = (ObjectiveOperand) malloc(sizeof(struct objectiveOperand));
		reg.objectiveOp->addrKind = REGI;
		reg.objectiveOp->addressing.regis = regNames[i];
		reg.regisName = regNames[i];
		reg.isAddress = FALSE;
		registers[i] = reg;
	}
}

void initSpecialOperands(void){
	resOP = registers[RES_REG].objectiveOp;
	rtnOP = registers[RTN_REG].objectiveOp;
	spOP = registers[SP_REG].objectiveOp;
	outOP = registers[OUT_REG].objectiveOp;
	zeroOP = registers[REG_ZERO].objectiveOp;
	gpOP = registers[GB_REG].objectiveOp;
}

void removeSavedOperands(void){
	int i;
	for (i = SAVED_REG_BEG; i <= SAVED_REG_END; i++){
		Regis reg = registers[i];
		reg.op->contents.variable.name = NULL;
		reg.op->contents.variable.scope = NULL;
		reg.isAddress = FALSE;
	}
	scopezers->savedRegCounter = 0;
}

void updateRegContent(ObjectiveOperand ops){
	int i;
	for (i = SAVED_REG_BEG; i <= SAVED_REG_END; i++){
		Regis reg = registers[i];
		if(reg.op->contents.variable.name != NULL && reg.op->contents.variable.scope != NULL){
			if(reg.objectiveOp->offset == ops->addressing.indexed.offset){
				if(reg.objectiveOp->regName == ops->addressing.indexed.regis){
					printCode(insertTargInstruction(createTargInstruction(_LW, TYPE_I, reg.objectiveOp, ops, NULL)));
				}
			}
		}
	}
}

Scopezera createScopezera(const char *name){
	int i;
	Scopezera sc = (Scopezera) malloc(sizeof(struct scopezera));
	sc->argumentRegCounter = 0;
	sc->savedRegCounter = 0;
	sc->temporaryRegCounter = 0;
	//each scope has a bucket
	BucketList buck = checkInBucketFunction((char *)name);
	// /BucketList bucks = checkInBucket((char *)name, 1);
	sc->paramQuantity = getQuantidadeParametros(buck->treeNode);
	sc->variableQuantity = getQuantidadeVariaveis(buck->treeNode);
	sc->memBlockSize = getTamanhoBlocoMemoriaEscopo((char*)name);
	sc->name = name;

	for(i = 0; i < 10; i++){
		sc->usedRegisters[i] = FALSE;
	}

	sc->next = NULL;
	return sc;
}

void pushScopezera(Scopezera sc){
	if(scopezers == NULL){
		scopezers = sc;
	}
	else{
		sc->next = scopezers;
		scopezers = sc;
		//saved operands must be cleared for every new scope
		removeSavedOperands();
	}
}

ObjectiveOperand getImmeadiate(int howMany){
	ObjectiveOperand immediate = (ObjectiveOperand) malloc(sizeof(struct objectiveOperand));
	immediate->addrKind = IMED;
	immediate->addressing.immediate = howMany;
	return immediate;
}

ObjectiveOperand getLabel(char *name){
	ObjectiveOperand label = (ObjectiveOperand) malloc(sizeof(struct objectiveOperand));
	label->addrKind = LABEL;
	label->addressing.label = name;
	return label;
}

ObjectiveOperand getArrayName(Operand op){
	ObjectiveOperand rs, rt;
	TreeNode *treeNode;
	rs = getTargetOpByName(op->contents.variable.name);
	if(rs == NULL){
		rs = getSavedReg(op);
		if(op->contents.variable.scope == globalScope){	//array is a global variable
			//get the memory address at the beginning of the array
			rt = getGPLocation(op);
			printCode(insertTargInstruction(createTargInstruction(_LA, TYPE_I, rs, rt, NULL))); 
			registers[(int) rs->addressing.regis].isAddress = TRUE;
		}
		else{	//we need to check if the array is a function parameter or if it was declared on this scope
			treeNode = getVarFromSymtab(op->contents.variable.name, op->contents.variable.scope)->treeNode;
			rt = getSPLocation(op);
			if(treeNode->kind.decl.mem == Param){ //is a function parameter
				//load pointer to array
				printCode(insertTargInstruction(createTargInstruction(_LW, TYPE_I, rs, rt, NULL)));
			}
			else{ //declared on current scope
				//load memory address at the beginning of the array
				printCode(insertTargInstruction(createTargInstruction(_LA, TYPE_I, rs, rt, NULL)));
				registers[(int) rs->addressing.regis].isAddress = TRUE;
			}
		}
	} 
	rs->offset = rt->addressing.indexed.offset;
	rs->regName = rt->addressing.indexed.regis;
	return rs;
}

Object createTargInstruction(Opcode opcode, Type type, ObjectiveOperand op1, ObjectiveOperand op2, ObjectiveOperand op3 ){
	Object obj = (Object) malloc(sizeof(struct object));
	obj->ops = opcode;
	obj->funct = _DONT_CARE;
	obj->type = type;
	obj->op1 = op1;
	obj->op2 = op2;
	obj->op3 = op3;
	obj->next = NULL;
	return obj;
}

Object insertTargInstruction(Object obj){
	if(objectHead == NULL){
		objectHead = obj;
	}
	else{
		Object aux = objectHead;
		while(aux->next != NULL){
			aux = aux->next;
		}
		aux->next = obj;
	}
	return obj;
}


void saveRegisters(int stackLocation){
	int i;
	for (i = SAVED_REG_BEG; i <= SAVED_REG_END; i++){
		Regis reg = registers[i];
		ObjectiveOperand rt;
		int saveFlag = FALSE;
		if(reg.isAddress){
			reg.isAddress = FALSE;
			reg.op->contents.variable.name = NULL;
			reg.op->contents.variable.scope = NULL;
		}
		else{
			if(reg.op->contents.variable.scope != NULL){
				rt = getSPLocation(reg.op);
				saveFlag = TRUE;
			}
			else if (reg.op->contents.variable.scope == NULL && reg.op->contents.variable.name != NULL){
				rt = getStackLocation(stackLocation);
				saveFlag = TRUE;
			}
			if(saveFlag == TRUE){
				scopezers->usedRegisters[i - SAVED_REG_BEG] = TRUE;
				printCode(insertTargInstruction(createTargInstruction(_SW, TYPE_I, reg.objectiveOp, rt, NULL)));
			}
		}
	}
}

void loadRegisters (int stackLocation){
	int i;
	for(i = SAVED_REG_BEG; i <= SAVED_REG_END; i++){
		Regis reg = registers[i];
		ObjectiveOperand rt;
		int loadFlag = FALSE;
		int registerWasSaved = scopezers->usedRegisters[i - SAVED_REG_BEG];

		if(registerWasSaved){
			if(reg.op->contents.variable.scope != NULL){
				rt = getSPLocation(reg.op);
				loadFlag = TRUE;
			}
			else if(reg.op->contents.variable.scope == NULL && reg.op->contents.variable.name != NULL){
				rt = getStackLocation(stackLocation);
				loadFlag = TRUE;
			}
			if(loadFlag == TRUE){
				printCode(insertTargInstruction(createTargInstruction(_LW, TYPE_I, reg.objectiveOp, rt, NULL)));
			}
		}
	}
}

void pushStackPointer(int howMany){
	printCode(insertTargInstruction(createTargInstruction(_ADDI, TYPE_R, spOP, spOP, getImmeadiate(howMany))));
}

void popStackPointer(int howMany){
	printCode(insertTargInstruction(createTargInstruction(_SUBI, TYPE_R, spOP, spOP, getImmeadiate(howMany))));
}

void generateTypeIInstruction(Quadruple q, Opcode op){
	ObjectiveOperand op1, op2, op3;
	Opcode opFinal;
	switch(op){
		case _ADD:
			opFinal = _ADDI;
		break;
		case _SUB:
			opFinal = _SUBI;
		break;
	}
	//get a register for op1
	op1 = getOperandRegName(q->op1);
	//get the immediate value
	op2 = getImmeadiate(q->op2->contents.val);
	//assign a temporary register for result
	op3 = getTemporaryReg(q->op3);
	printCode(insertTargInstruction(createTargInstruction(opFinal, TYPE_I, op3, op1, op2)));
}



void generateTypeRInstruction(Quadruple q, Opcode op){
	ObjectiveOperand op1, op2, op3;
	
	//verify if op2 is a register or immediate
	if(q->op2->kind == String){ //register
		//get a register for op1
		op1 = getOperandRegName(q->op1);
		//get a register for op2
		op2 = getOperandRegName(q->op2);
		//assign a temporary register for operation result
		op3 = getTemporaryReg(q->op3);
		printCode(insertTargInstruction(createTargInstruction(op, TYPE_R, op3, op1, op2)));
	}
	else{ //immediate
		generateTypeIInstruction(q, op);
	}

}

void generateTargetFunction(Quadruple q){
	memset(temps, '\0', sizeof(temps));
	strcat(temps, "\n");
	strcat(temps, q->op1->contents.variable.name);
	strcat(temps, ":");
	//insert label HERE!
	insertLabel(q->op1->contents.variable.name, line);
	emitCode(temps);
	emitASM(temps);
	//PUSH SCOPE HERE
	//saved operands must be cleared for every new scope
	pushScopezera(createScopezera(q->op1->contents.variable.name));
	
	//we either have main or another function
	if(strcmp(scopezers->name, "main")){ //we are not at main
		//push stack pointer to memory block size
		//plus 1 for ra register
		//plus 1 for return
		pushStackPointer(scopezers->memBlockSize + 2);
	}
	else{ //we are at main
		int tamanho = getTamanhoBlocoMemoriaEscopoGlobal();
		if(tamanho > 0){ //if this happens then we have global variables
			//global scope pointer must be used
			printCode(insertTargInstruction(createTargInstruction(_ADDI, TYPE_I, spOP, gpOP, getImmeadiate(1)))); ////////aqui era tamanho/////////////

		}
		pushStackPointer(scopezers->memBlockSize + tamanho + 1);
	}

}

void generateTargetAssignment(Quadruple q){
	//get operand
	//we get operand 2 since it's the thing we are assigning
	ObjectiveOperand reg = getOperandRegName(q->op2);
	if(q->op1->contents.variable.scope == NULL){ //array with a variable as index
		ObjectiveOperand reg2 = getOperandRegName(q->op1);
		//ObjectiveOperand regteste = getSPLocation(q->op1);
		printCode(insertTargInstruction(createTargInstruction(_SW, TYPE_I, reg, getMemoLocation(reg2->addressing.regis), NULL)));
		//printCode(insertTargInstruction(createTargInstruction(_SW, TYPE_I, reg, regteste, NULL)));
	}
	else if (q->op1->contents.variable.scope == globalScope){ //variable is global
		if(q->op3 != NULL){ //array with constant as index
			ObjectiveOperand reg2 = getOperandRegName(q->op1);
			printCode(insertTargInstruction(createTargInstruction(_SW, TYPE_I, reg, getIndexedMemoLocation(reg2->addressing.regis, q->op3->contents.val), NULL)));			
			//printCode(insertTargInstruction(createTargInstruction(_SW, TYPE_I, reg, getSPLocation(q->op1), NULL)));
			
		}
		else { //regular variable
			ObjectiveOperand opers = getGPLocation(q->op1);
			printCode(insertTargInstruction(createTargInstruction(_SW, TYPE_I, reg, opers, NULL)));
			updateRegContent(opers);
		}
	}
	else{ //non global variable
		if(q->op3 != NULL){ //array with constant as index
			ObjectiveOperand reg2 = getOperandRegName(q->op1);
			printCode(insertTargInstruction(createTargInstruction(_SW, TYPE_I, reg, getIndexedMemoLocation(reg2->addressing.regis, q->op3->contents.val), NULL)));
			//printCode(insertTargInstruction(createTargInstruction(_SW, TYPE_I, reg, getSPLocation(q->op1), NULL)));
			
		}
		else{ //regular variable
			ObjectiveOperand opers = getSPLocation(q->op1);
			//printCode(insertTargInstruction(createTargInstruction(_SW, TYPE_I, getSyscallReg(0), opers, NULL))); V1 IS HERE
			printCode(insertTargInstruction(createTargInstruction(_SW, TYPE_I, reg, opers, NULL)));
			updateRegContent(opers);
		}
	}
}

void generateTargetReturn(Quadruple q){
	//Only return if we are not at main scope
	//if(strcmp(scopezers->name, "main") == 1){	//not main
		//check if there is anything to return 
		//printf("teste\n");
		if(q->op1 != NULL){
			ObjectiveOperand reg = getOperandRegName(q->op1);
			printCode(insertTargInstruction(createTargInstruction(_MOV, TYPE_I, rtnOP, reg, NULL)));
		}
		printCode(insertTargInstruction(createTargInstruction(_JR, TYPE_R, resOP, NULL, NULL)));
	//}
}

void generateTargetCall(Quadruple q, CodeType codeInfo){
	int memBlockSize;
	int memBlockSizeCurrentScope;
	//verify if input or output
	//if input we need instructions that complement it (nop)
	if((strcmp(q->op1->contents.variable.name, "input") == 0) && (codeInfo == KERNEL)){ //input
		printCode(insertTargInstruction(createTargInstruction(_NOP, TYPE_I, NULL, NULL, NULL)));
		//ObjectiveOperand reg = getTemporaryReg(q->op3);
		printCode(insertTargInstruction(createTargInstruction(_IN, TYPE_I, getTemporaryReg(q->op3), NULL, NULL)));		
	}
	else if((strcmp(q->op1->contents.variable.name, "input") == 0) && (codeInfo == PROGRAMA)){ //input from a process
		printCode(insertTargInstruction(createTargInstruction(_NOP, TYPE_I, NULL, NULL, NULL)));
		printCode(insertTargInstruction(createTargInstruction(_SYS_IN, TYPE_I, NULL, NULL, NULL)));
		printCode(insertTargInstruction(createTargInstruction(_NOP, TYPE_I, NULL, NULL, NULL)));
		}

	else if((strcmp(q->op1->contents.variable.name, "output") == 0) && (codeInfo == KERNEL)){ //output
		printCode(insertTargInstruction(createTargInstruction(_NOP, TYPE_I, NULL, NULL, NULL)));
		printCode(insertTargInstruction(createTargInstruction(_OUT, TYPE_I, getArgumentReg(0), NULL, NULL)));
	}
	else if((strcmp(q->op1->contents.variable.name, "output") == 0) && (codeInfo == PROGRAMA)){ //output from a process
		printCode(insertTargInstruction(createTargInstruction(_NOP, TYPE_I, NULL, NULL, NULL)));
		printCode(insertTargInstruction(createTargInstruction(_SYS_OUT, TYPE_I, NULL, NULL, NULL)));
		printCode(insertTargInstruction(createTargInstruction(_NOP, TYPE_I, NULL, NULL, NULL)));
		}
	else if(!strcmp(q->op1->contents.variable.name, "lhd")) { //load from disk
        printCode(insertTargInstruction(createTargInstruction(_LW_HD, TYPE_I, getTemporaryReg(q->op3), getArgumentReg(0), NULL)));
    } 
	else if(!strcmp(q->op1->contents.variable.name, "shd")) { //store on disk
        printCode(insertTargInstruction(createTargInstruction(_SW_HD, TYPE_I, getArgumentReg(0), getArgumentReg(1), NULL)));
    }
	else if(!strcmp(q->op1->contents.variable.name, "lmem")) { //load from memory
        printCode(insertTargInstruction(createTargInstruction(_LW_MEM, TYPE_I, getTemporaryReg(q->op3), NULL, NULL)));
    } 
	else if(!strcmp(q->op1->contents.variable.name, "smem")) { //store on memory (bios)
        printCode(insertTargInstruction(createTargInstruction(_SW_MEM, TYPE_I, getArgumentReg(0), getArgumentReg(1), NULL)));
	}
	else if(!strcmp(q->op1->contents.variable.name, "smemproc")) { //store on memory (proc)
        printCode(insertTargInstruction(createTargInstruction(_SW_MEM_PROC, TYPE_I, getArgumentReg(0), getArgumentReg(1), NULL)));
	}
	else if(!strcmp(q->op1->contents.variable.name, "lcd")) { //outputs something to lcd
		//printCode(insertTargInstruction(createTargInstruction(_LCD, TYPE_I, getTemporaryReg(), rt, NULL)));
        printCode(insertTargInstruction(createTargInstruction(_LCD, TYPE_I, getArgumentReg(0), NULL, NULL)));
	}
	else if(!strcmp(q->op1->contents.variable.name, "chwrt")) { //changes the write shift, takes no argument
        printCode(insertTargInstruction(createTargInstruction(_CH_WRT, TYPE_I, NULL, NULL, NULL)));
	}
	else if(!strcmp(q->op1->contents.variable.name, "chrd")) { //changes the read shift, takes no argument
        printCode(insertTargInstruction(createTargInstruction(_CH_RD, TYPE_I, NULL, NULL, NULL)));
	}
	else if(!strcmp(q->op1->contents.variable.name, "recover_os")) { //recorvers the OS by changing the read shift then the write shift
		printCode(insertTargInstruction(createTargInstruction(_NOP, TYPE_I, NULL, NULL, NULL)));
        printCode(insertTargInstruction(createTargInstruction(_CH_RD, TYPE_I, NULL, NULL, NULL)));
		printCode(insertTargInstruction(createTargInstruction(_CH_WRT, TYPE_I, NULL, NULL, NULL)));
		printCode(insertTargInstruction(createTargInstruction(_NOP, TYPE_I, NULL, NULL, NULL)));
	}
	//////////////////////////////check if it's working/////////////////////////////////////////////
	else if(!strcmp(q->op1->contents.variable.name, "get_interruption")) { //get interruption number 
		//muda pra quem????????? Sera que eh o op3?
        printCode(insertTargInstruction(createTargInstruction(_MOV, TYPE_I, getTemporaryReg(q->op3), getSyscallReg(0), NULL)));
	}
	//////////////////////////////check if it's working/////////////////////////////////////////////
	else if(!strcmp(q->op1->contents.variable.name, "get_proc_pc")) { //gets pc for process
		printCode(insertTargInstruction(createTargInstruction(_GET_PC, TYPE_I, NULL, NULL, NULL)));
		//muda pra quem????????? Sera que eh o op3?
        printCode(insertTargInstruction(createTargInstruction(_MOV, TYPE_I, getTemporaryReg(q->op3), getSyscallReg(0), NULL)));
	}
	else if(strcmp(scopezers->name, "main") == 0){
		removeSavedOperands();
		memBlockSize = getTamanhoBlocoMemoriaEscopo(q->op1->contents.variable.name);
		memBlockSizeCurrentScope = scopezers->memBlockSize;
		//we need to save the registers before goinf into anothe function
		//saveRegisters(-memBlockSize); //negative because of the sp's index
		printCode(insertTargInstruction(createTargInstruction(_SW, TYPE_I, resOP, getStackLocation(-memBlockSizeCurrentScope), NULL)));
		printCode(insertTargInstruction(createTargInstruction(_JAL, TYPE_J, getLabel(q->op1->contents.variable.name), NULL, NULL)));

		//pop memory block from stack
		popStackPointer(memBlockSize + 2);

		printCode(insertTargInstruction(createTargInstruction(_LW, TYPE_I, resOP, getStackLocation(-memBlockSizeCurrentScope), NULL)));
		printCode(insertTargInstruction(createTargInstruction(_MOV, TYPE_I, getSavedReg(q->op3), rtnOP, NULL)));
		
		//we need to load the registers we saved
		//loadRegisters(-memBlockSize); //negative because of the sp's index
	}
	else{
		removeSavedOperands();
		memBlockSizeCurrentScope = scopezers->memBlockSize;
		memBlockSize = getTamanhoBlocoMemoriaEscopo(q->op1->contents.variable.name);
		int registerAddrStackLocation = memBlockSizeCurrentScope;
		printCode(insertTargInstruction(createTargInstruction(_SW, TYPE_I, resOP, getStackLocation(-registerAddrStackLocation), NULL))); //sw $ra
		//saveRegisters(-memBlockSize);
		printCode(insertTargInstruction(createTargInstruction(_JAL, TYPE_J, getLabel(q->op1->contents.variable.name), NULL, NULL)));
		//pop memory block from stack
		popStackPointer(memBlockSize + 2);
		printCode(insertTargInstruction(createTargInstruction(_LW, TYPE_I, resOP, getStackLocation(-registerAddrStackLocation), NULL))); //lw $ra
		//saveRegisters(-memBlockSize);
		printCode(insertTargInstruction(createTargInstruction(_MOV, TYPE_I, getSavedReg(q->op3), rtnOP, NULL)));
	}

}
 void generateTargetSetParam(Quadruple q, CodeType codeInfo){
 	ObjectiveOperand reg;
	ObjectiveOperand sysreg;
 	BucketList buck = NULL;
 	//if we have a variable then we must get corresponding bucket list
 	if(q->op1->kind == String && q->op1->contents.variable.scope != NULL){
 		buck = getVarFromSymtab(q->op1->contents.variable.name, q->op1->contents.variable.scope);
 	}
 	//we can only have 4 parameters
 	if(scopezers->argumentRegCounter < 4){
 		if(q->op1->kind == String){ //Variable
 			ObjectiveOperand argument = getArgumentReg(scopezers->argumentRegCounter);
 			if(buck != NULL && buck->treeNode->nodekind == Decl && buck->treeNode->kind.decl.declkind == Array){ //array
 				if(q->op1->contents.variable.scope == globalScope){
 					printCode(insertTargInstruction(createTargInstruction(_LA, TYPE_I, argument, getGPLocation(q->op1), NULL)));
 					registers[(int) argument->addressing.regis].isAddress = TRUE;
 				}
 				else if(strcmp(scopezers->name, "main") == 0){
 					printCode(insertTargInstruction(createTargInstruction(_LA, TYPE_I, argument, getSPLocation(q->op1), NULL)));
 					registers[(int) argument->addressing.regis].isAddress = TRUE;
 				}
 				else{
 					printCode(insertTargInstruction(createTargInstruction(_LW, TYPE_I, argument, getSPLocation(q->op1), NULL)));
 					registers[(int) argument->addressing.regis].isAddress = TRUE;

 				}
 				////////there wasnt any differentiation between global and normal scope
 				/*if(q->op1->contents.variable.scope == globalScope){
 					printCode(insertTargInstruction(createTargInstruction(_LA, TYPE_I, argument, getGPLocation(q->op1), NULL)));
 					registers[(int) argument->addressing.regis].isAddress = TRUE;
 				}
 				else{
 					printCode(insertTargInstruction(createTargInstruction(_LA, TYPE_I, argument, getSPLocation(q->op1), NULL)));
 					registers[(int) argument->addressing.regis].isAddress = TRUE;
 				}*/
 				
 				
 			}
 			else { //variable
 				reg = getOperandRegName(q->op1);
				sysreg = getSyscallReg(0);
 				if((getArgumentReg(scopezers->argumentRegCounter)->addressing.regis != reg->addressing.regis)){
 					printCode(insertTargInstruction(createTargInstruction(_MOV, TYPE_I, argument, reg, NULL)));
 				}
				/*else if((getArgumentReg(scopezers->argumentRegCounter)->addressing.regis != reg->addressing.regis) && (codeInfo == PROGRAMA)){
 					printCode(insertTargInstruction(createTargInstruction(_MOV, TYPE_I, sysreg, reg, NULL)));
 				}*/
 			}
 		}
 		else { //constant
 			printCode(insertTargInstruction(createTargInstruction(_LI, TYPE_I, getArgumentReg(scopezers->argumentRegCounter), getImmeadiate(q->op1->contents.val), NULL)));
 		}
 		scopezers->argumentRegCounter++;
 	}
 	else{ //more than 4 parameters
 		ObjectiveOperand rs = getSavedReg(q->op1);
 		ObjectiveOperand rt;
 		Opcode ops;
 		//Is it a constante or a variable?
 		if(q->op1->kind == String){	//Variable
 			if(buck != NULL && buck->treeNode->nodekind == Decl && buck->treeNode->kind.decl.declkind == Array){	//array
 				ops = _LA;
 				registers[(int) rs->addressing.regis].isAddress = TRUE;
 			}
 			else{	//regular variables
 				ops = _LW;
 			}
 			rt = getSPLocation(q->op1);
 		}
 		else{	//constant
 			ops = _LI;
 			rt = getImmeadiate(q->op1->contents.val);
 		}	
 		printCode(insertTargInstruction(createTargInstruction(ops, TYPE_I, rs, rt, NULL)));
 		printCode(insertTargInstruction(createTargInstruction(_SW, TYPE_I, rs, getSPLocation(q->op1), NULL)));
 	}
 }

 void generateRelationalInstruction(Quadruple q, Opcode op){
 	ObjectiveOperand op1, op2, op3;
 	//get register for operand 1
 	op1 = getOperandRegName(q->op1);
 	//get register for operadn 2
 	op2 = getOperandRegName(q->op2);
 	//assign a register for result
 	op3 = getTemporaryReg(q->op3);
 	printCode(insertTargInstruction(createTargInstruction(op, TYPE_R, op3, op1, op2)));

 }

void generateBranch(Quadruple q){
	ObjectiveOperand op1 = getOperandRegName(q->op1);
	ObjectiveOperand op2 = getLabel(q->op2->contents.variable.name);
	printCode(insertTargInstruction(createTargInstruction(_BEQ, TYPE_I, op1, zeroOP, op2)));
}

void generateTargetLabel(Quadruple q){
	memset(temps, '\0', sizeof(temps));
	strcat(temps, ".");
	strcat(temps, q->op1->contents.variable.name);
	strcat(temps, "\t");
	insertLabel(q->op1->contents.variable.name, line);
	emitCode(temps);
	emitASM(temps);
}

void generateTargetGetParam(Quadruple q){
	//up to four function parameters
	if(scopezers->argumentRegCounter < 4){
		ObjectiveOperand argument = getArgumentReg(scopezers->argumentRegCounter);
		printCode(insertTargInstruction(createTargInstruction(_SW, TYPE_I, argument, getSPLocation(q->op1), NULL)));
		scopezers->argumentRegCounter++;
	}
	else if(scopezers->argumentRegCounter >= 4){
		ObjectiveOperand argument = getSavedReg(q->op1);
		printCode(insertTargInstruction(createTargInstruction(_LW, TYPE_I, argument, getSPLocation(q->op1), NULL)));
	}
}

void generateTargetArray(Quadruple q){
	//get array address
	ObjectiveOperand reg = getArrayName(q->op1);
	//is index a constant or a variable?
	if(q->op2->kind == String){	//variable
		//load array value on a temporary
		ObjectiveOperand temporary = getTemporaryReg(q->op3);
		printCode(insertTargInstruction(createTargInstruction(_ADD, TYPE_R, temporary, reg, getOperandRegName(q->op2))));
		printCode(insertTargInstruction(createTargInstruction(_LW, TYPE_I, temporary, getIndexedMemoLocation(temporary->addressing.regis, 0), NULL)));
	}
	else{	//constant
		printCode(insertTargInstruction(createTargInstruction(_LW, TYPE_I, getTemporaryReg(q->op3), getIndexedMemoLocation(reg->addressing.regis, q->op2->contents.val), NULL)));
	}
}

void generateTargetArrayAddress(Quadruple q){
	//get array address
	ObjectiveOperand reg = getArrayName(q->op1);
	//is index a constant or a variable?
	if(q->op2->kind == String){
		//add base address and variable value
		ObjectiveOperand temporary = getTemporaryReg(q->op3);
		printCode(insertTargInstruction(createTargInstruction(_ADD, TYPE_R, temporary, reg, getOperandRegName(q->op2))));
	}
}

void geraCodigoObjeto(Quadruple q, CodeType codeInfo){
	INDENT;
	emitCode("\n////////////Codigo Objeto////////////");
	
	//initializa registers
	initRegs();
	//initialize special operands
	initSpecialOperands();
	while(q != NULL){
		switch(q->instruction){
			//arithemthic instructions
			case ADD:
				generateTypeRInstruction(q, _ADD);
				break;
			case SUB: 
				generateTypeRInstruction(q, _SUB);
				break;
			case TIMES:
				generateTypeRInstruction(q, _MULT);
				break;
			case OVER:
				generateTypeRInstruction(q, _DIV);
				break;    
			
			//relational instructions
    		case EQUAL:
    			generateRelationalInstruction(q, _EQ);
    			break;
    		case NE:
    			generateRelationalInstruction(q, _NEQ);
    			break;
    		case LST:
    			generateRelationalInstruction(q, _LT);
    			break;
    		case LET:
    			generateRelationalInstruction(q, _LET);
    			break;
    		case GRT:
    			generateRelationalInstruction(q, _GT);
    			break;
    		case GET:
    			generateRelationalInstruction(q, _GET);
    			break;

			//attribution instructions
    		case ASN:
    			generateTargetAssignment(q);
    			break;

			//arrays
    		case VEC: 
    			generateTargetArray(q);
    			break;
    		case VEC_ADDR:	
    			generateTargetArrayAddress(q);
    			break;

			//functions
    		case FUNC:
    			generateTargetFunction(q);
    			scopezers->savedRegCounter = 0;
    			break;
    		case RTN:
    			generateTargetReturn(q);
    			break;
    		case GET_PARAM:
    			generateTargetGetParam(q);
    			break;
    		case SET_PARAM:
    			generateTargetSetParam(q, codeInfo);
    			break;
    		case CALL:
    			generateTargetCall(q, codeInfo);
    			scopezers->argumentRegCounter = 0;
    			break;
    		case PARAM_LIST:
    			scopezers->argumentRegCounter = 0;
    			break;
			//jumps
    		case JFALSE:
    			generateBranch(q);
    			break;
    		case GOTO:
    			//simple jump
    			printCode(insertTargInstruction(createTargInstruction(_J, TYPE_J, getLabel(q->op1->contents.variable.name), NULL, NULL)));
    			break;
			//labels
    		case LBL: 
    			generateTargetLabel(q);
    			removeSavedOperands();
    			break;
			//halt
			/*case HALT:
				printCode(insertTargInstruction(createTargInstruction(_HALT, TYPE_I, NULL, NULL, NULL)));
				break;
			//syscall
			
			case SYSCALL:
				printf("eita");
				printCode(insertTargInstruction(createTargInstruction(_SYS_END, TYPE_I, NULL, NULL, NULL)));
				break;*/
		}
		q = q->next;
	}
	if(codeInfo == PROGRAMA){
		
		popStackPointer(scopezers->memBlockSize + 1);
		printCode(insertTargInstruction(createTargInstruction(_SYS_END, TYPE_I, NULL, NULL, NULL)));
	}
	else if (codeInfo == KERNEL){
		
		popStackPointer(scopezers->memBlockSize + 1); //was it supposed to be 2?
		printCode(insertTargInstruction(createTargInstruction(_HALT, TYPE_I, NULL, NULL, NULL)));
	}
	/* antes soh tinha a popstackpointer e o dedicado de halt
	popStackPointer(scopezers->memBlockSize + 1); //was it supposed to be 2?
	printCode(insertTargInstruction(createTargInstruction(_HALT, TYPE_I, NULL, NULL, NULL)));
	*/
}	

void printCode(Object instruction){
	char aux[20];
	memset(temps, '\0', sizeof(temps));
	sprintf(temps, "%d:\t", line++);
	strcat(temps, toOpcode(instruction->ops));
	
	strcat(temps, "\t");
	//print the operands
	if(instruction->op1 != NULL){
		//instructio can have four addressing types
		//immediate, register, indexed, label
		if(instruction->op1->addrKind == IMED){	//immediate
			sprintf(aux, "%d", instruction->op1->addressing.immediate);
			strcat(temps, aux);
		}
		else if (instruction->op1->addrKind == REGI){	//register
			strcat(temps, toRegName(instruction->op1->addressing.regis));
		}
		else if (instruction->op1->addrKind == INDEX){	//indexed
			sprintf(aux, "%d(%s)", instruction->op1->addressing.indexed.offset, toRegName(instruction->op1->addressing.indexed.regis));
			strcat(temps, aux);
		}
		else{	//label
			strcat(temps, instruction->op1->addressing.label);
		}
	}
	if (instruction->op2 != NULL){
		strcat(temps, ", ");
		//instructio can have four addressing types
		//immediate, register, indexed, label
		if(instruction->op2->addrKind == IMED){	//immediate
			sprintf(aux, "%d", instruction->op2->addressing.immediate);
			strcat(temps, aux);
		}
		else if (instruction->op2->addrKind == REGI){	//register
			strcat(temps, toRegName(instruction->op2->addressing.regis));
		}
		else if (instruction->op2->addrKind == INDEX){	//indexed
			sprintf(aux, "%d(%s)", instruction->op2->addressing.indexed.offset, toRegName(instruction->op2->addressing.indexed.regis));
			strcat(temps, aux);
		}
		else{	//label
			strcat(temps, instruction->op2->addressing.label);
		}
	}
	if (instruction->op3 != NULL){
		strcat(temps, ", ");
		//instructio can have four addressing types
		//immediate, register, indexed, label
		if(instruction->op3->addrKind == IMED){	//immediate
			sprintf(aux, "%d", instruction->op3->addressing.immediate);
			strcat(temps, aux);
		}
		else if (instruction->op3->addrKind == REGI){	//register
			strcat(temps, toRegName(instruction->op3->addressing.regis));
		}
		else if (instruction->op3->addrKind == INDEX){	//indexed
			sprintf(aux, "%d(%s)", instruction->op3->addressing.indexed.offset, toRegName(instruction->op3->addressing.indexed.regis));
			strcat(temps, aux);
		}
		else{	//label
			strcat(temps, instruction->op3->addressing.label);
		}
	}
	emitObjectCode(temps, indent);
	emitASMCode(temps, indent);
}

int getLabelLine(char *name){
	Label l;
	if(labelHead != NULL){
		l = labelHead;
	}
	while(l != NULL){
		if(!strcmp(name, l->name)){
			return l->line + 1;
		}
		l = l->next;
	}
	return -1;
}


