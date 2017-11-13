class Contato
	attr_accessor :nome, :telefones, :cpf, :endereco

	def initialize(nome="", cpf="", endereco="", telefones=[])
		@nome = nome
		@telefones = telefones
		@cpf = cpf
		@endereco = endereco
	end

	def addTelefone(telefone) 
		@telefones.push(telefone)
	end


end