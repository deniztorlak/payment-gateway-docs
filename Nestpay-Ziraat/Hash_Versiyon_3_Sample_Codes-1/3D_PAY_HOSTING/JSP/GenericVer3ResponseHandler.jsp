<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="java.security.MessageDigest"%>

<%@page import="java.util.Locale"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.SortedMap"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Comparator"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HASH RESULT</title>


</head>
<body >
<table>

		<%
		    // create sorted map
		    SortedMap<String, String> allRequestParams = new TreeMap<String, String>(new Comparator<String>() {
		        public int compare(String str1, String str2) {
		            str1 = str1.toUpperCase(Locale.US);
		            str2 = str2.toUpperCase(Locale.US);
		            return str1.compareTo(str2);
		        }
		    });
		    // get all paramater map
		    Map<String, String[]> parameterMap = request.getParameterMap();
		    Set<String> requestParams = parameterMap.keySet();
		    for (String requestParam : requestParams) {
		        String[] allRequestParamValues = parameterMap.get(requestParam);
		        if (allRequestParamValues != null && allRequestParamValues.length > 0) {
		            String value = allRequestParamValues[0];
		            allRequestParams.put(requestParam, value);
		%>
				<tr><td><%=requestParam%></td><td><%=value%></td></tr>
		<%
		    }
		    }
		    // init hash value 
		    String hashval3 = "";
		    for (String requestParam : allRequestParams.keySet()) {
		        String lowerParam = requestParam.toLowerCase(Locale.US);
		        if (!lowerParam.equals("encoding") && !lowerParam.equals("hash")) {
		            hashval3 += request.getParameter(requestParam).replace("\\", "\\\\").replace("|", "\\|") + "|";
		        }
		    }
		    String storeKey = "TEST1234";
		    storeKey = storeKey.replace("\\", "\\\\").replace("|", "\\|");
		    hashval3 += storeKey;

		    MessageDigest messageDigest = MessageDigest.getInstance("SHA-512");
		    messageDigest.update(hashval3.getBytes());
		    String actualHash = new String(Base64.encodeBase64(messageDigest.digest()), "UTF-8");
		    String retrievedHash = request.getParameter("HASH");
		    if(actualHash.equals(retrievedHash)){
		%>
			<h4>HASH is successfull</h4><br />
		<%} else { %>
			<h4>Security Alert. The digital signature is not valid.</h4> <br />
		<%} %>
		
		
</table>
</body>
</html>
