<?php  

require 'Conexion.php';

$con= new Conexion();
$response['conexion']= $con->initConexion('ejercicios_procedimientos');

if (isset($_POST["guardar"])) {
	if ($response['conexion']=='OK') {
		$descripcion= $_POST['Descripcion'];
		$costo= $_POST['Costo'];
		$zona= $_POST['Zona'];

		if ($con->guardarCasa($descripcion, $costo, $zona)) {
			$response['msj']= "Datos guardados satisfactoriamente!";
		}else{
			$response['msj']= "Datos no fueron guardados";
		}
		$con->closeConexion();
	}else{
		$response['conexion']= "No se pudo conectar a la base de datos";
	}
}elseif (isset($_POST["buscar"])) {
	if ($response['conexion']=='OK') {
		$codigo= $_POST['Cod'];
		$busqueda= $con->existencia('casa','codigo',$codigo);

		if (mysqli_num_rows($busqueda)==true) {
			$response['msj']= "Se encontro un registro!";
			$i=0;
			/*
			while($fila=$busqueda->fetch_assoc()){
				echo "<b>Codigo: </b>".$fila['codigo']."</br>",
					 "<b>Descripción: </b>".$fila['descripcion']."</br>",
					 "<b>Costo: </b>".$fila['costo']."</br>",
					 "<b>Zona: </b>".$fila['zona']."</br>",
					 "<b>Impuesto Anual: </b>".$fila['impuesto_anual']."</br>",
					 "<b>Valor Venta: </b>".$fila['valor_venta']."</br>";
			}*/
			while($fila= $busqueda->fetch_assoc()){
				$response['datosBD'][$i]['Cod']= $fila['codigo'];
				$response['datosBD'][$i]['Descripcion']= $fila['descripcion'];
				$response['datosBD'][$i]['Costo']= $fila['costo'];
				$response['datosBD'][$i]['Zona']= $fila['zona'];
				$response['datosBD'][$i]['Impuesto']= $fila['impuesto_anual'];
				$response['datosBD'][$i]['Valor']= $fila['valor_venta'];
				$i++;
			};
		}else{
			$response['msj']= "No se encuentró dicho registro!";
		}
		$con->closeConexion();
	}else{
		$response['conexion']= "No se pudo conectar a la base de datos";
	}
}elseif (isset($_POST["editar"])) {
	$codigo= $_POST['Cod'];
	$descripcion= $_POST['Descripcion'];
	$costo= $_POST['Costo'];
	$zona= $_POST['Zona'];

	if ($con->actualizarCasa($codigo, $descripcion, $costo, $zona)) {
		$response['msj']= "Datos actualizados con exito!";
	}else{
		$response['msj']="No se pudo actualizar el registo!";
	}
}elseif (isset($_POST['eliminar'])) {
	$codigo=$_POST['Cod'];
	if ($con->borrarDatos('borrarCasa', $codigo)) {
		$response['msj']="Datos eliminados con exito!";
	}else{
		$response['msj']="No se pudo eliminar el registo!";
	}
	$con->closeConexion();
}

echo json_encode($response);

?>
