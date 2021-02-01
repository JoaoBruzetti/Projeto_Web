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
		<title>Pagina Usuario</title>
				<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
		
	</head>
	<style>
		#painel{
			margin-top:100px;
		}
		
		table{
				margin-left:300px;
		}
	</style>
	<body>
			
		<%
			int userLogin = 0; 
			
			userLogin = (int) session.getAttribute("userlogin");
			if ( ! (userLogin > 0 )){
				response.sendRedirect("index.html");
			}else{
			%>
		
		<div id="painel" class="text-center">	
			
		<h1> Bem-Vindo! </h1>
				<br/> <br/>
  			<table>
  			<tr>
  
		<%
			Usuario usuario_carrega = new Usuario(userLogin);
			ResultSet dados = usuario_carrega.selectBy(  "ID_usuario", ""+userLogin );
			dados.next();
			if(dados.getInt("Nivel_usuario") == 1){
		%>
			 <td>
			<button> <a href="admin.jsp"> Clique aqui para entra na pagina de administrador</a> </button>
			</td>
			
		<% 	
			}
			else{
		%>
		 <td>
		<button> <a href="alugar.jsp"> Clique aqui para alugar nossos filmes</a> </button>
		 </td>
		 <td>
		<button> <a href="alterar.jsp"> Clique aqui para alterar seus dados</a> </button>
		</td>
		
		<%  } }%>
		 <td>
		<button> <a href="encerra.jsp"> Clique aqui para deslogar da sua conta</a> </button>
		</td>
		
	</tr>
	</table>	
	</div>
	</body>
</html>