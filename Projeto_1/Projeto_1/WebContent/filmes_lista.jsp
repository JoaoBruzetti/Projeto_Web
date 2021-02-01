<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.fabric.Response" %>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap" %>
<%@page import="classes.Usuario"%>
<%@page import="classes.Filme"%>
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
		<title>Filmes Cadastrados</title>
		
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
			
			
			#preco{
				width:40px;
			    borde:0;
			}
			
			#sinopse{
				width:500px;
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
			
		<h1 class="text-center"> Filmes </h1>
				
		<%
		  ResultSet dados_mostra = new Filme(0).selectAll();
		
		  while(dados_mostra.next()){
		 
		  	%>
		  	
		 <form id="formaltera<%out.print(dados_mostra.getInt("id_filme"));%>" class="form-horizontal">
		
			<div>
				<label for="id_filme">Id_filme:</label>
				<input type="text" id="id_filme" name="id_filme" value="<% out.println(dados_mostra.getInt("id_filme"));%>" readonly>
			</div>
			
			<div>
				<label for="nome">Nome:</label>
				<input type="text" id="nome" name="nome" value="<% out.println(dados_mostra.getString("nome")); %>">
			</div>
			
			<div>
				<label for="sinopse"> Sinopse</label>
				<input type="text" id="sinopse" name="sinopse" value="<% out.println(dados_mostra.getString("sinopse"));%>">
			</div>
			
			<div>
				<label for="preco">Preco:</label>
				<input type="number" id="preco" name="preco" value="<% out.print(dados_mostra.getInt("preco")); %>" required>,00
			</div>
			
			<div>
				<label for="faixa_etaria">Faixa_Etaria:</label>
				<select id="faixa_etaria" name="faixa_etaria">
  					<option value="<% out.print(dados_mostra.getString("faixa_etaria")) ;%>" selected> <% out.println(dados_mostra.getString("faixa_etaria"));%> </option>
  					<option value="L">L</option>
  					<option value="10">10</option>
  					<option value="12">12</option>
  					<option value="14">14</option>
  					<option value="16">16</option>
  					<option value="18">18</option>
				</select>
			</div>
	
			<input type="hidden" name="acao" value="1">
			<input type="button" id="btnAlterar<%out.print(dados_mostra.getInt("id_filme"));%>" class="btn btn-primary" value="Alterar"/>
			
		</form>
		<br/> 
		<div id="msgAlt<%out.print(dados_mostra.getInt("id_filme"));%>" class="text-center" > </div>
		 <br/>
		  	
		  	   <script type="text/javascript">
	
		$(document).ready( 
			function() {
			$("#btnAlterar<%out.print(dados_mostra.getInt("id_filme"));%>").click(
					function() {
						
						var formData = $("#formaltera<%out.print(dados_mostra.getInt("id_filme"));%>").serialize();
						$.post( "filmes_atualiza.jsp", formData, function( data, status ) {
								var objReturn = $.parseJSON(data);
								if ( objReturn.Alt == "true" ){
									$("#msgAlt<%out.print(dados_mostra.getInt("id_filme"));%>").html(objReturn.Msg);
								}else{
									$("#msgAlt<%out.print(dados_mostra.getInt("id_filme"));%>").html("Erro ao atualizar filme!!!");
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
		<br/>  <br/>
		<button> <a href="admin.jsp"> Voltar a Pagina de Admin</a> </button>
		
	</body>
</html>