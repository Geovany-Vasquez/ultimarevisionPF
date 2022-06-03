import compilerTools.Token;

%%
%class Lexer
%type Token
%line
%column
%{
    private Token token(String lexeme, String lexicalComp, int line, int column){
        return new Token(lexeme, lexicalComp, line+1, column+1);
    }
%}
/* Variables básicas de comentarios y espacios */
TerminadorDeLinea = \r|\n|\r\n
EntradaDeCaracter = [^\r\n]
EspacioEnBlanco = {TerminadorDeLinea} | [ \t\f]
ComentarioTradicional = "/*" [^*] ~"*/" | "/*" "*"+ "/"
FinDeLineaComentario = "//" {EntradaDeCaracter}* {TerminadorDeLinea}?
ContenidoComentario = ( [^*] | \*+ [^/*] )*
ComentarioDeDocumentacion = "/**" {ContenidoComentario} "*"+ "/"

/* Comentario */
Comentario = {ComentarioTradicional} | {FinDeLineaComentario} | {ComentarioDeDocumentacion}

/* Identificador */
Letra = [A-Za-zÑñ_ÁÉÍÓÚáéíóúÜü]
Digito = [0-9]
Identificador = {Letra}({Letra}|{Digito})*
Reserva = [h]


/* Número */
Numero = 0 | [1-9][0-9]*
%%
/* Numero */
{Letra} {return token(yytext(), "TXT", yyline, yycolumn);}

/* Comentarios o espacios en blanco */
{Comentario}|{EspacioEnBlanco} { /*Ignorar*/ }

\<{Reserva}{Digito}> { return token(yytext(), "ETIQUETA", yyline, yycolumn); }


\/<{Reserva}{Digito}> { return token(yytext(), "ETIQUETA", yyline, yycolumn); }




/* Tipos de datos */
numero |
color { return token(yytext(), "TIPO_DATO" , yyline, yycolumn);}



/* Numero */
{Numero} {return token(yytext(), "NUMERO", yyline, yycolumn);}

/* Colores */
#[{Letra}|{Digito}]{6} { return token(yytext(), "COLOR", yyline, yycolumn);}

/* Operadores de agrupacion */
"(" { return token(yytext(), "PARENTESIS_A", yyline, yycolumn);}
")" { return token(yytext(), "PARENTESIS_C", yyline, yycolumn);}
"{" { return token(yytext(), "LLAVE_A", yyline, yycolumn);}
"}" { return token(yytext(), "LLAVE_c", yyline, yycolumn);}

/* Signos de puntuacion */
"," {return token(yytext(), "COMA", yyline, yycolumn);}
";" {return token(yytext(), "PUNTO_COMA", yyline, yycolumn);}

/* Operadores de asignacion */
= {return token(yytext(), "OP_ASIG", yyline, yycolumn);}




/* while */
do |
while {return token(yytext(), "WHILE", yyline, yycolumn);}


/* break */
Break {return token(yytext(), "BREAK", yyline, yycolumn);}

/* if */
if {return token(yytext(), "IF", yyline, yycolumn);}
else {return token(yytext(), "else", yyline, yycolumn);}


/* Operadores logicos */
"&" |
"|" {return token(yytext(), "OP_LOGICO", yyline, yycolumn);}

/* Estructura */
!DOCTYPE | html | head | body | base | meta | link | style 1 script { return token(yytext(), "Estructura", yyline, yycolumn);}

/* Signos */
"(" | ")" | "{" | "}" | "[" | "]" | "<" | ">" | "/" { return token(yytext(), "Signos", yyline, yycolumn); }


/* Atributos */
id/=  { return textColor(yychar, yylength(), new Color(0, 191, 255)); }
class | lang | translate | title | data-share | accesskey | dir | style { return token(yytext(), "Atributos", yyline, yycolumn); }

/* Obsoleto */
applet | acronym | bgsound | frame | frameset | noframes | hgroup | isindex |
 listing | xmp | noembed | strike | basefont | big | blink | center | font |
 marquee | multicol | nobr | spacer | menu {return token(yytext(), "EtiquetaO", yyline, yycolumn);  }

/* Atributos Obsoletos */
charset | name | language | link | alink | vlink | bgcolor | align |
 valign | hspace | vspace | allowtransparency | frameborder | scrolling |
 border | cellpadding | cellspacing | nowrap { return token(yytext(), "AtributosO", yyline, yycolumn); }

/* Texto */
"<strong>" | "<em>" | "<mark>" | "<i>" | "<b>" | "<u>" | "<s>" | "<span>" | "<cite>" | "<sup>" | "</sup>" | "<sub>" | "</sub>" |
 "<small>" | "<q>" | "</q>" | "<dfn>" | "<abbr>" | "<br>" | "<wbr>" | "<kbd>" | "<samp>" | "<var>" | "<time>" |
 "<data>" | "<code>" | "<ins>" | "<del>" { return token(yytext(), "EtiquetasT", yyline, yycolumn); }
"q " { return token(yytext(), "texte", yyline, yycolumn); }

/* Agrupación */
"<"p">" | "<""/"p">" | "p " | "<"div">" | "<""/"div">" | "div " | "<"pre">" | "<""/"pre">" |
 "<"blockquote">" | "<""/"blockquote">" | "blockquote " | "<"main">" | "<""/"main">" |
 "<"hr">" | "<""/"hr">" | "<"ul">" | "<""/"ul">" | "<"ol">" | "<""/"ol">" | "ol " |
 "<"li">" | "<""/"li">" | "<"dl">" | "<""/"dl">" |  "<"dt">" | "<""/"dt">" |
 "<"dd">" | "<""/"dd">" |  "<"figure">" | "<""/"figure">" |  "<"figcaption">" | "<""/"figcaption">" { return token(yytext(), "Agrupa", yyline, yycolumn); }
start/= { return token(yytext(), "Empe", yyline, yycolumn); }
reversed/= { return token(yytext(), "Rever", yyline, yycolumn); }
type/= { return token(yytext(), "Escrit", yyline, yycolumn); }

/* Hipervinculos */
"<"a">" | "<""/"a">" { return token(yytext(), "Hiperv", yyline, yycolumn); }
href/=  { return token(yytext(), "referenci", yyline, yycolumn);}
download/=  { return token(yytext(), "Descarga", yyline, yycolumn); }
target/=  { return token(yytext(), "Targ", yyline, yycolumn); }
rel/= { return token(yytext(), "R", yyline, yycolumn);}
hreflang/= { return token(yytext(), "Refer", yyline, yycolumn); }
type/= { return token(yytext(), "Escrit", yyline, yycolumn); }

/* Seccion */
"<"article">" | "<""/"article">" | "article " | "<"nav">" | "<""/"nav">" | "<"header">" | "<""/"header">" |
 "<"h1">" | "<""/"h1">" | "<"h2">" | "<""/"h2">" | "<"h3">" | "<""/"h3">" | "<"h4">" | "<""/"h4">" |
 "<"h5">" | "<""/"h5">" | "<"h6">" | "<""/"h6">" | "<"footer">" | "<""/"footer">" | "<"section">" | "<""/"section">" |
 "<"aside">" | "<""/"aside">" | "<"address">" | "<""/"address">" { return token(yytext(), "Etiqueta", yyline, yycolumn); }

/* Tablas */
"<"table">" | "<""/"table">" | "<"tr">" | "<""/"tr">" | "<"td">" | "<""/"td">" | "<"th">" | "<""/"th">" |
 colspan | rowspan | headers | scope | abbr | "<"thead">" | "<""/"thead">" | "<"tbody">" | "<""/"tbody">" |
 "<"tfoot">" | "<""/"tfoot">" | "<"caption">" | "<""/"caption">" | "<"colgroup">" | "<""/"colgroup">" |
 "<"col">" | "<""/"col">" | "col " { return token(yytext(), "tabla", yyline, yycolumn); }






//Numero erroneo
0{Numero} {return token(yytext(), "Error", yyline, yycolumn);}

. { return token(yytext(), "ERROR", yyline, yycolumn); }