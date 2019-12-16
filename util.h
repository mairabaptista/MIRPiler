/****************************************************/
/* File: util.h                                     */
/* Utility functions for the TINY compiler          */
/* Compiler Construction: Principles and Practice   */
/* Kenneth C. Louden                                */
/****************************************************/

#ifndef _UTIL_H_
#define _UTIL_H_

#include "cgen.h"
#include "target.h"

/* Procedure printToken prints a token
 * and its lexeme to the listing file
 */
void printToken(TokenType, const char *);

/* Function newStmtNode creates a new statement
 * node for syntax tree construction
 */
TreeNode * newStmtNode(StmtKind);

/* Function newExpNode creates a new expression
 * node for syntax tree construction
 */
TreeNode * newExpNode(ExpKind);

TreeNode * newVarNode(DeclKind);

TreeNode * newSysNode(SysKind);

/* Function copyString allocates and makes a new
 * copy of an existing string
 */
char * copyString(char *);

char *copyDeclKind(DeclKind decl);

char *copyMemKind(MemKind mem);

char *copyExpType(ExpType exp);

char *copySysKind(SysKind sys);

char *copyInstruction(InstructionKind inst);

const char * toOpcode(Opcode op);
const char * toRegName(RegisterName rn);
const char * toBinaryOpcode(Opcode op);
const char * toBinaryRegister(RegisterName rn);
void emitASM(const char * c);
void emitASMCode(const char * c, int indent);

/* procedure printTree prints a syntax tree to the
 * listing file using indentation to indicate subtrees
 */
void printTree(TreeNode *);



char * itoa(int num, char * str, int base);

#endif
