require 'data_mapper' 
require 'dm-migrations'

#IMPORTANTE: criar o database antes de executar o código


#equivalente ao PG.connect

# DataMapper::Logger.new(STDOUT, :debug)
DataMapper.setup(:default, "postgres://postgres:postgres@localhost/bar")
# "<SGBD>://<USER>:<PASSWORD>@<HOST>/<DATABASE>"


class Cliente
	#cria os atributos e ao mesmo tempo configura o CREATE TABLE
	include DataMapper::Resource
	property :idCliente, Serial
	property :cpf, String
	property :nome, String
	property :comandaAberta, Boolean
	# demais atributos caso exista
	#....
	# relacionamentos
	has n, :comandas , :constraint => :destroy
end

class Garcom
	include DataMapper::Resource
	property :idGarcom, Serial
	property :cpf, String
	property :nome, String
	property :dataIngresso, Date
	property :dataDesligamento, Date
	# relacionamentos
	has n, :comandas, :constraint => :destroy

end

class Comanda 
	include DataMapper::Resource
	property :encerrada, Boolean
	property :idComanda, Serial
	property :dataAbertura, DateTime
	property :dataEncerramento, DateTime
	belongs_to :garcom
	belongs_to :cliente
	has n, :produtos, :through => Resource
end

class Produto
	include DataMapper::Resource
	property :idProduto, Serial
	property :preco, Float
	property :descricao, String
	has n, :comandas, :through => Resource

end


# class Aluno
#    belongs_to
# end


# finaliza as declarações de atributo
DataMapper.finalize



# migrate e upgrade convertem os modelos para sql e ambos criam a tabela sozinhos


#migrate da drop na tabela caso tenha alguma mudança nos atributos do modelo e cria uma nova


#DataMapper.auto_migrate!

#upgrade faz a mesma coisa que o migrate porém não exclui
#as tabelas antigas quando há mudança, só as atualiza
#DataMapper.auto_upgrade!