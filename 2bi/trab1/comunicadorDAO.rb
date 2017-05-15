require 'pg'
require './comunicador.rb'
require './programaDAO.rb'

class ComunicadorDAO
	  
    def initialize
		@con = PG.connect :dbname => 'radio_web', :user => 'postgres', :password => 'postgres', :host => 'localhost'
    end

    def busca(id_c)
    	rs = @con.exec_params("SELECT * FROM comunicadores WHERE id_c = $1", [id_c])
  		com = Comunicador.new
    	rs.each do |registro|
      		com.id_c = registro['id_c'].to_i
      		com.nome = registro['nome'].to_s      		
    	end
      dao = ProgramaDAO.new
      com.programas = dao.buscaCom(id_c)
    	com
    end

    def edita(com)
	  	rs = @con.exec_params("UPDATE comunicadores SET nome = $1 WHERE id_c = $2", [com.nome, com.id_c])
    end

    def adiciona(com)    	   
      puts com.nome
    	rs = @con.exec_params("INSERT INTO comunicadores (nome) VALUES ($1)", [com.nome])
    end

    def lista
    	vetcom = []
    	rs = @con.exec "SELECT * FROM comunicadores"
    	rs.each do |registro|
      		com = Comunicador.new
      		com.id_c = registro['id_c'].to_i
      		com.nome = registro['nome'].to_s
          dao = ProgramaDAO.new
          com.programas = dao.buscaCom(com.id_c)
      		vetcom.push(com)
    	end  
    	vetcom
    end

    def exclui(id_c)    	
    	@con.exec_params("DELETE FROM comunicadores WHERE id_c = $1", [id_c])
   	end
end	
	