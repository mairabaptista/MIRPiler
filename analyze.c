/****************************************************/
/* File: analyze.c                                  */
/* Semantic Analyzer                                */
/* for the C- compiler              		        */
/****************************************************/

#include "globals.h"
#include "symtab.h"
#include "analyze.h"
#include "util.h"
#include <string.h>

char *functionName;
int location = 0;   //counter for memory location
static int hasMain = 0;    //flag for main declaration
static int IO = 0; //flag for io function
static int isGlobal = 0; //flag for global scope (deprecated)
static int isDeclared = 0; //flag for declaration (deprecated)

/* Procedure traverse is a generic recursive
 * syntax tree traversal routine:
 * it applies preProc in preorder and postProc
 * in postorder to tree pointed to by t
 */
static void traverse( TreeNode * t,
               void (* preProc) (TreeNode *),
               void (* postProc) (TreeNode *) )
{ if (t != NULL)
  { preProc(t);
    { int i;
      for (i=0; i < MAXCHILDREN; i++)
        traverse(t->child[i],preProc,postProc);
    }
    postProc(t);
    traverse(t->sibling,preProc,postProc);
  }
}

int getHasMain(){
    return hasMain;
}

static void errorFlag(TreeNode * t, const char * message, int error){
    switch(error){
        case 1:
            fprintf(listing, "Semantic error: %s, line: %d - %s\n", t->kind.decl.name, t->lineno, message);
        break;
        case 2:
            fprintf(listing, "Semantic error: %s, line: %d - %s\n", t->kind.decl.name, t->lineno, message);
        break;
        case 3:
            fprintf(listing, "Semantic error: %s, line: %d - %s\n", t->kind.decl.name, t->lineno, message);
        break;
        case 4:
            fprintf(listing, "Semantic error: %s, line: %d - %s\n", t->kind.decl.name, t->lineno, message);
        break;
        case 5:
            fprintf(listing, "Semantic error: %s, line: %d - %s\n", t->kind.decl.name, t->lineno, message);
        break;
        case 6:
            fprintf(listing, "Semantic error: %s, line: %d - %s\n", t->kind.decl.name, t->lineno, message);
        break;
        case 7:
            fprintf(listing, "Semantic error: %s, line: %d - %s\n", t->kind.decl.name, t->lineno, message);
        break;
         case 8:
            fprintf(listing, "Semantic error: %s, line: %d - %s\n", t->kind.decl.name, t->lineno, message);
        break;
         case 9:
            fprintf(listing, "Semantic error: %s, line: %d - %s\n", t->kind.decl.name, t->lineno, message);
        break;
    }
    Error = TRUE;
}

/* Procedure insertNode inserts
 * identifiers stored in t into
 * the symbol table
 */
static void insertNode(TreeNode * t) {
    int arraySize;
    BucketList l;
    if (t->nodekind == Decl) {
        switch (t->kind.decl.declkind) {
            case Id:
                if(t->kind.decl.access == Access) {     //Variable is being accessed
                    //Is there a table entry with the same name?
                    l = checkInBucket(t->kind.decl.name, 0);
                    if (l != NULL) { //Entry found
                        if(l->treeNode->kind.decl.declkind == Function) {
                            //Type 9 error: Referecing function as variable
                            errorFlag(t, "Referecing function as variable", 9);
                            break;
                        } else {
                            st_insert(t->kind.decl.name, t->lineno, location, t, 1, 1, 0); //st_add_lineno(t); //era location++, ficava iterando por cima do valor
                            break;
                        }
                    }
                    //If entry not found, then:
                    //Type 1 error - Undeclared Variable
                    errorFlag(t, "Undeclared Variable", 1);
                } 

                else {    //Variable is being declared                    
                    BucketList l = checkInBucket(t->kind.decl.name, 0);     //Is there a table entry with the same name?
                    if(l != NULL) { //Entry found
                        if (l->treeNode != NULL) {
                            if (l->treeNode->kind.decl.declkind == Function) {  //Was it declared as function?
                                //Type 7 error - Variable already declared as function
                                errorFlag(t, "Variable already declared as function", 7);
                                break;
                            }
                            //Verify if there is a varible with the same name in the same scope
                            if(strcmp(l->treeNode->kind.decl.scope->functionName, getTopScope()->functionName)) {
                                //
                            } else {
                                //Type 4 error - Variable already declared
                                errorFlag(t, "Variable already declared", 4);
                                break;
                            }
                        }
                    }
                    
                    st_insert(t->kind.decl.name, t->lineno, location++, t, 1, 0, 0);
                }

                break;                
            case Array:
                if(t->kind.decl.access == Access) { //Variable is being accessed
                    //Is there a table entry with the same name?
                    l = checkInBucket(t->kind.decl.name, 0);
                    if (l != NULL) {    //Entry found
                        if(l->treeNode->kind.decl.declkind == Function) {
                            //Type 9 error: Referecing function as variable
                            errorFlag(t, "Referecing function as variable", 9);
                            break;
                        } else {
                            st_insert(t->kind.decl.name, t->lineno, location++, t, 1, 1, 0); //st_add_lineno(t);
                            break;
                        }
                    }
                    //If entry not found, then:
                    //Type 1 error - Undeclared Variable
                    errorFlag(t, "Undeclared Variable", 1);
                } 

                else { //Variable is being declared   
                    BucketList l = checkInBucket(t->kind.decl.name, 0);    //Is there a table entry with the same name?
                    if(l != NULL) { //Entry found
                        if (l->treeNode != NULL) {
                            if (l->treeNode->kind.decl.declkind == Function) {  //Was it declared as function?
                                //Type 7 error - Variable already declared as function
                                errorFlag(t, "Variable already declared as function", 7);
                                break;
                            }
                            //Verify if there is a varible with the same name in the same scope
                            if(strcmp(l->treeNode->kind.decl.scope->functionName, getTopScope()->functionName)) {
                                //

                            } else {
                                //Type 4 error - Variable already declared
                                errorFlag(t, "Variable already declared", 4);
                                break;
                            }
                        }
                    }
                    if(t->child[0] != NULL){
                        arraySize = t->child[0]->kind.decl.value;
                    }
                    else{
                        arraySize = 1;
                    }

                    st_insert(t->kind.decl.name, t->lineno, location++, t, arraySize, 0, 0);
                    // skips n positions in memory, where n is the array size
                    location += arraySize - 1;
                }
                break;
            case Function:
                functionName = t->kind.decl.name;
                if(strcmp(functionName, "main") == 0){
                    hasMain = 1; //main was declared
                } 
                if (st_lookup(functionName, 1)/*st_lookup_func(funcName)*/) {
                    //type 8 error - Main already declared
                errorFlag(t, "Main already declared", 8);
                    //declError(t, "Função main já declarada");
                    break;
                }
                // resets location
               
                pushScope(createScope(functionName));
                st_insert(functionName, t->lineno, location++, t, 1, 0, 1); //st_insert_func(funcName, t->lineno, t);
                location = 0;
                break;
            case Call:
                functionName = t->kind.decl.name;
                
                if (sys_lookup(functionName) != NULL) {
                    // Do nothing
                } else if (!st_lookup(functionName, 1)/*st_lookup_func(funcName)*/) {
                    //Type 5 error - Undeclared Function Call
                    errorFlag(t, "Undeclared Function Call", 5);
                    //declError(t, "Função não declarada");
                } else {
                    BucketList l = checkInBucket(functionName, 1); ////kkk usa global
                    if (l->treeNode != NULL) {
                        t->type = l->treeNode->type;
                    }
                }
                break;
      	}
  	} else if (t->nodekind == Sys) {
        sys_insert(sys_create(copySysKind(t->kind.sys), t));
    }
}

static void afterInsertNode(TreeNode * t) {
	if (t->kind.decl.declkind == Function) {
		if(t->kind.decl.name != NULL) {
			popScope();
        }
	}
}

/* Function buildSymtab constructs the symbol
 * table by preorder traversal of the syntax tree
 */
void buildSymtab(TreeNode * syntaxTree) {
	globalScope = createScope((char *) "GLOBAL_SCOPE");
	pushScope(globalScope);
	traverse(syntaxTree, insertNode, afterInsertNode);
	popScope();
    //sys_free();
	if(getHasMain() == 0) {
        //Type 6 error - undeclared main
		fprintf(listing, "Semantic error: undclared main\n");
    	return;
	}
 	if (TraceAnalyze) {
		fprintf(listing,"\nSymbol Table:\n");
    	printSymTab(listing);
  	}
}

static void beforeCheckNode(TreeNode * t) {
	if (t->nodekind == Exp) {
		if (t->kind.decl.declkind == Function) {
			functionName = t->kind.decl.name;
		}
  	}
}

/* Procedure checkNode performs
 * type checking at a single tree node
 */
static void checkNode(TreeNode * t) {
    if (t->nodekind == Stmt) {
        switch (t->kind.stmt) {
            case Integer: t->child[0]->type = IntegerType; break;
            case Void:
                if (t->child[0]->kind.decl.declkind == Id) {
                    //Type 3 error - Variable declared as void
                    errorFlag(t, "Variable declared as void", 3);
                } else {
                    t->child[0]->type = VoidType;
                }
                break;
        }
    } else if (t->nodekind == Exp) {
        switch (t->kind.exp) {
            case Assign:
                if ((t->child[0]->type != IntegerType) || (t->child[1]->type != IntegerType)) {
                    //Type 2 error - Wrong return type
                    errorFlag(t->child[0], "Wrong return type", 2);
                } else  {
                    t->type = IntegerType;
                }
                break;
            case Relop: t->type = VoidType; break;
            case Arith: t->type = IntegerType; break;
        }
    } else if (t->nodekind == Decl) {
        switch (t->kind.decl.declkind) {
            case Id: t->type = IntegerType; break;
            case Array: t->type = IntegerType; break;
            case Const: t->type = IntegerType; break;
        }
    }
}

/* Procedure typeCheck performs type checking
 * by a postorder syntax tree traversal
 */
void typeCheck(TreeNode * syntaxTree) {
	traverse(syntaxTree, beforeCheckNode, checkNode);
}
