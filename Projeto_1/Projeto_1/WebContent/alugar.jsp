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
		<title>Alugar Filmes</title>
		
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
			
			#id_filme{
				display:none;
			}
			
			#nome,#sinopse,#preco,#faixa_etaria{
			 box-shadow: 0 0 0 0;
			 border: 0 none;
			 outline:0;
			}
			
			#preco{
				width:40px;
			    borde:0;
			}
			#preco fieldset{
				width:300px;
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
			}
			%>
			
		<h1 class="text-center"> Catalógo de Filmes </h1>
		
		<%
		  ResultSet dados_mostra = new Filme(0).selectAll();
		
		  while(dados_mostra.next()){
		 
		  	%>
		  	
		 <form id="formaluga<%out.print(dados_mostra.getInt("id_filme"));%>">
		
			<div>
				<input type="text" id="id_filme" name="id_filme" value="<% out.println(dados_mostra.getInt("id_filme"));%>" readonly>
			</div>
			
			<div>
				<label for="nome">Nome:</label>
				<input type="text" id="nome" name="nome" value="<% out.println(dados_mostra.getString("nome")); %>" readonly>
			</div>
			
			<div>
				<label for="sinopse"> Sinopse:</label>
				<input type="text" id="sinopse" value="<% out.println(dados_mostra.getString("sinopse"));%>" name="sinopse" readonly>
			</div>
			
			<div>
				<label for="preco">Preco:</label>
				<input type="number" id="preco" name="preco" value="<%out.print(dados_mostra.getInt("preco"));%>" required readonly>,00
			</div>
			
			<div>
				<label for="faixa_etaria">Faixa Etaria:</label>
				<input type="text" id="faixa_etaria" name="faixa_etaria" value="<% out.print(dados_mostra.getString("faixa_etaria")); %>" readonly>
			</div>
	
			<div>
				<label for="qtd_dias">Quantidade de Dias:</label>
				<input type="number" id="qtd_dias" name="qtd_dias" value="0" min="0" max="10">
			</div>
	
	
			<input type="hidden" name="acao" value="1">
			<input type="button" id="btnAlugar<%out.print(dados_mostra.getInt("id_filme"));%>" class="btn btn-primary" value="Alugar"/>
			
		</form>
		<br/> 
		<div id="msgAlu<%out.print(dados_mostra.getInt("id_filme"));%>" class="text-center" > </div>
		<br/>
		  	
		  	<script type="text/javascript">
	
		$(document).ready( 
			function() {
			$("#btnAlugar<%out.print(dados_mostra.getInt("id_filme"));%>").click(
					function() {
						
						var formData = $("#formaluga<%out.print(dados_mostra.getInt("id_filme"));%>").serialize();
						$.post( "aluga.jsp", formData, function( data, status ) {
								var objReturn = $.parseJSON(data);
								if ( objReturn.Alt == "true" ){
									$("#msgAlu<%out.print(dados_mostra.getInt("id_filme"));%>").html(objReturn.Msg);
								}else{
									$("#msgAlu<%out.print(dados_mostra.getInt("id_filme"));%>").html("Erro ao alugar filme");
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
		<button> <a href="privateAccess.jsp"> Voltar a Pagina Anterior</a> </button>
		
		
	</body>
</html>