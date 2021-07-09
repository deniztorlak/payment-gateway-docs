package example;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Map;
import java.util.Map.Entry;
/**
 *
 * @author bsonmez
 */
public class HTTPRequest {
    
    public HTTPRequest() {
    }
    
    /**
     *
     * @param targetURL Targeted URL to send POST request.
     * @param parameters Request query parameters for POST request.
     * @return Answer of the target.
     */
    public String sendPostRequest(String targetURL, Map<String, String> parameters) {
        String result;
        try {
            HttpURLConnection con = (HttpURLConnection) (new URL(targetURL)).openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            con.setRequestProperty("Accept", "application/xml");
            String qString="";
            int i = 0;
            for (Entry<String, String> parameter : parameters.entrySet()) {
                if (i != 0) qString = qString + "&";
                qString = qString + URLEncoder.encode(parameter.getKey(), "UTF-8");
                qString = qString + "=";
                qString = qString + URLEncoder.encode(parameter.getValue(), "UTF-8");
                i++;
            }
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            wr.writeBytes(qString);
            wr.flush();
            wr.close();
            
            BufferedReader in = new BufferedReader(
		        new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();

            while ((inputLine = in.readLine()) != null) {
                    response.append(inputLine);
            }
            in.close();
            result = response.toString();
        } catch(Exception e) {
            System.out.println("HTTP request yapılırken problem oldu: " + e.getMessage());
            result = "";
        }
        return result;
    }
}
