package classes;

import java.sql.ResultSet;
import java.sql.SQLException;

import database.DBQuery;

public class Filme {
	private int	   	id_filme;
	private String 	nome;
	private String 	sinopse;
	private String 	faixa_etaria;
	private int 	preco;
	
	private String tableName	= "locadora.filme"; 
	private String fieldsName	= "id_filme, nome, sinopse, faixa_etaria, preco";  
	private String fieldKey		= "id_filme";
	
	private DBQuery dbQuery = new DBQuery(tableName, fieldsName, fieldKey);
	

	public Filme( int id_filme, String nome, String sinopse, String faixa_etaria,  int preco) {
		this.setIDfilme(id_filme);
		this.setNome(nome);
		this.setSinopse(sinopse);
		this.setFaixaEtaria(faixa_etaria);		
		this.setPreco(preco);
	}
	
	public Filme( String id_filme, String nome, String sinopse, String faixa_etaria,int preco) {
		this.setIDfilme(((id_filme == null)?0:Integer.valueOf(id_filme)));
		this.setNome(nome);
		this.setSinopse(sinopse);
		this.setFaixaEtaria(faixa_etaria);
		this.setPreco(preco);
		
	}
	
	public Filme(int id_filme) {
		this.setIDfilme(id_filme);
	}
	
	public String toString() {
		return(
				this.getIDfilme() + ""+" | "+
				this.getNome()+" | "+
				this.getSinopse()+" | "+
				this.getFaixaEtaria()+" | "+
				this.getPreco() + ""+" | "
		);
	}
	
	private String[] toArray() {
		
		String[] temp =  new String[] {
				this.getIDfilme() + "",
				this.getNome(),
				this.getSinopse(),
				this.getFaixaEtaria(),
				this.getPreco() + "",
		};
		return(temp);
	}
	
	public void save() {
		if( this.getIDfilme() > 0 ) {
			this.dbQuery.update(this.toArray());
		}else {
			this.dbQuery.insert(this.toArray());
		}
	}
	
	public void delete() {
		if( this.getIDfilme() > 0 ) {
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
	
	public void loadById(int ID_filme) {
		int preco = 0;
		String nome = "", sinopse = "", faixa_etaria = "";
		try {
			ResultSet resultSet = this.selectBy("ID_filme", ""+ID_filme);
			while (resultSet.next()) {
				nome 			= resultSet.getString("nome");
				sinopse 		= resultSet.getString("sinopse");
				faixa_etaria 	= resultSet.getString("faixa_etaria");
				preco 			= resultSet.getInt("preco");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		this.setNome(nome);
		this.setSinopse(sinopse);
		this.setFaixaEtaria(faixa_etaria);
		this.setPreco(preco);
		
	}
	
	public int getIDfilme() {
		return id_filme;
	}

	public void setIDfilme(int id_filme) {
		this.id_filme = id_filme;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getSinopse() {
		return sinopse;
	}

	public void setSinopse(String sinopse) {
		this.sinopse = sinopse;
	}

	public String getFaixaEtaria() {
		return faixa_etaria;
	}

	public void setFaixaEtaria(String faixa_etaria) {
		this.faixa_etaria = faixa_etaria;
	}
	
	public int getPreco() {
		return preco;
	}

	public void setPreco(int preco) {
		this.preco = preco;
	}
	
	public void setPreco(String preco) {
		this.preco = ((preco == "") ? 0 : Integer.parseInt(preco));
	}

}
