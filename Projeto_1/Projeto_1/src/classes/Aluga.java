package classes;

import java.sql.ResultSet;
import java.sql.SQLException;

import database.DBQuery;

public class Aluga {
	private int	   	id_aluga;
	private int	   	id_usuario;
	private int	   	id_filme;
	private int	   	qtd_dias;
	private int	   	preco_total;

	
	private String tableName	= "locadora.aluga"; 
	private String fieldsName	= "id_aluga, id_usuario, id_filme, qtd_dias, preco_total";  
	private String fieldKey		= "id_aluga";
	
	private DBQuery dbQuery = new DBQuery(tableName, fieldsName, fieldKey);
	

	public Aluga( int id_aluga, int id_usuario, int id_filme, int qtd_dias, int preco_total ) {
		this.setIDaluga(id_aluga);
		this.setIDusuario(id_usuario);
		this.setID_filme(id_filme);
		this.setQtd(qtd_dias);
		this.setPrecoTot(preco_total);	
	}
	
	public Aluga( String id_aluga, int id_usuario, int id_filme, int qtd_dias, int preco_total ) {
		this.setIDaluga(((id_aluga == null)?0:Integer.valueOf(id_aluga)));
		this.setIDusuario(id_usuario);
		this.setID_filme(id_filme);
		this.setQtd(qtd_dias);
		this.setPrecoTot(preco_total);
	}
	
	public Aluga(int id_aluga) {
		this.setIDaluga(id_aluga);
	}
	
	public String toString() {
		return(
				this.getIDaluga() + ""+" | "+
				this.getIDusuario() + ""+" | "+
				this.getIDfilme()+" | "+
				this.getQtd()+" | "+
				this.getPrecoTot()+" | "
		);
	}
	
	private String[] toArray() {
		
		String[] temp =  new String[] {
				this.getIDaluga() + "",
				this.getIDusuario() + "",
				this.getIDfilme() + "",
				this.getQtd() + "",
				this.getPrecoTot() + "",
		};
		return(temp);
	}
	
	public void save() {
		if( this.getIDaluga() > 0 ) {
			this.dbQuery.update(this.toArray());
		}else {
			this.dbQuery.insert(this.toArray());
		}
	}
	
	public void delete() {
		if( this.getIDaluga() > 0 ) {
			this.dbQuery.delete(this.toArray());
		}
	}
	
	public ResultSet selectAll() {
		ResultSet resultset = this.dbQuery.select("");
		return(resultset);
	}
	
	public ResultSet selectBy( String field, String value ) {
		ResultSet resultset = this.dbQuery.select( " "+field+"='"+value+"'");
		return(resultset);
	}
	
	public ResultSet select( String where ) {
		ResultSet resultset = this.dbQuery.select(where);
		return(resultset);
	}
	
	public void loadById(int idUsuario) {
		int Nivel = 0, id_filme = 0, qtd_dias = 0 ,preco_total = 0;
		try {
			ResultSet resultSet = this.selectBy("idUsuario", ""+idUsuario);
			while (resultSet.next()) {
				Nivel 		= resultSet.getInt("NivelUsuario");
				id_filme 	= resultSet.getInt("id_filme");
				qtd_dias 	= resultSet.getInt("qtd_dias");
				preco_total = resultSet.getInt("preco_total");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		this.setIDusuario(Nivel);
		this.setID_filme(id_filme);
		this.setPrecoTot(preco_total);
		this.setQtd(qtd_dias);
	}
	
	public int getIDaluga() {
		return id_aluga;
	}

	public void setIDaluga(int id_aluga) {
		this.id_aluga = id_aluga;
	}

	public int getIDusuario() {
		return id_usuario;
	}

	public void setIDusuario(int id_usuario) {
		this.id_usuario = id_usuario;
	}
	
	public void setIDusuario(String id_usuario) {
		this.id_usuario = ((id_usuario == "") ? 0 : Integer.parseInt(id_usuario));
	}

	public int getIDfilme() {
		return id_filme;
	}

	public void setID_filme(int id_filme) {
		this.id_filme = id_filme;
	}
	
	public int getQtd() {
		return qtd_dias;
	}

	public void setQtd(int qtd_dias) {
		this.qtd_dias = qtd_dias;
	}

	public int getPrecoTot() {
		return preco_total;
	}

	public void setPrecoTot(int preco_total) {
		this.preco_total =preco_total;
	}	

}
