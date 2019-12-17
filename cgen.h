/****************************************************/
/* File: cgen.h                                     */
/* The code generator interface to the TINY compiler*/
/* Compiler Construction: Principles and Practice   */
/* Kenneth C. Louden                                */
/****************************************************/

#include "globals.h"

#ifndef _CGEN_H_
#define _CGEN_H_

typedef enum {IntConst, String} OperandKind;

typedef enum InstructionKind {ADD, SUB, TIMES, OVER, VEC, VEC_ADDR,
    EQUAL, NE, LST, LET, GRT, GET, ASN,
    FUNC, RTN, GET_PARAM, SET_PARAM, CALL, PARAM_LIST,
    JFALSE, GOTO, LBL, SYSCALL, HALT} InstructionKind;

typedef struct operand {
    OperandKind kind;
    union {
        int val;        
        struct {
            char * name;
            struct ScopeRec * scope;
        } variable;
    } contents;
} * Operand;

//quadruple structure
typedef struct Quad {
    InstructionKind instruction;
    int line;
    //int offset;
    int display;
    Operand op1;
    Operand op2;
    Operand op3;
    struct Quad * next;
} * Quadruple;

typedef struct quad_list{
    Quadruple head;
} * Quad_list;

typedef struct Location {
    Quadruple * quad;
    struct Location * next;
} * LocationStack;

typedef struct Param {
    int * count;
    struct Param * next;
} * ParamStack;


Quadruple * insertQuad(Quadruple q);

Quadruple createQuad(InstructionKind instruction, Operand op1, Operand op2, Operand op3);

void updateLocation(Operand op);

void pushParam(int * count);

void popParam();

void printIntermediateCode();

Quadruple getCodigoIntermediario(void);

/* Procedure codeGen generates code to a code
 * file by traversal of the syntax tree. The
 * second parameter (codefile) is the file name
 * of the code file, and is used to print the
 * file name as a comment in the code file
 */
void codeGen(TreeNode * syntaxTree, char * codefile, CodeType codeInfo);

void checkEndOfFunction(void);

int getParamQuantity(TreeNode * functionNode);
void emitComment(const char * c, int indent);

#endif