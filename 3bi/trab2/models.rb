require "data_mapper"
require "dm-migrations"

	DataMapper.setup(:default, 'postgres://postgres:postgres@localhost/marvel')

class Heroi 
	include DataMapper::Resource
	property :id, Serial
	property :nome, String, :required => true
	property :nomeVerdadeiro, String, :required => true
	property :type, Discriminator
	belongs_to :equipe
	has n, :habilidades, :through => Resource
end

class Habilidade
	include DataMapper::Resource
	property :id, Serial
	property :nome, String
	property :nivelImpacto, String
	property :descricao, String, :length => 10..1000
	has n, :herois, :through => Resource
end

class Equipe
	include DataMapper::Resource
	property :id, Serial
	property :nome, String 
	has n, :herois, :constraint => :destroy
end

class Extraterrestre < Heroi

end

class Terrestre < Heroi

end

DataMapper.finalize
DataMapper.auto_migrate!
DataMapper.auto_upgrade!