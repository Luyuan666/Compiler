/**
 * Define a grammar called Hello

 */
grammar MiniJava;
@header {    
	 package cc1.zs222bv.miniJava;
}
 /*
  * Syntax Analysis Part 

 */
// §1. MiniJava main structure
miniJavaProgram : mainClass (classDeclaration)* EOF;
mainClass : 'class' ID LC mainMthod RC ;
classDeclaration : 'class' ID LC fieldDeclaration* method+ RC ;
states : state+ ; //statements block
state : variableDeclaration
	  | ifStmt
      | printStmt
      | assignStmt
      | whileStmt
      | arrStmt
      | 'break' SC
      | 'continue' SC
      | LC states RC
	  ;

// §2. details inside the mainClass
mainMthod: 'public' 'static' 'void' 'main' LRB 'String' (LB RB | VARARGS) ID RRB LC state RC ;
// §3. details inside the normal class
fieldDeclaration: types ID SC ;
method : 'public'? types ID LRB parameters? RRB LC variableDeclaration? states? retState RC ;
types : 'int' 
	  | 'boolean'
	  | 'char'
      | 'int' LB RB
	  | 'String' 
	  | ID
	  ;

parameters : types ID ( COMMA types ID )* ;

// §4. the details of method
variableDeclaration : intVDec
					|strVDec
					|booVDec
					|chaVDec 
					|refVDec
					|intArrVDec
					;
refVDec: ID  ID (ASSIGN (reference| thisChainStmt))? SC ;

chaVDec: 'char' ID (ASSIGN  character)? SC ;

booVDec: 'boolean' ID (ASSIGN bool)? SC ;

strVDec: 'String' ID (ASSIGN string)? SC ; 

intVDec: 'int' ID (ASSIGN integer)? SC;

intArrVDec : 'int' LB RB ID (ASSIGN ('new' 'int' LB (PO_INTEGER | ID) RB 
								| LC (integer | CHARACTER) (COMMA (integer | CHARACTER))* RC))? 
								;//int array variable declaration int[] num=new int[n || 3] 
								//int[] num= {1,2,5}

 
string : STRING 
	   | STRING PLUS STRING
	   | STRING PLUS CHARACTER 
	   ;
integer : (PO_INTEGER | DIGIT | neInteger)
	    | ID DOT 'length'
	    | ID DOT 'length' LRB RRB
		| ID LB (PO_INTEGER | ID) RB //the int array like b[3]
		;
neInteger: MINUS NE_INTEGER;


character : CHARACTER
		  | (ID | string) DOT 'charAt' LRB (PO_INTEGER | ID)  RRB
		  ;
		  
bool : 'true'
	 | 'false'
	 | thisChainStmt
	 ;
//b[8] = this.e()[new f().g(3)];
reference : 'new' ID LRB RRB (DOT ID LRB argList? RRB)* ;
argList: fullTypes (COMMA fullTypes)*;  //arguments for method call e.g. m(a,d)
retState : 'return' (fullTypes | boolExp) SC ;
fullTypes : assignExpre
		  | thisChainStmt
		  |	reference 
          | character
          | bool
          | string
          | integer
          | 'this'
          ;
thisChainStmt : rBIdDotMethod  //(id.m()).m()
              | idDotMethod
			  | ('this' DOT)? ID LRB argList? RRB (DOT ID LRB argList? RRB)*//this.d()
			  | LRB ('this' DOT)? ID LRB argList? RRB RRB (DOT ID LRB argList? RRB)*//(this.id())......
			  | 'new' ID LRB RRB (DOT ID LRB argList? RRB)+ //new f().g(3)...
			  | LRB 'new' ID LRB RRB DOT ID LRB argList? RRB RRB (DOT ID LRB argList? RRB)* //(new f().g(3))...
			  ;
idDotMethod : idDotid (DOT ID LRB argList? RRB)*;//id.m()
idDotid: ID (DOT ID)*
	   | LRB ID (DOT ID)* RRB  ; //id.id
rBIdDotMethod : LRB idDotMethod RRB (DOT ID LRB argList? RRB)*;

// §5. the details of state,i.e statement
/* String concatenation (+), length check (.length()), and character access (e.g. .charAt(7)). 
   The only applicable operators on characters are ==, <, and concatenation with strings. 
 */		

subBoolExpn : LRB NON? subBoolExp RRB 
		 | NON? LRB subBoolExp RRB
		 ;
boolExp: boolExpn
       | subBoolExp ((AND | OR) subBoolExp)*
	   ;
boolExpn: NON LRB boolExp RRB;

subBoolExp: subBoolExpn
		  | (assignExpre | character) (EQUALS | LESSTHAN) (assignExpre | character)
		  | bool EQUALS bool
		  | bool 
		  | thisChainStmt
		 ;
assignExpre : rBAExpre //round brace assignStament
		| assignExpre (MULT | DIV) assignExpre 
		| assignExpre (PLUS | MINUS) assignExpre
        | integer 
        | ID 
        | thisChainStmt
        ;
rBAExpre : LRB assignExpre RRB ;
  
// § 5.1 statement details , while statement
whileStmt: 'while' LRB boolExp RRB LC states RC ;
// § 5.2 statement details , if statement
ifStmt : 'if' LRB boolExp RRB (LC states? RC | state) elseIfPart* elsePart?
	   | 'if' LRB boolExp RRB SC
	   | 'if' LRB boolExp RRB elseIfPart* elsePart?
	   ;
elseIfPart: 'else' 'if' LRB boolExp RRB (LC states? RC | state)? ;
elsePart : 'else' (LC states? RC | state) ;
// § 5.3 statement details , assign statement
assignStmt : ID ASSIGN fullTypes SC ;
// § 5.4 statement details , array statement
//b[8] = this.e()[new f().g(3)];
arrStmt : ID LB assignExpre RB ASSIGN assignExpre arrStmtSub? SC 
		| ID ASSIGN 'new' 'int' LB (PO_INTEGER | ID) RB SC // = new int[3] 
		;
arrStmtSub: LB assignExpre RB;

// § 5.5 statement details , print statement
printStmt: 'System' DOT 'out' DOT 'println' LRB fullTypes RRB SC;



		
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
DOT : '.' ;

ID: LETTER(LETTER|DIGIT)* ;
LETTER : [a-zA-Z_$];
DIGIT : [0-9];
CHARACTER : '\'' ~['\\\r\n] '\'' ;
STRING :  '"' (~["\\\r\n])* '"';

PO_INTEGER : [1-9] ([1-9]|'0')+ // FROM 10
		     ;
NE_INTEGER : [1-9] ([1-9]|'0')* ;


// skip spaces, tabs, newlines, comments
WS : [ \r\t\r\n]+ -> skip ; 
COMMENT_BLOCK : '/*' .*? '*/' -> skip;
LINE_COMMENT: '//' ~[\r\n]* -> skip;

