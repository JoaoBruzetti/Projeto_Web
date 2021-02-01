package classes;

import java.sql.ResultSet;
import java.sql.SQLException;

import database.DBQuery;
import multitool.RandomCode;

public class Usuario {
	private int	   	ID_usuario;
	private int 	Nivel_usuario;
	private String 	nome;
	private String 	senha;
	private String 	tel;
	private String 	cpf;
	private String 	email;

	
	private String tableName	= "locadora.usuario"; 
	private String fieldsName	= "ID_usuario, Nivel_usuario, nome, senha, tel, cpf, email";  
	private String fieldKey		= "ID_usuario";
	
	private DBQuery dbQuery = new DBQuery(tableName, fieldsName, fieldKey);
	

	public Usuario( int ID_usuario, int Nivel_usuario, String nome, String senha, String tel, String cpf, String email) {
		this.setIDusuario(ID_usuario);
		this.setNivelUsuario(Nivel_usuario);
		this.setNome(nome);
		this.setSenha(senha);
		this.setTel(tel);
		this.setCpf(cpf);
		this.setEmail(email);	
	}
	
	public Usuario( String ID_usuario, int Nivel_usuario, String nome, String senha, String tel, String cpf, String email) {
		this.setIDusuario(((ID_usuario == null)?0:Integer.valueOf(ID_usuario)));
		this.setNivelUsuario(Nivel_usuario);
		this.setNome(nome);
		this.setSenha(senha);
		this.setTel(tel);
		this.setCpf(cpf);
		this.setEmail(email);
	}
	
	public Usuario(String nome, String senha, String email) {
		this.setIDusuario(0);
		this.setNome(nome);
		this.setSenha(senha);
		this.setEmail(email);
		this.setNivelUsuario(0);

	}
	
	public Usuario(String email) {
		this.setIDusuario(0);
		this.setEmail(email);
	}
	
	public Usuario(int ID_usuario) {
		this.setIDusuario(ID_usuario);
	}
	
	public String toString() {
		return(
				this.getIDusuario() + ""+" | "+
				this.getNivelUsuario() + ""+" | "+
				this.getNome()+" | "+
				this.getTel()+" | "+
				this.getCpf()+" | "+
				this.getEmail()+" | "+
				"********"+" | "
		);
	}
	
	private String[] toArray() {
		
		String[] temp =  new String[] {
				this.getIDusuario() + "",
				this.getNivelUsuario() + "",
				this.getNome(),
				this.getSenha(),
				this.getTel(),
				this.getCpf(),
				this.getEmail(),
		};
		return(temp);
	}
	
	public void save() {
		if( this.getIDusuario() > 0 ) {
			this.dbQuery.update(this.toArray());
		}else {
			this.dbQuery.insert(this.toArray());
		}
	}
	
	public void delete() {
		if( this.getNivelUsuario() > 0 ) {
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
	
	public String newPassword() {
		
		if (this.getEmail() != "" && this.getEmail()!= null) {
			if ( this.getIDusuario() > 0 ) {
				try {
					ResultSet resultset = this.select(" email ='"+this.getEmail()+"'");
					boolean existe = resultset.next();
					if ( existe ) {
						this.setSenha(  new RandomCode().generate(32) );
						this.save();
						return( this.getSenha());
					}
					resultset.getInt("idUsuario");
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
			} else {
				this.setSenha(  new RandomCode().generate(32));
				return(  this.getSenha() );
			}
		} else {
			// Sem email nÃo deve gerar senha
		}
		return this.getSenha(); 
	}

	public boolean checkLogin() {
		int id = 0;
		try {
			ResultSet resultSet = this.select(" email='"+ this.getEmail()+ "' AND senha = '"+this.getSenha()+"'");
			while (resultSet.next()) {
				System.out.println( "\n"+resultSet.getString("nome"));
				id = resultSet.getInt("ID_usuario");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		this.setIDusuario(id);
		return(id > 0);	
	}
	
	public void loadById(int ID_usuario) {
		int Nivel = 0;
		String nome = "", tel = "", cpf = "";
		try {
			ResultSet resultSet = this.selectBy("ID_usuario", ""+ID_usuario);
			while (resultSet.next()) {
				Nivel 		= resultSet.getInt("NivelUsuario");
				nome 			= resultSet.getString("nome");
				tel 		= resultSet.getString("tel");
				cpf 			= resultSet.getString("cpf");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		this.setNivelUsuario(Nivel);
		this.setNome(nome);
		this.setCpf(cpf);
		this.setTel(tel);
	}
	
	public int getIDusuario() {
		return ID_usuario;
	}

	public void setIDusuario(int ID_usuario) {
		this.ID_usuario = ID_usuario;
	}
	
	public int getNivelUsuario() {
		return Nivel_usuario;
	}

	public void setNivelUsuario(int Nivel_usuario) {
		this.Nivel_usuario = Nivel_usuario;
	}
	
	public void setNivelUsuario(String Nivel_usuario) {
		this.Nivel_usuario = ((Nivel_usuario == "") ? 0 : Integer.parseInt(Nivel_usuario));
	}

	
	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}
	
	public String getCpf() {
		return cpf;
	}

	public void setCpf(String cpf) {
		this.cpf = cpf;
	}
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

}
