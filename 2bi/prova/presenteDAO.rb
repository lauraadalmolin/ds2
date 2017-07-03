require 'pg'
require './presente.rb'

class PresenteDAO
	  
    def initialize
      @con = PG.connect :dbname => 'presentes', :user => 'postgres', :password => 'postgres', :host => 'localhost'
    end

    def editaImg(pre)
      rs = @con.exec_params("UPDATE lpresentes SET nome = $1, preco = $2, imagem = $3 WHERE id = $4", [pre.nome, pre.preco, pre.imagem, pre.id])
    end

    def adiciona(pre)    	   
      puts pre.nome
    	rs = @con.exec_params("INSERT INTO lpresentes (nome, imagem, preco) VALUES ($1, $2, $3) RETURNING id", [pre.nome, pre.imagem, pre.preco])
      rs.each do |registro|
        return registro['id']
      end
    end

    def lista
      vetpre = []
      rs = @con.exec "SELECT * FROM lpresentes"
      rs.each do |registro|
          pre = Presente.new
          pre.id = registro['id'].to_i
          pre.preco = registro['preco'].to_i
          pre.nome = registro['nome'].to_s
          pre.imagem = registro['imagem'].to_s
          vetpre.push(pre)
      end  
      vetpre
    end

    def retImagem(id)
      rs = @con.exec_params("SELECT imagem FROM lpresentes WHERE id = $1", [id])
      rs.each do |registro|
        return registro['imagem']
      end
    end

    def exclui(id)     
      @con.exec_params("DELETE FROM lpresentes WHERE id = $1", [id])
    end

    def busca()
          ret = ""
          rs = @con.exec "SELECT * FROM lpresentes ORDER BY id DESC LIMIT 3"
          rs.each do |registro|
              pre = Presente.new         
              pre.nome = registro['nome'].to_s        
              ret = ret + pre.nome + " | "
          end  
          ret
    end

    def bmax()
        ret = ""
          rs = @con.exec "SELECT MAX(preco) as max FROM lpresentes"
          rs.each do |registro|
              ret = registro['max']
          end  
        ret
    end

    def bmin()
         ret = ""
          rs = @con.exec "SELECT MIN(preco) as min FROM lpresentes"
          rs.each do |registro|
              ret = registro['min']
          end  
        ret
    end

    def bavg()
        ret = ""
          rs = @con.exec "SELECT AVG(preco) as avg FROM lpresentes"
          rs.each do |registro|
              ret = registro['avg']
          end  
        ret
    end
   
end	
