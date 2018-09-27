
function limpiarCampos(){
	$("#txtCedula").val("");
	$("#txtCosto").val("");
	$("#txtPlan").val("");
}

$(document).ready(function () {
	
	$("#btnBuscar").click(function(){
		var cedula= prompt("Ingresa el numero de cedula a buscar");
		var btnBuscar= $("#btnBuscar").attr("name");
		if (!$.isNumeric(cedula)) {
			alert("Debes ingresar correctamente la cedula!");
		}else{
			$("#tblResultado").empty();
			$.ajax({
				method: 'POST',
				url: '../server/serverMatricula.php',
				data: {Ced:cedula, buscar:btnBuscar},
				dataType: "json",
				cache: false,
				success: function(php_response){
					if (php_response.conexion=="OK") {
						alert(php_response.msj);
						$.each(php_response.datosDB, function(key, value){
							$("#tblResultado").append(`
								<tr>
									<td><input type="text" id="txtcedula" class="form-control" value="${value['Cod']}" disabled></td>
									<td><input type="text" id="txtvalor" class="form-control" value="${value['Valor']}"></td>
									<td><input type="text" id="txtplan" class="form-control" value="${value['Plan']}"></td>
									<td><input type="text" id="txttotal" class="form-control" value="${value['Total']}"></td>
									<td><button class="btn btn-warning" id="btnEditar" 
									name="editar"><span class="glyphicon glyphicon-pencil" 
									aria-hidden="true"></span></button></td>
									<td><button type="button" class="btn btn-danger" id="btnEliminar" 
									name="eliminar"><span class="glyphicon glyphicon-trash" 
									aria-hidden="true"></span></button></td>
								</tr>
							`);
							$("#btnEditar").click(function(){
								var ced= $("#txtcedula").val();
								var cost=$("#txtvalor").val();
								var pl= $("#txtplan").val();
								var btnEditar= $("#btnEditar").attr("name");

								if (confirm("Desea actualizar los datos?")) {
									if (ced=="" || cost=="" || pl=="") {
										alert("Debes llenar completamente los campos");
									}else{
										peticionAjax("../server/serverMatricula.php", {Ced:ced, Costo:cost, Plan:pl, editar:btnEditar});
										$("#tblResultado").empty();
							 			$("table").addClass("tblVisualizar");
									}
								}else{
									alert("Ha cancelado la operacion");
								}
							});
							$("#btnEliminar").click(function(){
								var cod= $("#txtcedula").val();
								var btnEliminar= $("#btnEliminar").attr("name");

								if (confirm("Desea eliminar dicho registro?")) {
									peticionAjax('../server/serverMatricula.php', {Cod:cod,eliminar:btnEliminar});
									$("#tblResultado").empty();
							 		$("table").addClass("tblVisualizar");
								}else{
									alert("La operacion ha sido cancelada");
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
		$("select").trigger("blur");

		var ced= $("#txtCedula").val();
		var cost=$("#txtCosto").val();
		var pl= $("#txtPlan").val();
		var btnGuardar= $("#btnGuardar").attr("name");

		if ($("input").hasClass("campErr") || $("select").hasClass("campErr")) {
			event.preventDefault();
			alert("Debes llenar correctamente los campos!");
		}else{
			event.preventDefault();
			peticionAjax('../server/serverMatricula.php', {Cedula:ced, Costo:cost, Plan:pl, guardar:btnGuardar});
			limpiarCampos();
		}
	});

//----------------------------------------------------------------

	$("#txtCedula").blur(function(){
		if (isNaN($(this).val()) || $(this).val()=="") {
			$(this).siblings(".msjError").css("display","block");
			$(this).addClass("campErr");
		}else{
			$(this).removeClass("campErr");
		}
	});
	$("#txtCosto").blur(function(){
		if (isNaN($(this).val()) || $(this).val()=="") {
			$(this).siblings(".msjError").css("display","block");
			$(this).addClass("campErr");
		}else{
			$(this).removeClass("campErr");
		}
	});
	$("#txtPlan").blur(function(){
		if ($(this).val()=="") {
			$(this).siblings(".msjError").css("display","block");
			$(this).addClass("campErr");
		}else{
			$(this).removeClass("campErr");
		}
	});
	$("input, select").focus(function(){
		$(this).siblings(".msjError").css("display","none");
	});
});