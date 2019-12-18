/****************************************************/
/* File: util.c	                                    */
/* Utility functions Implementation                 */
/****************************************************/

#include "globals.h"
#include "util.h"
#include "cgen.h"
#include "target.h"

/* Procedure printToken prints a token
 * and its lexeme to the listing file
 */
void printToken(TokenType token, const char* tokenString) {
    switch (token) {
        case IF: fprintf(listing,"if\n"); break;
        case ELSE: fprintf(listing, "else\n"); break;
        case WHILE: fprintf(listing,"while\n"); break;
        case RETURN: fprintf(listing,"return\n"); break;
        case INT: fprintf(listing,"int\n"); break;
        case VOID: fprintf(listing,"void\n"); break;
        case PLUS: fprintf(listing,"+\n"); break;
        case MINUS: fprintf(listing,"-\n"); break;
        case MULT: fprintf(listing,"*\n"); break;
        case DIV: fprintf(listing,"/\n"); break;
        case ASSIGN: fprintf(listing, "=\n"); break;
        case LT: fprintf(listing, "<\n"); break;
        case LE: fprintf(listing, "<=\n"); break;
        case GT: fprintf(listing, ">\n"); break;
        case GE: fprintf(listing, ">=\n"); break;
        case EQ: fprintf(listing, "==\n"); break;
        case NEQ: fprintf(listing, "!=\n"); break;
        case SEMI: fprintf(listing, ";\n"); break;
        case COMMA: fprintf(listing, ",\n"); break;
        case OPAREN: fprintf(listing, "(\n"); break;
        case CPAREN: fprintf(listing, ")\n"); break;
        case OBRACKET: fprintf(listing, "[\n"); break;
        case CBRACKET: fprintf(listing, "]\n"); break;
        case OCURLY: fprintf(listing, "{\n"); break;
        case CCURLY: fprintf(listing, "}\n"); break;
        case ENDFILE: fprintf(listing, "EOF\n"); break;
        case NUM: fprintf(listing, "NUM, val= %s\n", tokenString); break;
        case ID: fprintf(listing, "ID, name= %s\n", tokenString); break;
        case ERROR: fprintf(listing, "ERROR: %s\n", tokenString); break;
        default: /* should never happen */
        fprintf(listing, "Token desconhecido: %d\n", token);
    }
}

/* Function newStmtNode creates a new statement
 * node for syntax tree construction
 */
TreeNode * newStmtNode(StmtKind kind) {
    TreeNode * t = (TreeNode *) malloc(sizeof(TreeNode));
    int i;
    if (t == NULL) {
        fprintf(listing,"Out of memory error at line %d\n",lineno);
    } else {
        for (i = 0; i < MAXCHILDREN; i++) {
            t->child[i] = NULL;
        }
        t->sibling = NULL;
        t->nodekind = Stmt;
        t->lineno = lineno;
        t->kind.stmt = kind;
    }
    return t;
}

/* Function newExpNode creates a new expression
 * node for syntax tree construction
 */
TreeNode * newExpNode(ExpKind kind) {
    TreeNode * t = (TreeNode *) malloc(sizeof(TreeNode));
    int i;
    if (t == NULL) {
        fprintf(listing,"Out of memory error at line %d\n",lineno);
    } else {
        for (i = 0; i < MAXCHILDREN; i++) {
            t->child[i] = NULL;
        }
        t->sibling = NULL;
        t->nodekind = Exp;
        t->lineno = lineno;
        t->kind.exp = kind;
    }
    return t;
}

TreeNode * newVarNode(DeclKind kind) {
    TreeNode * t = (TreeNode *) malloc(sizeof(TreeNode));
    int i;
    if (t == NULL) {
        fprintf(listing,"Out of memory error at line %d\n",lineno);
    } else {
        for (i = 0; i < MAXCHILDREN; i++) {
            t->child[i] = NULL;
        }
        t->sibling = NULL;
        t->nodekind = Decl;
        t->lineno = lineno;
        t->kind.decl.declkind = kind;
        t->kind.decl.access = Declaration;
        t->kind.decl.scope = NULL;
    }
    return t;
}

TreeNode * newSysNode(SysKind kind) {
    TreeNode * t = (TreeNode *) malloc(sizeof(TreeNode));
    int i;
    if (t == NULL) {
        fprintf(listing,"Out of memory error at line %d\n",lineno);
    } else {
        for (i = 0; i < MAXCHILDREN; i++) {
            t->child[i] = NULL;
        }
        t->sibling = NULL;
        t->nodekind = Sys;
        t->lineno = lineno;
        t->kind.sys = kind;
    }
    return t;
}

/* Function copyString allocates and makes a new
 * copy of an existing string
 */
char * copyString(char * s) {
    int n;
    char * t;

    if (s == NULL) {
        return NULL;
    }

    n = strlen(s)+1;
    t = (char *) malloc(n);

    if (t == NULL) {
        fprintf(listing,"Out of memory error at line %d\n",lineno);
    } else {
        strcpy(t,s);
    }
    return t;
}



char *copyDeclKind(DeclKind decl){
    switch(decl){
        case Id: 
            return "Variable";
        break;
        case Array: 
            return "Array";
        break;
        case Const: 
            return "Constant";
        break;
        case Function: 
            return "Function";
        break;
        case Call:
            return "Function Call";
        break;
    }
}

char *copyMemKind(MemKind mem){
    switch(mem){
        case Locals: 
            return "Local";
        break;
        case Param: 
            return "Param";
        break;
        case Globals: 
            return "Global";
        break;
        case FunMem: 
            return "-";
        break;
    }
}

char *copyExpType(ExpType exp){
    switch(exp){
        case VoidType: 
            return "Void";
        break;
        case IntegerType: 
            return "Integer";
        break;
    }
}

char *copySysKind(SysKind sys){
    switch(sys){
        case Input: 
            return "input";
        break;
        case Output: 
            return "output";
        break;
        case LoadDisk: 
            return "lhd";
        break;
        case StoreDisk: 
            return "shd";
        break;
        case LoadMem: 
            return "lmem";
        break;
        case StoreMem: 
            return "smem";
        break;
        case LCD: 
            return "lcd";
        break;
        case StoreMemProc: 
            return "smemproc";
        break;
        case ChangeWrt: 
            return "chwrt";
        break;
        case ChangeRd: 
            return "chrd";
        break;
        case Syscall: 
            return "sysend";
        break;
        case SysIn: 
            return "sysin";
        break;
        case SysOut: 
            return "sysout";
        break;
        case RecoverOs: 
            return "recover_os";
        break;
        case GetInterruption:
            return "get_interruption";
        break;
        case GetPC:
            return "get_proc_pc";
        break;
        case SetProcPC:
            return "set_proc_pc";
        break;
        case MoveOsToProc:
            return "move_OS_to_proc";
        break;
        case MoveProctoOs:
            return "move_proc_to_OS";
        break;
        case SwapProcess:
            return "swap_process";
        break;
    }
}

/* Variable indentno is used by printTree to
 * store current number of spaces to indent
 */
int indentno = 0;

/* macros to increase/decrease indentation */
#define INDENT indentno += 2
#define UNINDENT indentno -= 2

/* printSpaces indents by printing spaces */
void printSpaces(void) {
    int i;
    for (i = 0; i < indentno; i++) {
        fprintf(listing," ");
    }
}

/* procedure printTree prints a syntax tree to the
 * listing file using indentation to indicate subtrees
 */
void printTree( TreeNode * tree ) {
    int i;
    INDENT;
    while (tree != NULL) {
        printSpaces();
        if (tree->nodekind == Stmt) {
            switch (tree->kind.stmt) {
                case Integer: fprintf(listing, "int\n"); break;
                case Void: fprintf(listing, "void\n"); break;
                case If: fprintf(listing, "if\n"); break;
                case Iteration: fprintf(listing, "while\n"); break;
                case Return: fprintf(listing, "return\n");	break;
                case Compound: fprintf(listing, "Declaração Composta:\n");	break;
            }
        } else if (tree->nodekind == Exp) {
            switch (tree->kind.exp) {
                case Assign: fprintf(listing, "Atrib Op: "); printToken(tree->op, "\0"); break;
                case Relop: fprintf(listing, "Rel Op: "); printToken(tree->op, "\0"); break;
                case Arith: fprintf(listing, "Arith Op: "); printToken(tree->op, "\0"); break;
                //case LOGICK: fprintf(listing, "Logic Op: "); printToken(tree->op, "\0"); break;
                //case UNARYK: fprintf(listing, "Unary Op: "); printToken(tree->op, "\0"); break;
            }
        } else if (tree->nodekind == Decl) {
            switch (tree->kind.decl.declkind) {
                case Id: fprintf(listing, "Id: %s\n", tree->kind.decl.name); break;
                case Array: fprintf(listing, "Vector: %s\n", tree->kind.decl.name); break;
                case Const: fprintf(listing, "Const: %d\n", tree->kind.decl.value); break;
                case Function: fprintf(listing, "Function: %s\n", tree->kind.decl.name); break;
                case Call: fprintf(listing, "Function call: %s\n", tree->kind.decl.name); break;
            }
        } else if (tree->nodekind == Sys) {
            fprintf(listing, "System call: %s\n", copySysKind(tree->kind.sys));
        }
        for (i = 0; i < MAXCHILDREN; i++) {
            printTree(tree->child[i]);
        }
        tree = tree->sibling;
    }
    UNINDENT;
}

/*
 * Procedimento que reverte uma string só utilizando o operador XOR,
 * é conhecido como XOR SWAP
 */
void reverse(char * str, int length) {
    char *p1, *p2;
    for (p1 = str, p2 = str + length - 1; p2 > p1; ++p1, --p2) {
        *p1 ^= *p2;
        *p2 ^= *p1;
        *p1 ^= *p2;
    }
}

// Implementation of itoa()
char * itoa(int num, char * str, int base) {
    int i = 0;
    int isNegative = FALSE;

    /* Handle 0 explicitely, otherwise empty string is printed for 0 */
    if (num == 0) {
        str[i++] = '0';
        str[i] = '\0';
        return str;
    }

    // In standard itoa(), negative numbers are handled only with
    // base 10. Otherwise numbers are considered unsigned.
    if (num < 0 && base == 10) {
        isNegative = TRUE;
        num = -num;
    }

    // Process individual digits
    while (num != 0) {
        int rem = num % base;
        str[i++] = (rem > 9)? (rem-10) + 'a' : rem + '0';
        num = num/base;
    }

    // If number is negative, append '-'
    if (isNegative) {
        str[i++] = '-';
    }
    str[i] = '\0'; // Append string terminator

    // Reverse the string
    reverse(str, i);
    return str;
}

char *copyInstruction(InstructionKind inst){
    switch(inst){
        case ADD:
            return "addition";
        break;
        case SUB: 
            return "subtraction";
        break;
        case TIMES:
            return "multiplication";
        break;
        case OVER:
            return "division";
        break;
        case VEC:
            return "array value";
        break;
        case VEC_ADDR:
            return "array address";
        break;
        case EQUAL: 
            return "equal";
        break;
        case NE: 
            return "not equal";
        break;
        case LST: 
            return "less than";
        break;
        case LET:
            return "less than equal to";
        break;
        case GRT:
            return "greater than";
        break;
        case GET:
            return "greater than equal to";
        break;
        case ASN:
            return "assign";
        break;
        case FUNC:
            return "function";
        break;
        case RTN:
            return "return";
        break;
        case GET_PARAM: 
            return "get param";
        break;
        case SET_PARAM:
            return "set param";
        break;
        case CALL:
            return "call";
        break;
        case PARAM_LIST:
            return "param list";
        break;
        case JFALSE:
            return "jump if false";
        break;
        case GOTO:
            return "goto";
        break;
        case LBL: 
            return "label";
        break;
        case SYSCALL:
            return "syscall";
        break;
        case HALT:
            return "halt";
        break;
    }
}


const char * toOpcode(Opcode op){
    switch(op){
        case _ADD:
            return "add";
        break;
        case _ADDI:
            return "addi";
        break;
        case _SUB:
            return "sub";
        break;
        case _SUBI:
            return "subi";
        break;
        case _MULT:
            return "mult";
        break;
        case _DIV:
            return "div";
        break;
        case _AND:
            return "and";
        break;
        case _OR:
            return "or";
        break;
        case _XOR:
            return "xor";
        break;
        case _NOT: 
            return "not";
        break;
        case _EQ:
            return "eq";
        break;
        case _NEQ: 
            return "neq";
        break;
        case _GT:
            return "gt";
        break;
        case _GET:
            return "get";
        break;
        case _LT:
            return "lt";
        break;
        case _LET:
            return "let";
        break;
        case _MOV:
            return "mov";
        break;
        case _LW:
            return "lw";
        break;
        case _LI:
            return "li";
        break;
        case _LA:
            return "la";
        break;
        case _SW:
            return "sw";
        break;
        case _IN:
            return "in";
        break;
        case _OUT:
            return "out";
        break;
        case _J:
            return "j";
        break;
        case _JAL:
            return "jal";
        break;
        case _JR:
            return "jr";
        break;
        case _BEQ:
            return "beq";
        break;
        case _HALT:
            return "hlt";
        break;
        case _NOP:
            return "nop";
        break;
        case _LW_HD:
            return "lhd";
        break;
        case _SW_HD:
            return "shd";
        break;
        case _LW_MEM:
            return "lmem";
        break;
        case _SW_MEM:
            return "smem";
        break;
        case _LCD:
            return "lcd";
        break;
        case _SW_MEM_PROC:
            return "smemproc";
        break;
        case _CH_WRT:
            return "chwrt";
        break;
        case _CH_RD:
            return "chrd";
        break;
        case _SYS_END:
            return "sysend";
        break;
        case _SYS_IN:
            return "sysin";
        break;
        case _SYS_OUT:
            return "sysout";
        break;
        case _GET_PC:
            return "getpc";
        break;
        case _SET_PROC_PC:
            return "setpc";
        break;
        case _SPRC: //swap process
            return "sprc";
        break;
    }
    
}
const char * toRegName(RegisterName rn){
    switch(rn){
        case $rzero:
            return "$rzero";
        break;
        case $v0: 
            return "$v0";
        break;
        case $v1: //reserved for interrupt value
            return "$v1";
        break;
        case $out1:
            return "$out1";
        break;
        case $out2: //reserved for syscall return  
            return "$out2";
        break;
        case $gp:
            return "$gp";
        break;
        case $a0:
            return "$a0";
        break;
        case $a1:
            return "$a1";
        break;
        case $a2:
            return "$a2";
        break;
        case $a3:
            return "$a3";
        break;
        case $s0:
            return "$s0";
        break;
        case $s1:
            return "$s1";
        break;
        case $s2:
            return "$s2";
        break;
        case $s3:
            return "$s3";
        break;
        case $s4:
            return "$s4";
        break;
        case $s5:
            return "$s5";
        break;
        case $s6:
            return "$s6";
        break;
        case $s7:
            return "$s7";
        break;
        case $s8:
            return "$s8";
        break;
        case $s9:
            return "$s9";
        break;
        case $t0:
            return "$t0";
        break;
        case $t1:
            return "$t1";
        break;
        case $t2:
            return "$t2";
        break;
        case $t3:
            return "$t3";
        break;
        case $t4:
            return "$t4";
        break;
        case $t5:
            return "$t5";
        break;
        case $t6:
            return "$t6";
        break;
        case $t7:
            return "$t7";
        break;
        case $t8:
            return "$t8";
        break;
        case $t9:
            return "$t9";
        break;
        case $sp:
            return "$sp";
        break;
        case $ra:
            return "$ra";
        break;
    }
}


const char * toBinaryOpcode(Opcode op){
    switch(op){
        case _ADD:
            return "000000";
        break;
        case _ADDI:
            return "001100";
        break;
        case _SUB:
            return "000001";
        break;
        case _SUBI:
            return "001101";
        break;
        case _MULT:
            return "000111";
        break;
        case _DIV:
            return "001000";
        break;
        case _AND:
            return "000010";
        break;
        case _OR:
            return "000011";
        break;
        case _XOR:
            return "001011";
        break;
        case _NOT: 
            return "000100";
        break;
        case _EQ:
            return "011110";
        break;
        case _NEQ: 
            return "100010";
        break;
        case _GT:
            return "100000";
        break;
        case _GET:
            return "010111";
        break;
        case _LT:
            return "110000";
        break;
        case _LET:
            return "110001";
        break;
        case _MOV:
            return "011011";
        break;
        case _LW:
            return "001110";
        break;
        case _LI:
            return "001111";
        break;
        case _LA:
            return "100110";
        break;
        case _SW:
            return "010000";
        break;
        case _IN:
            return "100101";
        break;
        case _OUT:
            return "111111";
        break;
        case _J:
            return "011010";
        break;
        case _JAL:
            return "100001";
        break;
        case _JR:
            return "011001";
        break;
        case _BEQ:
            return "010010";
        break;
        case _HALT:
            return "011101";
        break;
        case _NOP:
            return "011100";
        break;
        case _LW_HD:
            return "110010";
        break;
        case _SW_HD:
            return "110011";
        break;
        case _LW_MEM:
            return "110100";
        break;
        case _SW_MEM:
            return "110101";
        break;
        case _LCD:
            return "110110";
        break;
        case _SW_MEM_PROC:
            return "110111";
        break;
        case _CH_WRT:
            return "111000";
        break;
        case _CH_RD:
            return "111001";
        break;
        case _SYS_END:
            return "111100";
        break;
        case _SYS_IN:
            return "111010";
        break;
        case _SYS_OUT:
            return "111011";
        break;
        case _GET_PC:
            return "111101";
        break;
        case _SET_PROC_PC:
            return "111110";
        break;
        case _SPRC:
            return "100111";
        break;

    }
    
}

const char * toBinaryRegister(RegisterName rn){
    switch(rn){
        case $rzero:
            return "00000";
        break;
        case $v0:
            return "00001";
        break;
        case $v1:
            return "00010";
        break;
        case $out1:
            return "00011";
        break;
        case $out2:
            return "00100";
        break;
        case $gp:
            return "00101";
        break;
        case $a0:
            return "00110";
        break;
        case $a1:
            return "00111";
        break;
        case $a2:
            return "01000";
        break;
        case $a3:
            return "01001";
        break;
        case $s0:
            return "01010";
        break;
        case $s1:
            return "01011";
        break;
        case $s2:
            return "01100";
        break;
        case $s3:
            return "01101";
        break;
        case $s4:
            return "01110";
        break;
        case $s5:
            return "01111";
        break;
        case $s6:
            return "10000";
        break;
        case $s7:
            return "10001";
        break;
        case $s8:
            return "10010";
        break;
        case $s9:
            return "10011";
        break;
        case $t0:
            return "10100";
        break;
        case $t1:
            return "10101";
        break;
        case $t2:
            return "10110";
        break;
        case $t3:
            return "10111";
        break;
        case $t4:
            return "11000";
        break;
        case $t5:
            return "11001";
        break;
        case $t6:
            return "11010";
        break;
        case $t7:
            return "11011";
        break;
        case $t8:
            return "11100";
        break;
        case $t9:
            return "11101";
        break;
        case $sp:
            return "11110";
        break;
        case $ra:
            return "11111";
        break;
    }
}


void emitSpaces(int indent){
    int i;
    for(i = 0; i < indent; ++i) {
        fprintf(code, " ");
    }
}

void emitCode(const char * c) {
    fprintf(code, "%s\n", c);
}

void emitObjectCode(const char * c, int indent) {
    emitSpaces(indent);
    fprintf(code, "%s\n", c);
    
}

void emitASM(const char * c) {
    fprintf(asm_file, "%s\n", c);
}

void emitASMCode(const char * c, int indent) {
    emitSpaces(indent);
    fprintf(asm_file, "%s\n", c);
    
}