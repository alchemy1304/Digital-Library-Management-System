<?php
session_start();

	if(is_null($_SESSION['mail']))
	{
		echo "<script>alert('Please Sign In first');</script>";
		header('refresh:0 URL=signin.php');
	}

?>
<html>
<title>Welcome!</title>
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

$connect=mysqli_connect($host,$username,$password,$db_name);
?>


<div class=welcome style="text-align:center;
					padding:5px;
					margin:auto;
					position:relative;
					top:11vh;
					box-shadow:0px 0px 5px black;
					border-radius:6px;
					text-shadow:0px 0px 4px black;
					width:40vw;
					background-color:rgba(0,0,0,.7);">
<h3>Hello <?php echo $_SESSION['finame']; ?> !</h3><br>Here are the books You added to your wishlist
</div>


<?php

$mail = $_SESSION['mail'];

	$table = mysqli_query($connect,"SELECT * FROM $mail");

	$numOfRows = mysqli_num_rows($table);
	$numOfFields = mysqli_num_fields($table);
	$colName = mysqli_query($connect,"SHOW COLUMNS FROM $mail");


//--------------------------------------------------------------------------------  PRINTING USER SPECIFIC TABLE
echo "<center><div class=table><table>";
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
echo "</table></div></center>";
echo "<br><br><br><br><br><br><br>";

//--------------------------------------------------------------PRINTING BOOKINFO TABLE FOR USER'S CONVENIENCE

$table = mysqli_query($connect,"SELECT * FROM bookinfo");
$numOfRows = mysqli_num_rows($table);
$numOfFields = mysqli_num_fields($table);
$colName = mysqli_query($connect,"SHOW COLUMNS FROM bookinfo");


echo "<div style='text-align:center;
					margin:auto;
					position:relative;
					top:7vh;
					box-shadow:0px 0px 5px black;
					border-radius:6px;
					text-shadow:0px 0px 4px black;
					width:30vw;
					background-color:rgba(0,0,0,.7);'>
					<br>
			These are the Books in our library<br>You can put them in your wishlist
					<br><br></div>";

//-------------------------------------------------------------PRINTING TABLE

echo "<center><div class=table><table>";
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
echo "</table></div></center>";
echo "<br><br><br><br><br><br><br>";


//--------------------------------------------------------------------------ADDING BOOK TO WISHLIST

if(isset($_POST['srl']))
	{$ser = $_POST['srl'];}
if (isset($_POST['submitSerial']))
{
	$book=mysqli_query($connect,"SELECT * FROM bookinfo WHERE serial='$ser'");
	$book=mysqli_fetch_array($book);
	if(is_null($book[0]))
	{
		echo "<script> alert('Book unavailable in Library'); </script>";
	}
	else
	{
		if(mysqli_query($connect,"INSERT INTO $mail VALUES('$book[0]','$book[1]','$book[2]')"))
		{
			echo "<script> alert('Added to Wishlist'); </script>";
			header('refresh:0');
		}
		else echo "<script> alert('Already present in the Wishlist'); </script>";
	}		
}
elseif(isset($_POST['removeSerial']))
{
	$rmvSrl=$_POST['rmv'];
	$remove=mysqli_query($connect,"DELETE FROM $mail WHERE serial='$rmvSrl'");
	if($remove)
	{
		echo "<script> alert('Book is removed from your Wishlist'); </script>";
		header('refresh:0');
	}
	else echo "<script> alert('Book is not present in your Wishlist'); </script>";
}

?>


<div class=frm style="position:fixed; top:25vh; left:10px; padding:20px; width:300px; " >
<form method=post action="userProf.php">
<center>
You can add books to your Wishlist<br><br>
<input style="width:205px;" type=text name=srl placeholder="Fill in Serial Number"><br><br>
<input class=button type=submit name=submitSerial value="Add to Wishlist"><br><br>
Or you can remove them<br><br>
<input style="width:250px;" type=text name=rmv placeholder="Serial Number to remove"><br><br>
<input class=button type=submit name=removeSerial value="Remove from Wishlist">
</center>
</form>
</div>
</body>
</html>
