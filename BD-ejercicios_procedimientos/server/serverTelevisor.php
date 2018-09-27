<?php  

require 'Conexion.php';

$con= new Conexion();
$response['conexion']= $con->initConexion('ejercicios_procedimientos');

if (isset($_POST['guardar'])) {
	if ($response['conexion']=='OK') {
		$costo= $_POST['Costo'];
		$ganancia= $_POST['Ganancia'];
		if ($con->guardarTelevisor($costo, $ganancia)) {
			$response['msj']= "Datos guardados con exito!";
		}else{
			$response['msj']= "No se pudo guardar los datos";
		}
		$con->closeConexion();
	}else{
		$response['conexion']= "No se pudo conectar a la base de datos";
	}
}elseif (isset($_POST['buscar'])) {
	if ($response['conexion']=='OK') {
		$codigo= $_POST['Cod'];
		$busqueda= $con->existencia('televisor', 'codigo', $codigo);
		if (mysqli_num_rows($busqueda)==true) {
			$response['msj']="Se encontró un registro!";
			$i=0;
			while ($fila= $busqueda->fetch_assoc()) {
				$response['datosBD'][$i]['Codigo']=$fila['codigo'];
				$response['datosBD'][$i]['Costo']=$fila['costo'];
				$response['datosBD'][$i]['Por_Ganancia']=$fila['porc_ganancia'];
				$response['datosBD'][$i]['Impuesto']=$fila['impuesto'];
				$response['datosBD'][$i]['Ganancia']=$fila['ganancia'];
				$response['datosBD'][$i]['Iva']=$fila['iva'];
				$response['datosBD'][$i]['Valor_Venta']=$fila['valor_venta'];
			}
		}else{
			$response['msj']="No se encontro dicho registro";
		}
		$con->closeConexion();
	}else{
		$response['conexion']= "No se pudo conectar a la base de datos";
	}
}elseif (isset($_POST['editar'])) {
	if ($response['conexion']=='OK') {
		$codigo= $_POST['Codigo'];
		$costo= $_POST['Costo'];
		$ganancia= $_POST['Ganancia'];
		if ($con->actualizarTelevisor($codigo, $costo, $ganancia)) {
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
		$cod= $_POST['Codigo'];
		if ($con->borrarDatos('borrarTelevisor', $cod)) {
			$response['msj']="Registro eliminado con exito!";
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