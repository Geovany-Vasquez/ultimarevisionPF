package modelo;


import javax.swing.text.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import modelo.generador_arbol;
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Geovany
 */
public class NodoDOM 
{   
private Node nodoDOM;
@Override
public String toString( )
{

String S = "";
if( nodoDOM.getNodeType( ) == Node.ELEMENT_NODE )
{
S += "Element: " + nodoDOM.getNodeName ( )              //metodos toString() de la clase NodoDOM
            + " Valor: " + nodoDOM.getTextContent( );

NamedNodeMap atributos = nodoDOM.getAttributes();

for( int i = 0; i < atributos.getLength( ); i++ )
{

S += "Attr: "+ atributos.item( i );                     // retorna el texto a desplegar en el árbol

}
}

return S;
            
}
}
        