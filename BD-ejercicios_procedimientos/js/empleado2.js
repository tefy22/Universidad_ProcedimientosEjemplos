
function limpiar(){
	$("#txtCedula").val("");
	$("#txtNombre").val("");
	$("#txtValorHora").val("");
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
				url:'../server/serverEmpleado2.php',
				data:{buscar:btnBuscar, Cedula:ced},
				dataType:"json",
				cache:false,
				success: function(response){
					if (response.conexion=='OK') {
						alert(response.msj);
						$.each(response.datosBD, function(key, value){
							$("#tblResultado").append(`
								<tr>
									<td><input type="text" class="form-control" id="txtCedula2" value="${value['Cedula']}" disabled></td>
									<td><input type="text" class="form-control" id="txtNombre2" value="${value['Nombre']}"></td>
									<td><input type="text" class="form-control" id="txtSalario2" value="${value['Salario']}"></td>
									<td><input type="text" class="form-control" id="txtTransporte2" value="${value['Transporte']}" disabled></td>
									<td><input type="text" class="form-control" id="txtSalud2" value="${value['Salud']}" disabled></td>
									<td><input type="text" class="form-control" id="txtPension2" value="${value['Pension']}" disabled></td>
									<td><input type="text" class="form-control" id="txtBono2" value="${value['Bono']}" disabled></td>
									<td><input type="text" class="form-control" id="txtSalarioI2" value="${value['SalarioI']}" disabled></td>
									<td><button class="btn btn-warning" id="btnEditar"name="editar">
										<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></button></td>
									<td><button type="button" class="btn btn-danger" id="btnEliminar" name="eliminar">
										<span class="glyphicon glyphicon-trash" aria-hidden="true"></span></button></td>
								</tr>
							`);
							$("#btnEditar").click(function(){
								var btnEditar= $("#btnEditar").attr("name");
								var ced=$("#txtCedula2").val();
								var nom=$("#txtNombre2").val();
								var salario=$("#txtSalario2").val();
								if (confirm("Desea actualizar los datos?")) {
									peticionAjax('../server/serverEmpleado2.php', {editar:btnEditar, Cedula:ced, Nombre:nom, Salario:salario});
									$("#tblResultado").empty();
									$("table").addClass("tblVisualizar");
								}else{
									alert("Ha cancelado la operacion");
								}								
							});
							$("#btnEliminar").click(function(){
								var btnEliminar= $("#btnEliminar").attr("name");
								var ced= $("#txtCedula2").val();
								if (confirm("Desea eliminar el registro?")) {
									peticionAjax('../server/serverEmpleado2.php', {eliminar:btnEliminar, Cedula:ced});
									$("#tblResultado").empty();
									$("table").addClass("tblVisualizar");
								}else{
									alert("Ha cancelado la operacion");
								}
							});
						});						
					}else{
						alert(response.conexion);
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
		var valor=$("#txtValorHora").val();
		var btnGuardar= $("#btnGuardar").attr("name");

		if ($("input").hasClass("campErr")) {
			event.preventDefault();
			alert("Debes llenar correctamente los campos!");
		}else{
			event.preventDefault();
			peticionAjax('../server/serverEmpleado2.php', {guardar:btnGuardar, Cedula:ced, Nombre:nom, Salario:valor});
			limpiar();
		}
	});
//--------------------------------------------------------------------------------
	$("#txtCedula, #txtValorHora").blur(function(){
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