
function peticionAjax(newUrl, dataSubmit){
	$.ajax({
		method:'POST',
		url: newUrl,
		data: dataSubmit,
		dataType: "json",
		cache: false,
		success: function(phpResponse){
			if (phpResponse.conexion=='OK') {
				alert(phpResponse.msj);
			}else{
				alert(phpResponse.conexion);
			}
		},
		error: function(){
			alert("error en la comunicación con el servidor");
		}
	});
}

$(document).ready(function () {
	
	$("#btnCasa").click(function(){
		location.href="./vistas/casa.html";
	});
	$("#btnMatricula").click(function(){
		location.href="./vistas/matricula.html";
	});
	$("#btnTelevisor").click(function(){	
		location.href="./vistas/televisor.html";
	});
	$("#btnEmpleado").click(function(){
		location.href="./vistas/empleado.html";
	});
	$("#btnEmpleado2").click(function(){
		location.href="./vistas/empleado2.html";
	});
	$("#btnVolver").click(function(){
		location.href="./../index.html";
	});
});