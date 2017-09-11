require "data_mapper"
require "dm-migrations"

#para o código funcionar é necessário fazer o seguinte insert : "INSERT INTO usuarios VALUES (DEFAULT, 'administrador', 'admin', '1234')"

DataMapper.setup(:default, 'postgres://postgres:postgres@localhost/googlekeep')

class Usuario 
	include DataMapper::Resource
	property :id, Serial
	property :nome, String
	property :login, String
	property :senha, String
	has n, :anotacaos, :constraint => :destroy
end

class Anotacao
	include DataMapper::Resource
	storage_names[:default] = 'anotacoes'
	property :id, Serial
	property :titulo, String
	property :descricao, Text
	property :dataHora, DateTime
	belongs_to :usuario
end

DataMapper.finalize
#DataMapper.auto_migrate!
#DataMapper.auto_upgrade!

