/****************************************************/
/* File: symtab.c                                   */
/* Symbol table implementation for the C- compiler  */
/* Symbol table is implemented as a chained         */
/* hash table                                       */
/****************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "globals.h"
#include "symtab.h"
#include "util.h"

/* SHIFT is the power of two used as multiplier
   in hash function  */
#define SHIFT 4

#define MAX_SCOPE 40

int scopeDepth; //deprecated
Scope scopes[MAX_SCOPE];
int numScope = 0;
Scope scopeStack[MAX_SCOPE];
int numScopeStack = 0;

/* the hash function */
static int hash (char * key) {
    int temp = 0;
    int i = 0;
    while (key[i] != '\0') {
        temp = ((temp << SHIFT) + key[i]) % SIZE;
        ++i;
    }
    return temp;
}


Scope getTopScope(void) {
    return scopeStack[numScopeStack - 1];
}

void popScope(void) {
    --numScopeStack;
}

void incScope() {
    ++numScopeStack;
}

void pushScope(Scope scope) {
    scopeStack[numScopeStack++] = scope;
}

SysCall sys_create(char * name, TreeNode * treeNode) { //usa em analyze
    SysCall sc = (SysCall) malloc(sizeof(struct SysCallRec));
    sc->name = name;
    sc->treeNode = treeNode;
    sc->next = NULL;
    return sc;
}

void sys_insert(SysCall syscall) { //usa em analyze
    if (syscallHead == NULL) {
        syscallHead = syscall;
    } else {
        SysCall temp = syscallHead;
        while (temp->next != NULL) {
            temp = temp->next;
        }
        temp->next = syscall;
    }
}

SysCall sys_lookup(char * name) { //usa em analyze
    SysCall temp = syscallHead;
    while (temp != NULL) {
        if (!strcmp(name, copySysKind(temp->treeNode->kind.sys))) {
            return temp;
        }
        temp = temp->next;
    }
    return NULL;
}


Scope createScope(char * functionName) {
    Scope newScope = (Scope) malloc(sizeof(struct ScopeRec));
    newScope->functionName = functionName;
    newScope->memSize = 0;
    if(strcmp(functionName, "GLOBAL_SCOPE")) {
        newScope->parent = globalScope;
    }
    else{
        newScope->parent = NULL;
    }
    scopes[numScope++] = newScope;
    return newScope;
}

Scope checkVarInScope(char * name) {
    int h = hash(name);
    Scope sc = getTopScope();
    while(sc != NULL) {
        BucketList l = sc->hashTable[h];
        while ((l != NULL) && (strcmp(name, l->name))) {
            l = l->next;
        }
        if (l != NULL) return sc;
        sc = sc->parent;
    }
    return NULL;
}

BucketList checkInBucket(char * name, int isGlobal) {
    int h = hash(name);
    //if isGlobal == 1, use globalScope
    //else use topScope    
    Scope sc;
    if(isGlobal == 0){
        sc = getTopScope();
    }
    else{
        sc = globalScope;
    }
    //Scope sc = getTopScope();
    while(sc != NULL) {
        BucketList l = sc->hashTable[h];
        while ((l != NULL) && (strcmp(name,l->name))) {
            l = l->next;
        }
        if (l != NULL){
            return l;
                      
        } 
        sc = sc->parent;
    }
    return NULL;
}

BucketList checkInBucketFunction(char * name) {
    int h = hash(name);
    Scope sc = globalScope;
    BucketList l = sc->hashTable[h];
    while((l!= NULL) && (strcmp(name, l->name))){
        l = l->next;
    }
    if (l != NULL){
        return l;
    }
    else {
        return NULL;
    }
}



int getQuantidadeParametros(TreeNode * functionNode) {
    int qtd = 0;
    TreeNode * aux = functionNode->child[0];
    if(aux != NULL) {
        ++qtd;
        while(aux->sibling != NULL) {
            aux = aux->sibling;
            ++qtd;
        }
    }
    return qtd;
}

int getQuantidadeVariaveis(TreeNode * functionNode) {
    int qtd = 0;
    TreeNode * aux = functionNode->child[1]->child[0];
    if(aux != NULL) {
        ++qtd;
        while(aux->sibling != NULL) {
            aux = aux->sibling;
            ++qtd;
        }
    }
    return qtd;
}

int getTamanhoBlocoMemoriaEscopo(char * scopeName) {
    int i, tamanho = 0;
    for (i = 0; i < numScope; ++i) {
        if(!strcmp(scopeName, scopes[i]->functionName)) {
            tamanho = scopes[i]->memSize;
            break;
        }
    }
    return tamanho;
}

int getMemoryLocation(char * name, Scope scope){
    int h = hash(name);
    BucketList l = scope->hashTable[h];
    while(l != NULL){
        if(!strcmp(l->name, name)){
            return l->memloc;
        }
        l = l->next;
    }
    return -1;
}


int getTamanhoBlocoMemoriaEscopoGlobal(void) {
    int i, tamanho = 0;
    Scope global = scopes[0];
    BucketList *hashTable = global->hashTable;
    for (i = 0; i < SIZE; ++i) {
        if(hashTable[i] != NULL) {
            BucketList l = hashTable[i];
            while(l != NULL){
                if(l->treeNode->kind.decl.declkind == Id || l->treeNode->kind.decl.declkind == Array){
                    tamanho += l->tamanho;
                }
                l = l->next;
            }
        }
    }
    return tamanho;
}

BucketList getVarFromSymtab(char * name, Scope scope){
    int h = hash(name);
    BucketList l = scope->hashTable[h];
    while(l != NULL){
        if(strcmp(l->name, name) == 0){
            return l;
        }
        l = l->next;
    }
    return NULL;
}

/*BucketList getVarFromTable(char *name, Scope scope){
    int h = hash(name);
    BucketList l = scope->hashTable[h];
    while(l != NULL){
        if(strcmp(l->name, name) == 0){
            return l;
        }
        l = l->next;
    }
    return NULL;
}*/

/* Procedure st_insert inserts line numbers and
 * memory locations into the symbol table
 * loc = memory location is inserted only the
 * first time, otherwise ignored
 */
void st_insert(char * name, int lineno, int loc, TreeNode * treeNode, int tamanho, int addLineno, int isFunction) {
    //addLineno == 1, add a line
    //isFunction == 1, add new function to table
	int h = hash(name);
	Scope first = getTopScope();

    if(isFunction == 1){
        Scope glb = globalScope;
        BucketList glbBucket = glb->hashTable[h];
        while ((glbBucket != NULL) && (strcmp(name,glbBucket->name) != 0)) {
            glbBucket = glbBucket->next;
        }
        if (glbBucket == NULL) { //variable not yet in table
            //add scope
            treeNode->kind.decl.scope = glb;
            //add item in symbol table
            glbBucket = (BucketList) malloc(sizeof(struct BucketListRec));
            glbBucket->name = name;
            glbBucket->lines = (LineList) malloc(sizeof(struct LineListRec));
            glbBucket->lines->lineno = lineno;
            glbBucket->lines->next = NULL;
            glbBucket->memloc = -1;
            glbBucket->tamanho = 0;
            glbBucket->treeNode = treeNode;
            glbBucket->next = glb->hashTable[h];
            glb->hashTable[h] = glbBucket;
        }
    }
    else {


        if(addLineno == 1){
            treeNode->kind.decl.scope = checkVarInScope(treeNode->kind.decl.name);
            int lineno = treeNode->lineno;
            BucketList l = checkInBucket(treeNode->kind.decl.name, 0);
            LineList ll = l->lines;
            while (ll->next != NULL) {
                ll = ll->next;
            }
            if (ll->lineno != lineno) {
                ll->next = (LineList) malloc(sizeof(struct LineListRec));
                ll->next->lineno = lineno;
                ll->next->next = NULL;
            }
        }
        else{
            if(first->hashTable[h] == NULL) {
                //add scope
                treeNode->kind.decl.scope = first;

                BucketList aux = (BucketList) malloc(sizeof(struct BucketListRec));
                aux->name = name;
                aux->lines = (LineList) malloc(sizeof(struct LineListRec));
                aux->lines->lineno = lineno;
                aux->lines->next = NULL;
                aux->memloc = loc;    //loc-1 pois o nome da funcao entrou na posicao 0
                aux->tamanho = tamanho;
                aux->treeNode = treeNode;
                aux->next = NULL;
                first->hashTable[h] = aux;
                treeNode->kind.decl.scope->memSize += tamanho;
            } else {
                BucketList l = first->hashTable[h];
                while ((l->next != NULL) && (strcmp(name, l->name))) {
                    l = l->next;
                }
                if (l->next == NULL && (strcmp(name, l->name))) { //variable not yet in table
                    //add scope
                    treeNode->kind.decl.scope = first;
                    //add new item in symbol table
                    BucketList aux = (BucketList) malloc(sizeof(struct BucketListRec));
                    aux->name = name;
                    aux->lines = (LineList) malloc(sizeof(struct LineListRec));
                    aux->lines->lineno = lineno;
                    aux->lines->next = NULL;
                    aux->memloc = loc-1;
                    aux->tamanho = tamanho;
                    aux->treeNode = treeNode;
                    aux->next = NULL;

                    treeNode->kind.decl.scope->memSize += tamanho;
                }
            }
        }

    }
    
    
} /* st_insert */


/* Function st_lookup returns the memory
 * location of a variable or -1 if not found
 */
int st_lookup (char * name, int isFunction) {
    //isFunction == 1, looks up a function at global scope instead
    int h = hash(name);    
    if(isFunction == 1){
        Scope glb = globalScope;
        BucketList glbBucket = glb->hashTable[h];
        while ((glbBucket != NULL) && (strcmp(name,glbBucket->name))) {
            glbBucket = glbBucket->next;
        }
        if (glbBucket != NULL) {
            return TRUE;
        } else {
            return FALSE;
        }
    }
    else{
        BucketList l = checkInBucket(name, 0);
        if (l != NULL){
            return l->memloc;
        } 
        return -1;
    }    
}


/* Procedure printSymTab prints a formatted
 * listing of the symbol table contents
 * to the listing file
 */

void printSymTab(FILE * listing) {
	int i, j;
	for (i = 0; i < numScope; ++i) {
		Scope scope = scopes[i];
		BucketList * hashTable = scope->hashTable;

		if (i == 0) { // Global Scope
			fprintf(listing, "<Global Scope>\n");
            fprintf(listing, "Variable Name  Variable Type  Data Type  Origin  Size  Location  Line Number\n");
      		fprintf(listing, "-------------  -------------  ---------- ------  ----  --------  -----------\n");
            for (j = 0; j < SIZE; ++j) {
                if (hashTable[j] != NULL) {
                    BucketList l = hashTable[j];

                    while (l != NULL) {
                        LineList t = l->lines;
                        fprintf(listing, "%-15s", l->name);
                        fprintf(listing, "%-15s", copyExpType(l->treeNode->type) );
                        fprintf(listing, "%-11s", copyDeclKind(l->treeNode->kind.decl.declkind));

                        //if function, insert parameter quantity                        
                        if(l->treeNode->kind.decl.declkind == Function) {
                            if(l->treeNode->child[0] == NULL) {
                                //
                            } else {
                                //
                            }
                        } else {
                            l->treeNode->kind.decl.mem = Globals;
                        }                        

                        fprintf(listing, "%-8s", copyMemKind(l->treeNode->kind.decl.mem));
                        fprintf(listing, "%-9d", l->tamanho);


                        if(l->memloc == -1) {
                            fprintf(listing, "%-10c", '-');
                        } else {
                            fprintf(listing, "%-10d", l->memloc);
                        }

                        while (t != NULL) {
                            if (t->lineno != -1) {
                                fprintf(listing, "%-4d", t->lineno);
                            } else {
                                fprintf(listing, " ");
                            }
                            t = t->next;
                        }
                        fprintf(listing, "\n");
                        l = l->next;
                    }
                }
             }

            fprintf(listing, "\n");
		} else {
            fprintf(listing, "Function Name: %s\n", scope->functionName);
            fprintf(listing, "Variable Name  Variable Type  Data Type  Origin  Size  Location  Line Numbers\n");
            fprintf(listing, "-------------  -------------  ---------  ------  ----  --------  ------------\n");
            for (j = 0; j < SIZE; ++j) {
                if (hashTable[j] != NULL) {
                    BucketList l = hashTable[j];

                    while (l != NULL) {
                        LineList t = l->lines;
                        fprintf(listing, "%-15s", l->name);
                        fprintf(listing, "%-15s", copyExpType(l->treeNode->type));
                        fprintf(listing, "%-11s", copyDeclKind(l->treeNode->kind.decl.declkind));

                       
                        fprintf(listing, "%-8s", copyMemKind(l->treeNode->kind.decl.mem));
                        fprintf(listing, "%-9d", l->tamanho);

                        if(l->memloc == -1) {
                            fprintf(listing, "%-10c", '-');
                        } else {
                            fprintf(listing, "%-10d", l->memloc);
                        }

                        while (t != NULL) {
                            if (t->lineno != -1) {
                                fprintf(listing, "%-4d", t->lineno);
                            } else {
                                fprintf(listing, " ");
                            }
                            t = t->next;
                        }
                        fprintf(listing, "\n");
                        l = l->next;
                    }
                }
    }

		}

		fputc('\n', listing);
	}
} /* printSymTab */