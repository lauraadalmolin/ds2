require "data_mapper"
require "dm-migrations"

#para o código funcionar é necessário fazer o seguinte insert : "INSERT INTO usuarios VALUES (DEFAULT, 'administrador', 'admin', '1234')"

DataMapper.setup(:default, 'postgres://postgres:postgres@localhost/hogwarts2')

class Wand 
	include DataMapper::Resource
	property :id, Serial
	property :wood, String, :required => true
	property :flexibility, String, :required => true
	property :core, String, :required => true
	#has n, :anotacaos, :constraint => :destroy
end

class Usuario
	include DataMapper::Resource
	property :id, Serial
	property :login, String
	property :password, String
end

DataMapper.finalize
#DataMapper.auto_migrate!
#DataMapper.auto_upgrade!


# --- É preciso rodar esses inserts antes de utilizar o sistema pela primeira vez...
#

#INSERT INTO usuarios (login, password) VALUES ('admin', 'admin');


