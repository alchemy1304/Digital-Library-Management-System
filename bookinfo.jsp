<?php session_start(); error_reporting(0); ?>
<html>
<title>Book Info</title>
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

	$host="localhost";
	$username="root";
	$password="";
	$db_name="mydb";
	
$connect= mysqli_connect($host,$username,$password,$db_name);
if(!$connect)
{
	echo "<script type='text/javascript'>alert(' Can't connect to the Database ');	</script>";
}

$table = mysqli_query($connect,"SELECT * FROM bookinfo");
$numOfRows = mysqli_num_rows($table);
$numOfFields = mysqli_num_fields($table);
$colName = mysqli_query($connect,"SHOW COLUMNS FROM bookinfo");


echo "<div style='text-align:center;
					margin:auto;
					position:relative;
					top:11vh;
					box-shadow:0px 0px 5px black;
					border-radius:6px;
					text-shadow:0px 0px 4px black;
					width:50vw;
					background-color:rgba(0,0,0,.7);'>
					<br>
		We have the following Books in our library
					<br><br></div>";

//--------------------------------------------------------------------------------  PRINTING TABLE
echo "<center><form action='bookinfo.php' method=post><div class=table><table>";
	echo "<tr>";

while($colNameArr = mysqli_fetch_array($colName))
{
	echo "<th>".strtoupper($colNameArr[0])."</th>";
}
	echo "</tr>";
while($tableRow = mysqli_fetch_array($table))
{
	echo "<tr>";
	
	for($i=0;$i<$numOfFields;$i++)
	{
		echo "<td>".$tableRow[$i]."</td>";
	}

	echo "</tr>";
}
echo "</table></div></form></center>";
echo "<br><br><br><br><br><br><br>";

?>

</body>
</html>