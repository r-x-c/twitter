<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.mysql.jdbc.*" %>
<%
	String user_id = request.getParameter("user_id");
	String tweet_user_id = "";
	String username = "";
	int status = 0;
	
	
	
		java.sql.Connection conn = null;
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        String url = "jdbc:mysql://127.0.0.1/rchen";   //location and name of database
        String userid = "";
        String pass = "";
        conn = DriverManager.getConnection(url, userid, pass);      //connect to database
        
        java.sql.Statement stmt = conn.createStatement();
        
        
		String querytd = ("Select f2 from friends_t where f1=" + user_id);
		java.sql.ResultSet rstweettd = stmt.executeQuery(querytd);
		
		out.println(rstweettd.getString(1));
		
//Hashtag Hyperlinking & Key Redirect
        while(rstweettd.next())
        {
        	 tweet_user_id = rstweettd.getString(1);
				out.println(tweet_user_id);
        }
        

// 	           java.sql.PreparedStatement tc = conn.prepareStatement("delete from tweet_t where tweet_id=(?)");
//         		tc.setString (1, tweet_id);
// 
//            	 	status = tc.executeUpdate();
// 
// 				java.sql.Statement stmt = conn.createStatement();
// 
// 
// 		java.sql.ResultSet rstweettd = stmt.executeQuery(querytd);
// 
// 		while(rstweettd.next())
//         {
//         	 username = rstweettd.getString(1);
//         	 
//         	 String getuserID = "select user_id from user_t where username='" + username + "'";
// 				java.sql.ResultSet rsgetuserID = stmt.executeQuery(getuserID);
//     
//   				  while (rsgetuserID.next())
//   					  {
// 
// 							out.println(tweet_user_id);
//     				    }
        

%>
