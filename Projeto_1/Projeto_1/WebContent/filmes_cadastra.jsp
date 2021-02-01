<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.fabric.Response" %>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap" %>
<%@page import="classes.Usuario"%>
<%@page import="multitool.RandomCode"%>
<%@page import="mail.SendMail"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
		<title>Cadastro de Filme</title>
		<style>
				form{
				width: 80%;
				margin-left: 10%;
				margin-top: 50px;
				text-align: justify;
			}
			
			h3 {
				height: 35px;
			}
			
			button{
				margin-left: 43%;
			}
			
			#preco{
				width:40px;
			}
			
		</style>
	</head>
	
	<body>
	<% 
		int userLogin = 0; 
			
			userLogin = (int) session.getAttribute("userlogin");
			if ( ! (userLogin > 0 )){
				response.sendRedirect("index.html");
			}else{

				Usuario usuario_verifica = new Usuario(userLogin);
				ResultSet dados = usuario_verifica.selectBy(  "ID_usuario", ""+userLogin );
				dados.next();
				if(dados.getInt("Nivel_usuario") != 1){
				response.sendRedirect("privateAccess.jsp");
			}
			}
		
		%>
			
		<form id="formcadastro" class="form-horizontal">
			<h3 class="text-center">Cadastro de Filme</h3>
			<div class="form-group">
				<label for="nome">Nome:</label>
				<input type="text" id="nome" name="nome" class="form-control" placeholder="Nome">
			</div>
			
			<div class="form-group">
				<label for="cpf">Sinopse:</label>
				<input type="text" id="sinopse" name="sinopse" class="form-control" placeholder="Sinopse">
			</div>
			
			<div class="form-group">
				<label for="faixa_etaria">Faixa Etária:</label>
				<select id="faixa_etaria" name="faixa_etaria">
  					<option value="L">L</option>
  					<option value="10">10</option>
  					<option value="12">12</option>
  					<option value="14">14</option>
  					<option value="16">16</option>
  					<option value="18">18</option>
				</select>
			</div>
			
			<div class="form-group">
				<label for="tel">Preço:</label>
				<input type="number" id="preco" name="preco" placeholder="Preço">,00
			</div>
			
			<input type="hidden" name="acao" value="1">
			<input type="button" id="btnCadastrar" class="btn btn-primary" value="Cadastrar"/>
			
		</form>
		
		<div id="msgCad" class="text-center" > </div>
		<button> <a href='admin.jsp'> Voltar para a pagina de Administrador </a> </button>
		
		<script type="text/javascript">
	
		$(document).ready( 
			function() {
			$("#btnCadastrar").click(
					function() {
						
						var formData = $("#formcadastro").serialize();
						$.post( "filmes_cadastrar.jsp", formData, function( data, status ) {
								var objReturn = $.parseJSON(data);
								if ( objReturn.Cad == "true" ){
									$("#msgCad").html(objReturn.Msg);
								}else{
									$("#msgCad").html("Erro ao Cadastrar Filme");
								}
							}
						);	
					}		
				);
			
				} 
			);
	
		</script>
		
	</body>
</html>