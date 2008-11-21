<html>
<body>
<?php
#	$Id: ost_calc.php,v 1.2 2002/04/23 02:28:24 iva Exp iva $	

	echo "<h2>Инвентаризационная ведомость</h2>"; 
	echo " [<a href = 'index.php'> Домой</a>]";
	echo "<hr>";

include("inc/open_database.inc");

#            ******* CREATE ******
$result_count_charge   = pg_Exec($database,
		"SELECT * FROM group_charge ");
$result_count_order   = pg_Exec($database,
		"SELECT * FROM group_order ");

#          ******** UPDATE ********
$result_umat   = pg_Exec($database,
		" update mat set mat_ost = mat_num");
$result_umat_pass1   = pg_Exec($database,
		"update mat 
    			set mat_ost = mat_num - group_charge.osum
    			from group_charge
    			where (group_charge.mat_id = mat.mat_id) ");
$result_umat_pass2   = pg_Exec($database,
		"update mat 
    			 set mat_ost = mat_ost -  group_order.count
    		 	from group_order
    			where (group_order.id = mat.mat_id) ");

#           ******** SELECT *******
$result_ost013   = pg_Exec($database,
		"select count(mat_ost), sum(mat_ost*mat_price) 
    			from mat, invoid
    			where mat.invoid_id = invoid.invoid_id
          		and invoid.invoid_count = '013' 
			and mat_ost > 0");
$result_ost071   = pg_Exec($database,
		"select count(mat_ost), sum(mat_ost*mat_price) 
    			from mat, invoid
    			where mat.invoid_id = invoid.invoid_id
          		and invoid.invoid_count = '071'
			and mat_ost > 0 ");
$result_ost060   = pg_Exec($database,
		"select count(mat_ost), sum(mat_ost*mat_price) 
    			from mat, invoid
    			where mat.invoid_id = invoid.invoid_id
          		and invoid.invoid_count = '060'
			and mat_ost > 0 ");
$result_ost063_2   = pg_Exec($database,
		"select count(mat_ost), sum(mat_ost*mat_price) 
    			from mat, invoid
    			where mat.invoid_id = invoid.invoid_id
          		and invoid.invoid_count = '063-2'
			and mat_ost > 0 ");

echo "<h2> Счет 060</h2>";
$result =  pg_Exec($database,"SELECT mat_id, mat_type, mat_name, mat_price, mat_ost, invoid_count 
				FROM mat_ost, invoid
				WHERE (mat_ost.invoid_id = invoid.invoid_id)
				and  (invoid.invoid_count = '060')
				ORDER BY invoid_count, mat_type, mat_price");

echo "<table border=0>";

$shapka_num = 6;
$shapka = array ("ID","Тип","Марка","Цена","Кол","Счет");
include("inc/shapka.inc");

for($i=0; $i < pg_NUMRows($result); $i++)
{
	echo "<tr>";
	for($j=0; $j < 6; $j++){
		#write line
		echo "<td bgcolor = '#EEEEEE'>";
		echo pg_Result($result,$i,$j);
		echo "</td>";
	}

}
echo "</table>";
$co  = pg_Result($result_ost060,0,0);
$so  = pg_Result($result_ost060,0,1);
echo "<table border=0>";
echo "<tr>";
echo "<td bgcolor = '#c0c0c0'>Количесво </td><td bgcolor = '#c0c0c0'> Сумма </td>";
echo "</tr>";
echo "<tr>";
echo "<td bgcolor = '#aaaaaa'  <font color = '#ffffff'>$co </font></td><td bgcolor = '#aaaaaa' <font color = '#ffffff' > $so  </font></td>";
echo "</tr>";
echo "</table>";
echo "<h2> Счет 063-2</h2>";
$result =  pg_Exec($database,"SELECT mat_id, mat_type, mat_name, mat_price, mat_ost, invoid_count 
				FROM mat_ost, invoid
				WHERE (mat_ost.invoid_id = invoid.invoid_id)
				and  (invoid.invoid_count = '063-2')
				ORDER BY invoid_count, mat_type, mat_price");

echo "<table border=0>";

$shapka_num = 6;
$shapka = array ("ID","Тип","Марка","Цена","Кол","Счет");
include("inc/shapka.inc");

for($i=0; $i < pg_NUMRows($result); $i++)
{
	echo "<tr>";
	for($j=0; $j < 6; $j++){
		#write line
		echo "<td bgcolor = '#EEEEEE'>";
		echo pg_Result($result,$i,$j);
		echo "</td>";
	}

}
echo "</table>";
$co  = pg_Result($result_ost063_2,0,0);
$so  = pg_Result($result_ost063_2,0,1);
echo "<table border=0>";
echo "<tr>";
echo "<td bgcolor = '#c0c0c0'>Количесво </td><td bgcolor = '#c0c0c0'> Сумма </td>";
echo "</tr>";
echo "<tr>";
echo "<td bgcolor = '#aaaaaa'  <font color = '#ffffff'>$co </font></td><td bgcolor = '#aaaaaa' <font color = '#ffffff' > $so  </font></td>";
echo "</tr>";
echo "</table>";

echo "<h2> Счет 071</h2>";
$result =  pg_Exec($database,"SELECT mat_id, mat_type, mat_name, mat_price, mat_ost, invoid_count 
				FROM mat_ost, invoid
				WHERE (mat_ost.invoid_id = invoid.invoid_id)
				and  (invoid.invoid_count = '071')
				ORDER BY invoid_count, mat_type, mat_price");

#echo "";
echo "<table border=0>";
$shapka_num = 6;
$shapka = array ("ID","Тип","Марка","Цена","Кол","Счет");
include("inc/shapka.inc");

for($i=0; $i < pg_NUMRows($result); $i++)
{
	echo "<tr>";
	for($j=0; $j < 6; $j++){
		#write line
		echo "<td>";
		echo pg_Result($result,$i,$j);
		echo "</td>";
	}

}
echo "</table>";
#ITOG 071
$co  = pg_Result($result_ost071,0,0);
$so  = pg_Result($result_ost071,0,1);
echo "<table border=0>";
echo "<tr>";
echo "<td bgcolor = '#c0c0c0'>Количесво </td><td bgcolor = '#c0c0c0'> Сумма </td>";
echo "</tr>";
echo "<tr>";
echo "<td bgcolor = '#aaaaaa'  <font color = '#ffffff'>$co </font></td><td bgcolor = '#aaaaaa' <font color = '#ffffff' > $so  </font></td>";
echo "</tr>";
echo "</table>";

echo "<h2> Счет 013</h2>";
$result =  pg_Exec($database,"SELECT mat_id, mat_type, mat_name, mat_price, mat_ost, invoid_count 
				FROM mat_ost, invoid
				WHERE (mat_ost.invoid_id = invoid.invoid_id)
				and  (invoid.invoid_count = '013')
				ORDER BY invoid_count, mat_type, mat_price");

#echo "";
echo "<table border=0>";
$shapka_num = 6;
$shapka = array ("ID","Тип","Марка","Цена","Кол","Счет");
include("inc/shapka.inc");

for($i=0; $i < pg_NUMRows($result); $i++)
{
	echo "<tr>";
	for($j=0; $j < 6; $j++){
		#write line
		echo "<td>";
		echo pg_Result($result,$i,$j);
		echo "</td>";
	}

}
echo "</table>";
#ITOG 013
$co  = pg_Result($result_ost013,0,0);
$so  = pg_Result($result_ost013,0,1);
echo "<table border=0>";
echo "<tr>";
echo "<td bgcolor = '#c0c0c0'>Количесво </td><td bgcolor = '#c0c0c0'> Сумма </td>";
echo "</tr>";
echo "<tr>";
echo "<td bgcolor = '#aaaaaa'  <font color = '#ffffff'>$co </font></td><td bgcolor = '#aaaaaa' <font color = '#ffffff' > $so  </font></td>";
echo "</tr>";
echo "</table>";

	echo "<hr>";
	echo "<a href = 'index.php'>Домой</a>";
?>
</body>
</html>
