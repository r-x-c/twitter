<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.mysql.jdbc.*" %>

<html>
	<body>

<%
	String user_id = request.getParameter("key");
	
	String redirectURL = "";
	String followers = "";
	String following = "";
	String tweetcount = "";
	String tweet = "";
	String username = "";
	String hyperlink = "";

	int status = 0;
	int counter = 0;

	java.sql.Connection conn = null;
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        String url = "jdbc:mysql://127.0.0.1/rchen";   //location and name of database
        String userid = "";
        String password = "";
        conn = DriverManager.getConnection(url, userid, password);      //connect to database
	
	java.sql.Statement stmt = conn.createStatement();

//Followers
	String queryfollowers = "select count(*) from friends_t where f2=" + user_id;

    java.sql.ResultSet rsfollowers = stmt.executeQuery(queryfollowers);
        while(rsfollowers.next())
        {
         	followers = Integer.toString(Integer.parseInt(rsfollowers.getString(1))-1);
        }

//Followings
	String queryfollowings =  "select count(*) from friends_t where f1=" + user_id;

    java.sql.ResultSet rsfollowings = stmt.executeQuery(queryfollowings);
        while(rsfollowings.next())
        {
         	following = Integer.toString(Integer.parseInt(rsfollowings.getString(1))-1);  	
        }
        
//Tweets
	String querytweets =  "select count(*) from tweet_t where user_id=" + user_id;

    java.sql.ResultSet rstweets = stmt.executeQuery(querytweets);
        while(rstweets.next())
        {
         	tweetcount = rstweets.getString(1);
        }

	//LOGIN = "select user_id FROM user_t where name=" + "'" + username + "'" +  " and password=" + "'" +  pwd + "'";

%>



<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <meta name="description" content="">
    <meta name="author" content="">
    <style type="text/css">
    	body {
    		padding-top: 60px;
    		padding-bottom: 40px;
    	}
    	.sidebar-nav {
    		padding: 9px 0;
    	}
    </style>    
    <link rel="stylesheet" href="css/gordy_bootstrap.min.css">
</head>
<body class="user-style-theme1">
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
                <i class="nav-home"></i> <a href="#" class="brand">!Twitter</a>
				<div class="nav-collapse collapse">
					<p class="navbar-text pull-right">Logged in as <a href="#" class="navbar-link">Username</a>
					</p>
					<ul class="nav">
						<li class="active"><a href="index.html">Home</a></li>
						<li><a href="queries.html">Test Queries</a></li>
						<li><a href="twitter-signin.html">Main sign-in</a></li>
					</ul>
				</div><!--/ .nav-collapse -->
			</div>
		</div>
	</div>

    <div class="container wrap">
        <div class="row">

            <!-- left column -->
            <div class="span4" id="secondary">
                <div class="module mini-profile">
                    <div class="content">
                        <div class="account-group">
                            <a href="#">
                                <img class="avatar size32" src="images/pirate_normal.jpg" alt="Gordy">
                                <b class="fullname">Gordy</b>
                                <small class="metadata">View my profile page</small>
                            </a>
                        </div>
                    </div>
                    <div class="js-mini-profile-stats-container">
                        <ul class="stats">
                            <li><a href="#"><strong> <%=tweetcount%></strong>Tweets</a></li>
                            <li><a href="twitter-following.html"><strong> <%=following%> </strong>Following</a></li>
                            <li><a href="#"><strong> <%=followers%>  </strong>Followers</a></li>
                        </ul>
                    </div>
                 		  
              		  </div>

                <div class="module other-side-content">
                    <div class="content"
						<html>
							<head>
							<title>HTML body tag</title>
							</head>
								<body style="background-image:url(b6.gif)">
									<form action="tweet_compose.jsp" class="tweet-box" method ="get">
									<textarea class="tweet-box" name="tweetdata" placeholder="Compose new Tweet..." id="tweet-box-mini-home-profile"></textarea>
									<input type="hidden" name="user_id" value="<%=user_id%>" > <br>
									<input type="submit" value="Submit" name="">
											
									</form>	
								</body>
						</html>                   

					 </div>
                </div>
            </div>

            <!-- right column -->
            <div class="span8 content-main">
                <div class="module">
                    <div class="content-header">
                        <div class="header-inner">
                            <h2 class="js-timeline-title">Tweets</h2>
                        </div>
                    </div>

                    <!-- new tweets alert -->
                    <div class="stream-item hidden">
                        <div class="new-tweets-bar js-new-tweets-bar well">
                            2 new Tweets
                        </div>
                    </div>

                    <!-- all tweets -->
                    <div class="stream home-stream">

<%
//Display Tweet
// 		
// 		String hashkey = "select hash_id from hash_t where hashtag='" + hashtag + "';";
// 		java.sql.ResultSet rstweettd = stmt.executeQuery(querytd);

		
		String querytd = "select a.username, b.tweet_text from user_t a natural join tweet_t b natural join friends_t c where c.f1 =" + user_id + " and c.f2 = b.user_id";
		java.sql.ResultSet rstweettd = stmt.executeQuery(querytd);
		
//Hashtag Hyperlinking & Key Redirect
        while(rstweettd.next())
        {
            username = rstweettd.getString(1);
         	tweet = rstweettd.getString(2);
				StringBuilder modtweet = new StringBuilder(tweet + " ");
				boolean inHashTag = false;
				int tempstart = 0;
				int tempend = 0;
				String hashtag = "";
				String hashid = "";


				for (int i = 1; i < tweet.length(); i++)
					{
						if(tweet.substring(i-1, i).equals("#")) //If a hashtag is detected, insert hyperlink primer
						{
							tempstart = i+19; //Tempstart and Tempend are used to get the hashtag, which is used to retrieve the hash_id (key)
							inHashTag = true;
							tweet = modtweet.replace(i-1, i-1,("<a href=\"hashkey=\">")).toString(); //i.e. <<a href="hashkey=">#NYC
							i+=21;
						}
						else if (inHashTag && tweet.substring(i, i+1).equals(" ")) //After a hashtag is detected, wait until the next space. Close here
						{
							tempend = i;
							tweet = modtweet.replace(i,i,("</a>")).toString(); //i.e. <<a href="hashkey=">#NYC</a>
							hashtag = tweet.substring(tempstart, tempend);


/*I got stuck here.
* I insert hashtag into the key slot, whereas I should be inserting the hash_id
* Below is my conversion, or my attempt at one
* Every time I uncomment it, tweet list gets screwed up--I dont understand why
**/
 //Inputs the hashtag
	 
	 out.println (hashkey);
	 
 							// java.sql.ResultSet rsHashFind = stmt.executeQuery(hashkey);
//    							while(rsHashFind.next())
//   							{
//   								 hashid = rsHashFind.getString(1);
//  							}

 							tweet = modtweet.replace(i-hashtag.length()-3,i-hashtag.length()-3,(hashtag)).toString(); //i.e. <<a href="hashkey=12">#NYC</a>
							inHashTag = false;

							i+=4;

						}
			
					}	
%>



                        <!-- start tweet -->
                        <div class="js-stream-item stream-item expanding-string-item">
                            <div class="tweet original-tweet">
                                <div class="content">
                                    <div class="stream-item-header">
                                        <small class="time">
                                            <a href="#" class="tweet-timestamp" title="10:15am - 16 Nov 12">
                                                <span class="_timestamp">6m</span>
                                            </a>
                                        </small>
                                        <a class="account-group">
                                            <img class="avatar" src="images/obama.png" alt="Barak Obama">
                                            <strong class="fullname"><%=username%></strong>
                                            <span>&rlm;</span>
                                            <span class="username">
                                                <s>@</s>
                                                <b><%=username%></b>
                                            </span>
                                        </a>
                                    </div>
                                    <p class="js-tweet-text">                                     
                                    <%=modtweet%>
                               <!--       <a href="http://t.co/xOqdhPgH" class="twitter-timeline-link" target="_blank" title="http://OFA.BO/xRSG9n" dir="ltr">
                                            <span class="invisible">http://</span>
                                            <span class="js-display-url">OFA.BO/xRSG9n</span>
                                            <span class="invisible"></span>
                                            <span class="tco-ellipsis">
                                                <span class="invisible">&nbsp;</span>
                                            </span>
                                        </a> -->
                                    </p>
                                </div>
                            </a>
                                <div class="expanded-content js-tweet-details-dropdown"></div>
                            </div>
                        </div><!-- end tweet -->
<%
}
%>
                      
                    </div>
                    <div class="stream-footer"></div>
                    <div class="hidden-replies-container"></div>
                    <div class="stream-autoplay-marker"></div>
                </div>
                </div>
               
            </div>
        </div>
    </div>
     <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
     <script type="text/javascript" src="js/main-ck.js"></script>
  </body>
</html>
