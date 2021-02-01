<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.fabric.Response" %>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap" %>
<%@page import="classes.Usuario"%>
<%@page import="classes.Filme"%>
<%@page import="multitool.RandomCode"%>
<%@page import="mail.SendMail"%>
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
		
			String acao				= request.getParameter("acao");
			String saida			= "";
			if (acao != null) {
				int id_filme			= 0;
				String nome				= request.getParameter("nome");
				String sinopse 			= request.getParameter("sinopse");
				String faixa_etaria		= request.getParameter("faixa_etaria");
				String preco			= request.getParameter("preco");
				int  preco_int  		= Integer.valueOf(preco);
				Filme filme = new Filme(id_filme, nome, sinopse, faixa_etaria, preco_int);
				filme.save();
				
				saida = "{ \"Cad\": \"true\", \"Msg\": \"<h3> Filme cadastrado com sucesso!!! </h3>\" }";

			}else{
				saida = "{ \"Cad\": \"false\"}";
			}
			out.write(saida);
			
		%>
		