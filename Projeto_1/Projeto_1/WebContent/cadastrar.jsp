<%@page import="com.mysql.fabric.Response" %>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap" %>
<%@page import="classes.Usuario"%>
<%@page import="multitool.RandomCode"%>
<%@page import="mail.SendMail"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
		<%
			String acao				= request.getParameter("acao");
			String saida 			= "";
			
			if (acao != null) {
				int ID_usuario			= 0;
				String email			= request.getParameter("email");
				String senha 			= new Usuario(email).newPassword();
				int Nivel_usuario		= 2;
				String nome				= request.getParameter("nome");
				String cpf				= request.getParameter("cpf");
				String tel			= request.getParameter("tel");
				Usuario usuario = new Usuario(ID_usuario, Nivel_usuario, nome, senha, tel, cpf, email);
				usuario.save();
				
				String smtpHost = "smtp.gmail.com"; 
				String smtpPort = "587"; 
				String username = "joao.bruzetti@gmail.com";
				String password = "15022001";
				String auth     = "tls";  
				SendMail sendMail =  new SendMail( smtpHost,  smtpPort,  username,  password,  auth  );
					
				String mailFrom 	= "joao.bruzetti@gmail.com"; 
				String mailTo 		= email; 
				String mailSubject 	= "Cadastro"; 
				String mailBody 	= "Você criou uma conta no  nosso site, com o email: " + email + " e senha " + senha + ".Agora pode usufruir dos nossos recursos aproveite!!! Caso queria alterar sua senha pode fazer isso no nosso site."; 
				sendMail.send( mailFrom, mailTo, mailSubject, mailBody );
				
				saida = "{ \"Cad\": \"true\", \"Msg\": \"<h3> Usuario cadastrado com sucesso!!!</h3>\" }";

			}else{
				saida = "{ \"Cad\": \"false\"}";
			}
			out.write(saida);
		%>