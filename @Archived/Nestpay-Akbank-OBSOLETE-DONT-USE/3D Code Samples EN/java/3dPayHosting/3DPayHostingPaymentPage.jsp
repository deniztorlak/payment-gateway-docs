<%@page contentType="text/html;charset=ISO-8859-9"%>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

   <html>
       <head>
           <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
           <title>3D Hosting Payment Page</title>
       </head>
       <body>
         <h1>3D Hosting Payment Page</h1>
    
    
    <h3>3D Parameters</h3>
    <table border="1">
        <tr>
            <td>Parameter Name:</td>
            <td>Parameter Value:</td>
        </tr>
    
    <%
       String [] paymentParameters = new String[]{"AuthCode","Response","HostRefNum","ProcReturnCode","TransId","ErrMsg"};
       java.util.Enumeration enu = request.getParameterNames();
                while(enu.hasMoreElements())
                    {
                        String param = (String)enu.nextElement();
                        String val = (String)request.getParameter(param);
                        boolean ok = true;
                        for(int i=0;i<paymentParameters.length;i++)
                        {
                            if(param.equalsIgnoreCase(paymentParameters[i]))
                            {    
                                ok = false;
                                break;
                            }
                        }
                        if(ok)
                            out.println("<tr><td>"+param+"</td>"+"<td>"+val+"</td></tr>");
                    }
    
    %>
    </table>
    <br>
    <br>
    <%
          String hashparams = request.getParameter("HASHPARAMS");
    String hashparamsval = request.getParameter("HASHPARAMSVAL");
    String storekey="XXXXXXX";
    String paramsval="";
    int index1=0,index2=0;
	
    //values which will be used in hash validation is being parsed
	
    do
    {   
        index2 = hashparams.indexOf(":",index1);
        String val = request.getParameter(hashparams.substring(index1,index2)) == null ? "" : request.getParameter(hashparams.substring(index1,index2));
        paramsval += val;
        index1 = index2 + 1;
    }
    while(index1<hashparams.length());
    
    String hashval = paramsval + storekey;         //Store key is being added to hash value
    String hashparam = request.getParameter("HASH");
    java.security.MessageDigest sha1 = java.security.MessageDigest.getInstance("SHA-1");
        
    String hash = (new sun.misc.BASE64Encoder()).encode(sha1.digest(hashval.getBytes()));  
         
            String mdStatus = request.getParameter("mdStatus"); //Result of the 3D Secure authentication. 1,2,3,4 are successful; 5,6,7,8,9,0 are unsuccessful.
            if(mdStatus!=null && (mdStatus.equals("1") || mdStatus.equals("2") || mdStatus.equals("3")|| mdStatus.equals("4"))) 
            {
                
             %>
                <h5>3D Authentication is successful.</h5><br/>
                <h3>Payment Result</h3>
                <table border="1">
                    <tr>
                        <td><b>Parameter Name</b></td>
                        <td><b>Parameter Value</b></td>
                    </tr>
                    <%
                        for(int i=0;i<paymentParameters.length;i++)
                        {
                            String paramname = paymentParameters[i];
                            String paramval = request.getParameter(paramname);
                            out.println("<tr><td>"+paramname+"</td><td>"+paramval+"</td></tr>");
                        }
                    
                    %>
                </table>
                
            <%
            if("Approved".equalsIgnoreCase(request.getParameter("Response")))
            {
            %>
                <h6>Payment is successful.</h6>
            <%
            }else{
                %>
                    <h6>Payment is unsuccessful.</h6>
                <%
            }
            }else{
             %>
             <h5>3D Authentication is successful.</h5>
             <%
            }
             if(!paramsval.equals(hashparamsval)|| !hash.equals(hashparam)) //hash generated in this page, hash returned and hash generated from parsed parameters should be same
            {
                out.println("<h4>Security warning. Digital signature is wrong.</h4>");
            }
    
    %>       
           
       </body>
       
   </html>