package modelo;

import java.util.LinkedList;
import java.awt.List;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.StringReader;
import java.util.Iterator;
import javax.swing.event.TreeModelEvent;
import javax.swing.event.TreeModelListener;
import javax.swing.text.Document;
import javax.swing.tree.TreeModel;
import javax.swing.tree.TreePath;
import org.xml.sax.InputSource;
import modelo.NodoDOM;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.*;
import javax.xml.parsers.*;
import java.io.*;
import javax.swing.JFrame;
import javax.swing.JTree;
import javax.swing.tree.DefaultMutableTreeNode;
/**
 *
 * @author Geovany
 */
public class generador_arbol implements TreeModel
{

private Document documento; // referencia al documento
private LinkedList listenerList = new LinkedList( );
    /*LinkedList*/ // se declara la colección de listeners del modelo
boolean colapsado = true; //declara un atributo booleano que informa si el nodo esta comprimido o no

public Object getRoot( )// retorna el documento de árbol DOM
{
    return new NodoDOM ( documento );
}
public boolean isLeaf( Object aNode ) // indica siel nodo del párametro es hoja
{
    NodoDOM node = (NodoDOM) aNode;   // NodoDOM es una nueva clase para personalizar un nodo DOM(). >:D
    if(node.childCount()>0)
        return false;
    return true;
}
public int getChildCount( Object parent )
{
   NodoDOM node = ( NodoDOM )parent;
   return node.childCount(); 
}
public Object getChild(Object parent, int index )
{
   NodoDOM node = ( NodoDOM )parent;
   return node.child ( index ); 
}
public int getIndexOfChild( Object parent, Object child )
{
    NodoDOM node = ( NodoDOM )parent;
    return node.index(( NodoDOM )child);
}
public void valueForPathChanged(TreePath path, Object newValue )
{

}
public void addTreeModelListener( TreeModelListener listener )
{
    if( listener != null && !listenerList.contains( listener )) 
    {
     listenerList.add (listener );
}
}
public void removeTreeModelListener( TreeModelListener listener )
{
    if (listener !=null)
    {
    listenerList.remove(listener) ;
    }
}
public void fireTreeNodesChanged( TreeModelEvent e )  //respuesta a la modificación del nodo
{
Iterator it = listenerList.iterator();
while(it.hasNext())
{
TreeModelListener listener = (TreeModelListener)it.next();
listener.treeNodesChanged(e);
}


}
public void fireTreeNodesInserted( TreeModelEvent e )  // respuesta a la inserción del nodo nuevo
{

}
public void fireTreeNodesRemoved( TreeModelEvent e )   //respuesta a la eliminación del nodo
{

}
public void fireTreeStructureChanged( TreeModelEvent e ) // respuesta a la modificación de la estructura del árbol
{

}
   
public generador_arbol (String rutaXml ) throws Exception{
    try
    {
        cargarXml(rutaXml); //se carga el archivo XML en un árbol de nodos DOM
    }
catch( Exception e )
{
throw new Exception( "Error de lectura"+ e.getMessage() );
        }
}
public void cargarXml( String xmlPath ) throws Exception
{
StringBuffer lectura = new StringBuffer( );// se lee el archivo
try
{
FileReader fr = new FileReader( xmlPath );
BufferedReader in = new BufferedReader ( fr );
String str;
while( ( str = in.readLine( ) ) != null )
{
lectura.append( str );
}
in.close( );
fr.close();
}
catch( IOException e )
{

throw new Exception( "Error al leer el archivo del disco", e );

}                                                                    // aca termina la lectura del archivo :v

 
String xml = lectura.toString( );
DOMParser parser = new DOMParser( );     // saca el xml completo y lo parsea utilizando DOM
parser.parse( new InputSource( new StringReader( xml ) ) );
documento = parser.getDocument( );
}

}
        
