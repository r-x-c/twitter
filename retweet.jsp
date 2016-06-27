<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.mysql.jdbc.*" %>
			//out.println(query);
<%
	String user_id = request.getParameter("user_id");
	String tweet_id = request.getParameter("tweet_id");
	String username = request.getParameter("username");
	String tweet = "";
	String redirectURL = "";

	int status = 0;
	
		java.sql.Connection conn = null;
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        String url = "jdbc:mysql://127.0.0.1/rchen";   //location and name of database
        String userid = "";
        String pass = "";
        conn = DriverManager.getConnection(url, userid, pass);      //connect to database
        
        java.sql.Statement stmttweet = conn.createStatement();
        java.sql.Statement stmt = conn.createStatement();
        
	String findText =  ("select tweet_text from tweet_t where tweet_id =" + tweet_id);

    java.sql.ResultSet x = stmt.executeQuery(findText);
        while(x.next())
        {
         	tweet = x.getString(1);
        }

		tweet = ("Retweet from @" + username + ": " + tweet);
        
    	java.sql.PreparedStatement tc = conn.prepareStatement("insert into tweet_t (tweet_text, user_id) values (? , ?)");


  		tc.setString (1, tweet);
  		tc.setString (2, user_id);


        status = tc.executeUpdate();
           	 	
        redirectURL = "twitter-home.jsp?key=" + user_id;
 	 	response.sendRedirect(redirectURL);

%>
