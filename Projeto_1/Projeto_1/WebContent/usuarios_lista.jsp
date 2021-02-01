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
		<title>Usuarios Cadastrados</title>
		
		<style>
			
			form{
				width: 80%;
				margin-left: 43%;
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
			
		<h1 class="text-center"> Usuarios </h1>
		
		<%
		  ResultSet dados_mostra = new Usuario(0).selectAll();
		
		  while(dados_mostra.next()){
		
		%>
		<form id="formaltera<% out.print(dados_mostra.getInt("ID_usuario"));%>" class="form-horizontal">
		
			<div>
				<label for="id_usuario">Id_Usuario:</label>
				<input type="text" id="id_usuario" name="id_usuario" value="<% out.println(dados_mostra.getInt("ID_usuario"));%>" readonly>
			</div>
			
			<div>
				<label for="nivel_usuario">Nivel usuario:</label>
				<select id="nivel_usuario" name="nivel_usuario">
  					<option value="<% out.print(dados_mostra.getInt("Nivel_usuario")) ;%>" selected> <% out.println(dados_mostra.getInt("Nivel_usuario"));%> </option>
  					<option value="1">1</option>
  					<option value="2">2</option>
				</select>
			</div>
			
			<div>
				<label for="nome">Nome:</label>
				<input type="text" id="nome" name="nome" value="<% out.println(dados_mostra.getString("nome")); %>">
			</div>
			
			<div>
				<label for="senhaAtual"> Senha</label>
				<input type="text" id="senha" name="senha" value="<% out.println(dados_mostra.getString("senha"));%>">
			</div>
			
			<div>
				<label for="cpf">CPF:</label>
				<input type="text" id="cpf" name="cpf" value="<% out.println(dados_mostra.getString("cpf"));%>" required>
			</div>
			
			<div>
				<label for="telefone">Telefone:</label>
				<input type="text" id="tel" name="tel" value="<% out.println(dados_mostra.getString("tel"));%>" required>
			</div>
			
				<div>
				<label for="email">Email:</label>
				<input type="email" id="email" name="email" value="<% out.println(dados_mostra.getString("email")); %> " required>
				</div>
			
			<input type="hidden" name="acao" value="1">
			<input type="button" id="btnAlterar<% out.print(dados_mostra.getInt("ID_usuario"));%>" class="btn btn-primary" value="Alterar"/>
			
		</form>
		<br/>  
			<div id="msgAlt<%out.print(dados_mostra.getInt("ID_usuario"));%>" class="text-center" > </div>
		<br/>
		
		 <script type="text/javascript">
	
		$(document).ready( 
			function() {
			$("#btnAlterar<% out.print(dados_mostra.getInt("ID_usuario"));%>").click(
					function() {
						
						var formData = $("#formaltera<%out.print(dados_mostra.getInt("ID_usuario"));%>").serialize();
						$.post( "usuarios_atualiza.jsp", formData, function( data, status ) {
								var objReturn = $.parseJSON(data);
								if ( objReturn.Alt == "true" ){
									$("#msgAlt<%out.print(dados_mostra.getInt("ID_usuario"));%>").html(objReturn.Msg);
								}else{
									$("#msgAlt<%out.print(dados_mostra.getInt("ID_usuario"));%>").html("Erro ao alterar usuario");
								}
							}
						);	
					}		
				);
			
				} 
			);
	
		</script>
		
		<%
		  }
		%>
		<button> <a href="admin.jsp"> Voltar a Pagina de Admin</a> </button>
		
	</body>
</html>