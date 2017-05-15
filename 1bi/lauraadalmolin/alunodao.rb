require "pg"

class AlunoDAO

	def initialize		
    	@con = PG.connect :dbname => 'trabalho', :user => 'postgres', :password => 'postgres', :host => 'localhost'    
	end

	def salva (aluno)
			if (validaNome(aluno.nome)) 
				@con.exec_params("INSERT INTO alunos (nome, matricula) VALUES ($1, DEFAULT)", [aluno.nome])
			else
				puts "\nNome curto demais: O nome deve conter no mínimo 3 caracteres;\n"
			end
	end

	def buscaTodos 

		rs = @con.exec "SELECT * FROM alunos"
  		
		alunos = []
		rs.each do |registro|
      		nome = registro['nome'].to_s
       		matricula = registro['matricula'].to_i   
      		aluno = Aluno.new(nome, matricula)
      		alunos.push(aluno)		
    	end 
 
    	alunos
	end


	def edita (aluno, cpf)
		exclui(cpf)
		salva(aluno)
	end

	def buscaAluno(matricula)

		alunos = buscaTodos
		posicao = -1
		i = 0
		while i  < alunos.length
			if (alunos[i].matricula.eql?(matricula))
				posicao = i
			end
			i = i +1
		end
		if posicao == -1
			return nil
		end
		alunos[posicao]

	end

	def formata (alunos)
		printable = []
		i = 0 
		if (alunos == nil) 
			printable[0] = "-> Não há nenhum aluno na agenda\n\n";
		else

			while i < alunos.length
				printable[i] = "Nome: " + alunos[i].nome + "\nMatrícula: " + alunos[i].matricula.to_s + "\n----------\n";
				i = i + 1
			end
		end
		printable
	end


	def lista
		alunos = buscaTodos
		alunos = self.formata (alunos)
		alunos
	end

	def exclui (matricula) 
		@con.exec_params("DELETE FROM alunos WHERE matricula = $1", [matricula])
		@con.exec_params("DELETE FROM atendimentos WHERE matricula = $1", [matricula])
	end

	def validaNome(nome)
		retorno = true
		if (nome.length < 3)
			retorno = false
		end
		retorno
	end


end