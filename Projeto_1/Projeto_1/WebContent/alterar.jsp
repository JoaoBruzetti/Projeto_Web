<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.fabric.Response" %>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap" %>
<%@page import="classes.Usuario"%>
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
		<title>Alteração de Dados</title>
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
	
	<%
		int userLogin = 0; 
		
		userLogin = (int) session.getAttribute("userlogin");
		if ( ! (userLogin > 0 )){
			response.sendRedirect("teste01.html");
		}
		Usuario usuario_carrega = new Usuario(userLogin);
		ResultSet dados = usuario_carrega.selectBy(  "ID_usuario", ""+userLogin );
		dados.next();
		
	%>
	
	<body>
		
		<form id="formaltera" class="form-horizontal">
			<h3>Dados do Usuário:</h3>
		
			<div class="form-group">
				<label for="email">Email:</label>
				<input type="email" id="email" name="email" class="form-control" placeholder="<% out.println(dados.getString("email")); %> " disabled>
			</div>
			
			<div class="form-group">
				<label for="senhaAtual"> Senha</label>
				<input type="password" id="senha" value="<% out.println(dados.getString("senha"));%>" name="senha" class="form-control" placeholder="Nova Senha">
			</div>
			
			<div class="form-group">
				<label for="nome">Nome:</label>
				<input type="text" id="nome" name="nome" class="form-control" value="<% out.println(dados.getString("nome")); %>">
			</div>
			
			<div class="form-group">
				<label for="cpf">CPF:</label>
				<input type="text" id="cpf" name="cpf" class="form-control" placeholder=" <% out.println(dados.getString("cpf")); %>" disabled>
			</div>
			
			<div class="form-group">
				<label for="telefone">Telefone:</label>
				<input type="text" id="tel" name="tel" class="form-control" value="<% out.println(dados.getString("tel"));%>" required>
			</div>
			
			<input type="hidden" name="acao" value="1">
			<input type="button" id="btnAlterar" class="btn btn-primary" value="Alterar"/>
			
		</form>
		
		<div id="msgAlt" class="text-center"> </div>
		
		<button> <a href="privateAccess.jsp"> Voltar a Pagina de Admin</a> </button>
		
	     <script type="text/javascript">
	
		$(document).ready( 
			function() {
			$("#btnAlterar").click(
					function() {
						
						var formData = $("#formaltera").serialize();
						$.post( "atualiza.jsp", formData, function( data, status ) {
								var objReturn = $.parseJSON(data);
								if ( objReturn.Alt == "true" ){
									$("#msgAlt").html(objReturn.Msg);
								}else{
									$("#msgAlt").html("Erro ao alterar dados");
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