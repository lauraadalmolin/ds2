require 'pg'
require './programa.rb'

class ProgramaDAO
	  
    def initialize
		@con = PG.connect :dbname => 'radio_web', :user => 'postgres', :password => 'postgres', :host => 'localhost'
    end

    def busca(id_p)
    	rs = @con.exec_params("SELECT * FROM programas WHERE id_p = $1", [id_p])
  		pro = Programa.new
    	rs.each do |registro|
          pro.id_c = registro['id_c'].to_i
          pro.id_p = registro['id_p'].to_i
          pro.nome = registro['nome'].to_s          
          pro.duracao = registro['duracao'].to_i          
          pro.dias_da_semana = registro['dias_da_semana'].to_s          
          pro.hora_inicio = registro['hora_inicio'].to_i         
          pro.hora_fim = registro['hora_fim'].to_i  		
    	end 
    	pro
    end

    def buscaCom(id_c)
      rs = @con.exec_params("SELECT * FROM programas WHERE id_c = $1", [id_c])
      vetpro = []
      rs.each do |registro|
          pro = Programa.new
          pro.id_c = registro['id_c'].to_i
          pro.id_p = registro['id_p'].to_i
          pro.nome = registro['nome'].to_s          
          pro.duracao = registro['duracao'].to_i          
          pro.dias_da_semana = registro['dias_da_semana'].to_s          
          pro.hora_inicio = registro['hora_inicio'].to_i         
          pro.hora_fim = registro['hora_fim'].to_i
          vetpro.push(pro)      
      end 
      vetpro
    end

    def edita(pro)
	  	rs = @con.exec_params("UPDATE programas SET nome = $1, duracao = $2, dias_da_semana = $3, hora_inicio = $4, hora_fim = $5  WHERE id_p = $6", [pro.nome, pro.duracao, pro.dias_da_semana, pro.hora_inicio, pro.hora_fim, pro.id_p])
    end

    def adiciona(pro)    	   
      puts pro.nome
    	rs = @con.exec_params("INSERT INTO programas (id_c, nome, duracao, dias_da_semana, hora_inicio, hora_fim) VALUES ($1, $2, $3, $4, $5, $6)", [pro.id_c, pro.nome, pro.duracao, pro.dias_da_semana, pro.hora_inicio, pro.hora_fim])
    end

    def lista
    	vetpro = []
    	rs = @con.exec "SELECT * FROM programas"
    	rs.each do |registro|
      		pro = Programa.new
      		pro.id_c = registro['id_c'].to_i
          pro.id_p = registro['id_p'].to_i
          pro.nome = registro['nome'].to_s          
          pro.duracao = registro['duracao'].to_i          
          pro.dias_da_semana = registro['dias_da_semana'].to_s          
          pro.hora_inicio = registro['hora_inicio'].to_i         
          pro.hora_fim = registro['hora_fim'].to_i
      		vetpro.push(pro)
    	end  
    	vetpro
    end

    def exclui(id_p)    	
    	@con.exec_params("DELETE FROM programas WHERE id_p = $1", [id_p])
   	end
end	
	