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
		}
		Usuario usuario_carrega = new Usuario(userLogin);
		ResultSet dados = usuario_carrega.selectBy(  "ID_usuario", ""+userLogin );
		dados.next();
		
		String ID_usuario		= ""+userLogin;
		String email			= dados.getString("email");
		int Nivel_usuario		= dados.getInt("Nivel_usuario");
		String cpf				= dados.getString("cpf");
		
			String acao					= request.getParameter("acao");
			String saida 				= "";
			
			if (acao != null) {
				String nome 			= request.getParameter("nome");
				String senha 			= request.getParameter("senha");
				String tel				= request.getParameter("tel");
				Usuario usuario = new Usuario(ID_usuario, Nivel_usuario, nome, senha, tel, cpf, email);
				usuario.save();
				
				saida = "{ \"Alt\": \"true\", \"Msg\": \"<h3> Dados Alterados com sucesso!!!</h3>\" }";

			}else{
				saida = "{ \"Alt\": \"false\"}";
			}
			out.write(saida);
	%>  