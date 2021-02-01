<%@page import="classes.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	String user = request.getParameter("user");
	String pass = request.getParameter("pass");
	
	String saida = ""; 

	Usuario usuario = new Usuario (user, pass, user);
	if (usuario.checkLogin()){
		session.setAttribute("userlogin", usuario.getIDusuario());
		saida = "{ \"login\": \"true\", \"user\": \"" + usuario.getIDusuario()+"\" }";
		
	}else{
		session.setAttribute("userlogin", 0);
		saida = "{ \"login\": \"false\", \"user\": \"0\"}";
	}
	out.write(saida);
%>