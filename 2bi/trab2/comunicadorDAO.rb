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
          com.imagem = registro['imagem'].to_s     		
    	end
      dao = ProgramaDAO.new
      com.programas = dao.buscaCom(id_c)
    	com
    end

    def edita(com)
	  	rs = @con.exec_params("UPDATE comunicadores SET nome = $1 WHERE id_c = $2", [com.nome, com.id_c])
    end
    def editaImg(com)
      rs = @con.exec_params("UPDATE comunicadores SET nome = $1, imagem = $2 WHERE id_c = $3", [com.nome, com.imagem, com.id_c])
    end

    def adiciona(com)    	   
      puts com.nome
    	rs = @con.exec_params("INSERT INTO comunicadores (nome, imagem) VALUES ($1, $2) RETURNING id_c", [com.nome, com.imagem])
      rs.each do |registro|
        return registro['id_c']
      end
    end

    def lista
    	vetcom = []
    	rs = @con.exec "SELECT * FROM comunicadores"
    	rs.each do |registro|
      		com = Comunicador.new
      		com.id_c = registro['id_c'].to_i
      		com.nome = registro['nome'].to_s
          com.imagem = registro['imagem'].to_s
          dao = ProgramaDAO.new
          com.programas = dao.buscaCom(com.id_c)
      		vetcom.push(com)
    	end  
    	vetcom
    end

    def exclui(id_c)    	
    	@con.exec_params("DELETE FROM comunicadores WHERE id_c = $1", [id_c])
   	end

    def retImagem(id_c)
      rs = @con.exec_params("SELECT imagem FROM comunicadores WHERE id_c = $1", [id_c])
      rs.each do |registro|
        return registro['imagem']
      end
    end

    def retImagensProgramas(id_c) 
      rs = @con.exec_params("SELECT p.imagem AS imagem FROM programas p INNER JOIN comunicadores c ON (c.id_c = p.id_c) WHERE c.id_c = $1", [id_c])
      vet = []
      rs.each do |registro|
        vet.push(registro['imagem'])
      end
      return vet
    end

end	
	