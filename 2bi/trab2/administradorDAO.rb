
require 'pg'
require './administradorDAO.rb'

class AdministradorDAO
	  
    def initialize
		@con = PG.connect :dbname => 'radio_web', :user => 'postgres', :password => 'postgres', :host => 'localhost'
    end

    def verifica(login, senha)
    	rs = @con.exec_params("SELECT * FROM administradores WHERE login = $1 AND senha = $2", [login, senha])
  		rs.each do |registro|
      		return true		
    	end
      return false
    end

    
end	
	