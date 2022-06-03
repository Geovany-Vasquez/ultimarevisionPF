import compilerTools.TextColor;
import java.awt.Color;

%%
%class LexerColor
%type TextColor
%char
%{
    private TextColor textColor(long start, int size, Color color){
        return new TextColor((int) start, size, color);
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
{Letra} {return textColor(yychar, yylength(), Color.white);}

/* Comentarios o espacios en blanco */
{Comentario} { return textColor(yychar, yylength(), new Color(146,146,146)); }
{EspacioEnBlanco} { /*Ignorar*/ }




/* Tipos de datos */
numero |
color { return textColor(yychar, yylength(), new Color(148, 58, 173));}



/* Numero */
{Numero} {return textColor(yychar, yylength(), new Color(135, 129, 147));}

/* Colores */
#[{Letra}|{Digito}]{6} { return textColor(yychar, yylength(), new Color(224, 195, 12));}

/* Operadores de agrupacion */
"(" | ")" | "{" | "}" { return textColor(yychar, yylength(), new Color(169, 155, 179));}

/* Signos de puntuacion */
"," | ";" { return textColor(yychar, yylength(), Color.red );}


/* Operadores de asignacion */
= { return textColor(yychar, yylength(), new Color(169, 155, 179));}




/* while */
do |
while { return textColor(yychar, yylength(), new Color(121, 107, 255));}


/* break */
Break { return textColor(yychar, yylength(), new Color(255, 64, 146));}

/* if */
if { return textColor(yychar, yylength(), Color.red );}
else { return textColor(yychar, yylength(), Color.red );}


/* Operadores logicos */
"&" |
"|" { return textColor(yychar, yylength(), new Color(48, 63, 159));}
/* Estructura */
!DOCTYPE | html | head | body | base | meta | link | style 1 script { return textColor(yychar, yylength(), Color.blue ); }

/* Signos */
"(" | ")" | "{" | "}" | "[" | "]" | "<" | ">" | "/" { return textColor(yychar, yylength(), Color.green); }

/* Atributos */
id/=  { return textColor(yychar, yylength(), new Color(0, 191, 255)); }
class | lang | translate | title | data-share | accesskey | dir | style { return textColor(yychar, yylength(), Color.blue );; }

/* Obsoleto */
applet | acronym | bgsound | frame | frameset | noframes | hgroup | isindex |
 listing | xmp | noembed | strike | basefont | big | blink | center | font |
 marquee | multicol | nobr | spacer | menu { return textColor(yychar, yylength(), Color.blue ); }

/* Atributos Obsoletos */
charset | name | language | link | alink | vlink | bgcolor | align |
 valign | hspace | vspace | allowtransparency | frameborder | scrolling |
 border | cellpadding | cellspacing | nowrap { return textColor(yychar, yylength(), Color.blue ); }

/* Texto */
"<strong>" | "<em>" | "<mark>" | "<i>" | "<b>" | "<u>" | "<s>" | "<span>" | "<cite>" | "<sup>" | "</sup>" | "<sub>" | "</sub>" |
 "<small>" | "<q>" | "</q>" | "<dfn>" | "<abbr>" | "<br>" | "<wbr>" | "<kbd>" | "<samp>" | "<var>" | "<time>" |
 "<data>" | "<code>" | "<ins>" | "<del>" { return textColor(yychar, yylength(), Color.blue ); }
"q " { return textColor(yychar, yylength(), Color.blue ); }

/* Agrupación */
"<"p">" | "<""/"p">" | "p " | "<"div">" | "<""/"div">" | "div " | "<"pre">" | "<""/"pre">" |
 "<"blockquote">" | "<""/"blockquote">" | "blockquote " | "<"main">" | "<""/"main">" |
 "<"hr">" | "<""/"hr">" | "<"ul">" | "<""/"ul">" | "<"ol">" | "<""/"ol">" | "ol " |
 "<"li">" | "<""/"li">" | "<"dl">" | "<""/"dl">" |  "<"dt">" | "<""/"dt">" |
 "<"dd">" | "<""/"dd">" |  "<"figure">" | "<""/"figure">" |  "<"figcaption">" | "<""/"figcaption">" { return textColor(yychar, yylength(), Color.blue ); }
start/= { return textColor(yychar, yylength(), Color.blue ); }
reversed/= { return textColor(yychar, yylength(), Color.blue ); }
type/= { return textColor(yychar, yylength(), Color.blue ); }

/* Hipervinculos */
"<"a">" | "<""/"a">" { return textColor(yychar, yylength(), Color.blue ); }
href/=  { return textColor(yychar, yylength(), Color.blue ); }
download/=  { return textColor(yychar, yylength(), Color.blue ); }
target/=  { return textColor(yychar, yylength(), Color.blue ); }
rel/= { return textColor(yychar, yylength(), Color.blue );}
hreflang/= { return textColor(yychar, yylength(), Color.blue ); }
type/= { return textColor(yychar, yylength(), Color.blue ); }

/* Seccion */
"<"article">" | "<""/"article">" | "article " | "<"nav">" | "<""/"nav">" | "<"header">" | "<""/"header">" |
 "<"h1">" | "<""/"h1">" | "<"h2">" | "<""/"h2">" | "<"h3">" | "<""/"h3">" | "<"h4">" | "<""/"h4">" |
 "<"h5">" | "<""/"h5">" | "<"h6">" | "<""/"h6">" | "<"footer">" | "<""/"footer">" | "<"section">" | "<""/"section">" |
 "<"aside">" | "<""/"aside">" | "<"address">" | "<""/"address">" { return textColor(yychar, yylength(), Color.blue ); }

/* Tablas */
"<"table">" | "<""/"table">" | "<"tr">" | "<""/"tr">" | "<"td">" | "<""/"td">" | "<"th">" | "<""/"th">" |
 colspan | rowspan | headers | scope | abbr | "<"thead">" | "<""/"thead">" | "<"tbody">" | "<""/"tbody">" |
 "<"tfoot">" | "<""/"tfoot">" | "<"caption">" | "<""/"caption">" | "<"colgroup">" | "<""/"colgroup">" |
 "<"col">" | "<""/"col">" | "col " { return textColor(yychar, yylength(), Color.blue ); }





. { /* Ignorar */ }