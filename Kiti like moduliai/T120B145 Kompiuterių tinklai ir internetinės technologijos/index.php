<!DOCTYPE html>
<html>
<head>
<title>Lab2</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
	#zinutes {
 	   font-family: Arial; border-collapse: collapse; width: 70%;
	}
	#zinutes td {
 	   border: 1px solid #ddd; padding: 8px;
	}
        #zinutes th{
           border: 1px solid #ddd; padding: 8px; background-color: yellow;
         }
	#zinutes tr:nth-child(even){background-color: #F5F5F5}
	#zinutes tr:hover {background-color: #ddd;}
</style>



<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js">
 </script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js">
</script>
</head>
<body>
<center><h3>Žinučių sistema</h3></center>
<table style="margin: 1px auto;" id="zinutes">
<tr>
<th>
Darba atliko: Lukas Kuzmickas
</th>
</tr>
</table>

<table style="margin: 1px auto;" id="zinutes">
<tr>
<th>Nr</th>
<th>Kas siuntė</th>
<th>Siuntėjo e. paštas</th>
<th>Gavėjas</th>
<th>Data</th>
<th>Žinutė</th>
</tr>



<?php
$server = "localhost";
$db = "lukaskuzmickas";
$user = "stud";
$password = "stud";
$lentele = "lukaskuzmickas";
$conn = new mysqli($server, $user, $password, $db);
	if($conn->connect_error) die("Negaliu prisijungti: " . $conn->connect_error);
mysqli_set_charset($conn,"utf8");// dėl lietuviškų raidžių
$sql = "SELECT * FROM $lentele";
if (!$result = $conn->query($sql)) die("Negaliu nuskaityti: " . $conn->error);
	while($row = $result->fetch_assoc())
		{
if($row['svarbi'] == 1)
{
echo "
<tr>
<td>".$row['id']."</td>
<td>".$row['vardas']."</td>
<td>".$row['epastas']."</td>
<td>".$row['kam']."</td>
 <td>".$row['data']."</td>
<td> <b> ".$row['zinute']." </b </td>
</tr>";
}
else
{
echo "
<td>".$row['id']."</td>
<td>".$row['vardas']."</td>
<td>".$row['epastas']."</td>
<td>".$row['kam']."</td>
 <td>".$row['data']."</td>
<td> ".$row['zinute']." </td>
</tr>";
}
		} 
echo "</table>";

?>








<div class="container">
  <form method='post'>
     <div class="form-group col-lg-4">
          <label for="vardas" class="control-label">Siuntėjo vardas:</label>
          <input name='vardas' type='text' class="form-control input-sm">
      </div>
      <div class="form-group col-lg-4">
          <label for="epastas" class="control-label">Siuntėjo e-paštas:</label>
          <input name='epastas' id="epastas" type='email' class="form-control input-sm">
      </div>
      <div class="form-group col-lg-4">
          <label for="kam" class="control-label">Kam skirta:</label>
          <input name='kam' type='text' class="form-control input-sm">
      </div>
      <div class="form-group col-lg-12">
          <label for="zinute" class="control-label">Žinutė:</label>
          <textarea name='zinute' class="form-control input-sm"></textarea>
      </div>
      <div class="form-group col-lg-12">
          <label for="svarbi" class="control-label">Svarbi žinutė</label>
          <input type="checkbox" name="svarbi" value="svarbi žinutė">
      </div>
<div class="form-group col-lg-2">
         <input type='submit' name='ok' value='siųsti' class="btnbtn-default">
</div>



	  
  </form>
<button>
  <a href="automobilis.htm">
    <b>Toliau</b>
  </a>
</button>

<a href="bootstrap_automobilis.htm"><b>Toliau į bootstrap_automobilis.htm<b></a>
</div>





<?php
$server = "localhost";
$db = "lukaskuzmickas";
$user = "stud";
$password = "stud";
$lentele = "lukaskuzmickas";
$conn = new mysqli($server, $user, $password, $db);
	if($conn->connect_error) die("Negaliu prisijungti: " . $conn->connect_error);
mysqli_set_charset($conn,"utf8");// dėl lietuviškų raidžių
//if (isset($_POST["ok"]))
if($_POST !=null){
// įrašyti reikšmes iš formos
	$vardas = $_POST['vardas'];
	$epastas =$_POST['epastas'];
        $kam = $_POST['kam'];
        $zinute = $_POST['zinute'];
        $svarbi = $_POST['svarbi'];
        $data = date("Y-m-d H:i:s");
if(filter_has_var(INPUT_POST,'svarbi')) {
     $sql = "INSERT INTO $lentele (vardas, epastas, kam, data, zinute, svarbi ) VALUES ('$vardas', '$epastas', '$kam', '$data',  '$zinute',1)";
}
else
{
$sql = "INSERT INTO $lentele (vardas, epastas, kam, data, zinute, svarbi ) VALUES ('$vardas', '$epastas', '$kam', '$data',  '$zinute',0)";
}

	if (!$result = $conn->query($sql)) die("Negaliu įrašyti: " . $conn->error);
    echo "Įrašyta";	
    header('Location: index.php');
    exit();
}
?>











