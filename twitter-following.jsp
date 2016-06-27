<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.mysql.jdbc.*" %>

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
                            <li><a href="#"><strong>739</strong>Tweets</a></li>
                            <li><a href="#"><strong>115</strong>Following</a></li>
                            <li><a href="#"><strong>97</strong>Followers</a></li>
                        </ul>
                    </div>
                    <form>
                        <textarea class="tweet-box" placeholder="Compose new Tweet..." id="tweet-box-mini-home-profile"></textarea>
                    </form>
                </div>

                <div class="module other-side-content">
                    <div class="content"
                        <p>Some other content here</p>
                    </div>
                </div>
            </div>

            <!-- right column -->
            <div class="span8 content-main">
                <div class="module">
                    <div class="content">
                        <div class="profile-header-inner" data-background-image="url('images/grey-header-web.png')">
                            <a href="#" class="profile-picture media-thumbnail">
                                <img src="images/profileThumb.jpeg" alt="Barack Obama" class="avatar size73">
                            </a>
                            <div class="profile-card-inner">
                                <h1 class="fullname">Barack Obama</h1>
                                <h2 class="username">@barakobama</h2>
                                <div class="bio-container">
                                    <p class="bio profile-field">This account is run by Organizing for Action staff. Tweets from the President are signed -bo.
Washington, DC · http://www.barackobama.com</p>
                                </div>
                            </div>
                        </div>
                        <div class="flex-module profile-banner-footer clearfix">
                            <div class="default-footer">
                                <ul class="stats js-mini-profile-stats" style="float:left">
                                    <li>
                                        <a class="js-nav" href="#">
                                            <strong>8,716</strong>
                                            Tweets
                                        </a>
                                    </li>
                                    <li>
                                        <a class="js-nav" href="#">
                                            <strong>665,052</strong>
                                            Following
                                        </a>
                                    </li>
                                    <li>
                                        <a class="js-nav" href="#">
                                            <strong>27,899,207</strong>
                                            Followers
                                        </a>
                                    </li>
                                </ul>
                                <a href="#dm" class="btn dm-button pull-right" type="button" title"Direct Messages" data-toggle="modal">
                                    <i class="icon-envelope"></i>
                                </a>
                                <div id="dm" class="modal hide fade">
                                    <div class="modal-header twttr-dialog-header">
                                        <div class="twttr-dialog-close" data-dismiss="modal" aria-hidden="true">&nbsp;</div>
                                        <h3>Direct Messages</h3>
                                    </div>
                                    <div class="modal-body">
                                        <!-- direct messages start -->
<%
		String user_id = request.getParameter("key");
		String tweet_user_id = "";
		String username = "";

			int status = 0;
	int counter = 0;

	java.sql.Connection conn = null;
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        String url = "jdbc:mysql://127.0.0.1/rchen";   //location and name of database
        String userid = "";
        String password = "";
        conn = DriverManager.getConnection(url, userid, password);      //connect to database
	
				java.sql.Statement stmt = conn.createStatement();

			String querytd = ("Select f2 from friends_t where f1=" + user_id);

		java.sql.ResultSet rstweettd = stmt.executeQuery(querytd);

		while(rstweettd.next())
        {
        	 username = rstweettd.getString(1);
        	 
        	 String getuserID = "select user_id from user_t where username='" + username + "'";
				java.sql.ResultSet rsgetuserID = stmt.executeQuery(getuserID);
    
  				  while (rsgetuserID.next())
  					  {
  					  tweet_user_id = rsgetuserID.getString(1);

							out.println(tweet_user_id);
    				    }
        
        }

%>
                                    
                                    
                                    
                                    
                                        <!-- direct messages end -->
                                    </div>
                                    <div class="twttr-dialog-footer">
                                        Tip: you can send a message to anyone who follows you. <a href="#" target="_blank" class="learn-more">Learn more</a>
                                  </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="module">
                    <div class="content-header">
                        <div class="header-inner">
                            <h2 class="js-timeline-title">PEOPLE FOLLOWING ME:</h2>
                        </div>
                    </div>

                    <!-- new tweets alert -->
                    <div class="stream-item hidden">
                        <div class="new-tweets-bar js-new-tweets-bar well">
                            2 new Tweets
                        </div>
                    </div>

                    <!-- all tweets -->
                    <div class="stream following-stream">

                      
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
