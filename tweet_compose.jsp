<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.mysql.jdbc.*" %>
			//out.println(query);
<%
	String text = request.getParameter("tweetdata");
	String user_id = request.getParameter("user_id");
	String hash_id = "";
	String tweet_id = "";
	boolean hashfound = false;
	String hashtag = "";
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
        
        java.sql.PreparedStatement tc = conn.prepareStatement("insert into rchen.tweet_t (tweet_text, user_id) values (?, ?);");
		tc.setString (1, text);
   	 	tc.setString (2, user_id);
   	 	status = tc.executeUpdate();
   	 	
   	 	String retrievetweetid = "select tweet_id from tweet_t";
		java.sql.ResultSet tweet_list = stmttweet.executeQuery(retrievetweetid);
		
		while(tweet_list.next() )
		{
			tweet_id = tweet_list.getString(1);
		}
				
		String[] data = text.toUpperCase().split("[,. ]+");
		
	//	out.println("44: dl is: " + data.length);		
		for (int i = 0; i < data.length; i++)
		{
			if(data[i].isEmpty())
			{
				i++;
			}
			
			
			else if(data[i].substring(0,1).equals("#") && !data[i].substring(1,data[i].length()).isEmpty())
			{
				hashtag = data[i].substring(1, data[i].length()).toUpperCase();
				
				String hash_exist = "select hash_id from hash_t where hashtag='" + hashtag + "'";				
				java.sql.ResultSet tc_exist = stmt.executeQuery(hash_exist);
		 
					while(tc_exist.next()) //already exists
					{
								hash_id = tc_exist.getString(1);
								hashfound = true;
								java.sql.PreparedStatement ps = conn.prepareStatement("insert into rchen.tweethash_t (tweetnum, hashnum) values (?, ?)");
								ps.setString (1, tweet_id);
								ps.setString (2, hash_id);
								status = ps.executeUpdate();
					}//while
		 
					 if(!hashfound) //does not exist
					 {
					 		java.sql.PreparedStatement ps = conn.prepareStatement("insert into rchen.hash_t (hashtag) values (?)");
  				 	  		ps.setString (1, hashtag);
  				 	 	 	status = ps.executeUpdate();
  				 	 	 								
						 	java.sql.ResultSet find_hash = stmt.executeQuery(hash_exist);
						 	
						 	while(find_hash.next())
						 	{
						 		hash_id = find_hash.getString(1);
						 	}
						 	
				 			java.sql.PreparedStatement dne = conn.prepareStatement("insert into rchen.tweethash_t (tweetnum, hashnum) values (?, ?)");
  				 	  		dne.setInt (1, Integer.parseInt(tweet_id));
 				  	  		dne.setInt (2, Integer.parseInt(hash_id));
  				 	 	    status = dne.executeUpdate();
    			    }
			}//if
			
			else
			{
				i++;
			}
			
		}//for
		redirectURL = "twitter-home.jsp?key=" + user_id;
 	 	response.sendRedirect(redirectURL);
%>
