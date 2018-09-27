
function limpiar(){
	ced=$("#txtCedula").val("");
	nom=$("#txtNombre").val("");
	horas=$("#txtHorasTrabajadas").val("");
	valor=$("#txtValorHora").val("");
}

$(document).ready(function () {
	
	$("#btnBuscar").click(function(){
		var ced= prompt("Ingresa el numero de cedula a buscar");
		var btnBuscar= $("#btnBuscar").attr("name");
		if (!$.isNumeric(ced)) {
			alert("Debes Ingresar la cedula correctamente!");
		}else{
			$("#tblResultado").empty();
			$.ajax({
				method:'POST',
				url:'../server/serverEmpleado.php',
				data: {Cedula:ced, buscar:btnBuscar},
				dataType:"json",
				cache: false,
				success: function(php_response){
					if (php_response.conexion=='OK') {
						alert(php_response.msj);
						$.each(php_response.datosBD, function(key, value){							
							$("#tblResultado").append(`
								<tr>
									<td><input type="text" class="form-control" id="txtCedula2" value="${value['Cedula']}" disabled></td>
									<td><input type="text" class="form-control" id="txtNombre2" value="${value['Nombre']}"></td>
									<td><input type="text" class="form-control" id="txtHoras2" value="${value['Horas']}"></td>
									<td><input type="text" class="form-control" id="txtValor2" value="${value['Valor']}"></td>
									<td><input type="text" class="form-control" id="txtSalarioB2" value="${value['SalarioB']}" disabled></td>
									<td><input type="text" class="form-control" id="txtSalud2" value="${value['Salud']}" disabled></td>
									<td><input type="text" class="form-control" id="txtPension2" value="${value['Pension']}" disabled></td>
									<td><input type="text" class="form-control" id="txtBono2" value="${value['Bono']}" disabled></td>
									<td><input type="text" class="form-control" id="txtSalarioN2" value="${value['SalarioN']}" disabled></td>
									<td><button class="btn btn-warning" id="btnEditar" 
									name="editar"><span class="glyphicon glyphicon-pencil" 
									aria-hidden="true"></span></button></td>
									<td><button type="button" class="btn btn-danger" id="btnEliminar" 
									name="eliminar"><span class="glyphicon glyphicon-trash" 
									aria-hidden="true"></span></button></td>
								</tr>
							`);
							$("#btnEliminar").click(function(){
								var ced= $("#txtCedula2").val();
								var btnEliminar= $("#btnEliminar").attr("name");
								if (confirm("Desea eliminar el registro?")) {
									peticionAjax('../server/serverEmpleado.php', {eliminar:btnEliminar, Cedula:ced})
									$("#tblResultado").empty();
									$("table").addClass("tblVisualizar");
								}else{
									alert("Ha cancelado la operacion");
								}
							});
							$("#btnEditar").click(function(){
								var btnEditar= $("#btnEditar").attr("name");
								var ced= $("#txtCedula2").val();
								var nombre= $("#txtNombre2").val();
								var horas= $("#txtHoras2").val();
								var valor= $("#txtValor2").val();
								if (confirm("Desea actualizar el registro?")) {
									peticionAjax('../server/serverEmpleado.php', {editar:btnEditar, Cedula:ced, Nombre:nombre, Horas:horas, Valor:valor})
									$("#tblResultado").empty();
									$("table").addClass("tblVisualizar");
								}else{
									alert("Ha cancelado la operacion");
								}
							});
						});
					}else{
						alert(php_response.conexion);
					}
				},
				error: function(){
					alert("Error en la comunicación con el servidor");
				}
			});
			$("table").removeClass("tblVisualizar");
		}
	});

	$("#btnGuardar").click(function(event){
		$("input").trigger("blur");

		var ced=$("#txtCedula").val();
		var nom=$("#txtNombre").val();
		var horas=$("#txtHorasTrabajadas").val();
		var valor=$("#txtValorHora").val();
		var btnGuardar= $("#btnGuardar").attr("name");

		if ($("input").hasClass("campErr")) {
			event.preventDefault();
			alert("Debes llenar correctamente los campos!");
		}else{
			event.preventDefault();
			peticionAjax('../server/serverEmpleado.php', {guardar:btnGuardar, Cedula:ced, Nombre:nom, Horas:horas, Valor:valor});
			limpiar();
		}
	});
//------------------------------------------------------------
	$("#txtCedula, #txtHorasTrabajadas, #txtValorHora").blur(function(){
		if (isNaN($(this).val()) || $(this).val()=="") {
			$(this).siblings(".msjError").css("display","block");
			$(this).addClass("campErr");
		}else{
			$(this).removeClass("campErr");
		}
	});

	$("#txtNombre").blur(function(){
		if ($(this).val()=="") {
			$(this).siblings(".msjError").css("display","block");
			$(this).addClass("campErr");
		}else{
			$(this).removeClass("campErr");
		}
	});

	$("input").focus(function(){
		$(this).siblings(".msjError").css("display","none");
	});
});
