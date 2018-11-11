/**
 * Define a grammar called MiniJava
 */
grammar MiniJava;

miniJavaProgram : mainClass (ClassDeclaration)*;	

mainClass: 'class' ID LC mainMethod RC;

mainMethod: 'public' 'static' 'void' 'main' LRB STR LB RB ID RRB LC Statement RC;

Statement : IfStmt | WhileStmt | ForStmt | AssignStmt | Stat | Break | Continue;

ClassDeclaration : 'class' ID LC Method RC;

Method : 'public' Type ID LRB Type ID RRB LC Statement RC;

AssignStmt : INTAssign|STRAssign|BOOAssign|CHAAssign;

INTAssign : INT ID (ASSIGN INTEGER|ID)? SC;

STRAssign : STR ID (ASSIGN STRING|ID)? SC;

BOOAssign : BOO ID (ASSIGN BOOLEAN|ID)? SC;

CHAAssign : CHA ID (ASSIGN CHARACTER|ID)? SC;

IfStmt : IF BoolEXP LC Statement* RC ElsePart;
ElsePart : ELSE LC Statement* RC | WS;//  or ε 

WhileStmt : WHILE BoolEXP LC Statement* RC;

ForStmt : ;

BoolEXP : LRB ID ExpreOPR Expr RRB;


Expr : FULLType (MULT FULLType)*
	| FULLType (PLUS FULLType)*
	| LRB ( Expr ) RRB
	;
	
Stat : Type ID ASSIGN Expr SC
	| AssignStmt
	| WS
;



 Break : 'break';
 Continue :'continue';
 IF : 'if';
 ELSE : 'else';
 NON : '!';
 OR : '||';
 LESSTHAN : '<';
 AND :'&&';
 EQUALS : '==';
 ASSIGN : '=' ;
 PLUS : '+' ;
 MINUS : '-' ;
 MULT : '*' ;
 DIV : '/' ;
 LRB : '(' ;           // Left Round Bracket
 RRB : ')' ;
 LB: '[';
 RB: ']';
 LC :'{' ;
 RC :'}' ;
 SC : ';' ;
 
 
 LETTER : [a-zA-Z];
 DIGIT : [0-9];
 ID: LETTER(LETTER|DIGIT)*;
 CHARACTER : LETTER | '\'' [\\|\t|\r|\n|\'|\"]|~['|\\] '\'';
 STRING : '"' (DIGIT|LETTER|[\\|\t|\r|\n|\'|\"]|~["|\\])* '"';
 INTEGER : [-]? DIGIT+;
 BOOLEAN :'true'|'false';
 FULLType : CHARACTER | STRING | INTEGER | BOOLEAN;
 
 WS : [ \t\r\n]+ -> skip ; // skip spaces, tabs, newlines
 
 INT: 'int' ;
 BOO: 'boolean';
 CHA: 'char';
 INTARR: 'int[]';
 STR: 'String';
 
 WHILE: 'while';
 
 Type : INT
		| BOO
		| CHA
		| INTARR
		| STR 
		| ID
		;
		
 ExpreOPR // possibility of boolean expressions operators
	: LESSTHAN
	| EQUALS
	| AND
	| OR
	| NON ASSIGN
	;
 
