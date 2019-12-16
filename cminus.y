/****************************************************/
/* File: cminus.y                                   */
/* C- grammar                                       */
/****************************************************/

%{
    #define YYPARSER /* distinguishes Yacc output from other code files */

    #include "globals.h"
    #include "util.h"
    #include "scan.h"
    #include "parse.h"

    #define YYSTYPE TreeNode *
    char * savedName; /* for use in assignments */
    int savedLineNo;  /* ditto */
    TreeNode * savedTree; /* stores syntax tree for later return */
    int yylex(void);
    int yyerror(char * message);
    TreeNode * createSysCall(ExpType type, SysKind syscall);
    void insertNewNode(TreeNode * node);

    char * funcName;
    typedef union type_t type_t;

    union type_t
    {
      TreeNode *node;
      char *str;
      int op;
    };
%}

%token IF ELSE WHILE RETURN
%token GT  GE  LT  LE  EQ  NEQ PLUS MINUS MULT DIV ASSIGN 
/*     >   >=  <   <=  ==  !=   +      -    *   /    =           */
%token OPAREN CPAREN OBRACKET CBRACKET OCURLY CCURLY SEMI COMMA
/*       (      )       [          ]     {      }      ;    ,    */
%token ERROR ENDFILE
%token INT VOID
%token ID NUM
%nonassoc OPAREN
%nonassoc ELSE

%% /* Grammar for C- */

program         : declarationList {
                    //artficially insert input and output calls as system calls:
                    insertNewNode(createSysCall(IntegerType, Input));   //input
                    insertNewNode(createSysCall(VoidType, Output));     //output
                    insertNewNode(createSysCall(IntegerType, LoadDisk));     //load on disk
                    insertNewNode(createSysCall(VoidType, StoreDisk));     //store on disk
                    insertNewNode(createSysCall(IntegerType, LoadMem));     //load on memory
                    insertNewNode(createSysCall(VoidType, StoreMem));     //store on memory (use on bios)
                    insertNewNode(createSysCall(VoidType, StoreMemProc));     //store on memory (use on bios)
                    insertNewNode(createSysCall(VoidType, LCD));      //write lcd

                    TreeNode *node = savedTree;
                    while(node->sibling != NULL){
                        node = node->sibling;
                    }
                    node->sibling = $1;
                    //savedTree = $1;
                };

declarationList : declarationList declaration {
                    TreeNode *no = $1;
                    if (no != NULL) {
                        while (no->sibling != NULL) {
                            no = no->sibling;
                        }
                        no->sibling = $2;
                        $$ = $1;
                    } else {
                        $$ = $2;
                    }
                }
                | declaration { $$ = $1; };

declaration    : var_declaration { $$ = $1; }
               | fun_declaration { $$ = $1; };

var_declaration : type_specifier id SEMI {
                    $$ = $1;
                    $$->child[0] = $2;
                    $$->child[0]->type = $$->type;
                    $$->child[0]->kind.decl.mem = Locals;
                }
                | type_specifier id OBRACKET num CBRACKET SEMI {
                    $$ = $1;
                    $$->child[0] = $2;
                    $$->child[0]->type = $$->type;
                    $$->child[0]->kind.decl.mem = Locals;
                    $$->child[0]->kind.decl.declkind = Array;
                    $$->child[0]->child[0] = $4;
                    $$->child[0]->child[0]->type = IntegerType;
                }
                | error {yyerrok;};

type_specifier   : INT {
                    $$ = newStmtNode(Integer);
                    $$->type = IntegerType;
                    $$->op = INT;
                }
                | VOID {
                    $$ = newStmtNode(Void);
                    $$->type = VoidType;
                    $$->op = VOID;
                };

fun_declaration  : type_specifier id OPAREN params CPAREN compound_stmt {
                    $$ = $1;
                    $$->child[0] = $2;
                    $$->child[0]->type = $$->type;
                    $$->child[0]->kind.decl.declkind = Function;
                    $$->child[0]->kind.decl.mem = FunMem;
                    $$->child[0]->child[0] = $4;
                    $$->child[0]->child[1] = $6;
                };

params          : param_list { $$ = $1; }
                | VOID { $$ = NULL; };

param_list     : param_list COMMA param {
                    TreeNode *no = $1;
                    if (no != NULL) {
                    	while (no->sibling != NULL) {
                    		no = no->sibling;
                    	}
                    	no->sibling = $3;
                    	$$ = $1;
                    } else {
                    	$$ = $3;
                    }
                }
                | param { $$ = $1; };

param           : type_specifier id {
                    $$ = $1;
                    $$->child[0] = $2;
                    $$->child[0]->kind.decl.mem = Param;
                }
                | type_specifier id OBRACKET CBRACKET
                {
                    $$ = $1;
                    $$->child[0] = $2;
                    $$->child[0]->kind.decl.mem = Param;
                    $$->child[0]->kind.decl.declkind = Array;
                };

compound_stmt    : OCURLY local_declarations statement_list CCURLY {
                    $$ = newStmtNode(Compound);
                    $$->child[0] = $2;
                    $$->child[1] = $3;
                    $$->op = Compound;
                };

local_declarations  : local_declarations var_declaration{
                    	TreeNode *no = $1;
                    	if (no != NULL) {
                    		while (no->sibling != NULL) {
                    			no = no->sibling;
                    		}
                    		no->sibling = $2;
                    		$$ = $1;
                    	} else {
                    		$$ = $2;
                    	}
                    }
                    | /*empty */{ $$ = NULL; }; /*vazio { $$ = $1; };*/

statement_list  : statement_list statement {
                	YYSTYPE t = $1;
                	if (t != NULL) {
                		while (t->sibling != NULL) {
                			t = t->sibling;
                		}
                		t->sibling = $2;
                		$$ = $1;
                	} else {
                		$$ = $2;
                	}
                }
                | /*empty */{ $$ = NULL; };/*vazio { $$ = $1; }*/;

statement       : expression_stmt { $$ = $1; }
                | compound_stmt { $$ = $1; }
                | selection_stmt { $$ = $1; }
                | iteration_stmt { $$ = $1; }
                | return_stmt { $$ = $1; };

expression_stmt : expression SEMI { $$ = $1; }
                | SEMI { $$ = NULL; };

selection_stmt   : IF OPAREN expression CPAREN statement {
                    $$ = newStmtNode(If);
                    $$->child[0] = $3;
                    $$->child[1] = $5;
                    $$->op = If;
                }
                | IF OPAREN expression CPAREN statement ELSE statement
                {
                    $$ = newStmtNode(If);
                    $$->child[0] = $3;
                    $$->child[1] = $5;
                    $$->child[2] = $7;
                    $$->op = If;
                };

iteration_stmt  : WHILE OPAREN expression CPAREN statement {
                	$$ = newStmtNode(Iteration);
                	$$->child[0] = $3;
                	$$->child[1] = $5;
                    $$->op = Iteration;
                };

return_stmt      : RETURN SEMI {
                	$$ = newStmtNode(Return);
                    $$->op = Return;
                }
                | RETURN expression SEMI
                {
                	$$ = newStmtNode(Return);
                	$$->child[0] = $2;
                    $$->op = Return;
                };

expression     : var assigment_operator expression {
                    $$ = $2;
                    $$->child[0] = $1;
                	$$->child[1] = $3;
                }
                | simple_expression { $$ = $1; };

assigment_operator  : ASSIGN  {
                    	$$ = newExpNode(Assign);
                    	$$->op = ASSIGN;
                    };

var              : id {
                	$$ = $1;
                    $$->kind.decl.access = Access;
                }
                | id OBRACKET expression CBRACKET
                {
                	$$ = $1;
                	$$->kind.decl.declkind = Array;
                    $$->kind.decl.access = Access;
                	$$->child[0] = $3;
                };

simple_expression   : additive_expression relop additive_expression {
                      $$ = $2;
                      $$->child[0] = $1;
                      $$->child[1] = $3;
                    }
                    | additive_expression  { $$ = $1; };


relop               : GT  {
                      $$ = newExpNode(Relop);
                      $$->op = GT;
                    }
                    | LT  {
                      $$ = newExpNode(Relop);
                      $$->op = LT;
                    }
                    | GE  {
                      $$ = newExpNode(Relop);
                      $$->op = GE;
                    }
                    | LE  {
                      $$ = newExpNode(Relop);
                      $$->op = LE;
                    }
                    | EQ  {
                      $$ = newExpNode(Relop);
                      $$->op = EQ;
                    }
                    | NEQ {
                      $$ = newExpNode(Relop);
                      $$->op = NEQ;
                    };

additive_expression : additive_expression addop term {
                    	$$ = $2;
                    	$$->child[0] = $1;
                    	$$->child[1] = $3;
                    }
            	    | term { $$ = $1; };

addop               : PLUS  {
                    	$$ = newExpNode(Arith);
                    	$$->op = PLUS;
                    }
                    | MINUS
                    {
                    	$$ = newExpNode(Arith);
                    	$$->op = MINUS;
                    };

term                : term mulop factor {
                    	$$ = $2;
                    	$$->child[0] = $1;
                    	$$->child[1] = $3;
                    }
                    | factor { $$ = $1; };

mulop               : MULT{
                    	$$ = newExpNode(Arith);
                    	$$->op = MULT;
                    }
                    | DIV
                    {
                    	$$ = newExpNode(Arith);
                    	$$->op = DIV;
                    };

factor              :  OPAREN expression CPAREN { $$ = $2; }
                    | var { $$ = $1; }
                    | call { $$ = $1; }
                    | num { $$ = $1; };

call            : var OPAREN args CPAREN {
                    	$$ = $1;
                    	$$->kind.decl.declkind = Call;
                    	$$->child[0] = $3;
                        $$->op = Call;
                };

args            : arg_list { $$ = $1; }
                | { $$ = NULL;};/*vazio { $$ = $1; };*/

arg_list        : arg_list COMMA expression {
                	TreeNode *no = $1;
                	if (no != NULL) {
                		while (no->sibling != NULL) {
                			no = no->sibling;
                		}
                		no->sibling = $3;
                		$$ = $1;
                	} else {
                		$$ = $3;
                	}
                }
                | expression { $$ = $1; };

id              : ID {
                	$$ = newVarNode(Id);
                	$$->kind.decl.name = copyString(tokenString);
                    $$->type = IntegerType;
                };

num             : NUM {
                    $$ = newVarNode(Const);
                    $$->kind.decl.value = atoi(tokenString);
                    $$->type = IntegerType;
        		};

/*vazio
    : { $$ = NULL; }
    ;*/

%%

int yyerror(char * message) {
    fprintf(listing,"Syntax error at line %d: %s\n",lineno,message);
    fprintf(listing,"Current token: ");
    printToken(yychar,tokenString);
    Error = TRUE;
    return 0;
}

/* yylex calls getToken to make Yacc/Bison output
 * compatible with ealier versions of the TINY scanner
 */
int yylex(void) {
    return getToken();
}

TreeNode * parse(void) {
    yyparse();
    return savedTree;
}

TreeNode * getIntNode(TreeNode * childNode) {
    TreeNode * intNode = newStmtNode(Integer);
    intNode->op = INT;
    intNode->type = IntegerType;
    intNode->child[0] = childNode;
    return intNode;
}

TreeNode * getVoidNode(TreeNode * childNode) {
    TreeNode * voidNode = newStmtNode(Void);
    voidNode->op = VOID;
    voidNode->type = VoidType;
    voidNode->child[0] = childNode;
    return voidNode;
}

TreeNode * createSysCall(ExpType type, SysKind syscall) {
    TreeNode * function = newSysNode(syscall);
    function->lineno = 0;
    function->op = ID;
    function->type = type;
    return type == IntegerType ? getIntNode(function) : getVoidNode(function);
}

void insertNewNode(TreeNode * node) {
    TreeNode * temp;
    if (savedTree == NULL) {
        savedTree = node;
        savedTree->sibling = NULL;
    } else {
        temp = savedTree;
        while (temp->sibling != NULL) {
            temp = temp->sibling;
        }
        temp->sibling = node;
        temp->sibling->sibling = NULL;
    }
}
