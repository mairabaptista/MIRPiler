/****************************************************/
/* File: globals.h                                  */
/* Yacc/Bison Version                               */
/* Global types and vars for C- compiler            */
/* must come before other include files             */
/****************************************************/

#ifndef _GLOBALS_H_
#define _GLOBALS_H_

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

/* Yacc/Bison generates internally its own values
 * for the tokens. Other files can access these values
 * by including the tab.h file generated using the
 * Yacc/Bison option -d ("generate header")
 *
 * The YYPARSER flag prevents inclusion of the tab.h
 * into the Yacc/Bison output itself
 */

#ifndef YYPARSER

/* the name of the following file may change */
#include "cminus.tab.h"

/* ENDFILE is implicitly defined by Yacc/Bison,
 * and not included in the tab.h file
 */
#define ENDFILE 0

#endif

#ifndef FALSE
#define FALSE 0
#endif

#ifndef TRUE
#define TRUE 1
#endif

/* MAXRESERVED = the number of reserved words */
#define MAXRESERVED 8

/* Yacc/Bison generates its own integer values
 * for tokens
 */
typedef int TokenType;

extern FILE* source; /* source code text file */
extern FILE* listing; /* listing output text file */
extern FILE* code; /* code text file for TM simulator */
extern FILE* asm_file;

extern int lineno; /* source line number for listing */

/**************************************************/
/***********   Syntax tree for parsing ************/
/**************************************************/

typedef enum {Stmt, Exp, Decl, Sys} NodeKind;
typedef enum {Integer, Void, If, Iteration, Return, Compound} StmtKind;
typedef enum {Assign, Relop, Arith} ExpKind;
typedef enum {Id, Array, Const, Function, Call} DeclKind;
typedef enum {Input, Output, LoadDisk, StoreDisk, LoadMem, StoreMem,
              LCD, StoreMemProc, ChangeWrt, ChangeRd, Syscall} SysKind; //reserved for syscalls
typedef enum {Declaration, Access} AccessKind;
typedef enum {Locals, Param, Globals, FunMem} MemKind;

/* ExpType é usado para checagem de tipos */
typedef enum exp {VoidType, IntegerType} ExpType;

/* Used to select the type of code generation */
typedef enum {KERNEL, PROGRAMA} CodeType;

#define MAXCHILDREN 3

typedef struct DeclIdentifier {
    DeclKind declkind;
    MemKind mem;
    AccessKind access;
    struct ScopeRec *scope;
    int value;
    char *name;
    int ops;    //deprecated
    char *t_type; //deprecated
} DeclIdentifier;

typedef struct treeNode {
    struct treeNode * child[MAXCHILDREN];
    struct treeNode * sibling;
    NodeKind nodekind;
    int lineno;
    int col; //deprecated
    union {
        StmtKind stmt;
        ExpKind exp;
        struct DeclIdentifier decl;
        SysKind sys;
    } kind;
    int op;
    ExpType type; 
    char *expected; //deprecated
    int declared; //deprecated
    int scopeVar; //deprecated
    char *scope; //deprecated
} TreeNode;

/*typedef struct codeInfo {
    CodeType codeType;
    char pgm[120];
    int offset;
} CodeInfo;*/

/**************************************************/
/***********   Flags for tracing       ************/
/**************************************************/

/* EchoSource = TRUE causes the source program to
 * be echoed to the listing file with line numbers
 * during parsing
 */
extern int EchoSource;

/* TraceScan = TRUE causes token information to be
 * printed to the listing file as each token is
 * recognized by the scanner
 */
extern int TraceScan;

/* TraceParse = TRUE causes the syntax tree to be
 * printed to the listing file in linearized form
 * (using indents for children)
 */
extern int TraceParse;

/* TraceAnalyze = TRUE causes symbol table inserts
 * and lookups to be reported to the listing file
 */
extern int TraceAnalyze;

/* TraceCode = TRUE causes comments to be written
 * to the TM code file as code is generated
 */
extern int TraceCode;

/* Error = TRUE prevents further passes if an error occurs */
extern int Error;
#endif
