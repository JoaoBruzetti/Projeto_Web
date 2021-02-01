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
		<title>Cadastro de Usuário</title>
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
			
		</style>
	</head>
	
	<body>
		<form id="formcadastro" class="form-horizontal">
			<h3 class="text-center">Cadastro do Usuário</h3>
			
			<div class="form-group">
				<label for="email">Email:</label>
				<input type="email" id="email" name="email" class="form-control" placeholder="Email">
			</div>
			
			<div class="form-group">
				<label for="nome">Nome:</label>
				<input type="text" id="nome" name="nome" class="form-control" placeholder="Nome">
			</div>
			
			<div class="form-group">
				<label for="cpf">Cpf:</label>
				<input type="number" id="cpf" name="cpf" class="form-control" placeholder="Cpf">
			</div>
			
			<div class="form-group">
				<label for="tel">Telefone:</label>
				<input type="number" id="tel" name="tel" class="form-control" placeholder="Tel">
			</div>
			
			<input type="hidden" name="acao" value="1">
			<input type="button" id="btnCadastrar" class="btn btn-primary" value="Cadastrar"/>
		</form>
		<div id="msgCad" class="text-center" > </div>
		<button> <a href='index.html'> Voltar para a pagina de login </a> </button>
		
		<script type="text/javascript">
	
		$(document).ready( 
			function() {
			$("#btnCadastrar").click(
					function() {
						
						var formData = $("#formcadastro").serialize();
						$.post( "cadastrar.jsp", formData, function( data, status ) {
								var objReturn = $.parseJSON(data);
								if ( objReturn.Cad == "true" ){
									$("#msgCad").html(objReturn.Msg);
								}else{
									$("#msgCad").html("Erro ao Cadastrar Uusario");
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