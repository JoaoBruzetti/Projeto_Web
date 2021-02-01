<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.fabric.Response" %>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap" %>
<%@page import="classes.Usuario"%>
<%@page import="classes.Filme"%>
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
				
				String id_filme			= request.getParameter("id_filme");
				String nome 			= request.getParameter("nome");
				String sinopse 			= request.getParameter("sinopse");
				String faixa_etaria		= request.getParameter("faixa_etaria");
				String preco    		= request.getParameter("preco");
				
				int id_filme_int 		= Integer.valueOf(id_filme+"");
				int preco_int  			= Integer.valueOf(preco+"");
				
				Filme filme_altera = new Filme(id_filme_int, nome, sinopse, faixa_etaria,preco_int);
				filme_altera.save();
				
				saida = "{ \"Alt\": \"true\", \"Msg\": \"<h3> Dados Alterados com sucesso!!!</h3>\" }";

			}else{
				saida = "{ \"Alt\": \"false\"}";
			}
			out.write(saida);
	%>  