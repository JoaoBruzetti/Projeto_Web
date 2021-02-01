<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.fabric.Response" %>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap" %>
<%@page import="classes.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	
			String acao					= request.getParameter("acao");
  			String saida 				= "";
			
			if (acao != null) {
				
				String ID_usuario		= request.getParameter("id_usuario");
				String Nivel_usuario    = request.getParameter("nivel_usuario");
				String nome 			= request.getParameter("nome");
				String senha 			= request.getParameter("senha");
				String tel				= request.getParameter("tel");
				String cpf				= request.getParameter("cpf");		
				String email			= request.getParameter("email");
				
				int ID_usuario_int 		= Integer.valueOf(ID_usuario+"");
				int Nivel_usuario_int  	= Integer.valueOf(Nivel_usuario+"");
				
				Usuario usuario_altera = new Usuario(ID_usuario_int, Nivel_usuario_int, nome, senha, tel, cpf, email);
				usuario_altera.save();
				saida = "{ \"Alt\": \"true\", \"Msg\": \"<h3> Dados Alterados com sucesso!!!</h3>\" }";

			}else{
				saida = "{ \"Alt\": \"false\"}";
			}
			out.write(saida);
	%>  
