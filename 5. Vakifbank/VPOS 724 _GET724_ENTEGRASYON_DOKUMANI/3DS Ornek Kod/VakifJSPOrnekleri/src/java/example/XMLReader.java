package example;
import java.io.StringReader;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
/**
 *
 * @author bsonmez
 */

public class XMLReader {
    private Document doc;
    
    /**
     *
     * @param input Input XML file.
     */
    public XMLReader(String input) {
        try {
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            doc = dBuilder.parse(new InputSource(new StringReader(input)));
            doc.getDocumentElement().normalize();
        } catch (Exception e) {
            System.out.println("XML okunurken problem oldu: " + e.getMessage());
        }
    }
    
    /**
     *
     * @param tagName The tag to read value from XML file.
     * @return Value of the read tag.
     */
    public String readNode(String tagName) {
        String result = "";
        NodeList nList = doc.getElementsByTagName(tagName);
        if (nList.getLength() != 0) {
            result = nList.item(0).getTextContent();
        }
        return result;
    }
}
