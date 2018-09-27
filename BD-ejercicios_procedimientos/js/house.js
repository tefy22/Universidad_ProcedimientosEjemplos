
function limpiarCampos(){
	$("#txtDescripcion").val("");
	$("#txtCosto").val("");
	$("#txtZona").val("");
}
 
$(document).ready(function () {
	$("#btnGuardar").click(function(event){
		$("input").trigger("blur");
		$("select").trigger("blur");
		$("textarea").trigger("blur");

		var desc= $("#txtDescripcion").val();
		var cost= $("#txtCosto").val();
		var zona= $("#txtZona").val();
		var btnGuardar= $("#btnGuardar").attr("name");

		if ($("input").hasClass("campErr") || $("select").hasClass("campErr") || $("textarea").hasClass("campErr")) {
			event.preventDefault();
			alert("Debes llenar correctamente los campos!");
		}else{
			event.preventDefault();
			peticionAjax('../server/serverCasa.php', {Descripcion:desc, Costo: cost, Zona:zona, guardar:btnGuardar});
			limpiarCampos();
		}
	});
	$("#btnBuscar").click(function(){
		var btnBuscar= $("#btnBuscar").attr("name");
		var codigo= prompt("Ingrese el codigo a buscar");		
		if (!$.isNumeric(codigo)) {
			alert("Debes ingresar un codigo correcto");
		}else{
			$("#tblResultado").empty();
			$.ajax({
				method:'POST',
				url: '../server/serverCasa.php',
				data: {Cod:codigo, buscar:btnBuscar},
				dataType:"json",
				cache: false,
				success: function(phpResponse){
					if (phpResponse.conexion=='OK') {
						alert(phpResponse.msj);
						$.each(phpResponse.datosBD, function(key, value){
							$("#tblResultado").append(`
								<tr>
									<td><input type="text" class="form-control" id="txtCodigo2" disabled value="${value['Cod']}"></td>
									<td><textarea class="form-control" id="txtDescripcion2">${value['Descripcion']}</textarea></td>
									<td><input type="text" class="form-control" id="txtCosto2" value="${value['Costo']}"></td>
									<td><input type="text" class="form-control" id="txtZona2" value="${value['Zona']}"></td>
									<td><input type="text" class="form-control" id="txtImpuesto2" value="${value['Impuesto']}" disabled></td>
									<td><input type="text" class="form-control" id="txtValor2" value="${value['Valor']}" disabled></td>
									<td><button class="btn btn-warning" id="btnEditar" 
									name="editar"><span class="glyphicon glyphicon-pencil" 
									aria-hidden="true"></span></button></td>
									<td><button type="button" class="btn btn-danger" id="btnEliminar" 
									name="eliminar"><span class="glyphicon glyphicon-trash" 
									aria-hidden="true"></span></button></td>
								</tr>`);
						});		
						$("#btnEditar").on("click", function(){
							var btnEditar= $("#btnEditar").attr("name");
							var codigo= $("#txtCodigo2").val();
							var descrip= $("#txtDescripcion2").val();
							var costo= $("#txtCosto2").val();
							var zona= $("#txtZona2").val();

							if (confirm("Desea actualizar los datos?")) {
								if (codigo=="" || descrip=="" || costo=="" || zona=="") {
									alert("Debes completar los campos correctamente");
								}else{
									peticionAjax('../server/serverCasa.php', {Cod:codigo, Descripcion:descrip, Costo: costo, Zona:zona, editar:btnEditar});
									$("#tblResultado").empty();
									$("table").addClass("tblVisualizar");
								}								
							}else{
								alert("Ha sido cancelado con exito");
							}
						});						
						$("#btnEliminar").click(function(){
							 
							 var codigo= $("#txtCodigo2").val();
							 var btnEliminar= $("#btnEliminar").attr("name");

							 if (confirm("Esta seguro que desea eliminar este registro?")) {
							 	peticionAjax('../server/serverCasa.php', {Cod:codigo, eliminar:btnEliminar});
							 	$("#tblResultado").empty();
							 	$("table").addClass("tblVisualizar");
							 }else{
							 	alert("Ha sido cancelado con exito");
							 }							
						});
					}else{
						alert(phpResponse.conexion);
					}
					
				},
				error: function(){
					alert("Error en la comunicación con el servidor");
				}
			});
			$("table").removeClass("tblVisualizar");
		}
	});
	
//------------------------------------------------------------------------------------------
	$("#txtDescripcion, #txtZona").blur(function(){		
		if ($(this).val()=="") {
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
	$("input, select, textarea").focus(function(){
		$(this).siblings(".msjError").css("display","none");
	});
});