/**
 * Define a grammar called Hello

 */
grammar MiniJava;

 /*
  * Syntax Analysis Part , WITH ????? PART MEANS SUSPECTED PROBLEMS
 */
// §1. MiniJava main structure
miniJavaProgram : mainClass (classDeclaration)*;
mainClass : 'class' ID LC mainMthod RC ;
classDeclaration : 'class' LC fieldDeclaration* method RC ;
states : state+ ; //statements block
state : ifState
		//| whileState
		//| printState
		//| states
		; //-------------not finish yet

// §2. details inside the mainClass
mainMthod: 'public' 'static' 'void' 'main' LRB STR (LB RB | VARARGS ) ID RRB 
			LC (LC states RC | state) RC;

// §3. details inside the normal class
fieldDeclaration: types ID SC ;

method : 'public' types ID LRB ( types ID ( COMMA types ID )*)* RRB LC states RC ;//?????



// §4. the details of method
variableDeclaration : intVDec
					  |strVDec
					  |booVDec
					  |chaVDec 
					  |refVDec
					  ;
refVDec: ID ID ASSIGN (ID | 'new' ID LRB RRB) SC ;

chaVDec: CHA ID ASSIGN  CHARACTER SC ;

booVDec: BOO ID ASSIGN ('true'|'false') SC ;

strVDec: STR ID ASSIGN STRING SC;

intVDec: INT ID ASSIGN INTEGER SC;

// §5. the details of state,i.e statement

/*
 * String concatenation (+), length check (.length()), and character access (e.g. .charAt(7)). 
 */		
rBExpre : LRB expre RRB ;//-----> not complete yet
boolExpre : (INTEGER | ID | expre) expreOPR (INTEGER | ID | expre)
		  ;
expre : rBExpre//?????
		| expre (MULT | DIV) expre
		| expre (PLUS | MINUS) expre
        | (INTEGER | ID )
        ;
		  
// § 5.1 statement details , while statement

// § 5.2 statement details , if statement
ifState : 'if' boolExpre LC states RC ;
// § 5.3 statement details , assign statement

// § 5.4 statement details , array statement

// § 5.5 statement details , print statement



/* state : expr SC
       | assign ; //single statement

rBExpr : LRB expr RRB ;   // Round bracket expression
expr :  rBExpr
        | expr (MULT | DIV) expr
        | expr (PLUS | MINUS) expr
        | (INT | ID)
     ;//left-recursive problem need to be solved  or ambigous problem
assign : ID ASSIGN expr SC ;*/
expreOPR// possibility of boolean expressions operators
	: LESSTHAN
	| EQUALS
	| AND
	| OR
	| NON ASSIGN
	;
types : INT
		| BOO
		| CHA
		| INTARR
		| STR 
		| ID
		;


/*
 * Lexical parse part
 */
//operators
ASSIGN : '=' ;
PLUS : '+' ;
MINUS : '-' ;
MULT : '*' ;
DIV : '/' ;
LESSTHAN: '<' ;
EQUALS : '==' ;
AND : '&&' ;
OR : '||' ;
NON : '!' ;



//symbols
LRB : '(' ;           // Left Round Bracket
RRB : ')' ;
LB: '[';
RB: ']';
LC :'{' ;
RC :'}' ;
VARARGS : '...' ;
SC : ';' ;
COMMA : ',' ;
WS : [\t\r\n]+ -> skip ; // skip spaces, tabs, newlines

LETTER : [a-zA-Z];
DIGIT : [0-9];
ID: LETTER(LETTER|DIGIT)*;
CHARACTER : '\'' ~['\\\r\n] '\'' ;
STRING :  '"' (~["\\\r\n])* '"';
INTEGER : '0'
		  | '-'? [1-9] ([1-9]|'0')*
		  ;


//types
INT : 'int' ;
BOO : 'boolean';
CHA : 'char';
INTARR : 'int[]';
STR : 'String' ;

