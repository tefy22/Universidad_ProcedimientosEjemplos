<?php  

class Conexion {
	
	private $host;
	private $user;
	private $password;
	private $conexion;
	private $baseDatos;

	function __construct(){
		$this->host='localhost';
		$this->user='root';
		$this->password='';
	}

	function initConexion($baseDatos){
		$this->conexion= new mysqli($this->host, $this->user, $this->password, $baseDatos);
		if ($this->conexion->connect_error) {
			return "Error: ".$this->conexion->connect_error;
		}else{
			return "OK";
		}
	}

	function closeConexion(){
		$this->conexion->close();
	}

	function ejecutar($sql){
		return $this->conexion->query($sql);
	}

	function existencia($table, $campo, $atributo){
		$sql="select * from ".$table." where ".$campo."=".$atributo.";";
		return $this->ejecutar($sql);
	}

	function guardarCasa($descripcion, $costo, $zona){
		$sql= "call guardarCasa('".$descripcion."', ".$costo.", '".$zona."');";
		return $this->ejecutar($sql);
	}

	function guardarMatricula($cedula, $valor, $plan){
		$sql="call guardarMatricula(".$cedula.", ".$valor.", '".$plan."');";
		return $this->ejecutar($sql);
	}

	function guardarTelevisor($costo, $ganancia){
		$sql= "call guardarTelevisor(".$costo.", ".$ganancia.");";
		return $this->ejecutar($sql);
	}

	function guardarEmpleado($cedula, $nombre, $horas, $valor){
		$sql="call guardarEmpleado(".$cedula.", '".$nombre."', ".$horas.", ".$valor.");";
		return $this->ejecutar($sql);
	}

	function guardarEmpleado2($cedula, $nombre, $salario){
		$sql="call guardarEmpleado2(".$cedula.", '".$nombre."', ".$salario.");";
		return $this->ejecutar($sql);
	}

	function actualizarCasa($codigo, $descripcion, $costo, $zona){
		$sql= "call actualizarCasa(".$codigo.", '".$descripcion."', ".$costo.", '".$zona."');";
		return $this->ejecutar($sql);
	}

	function actualizarMatricula($cedula, $valor, $plan){
		$sql= "call actualizarMatricula(".$cedula.", ".$valor.", '".$plan."');";
		return $this->ejecutar($sql);
	}

	function actualizarTelevisor($codigo, $costo, $ganancia){
		$sql= "call actualizarTelevisor(".$codigo.", ".$costo.", ".$ganancia.");";
		return $this->ejecutar($sql);
	}

	function actualizarEmpleado($cedula, $nombre, $horas, $valor){
		$sql="call actualizarEmpleado(".$cedula.", '".$nombre."', ".$horas.", ".$valor.");";
		return $this->ejecutar($sql);
	}

	function actualizarEmpleado2($cedula, $nombre, $salario){
		$sql="call actualizarEmpleado2(".$cedula.", '".$nombre."', ".$salario.");";
		return $this->ejecutar($sql);
	}

	function borrarDatos($nombre, $identificador){
		$sql="call ".$nombre." (".$identificador.");";
		return $this->ejecutar($sql);
	}

}


?>