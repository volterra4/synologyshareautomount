<?php
// Original author: Twisted world
// Original source: https://forum.synology.com/enu/viewtopic.php?f=36&t=142308

// Build an array of trusted IP addresses...
$trusted=array("IP1","IP2","IP3");
// check if request is made from valid ip address
if (in_array($_SERVER['REMOTE_ADDR'],$trusted)) { 
 // THIS IS EXECUTED IF THE IP ADDRESS IS TRUSTED
 // PUT PASSWORDS FOR SHARES IN THE ARRAY BELOW
 $password = array(
"share1" => "wMDiRrZVkXCN19M0HvizFsdGV1uMm0EgOh+jkTHU2Hw=",
"share2" => "wMDiRrZVkXCN19M0HvizFsdGV1uMm0EgOh+jkTHU2Hw=",
"share3" => "wMDiRrZVkXCN19M0HvizFsdGV1uMm0EgOh+jkTHU2Hw=",
 );
 $share=$_SERVER['QUERY_STRING']; // get the share name from the request
 echo $password[$share]; // echo the password, this will be grabbed by wget 
} else {
 // THIS IS EXECUTED IF THE IP ADDRESS IS INCORRECT
 // You can output dummy info so you can check if the script is working.
 // Better (safer) would be to just output entirely nothing at all here.
 echo "swordfish";
}
?>