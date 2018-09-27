
function limpiar(){
	$("#txtCosto").val("");
	$("#txtGanancia").val("");
}

$(document).ready(function () {

	$("#btnBuscar").click(function(){
		var cod= prompt("Ingrese el codigo a buscar:");
		var btnBuscar= $("#btnBuscar").attr("name");
		if (!$.isNumeric(cod)) {
			alert("Debes ingresar correctamente el codigo!");
		}else{
			$("#tblResultado").empty();
			$.ajax({
				method: 'POST',
				url: '../server/serverTelevisor.php',
				data: {Cod:cod, buscar:btnBuscar},
				dataType: "json",
				cache: false,
				success: function(phpResponse){
					if (phpResponse.conexion=='OK') {
						alert(phpResponse.msj);
						$.each(phpResponse.datosBD, function(key,value){
							$("#tblResultado").append(`
								<tr>
									<td><input type="text" class="form-control" id="txtCodigo2" value="${value['Codigo']}" disabled></td>
									<td><input type="text" class="form-control" id="txtCosto2" value="${value['Costo']}"></td>
									<td><input type="text" class="form-control" id="txtPorGanancia2" value="${value['Por_Ganancia']}"></td>
									<td><input type="text" class="form-control" id="txtImpuesto2" value="${value['Impuesto']}" disabled></td>
									<td><input type="text" class="form-control" id="txtGanancia2" value="${value['Ganancia']}" disabled></td>
									<td><input type="text" class="form-control" id="txtIva2" value="${value['Iva']}" disabled></td>
									<td><input type="text" class="form-control" id="txtValorVenta2" value="${value['Valor_Venta']}" disabled></td>
									<td><button class="btn btn-warning" id="btnEditar" 
									name="editar"><span class="glyphicon glyphicon-pencil" 
									aria-hidden="true"></span></button></td>
									<td><button type="button" class="btn btn-danger" id="btnEliminar" 
									name="eliminar"><span class="glyphicon glyphicon-trash" 
									aria-hidden="true"></span></button></td>
								</tr>
							`);
						});
						$("#btnEditar").click(function(){
							var btnEditar= $("#btnEditar").attr("name");
							var cod= $("#txtCodigo2").val();
							var costo= $("#txtCosto2").val();
							var ganancia= $("#txtPorGanancia2").val();

							if (confirm("Desea actualizar los datos?")) {
								if (cod=="" || costo=="" || ganancia=="") {
									alert("Debes llenar completamente todos los campos");
								}else{
									peticionAjax("../server/serverTelevisor.php", {editar:btnEditar, Codigo:cod, Costo:costo, Ganancia:ganancia});
									$("#tblResultado").empty();
									$("table").addClass("tblVisualizar");
								}
							}else{
								alert("Ha cancelado la operación");
							}
						});
						$("#btnEliminar").click(function(){
							var btnEliminar= $("#btnEliminar").val();
							var cod= $("#txtCodigo2").val();

							if (confirm("Desea eliminar el registro?")) {								
								peticionAjax('../server/serverTelevisor.php', {eliminar:btnEliminar, Codigo:cod});
								$("#tblResultado").empty();
									$("table").addClass("tblVisualizar");
							}else{
								alert("Ha cancelado la operación");
							}							
						});
					}else{
						alert(phpResponse.conexion);
					}
				},
				error: function(){alert("Error en la comunicación con el servidor")}
			});
			$("table").removeClass("tblVisualizar");
		}
	});

	$("#btnGuardar").click(function(event){
		$("input").trigger("blur");
		var cost= $("#txtCosto").val();
		var gan= $("#txtGanancia").val();
		var btnGuardar= $("#btnGuardar").attr("name");
		if ($("input").hasClass("campErr")) {
			event.preventDefault();
			alert("Debes completar los campos correctamente!");
		}else{
			event.preventDefault();
			peticionAjax('../server/serverTelevisor.php', {Costo:cost, Ganancia:gan, guardar:btnGuardar});
			limpiar();
		}
	});

//-------------------------------------------------------------------------
	$("#txtCosto, #txtGanancia").blur(function(){
		if (isNaN($(this).val()) || $(this).val()=="") {
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