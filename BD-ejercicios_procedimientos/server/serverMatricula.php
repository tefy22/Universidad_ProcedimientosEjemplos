<?php  

require("Conexion.php");

$con= new Conexion();
$response['conexion']= $con->initConexion('ejercicios_procedimientos');
if (isset($_POST['guardar'])) {
	if ($response['conexion']=='OK') {
		$cedula=$_POST['Cedula'];
		$costo=$_POST['Costo'];
		$plan=$_POST['Plan'];
		if ($con->guardarMatricula($cedula, $costo, $plan)) {
			$response['msj']= "Se guardo el registro exitosamente!";
		}else{
			$response['msj']="No se pudo guardar el registro, puede ser que se encuentre ya registrado!";
		}
	}else{
		$response['conexion']="No se pudo conectar a la base de datos";
	}
	$con->closeConexion();	
}elseif (isset($_POST['buscar'])) {
	if ($response['conexion']=='OK') {
		$cedula= $_POST['Ced'];
		$busqueda= $con->existencia('matricula', 'codigo', $cedula);
		if (mysqli_num_rows($busqueda)==true) {
			$response['msj']= "Se encontro un registro!";
			$i=0;
			while ($fila= $busqueda->fetch_assoc()) {
				$response['datosDB'][$i]['Cod']=$fila['codigo'];
				$response['datosDB'][$i]['Valor']=$fila['valor'];
				$response['datosDB'][$i]['Plan']=$fila['plan'];
				$response['datosDB'][$i]['Total']=$fila['valor_real'];
				$i++;
			};
		}else{
			$response['msj']="No se Encontro ningun registro";
		}
	}else{
		$response['conexion']="No se pudo conectar a la base de datos";
	}
	$con->closeConexion();
}elseif (isset($_POST['editar'])) {
	if ($response['conexion']=='OK') {
		$cedula= $_POST['Ced'];
		$costo= $_POST['Costo'];
		$plan= $_POST['Plan'];
		if($con->actualizarMatricula($cedula, $costo, $plan)){
			$response['msj']="Datos actualizados con exito!";
		}else{
			$response['msj']="no se pudo actualizar el registro";
		}	
	}else{
		$response['conexion']="No se pudo conectar a la base de datos";
	}
	$con->closeConexion();	
}elseif (isset($_POST['eliminar'])) {
	if ($response['conexion']=='OK') {
		$ced= $_POST['Cod'];
		if ($con->borrarDatos('borrarMatricula',$ced)) {
			$response['msj']="Datos eliminados con exito!";
		}else{
			$response['msj']="No se pudo eliminar el registro";
		}
	}else{
		$response['conexion']="No se pudo conectar a la base de datos";
	}
	$con->closeConexion();
}
echo json_encode($response);
?>