<?php  

require 'Conexion.php';

$con= new Conexion();
$response['conexion']= $con->initConexion('ejercicios_procedimientos');

if (isset($_POST['guardar'])) {
	if ($response['conexion']=='OK') {
		$ced= $_POST['Cedula'];
		$nom= $_POST['Nombre'];
		$horas= $_POST['Horas'];
		$valor= $_POST['Valor'];
		if ($con->guardarEmpleado($ced, $nom, $horas, $valor)) {
			$response['msj']= "Se guardo el registro exitosamente!";
		}else{
			$response['msj']="No se pudo guardar el registro, puede ser que se encuentre ya registrado!";
		}

		$con->closeConexion();
	}else{
		$response['conexion']= "No se pudo conectar a la base de datos";
	}
}elseif (isset($_POST['buscar'])) {
	if ($response['conexion']=='OK') {
		$ced= $_POST['Cedula'];
		$busqueda= $con->existencia('empleado','cedula',$ced);
		if (mysqli_num_rows($busqueda)==true) {
			$response['msj']= "Se encontro un registro!";
			$i=0;
			while ($fila= $busqueda->fetch_assoc()) {
				$response['datosBD'][$i]['Cedula']= $fila['cedula'];
				$response['datosBD'][$i]['Nombre']= $fila['nombre'];
				$response['datosBD'][$i]['Horas']= $fila['horas_trabajadas'];
				$response['datosBD'][$i]['Valor']= $fila['valor_hora'];
				$response['datosBD'][$i]['SalarioB']= $fila['salario_bruto'];
				$response['datosBD'][$i]['Salud']= $fila['salud'];
				$response['datosBD'][$i]['Pension']= $fila['pension'];
				$response['datosBD'][$i]['Bono']= $fila['bono'];
				$response['datosBD'][$i]['SalarioN']= $fila['salario_neto'];
				$i++;
			}
		}else{
			$response['msj']="No se Encontro ningun registro";
		}
		$con->closeConexion();
	}else{
		$response['conexion']= "No se pudo conectar a la base de datos";
	}
}elseif (isset($_POST['eliminar'])) {
	if ($response['conexion']=='OK') {
		$ced= $_POST['Cedula'];
		if ($con->borrarDatos('borrarEmpleado', $ced)) {
			$response['msj']="Datos eliminados con exito!";
		}else{
			$response['msj']="No se pudo eliminar el registro";
		}
		$con->closeConexion();
	}else{
		$response['conexion']= "No se pudo conectar a la base de datos";
	}
}elseif (isset($_POST['editar'])) {
	if ($response['conexion']=='OK') {
		$ced= $_POST['Cedula'];
		$nom= $_POST['Nombre'];
		$horas= $_POST['Horas'];
		$valor= $_POST['Valor'];
		if ($con->actualizarEmpleado($ced, $nom, $horas, $valor)) {
			$response['msj']="Datos actualizados con exito!";
		}else{
			$response['msj']="no se pudo actualizar el registro";
		}
		$con->closeConexion();
	}else{
		$response['conexion']= "No se pudo conectar a la base de datos";
	}
}

echo json_encode($response);
?>