/****************************************************/
/* File: analyze.h                                  */
/* Semantic Analyzer                                */
/* for the C- compiler              		        */
/****************************************************/

#ifndef _ANALYZE_H_
#define _ANALYZE_H_

#include "symtab.h"

/* Function buildSymtab constructs the symbol
 * table by preorder traversal of the syntax tree
 */
void buildSymtab(TreeNode *);

/* Procedure typeCheck performs type checking
 * by a postorder syntax tree traversal
 */
void typeCheck(TreeNode *);

#endif
