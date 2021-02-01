<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.fabric.Response" %>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap" %>
<%@page import="classes.Usuario"%>
<%@page import="classes.Filme"%>
<%@page import="classes.Aluga"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%
 
	int userLogin = 0; 
	
	userLogin = (int) session.getAttribute("userlogin");
	if ( ! (userLogin > 0 )){
		response.sendRedirect("index.html");
	}

		
			String acao					= request.getParameter("acao");
			String saida 				= "";
			
			if (acao != null) {
				
				String id_filme			= request.getParameter("id_filme");
				int ID_usuario  		= (int) session.getAttribute("userlogin");
				int id_aluga			=  0;
				String qtd_dias			= request.getParameter("qtd_dias");
				String preco			= request.getParameter("preco");
		
				int id_filme_int 		= Integer.valueOf(id_filme+"");
				int qtd_dias_int 		= Integer.valueOf(qtd_dias+"");
				int preco_int 			= Integer.valueOf(preco+"");
				int preco_total			= qtd_dias_int * preco_int;
				

				Aluga aluga  = new Aluga(id_aluga, ID_usuario, id_filme_int, qtd_dias_int, preco_total);
				aluga.save();
				
				saida = "{ \"Alt\": \"true\", \"Msg\": \"<h3>Filme Alugado com sucesso!!!</h3>\" }";

			}else{
				saida = "{ \"Alt\": \"false\"}";
			}
			out.write(saida);
	%>  