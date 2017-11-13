class Atendimento 
	attr_accessor :data, :hora_inicio, :hora_termino, :duvidas, :professor, :aluno, :codigo

	def initialize(data="", hora_termino="", hora_inicio="", duvidas="", professor="", aluno=nil, codigo=0)
		@data = data
		@hora_inicio = hora_inicio
		@hora_termino = hora_termino
		@duvidas = duvidas
		@professor = professor
		@aluno = aluno
		@codigo = codigo
	end

end