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
		<title>Pagina de Administração</title>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
		
		<style>
		#painel{
			margin-top:100px;
		}
		
		table{
				margin-left:400px;
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
		
		<div id="painel" class="text-center">	
			
		<h1> Bem-Vindo Administrador! </h1>
		 <br/> <br/>
		<table>
		<tr>
		<td>
		<button> <a href="filmes_cadastra.jsp"> Cadastrar Filmes</a> </button>
		</td>
		<td>
		<button> <a href="filmes_lista.jsp"> Gerenciar Filmes</a> </button>
		</td>
		<td>
		<button> <a href="usuarios_lista.jsp">Gerenciar Usuario</a> </button>
		</td>
		<td>
		<button> <a href="privateAccess.jsp"> Voltar a Pagina Anterior</a> </button>
		</td>
		
		</tr>
		</table>
		</div>
		
	</body>
</html>