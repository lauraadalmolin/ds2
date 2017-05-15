class Animal
	attr_accessor :id, :nome, :especie
	def to_s
		@id.to_s + ";" + @especie + ";" + @nome
	end
end