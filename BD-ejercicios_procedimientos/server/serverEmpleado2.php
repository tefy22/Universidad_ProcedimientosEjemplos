<?php  

require 'Conexion.php';

$con= new Conexion();
$response['conexion']= $con->initConexion('ejercicios_procedimientos');

if (isset($_POST['guardar'])) {
	if ($response['conexion']=='OK') {
		$ced= $_POST['Cedula'];
		$nom= $_POST['Nombre'];
		$salario= $_POST['Salario'];
		if ($con->guardarEmpleado2($ced, $nom, $salario)) {
			$response['msj']= "Datos guardados exitosamente!";
		}else{
			$response['msj']= "No se pudo guardar el registro, puede ser que se encuentre ya registrado!";
		}
		$con->closeConexion();
	}else{
		$response['conexion']= "No se pudo conectar a la base de datos";
	}
}elseif (isset($_POST['buscar'])) {
	if ($response['conexion']=='OK') {
		$ced= $_POST['Cedula'];
		$busqueda= $con->existencia('empleado2','cedula', $ced);
		if (mysqli_num_rows($busqueda)) {
			$response['msj']= "Se Encontro un registro";
			$i=0;
			while ($fila= $busqueda->fetch_assoc()) {
				$response['datosBD'][$i]['Cedula']= $fila['cedula'];
				$response['datosBD'][$i]['Nombre']= $fila['nombre'];
				$response['datosBD'][$i]['Salario']= $fila['salario_basico'];
				$response['datosBD'][$i]['Transporte']= $fila['subsidio_transporte'];
				$response['datosBD'][$i]['Salud']= $fila['salud'];
				$response['datosBD'][$i]['Pension']= $fila['pension'];
				$response['datosBD'][$i]['Bono']= $fila['bono'];
				$response['datosBD'][$i]['SalarioI']= $fila['salario_integral'];
				$i++;
			}
		}else{
			$response['msj']="No se Encontro ningun registro";
		}
		$con->closeConexion();
	}else{
		$response['conexion']= "No se pudo conectar a la base de datos";
	}
}elseif (isset($_POST['editar'])) {
	if ($response['conexion']=='OK') {
		$ced= $_POST['Cedula'];
		$nom= $_POST['Nombre'];
		$salario= $_POST['Salario'];
		if ($con->actualizarEmpleado2($ced, $nom, $salario)) {
			$response['msj']="Datos actualizados con exito!";
		}else{
			$response['msj']="no se pudo actualizar el registro";
		}
		$con->closeConexion();
	}else{
		$response['conexion']= "No se pudo conectar a la base de datos";
	}
}elseif (isset($_POST['eliminar'])) {
	if ($response['conexion']=='OK') {
		$ced= $_POST['Cedula'];
		if ($con->borrarDatos('borrarEmpleado2', $ced)) {
			$response['msj']="Datos eliminados con exito!";
		}else{
			$response['msj']="No se pudo eliminar el registro";
		}
		$con->closeConexion();
	}else{
		$response['conexion']= "No se pudo conectar a la base de datos";
	}
}

echo json_encode($response);

?>