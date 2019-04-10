<?php
session_start();
error_reporting(0);
?>
<html>
<title>Forgot Password</title>
<head>
<link rel="stylesheet" type="text/css" href="http://localhost/DSW PROJ/CSSstylesheet.css">
</head>

<body>
		<div class=navbar>
		<a href="http://localhost/DSW PROJ/Page1.php"><img src="http://localhost/DSW PROJ/home3.png" style="position:relative; left:7px; top:7px; align:center; width:40px; height:40px;"></a>
		<form action="bookinfo.php" method=post style="position:fixed; top:0px; right:5px;" >
		<?php if(is_null($_SESSION['mail'])) echo "<input style='padding:10px; float:right; height:45px;' type=submit class=button name=signIn value='Sign In'>"; ?>        
		<?php if(!is_null($_SESSION['mail'])) echo "<input style='float:right; padding:10px; height:45px;' type=submit class=button name=signOut value='Sign Out'>"; ?>         
		</form>
		</div>
		<?php

		if(isset($_POST['signOut']))
		{
			session_unset();
			header('refresh:0 URL=Page1.php');
		}
		elseif (isset($_POST['signIn']))
		{
			header('refresh:0 URL=signin.php');
		}
		?>



<?php

$tbl_name="userinfo";

$connect=mysqli_connect('localhost','root','','mydb');
if(isset($_POST['submit']))
{
	$usermail=$_POST['mail'];
	$userpassword=$_POST['password'];
	$userpno=$_POST['phone'];
	$sql="select * from $tbl_name where mail='$usermail' and phone='$userpno'";
	$result=mysqli_query($connect,$sql);
	$count=mysqli_num_rows($result);
	if($count==1)
	{
		$sql1="update $tbl_name set password='$userpassword' where mail='$usermail'";
		$res=mysqli_query($connect,$sql1);
		echo "<script type='text/javascript'>alert('Password Successfully Changed');</script>";
		header('refresh:0 URL=page1.php');
	}
	else
	{
		echo "<script type='text/javascript'>alert('Incorrect Email and Phone Number Combination');	</script>";
		header('refresh:0 URL=resetPassword.php');
	}
}
?>
<div class=frm>
<form action="resetPassword.php" method="post">
<center>
<br><br>


<input type=text name="mail" placeholder="Enter your Email" required></input><br><br>
<input type=text name="phone" placeholder="Enter Phone Number" required></input><br><br>
<input type="password" name="password" placeholder="New Password" required></input><br><br>
<input type="Reset" value="Reset" name="reset" class=button></input>&emsp;&emsp;<input type="Submit" name="submit" value="Submit" class=button></input>
</center>
</form>
</div>

</body>
</html>