<?php
session_start();
error_reporting(0);
?>


<html>
<title>About Developers</title>
<head>
<link rel="stylesheet" type="text/css" href="http://localhost/DSW PROJ/CSSstylesheet.css">
</head>
<body>
<?php 

	$host="localhost";
	$username="root";
	$password="";
	$db_name="mydb";

	

if(isset($_POST['submit1']))
{

	$connect=mysqli_connect($host,$username,$password,$db_name);
	if(!$connect)
	{
		echo "<script>alert('Connection not established');</script>";
	}
	
	$qry=mysqli_query($connect,"SELECT password FROM adminPassword");
	$pass=mysqli_fetch_array($qry);
	if(!$qry) echo "<script>alert('Can't connect to password');</script>";
	
	
	if($pass[0] != $_POST['pass'])
	{
		echo "<script>alert('Incorrect Admin Password');</script>";
	}
	else {header('refresh:0 URL=adminPage.php');}
	
}

?>
<center>
<br><br><br><br><br><br>
<div class=about>
<br><br><br>
Developed with Goodwill by
<br><br>
Anant<br>Naman<br>Rishabh<br>Saksham<br><br>
</div>
<br>
<a href="Page1.php"><input type=button class=button value=Home></a>
<center>
<br>
<div class=developers>
<br>
<span>&emsp;One of the Developers?&emsp;</span>
<br>
<br><center>
	<div class=developers-content style="align: center;">
	<form method=post action="about.php">
	<input type=password name=pass style="width:200px; align: center; padding-left: 10px;" placeholder=" Admin Password">&emsp;&emsp;
	<input class=button type=submit name=submit1 value=Next>
	</form>
	<br>
	</div></center>
</div>
</center>
<br>
	
</center>
</body>
</html>