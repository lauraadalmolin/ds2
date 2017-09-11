
require "pg"

class AtendimentoDAO

	def initialize		
    	@con = PG.connect :dbname => 'trabalho', :user => 'postgres', :password => 'postgres', :host => 'localhost'    
	end

	def salva (atendimento)
			if (validaData(atendimento.data) && validaHora(atendimento.hora_inicio) && validaHora(atendimento.hora_termino) && validaProfessor(atendimento.professor)) 
				
				@con.exec_params("INSERT INTO atendimentos (data, hora_termino, hora_inicio, duvidas, professor, matricula, codigo) VALUES ($1, $2, $3, $4, $5, $6, DEFAULT)", [atendimento.data, atendimento.hora_termino, atendimento.hora_inicio, atendimento.duvidas, atendimento.professor, atendimento.aluno.matricula])
			else
				puts "\nUm erro ocorreu ao tentar salvar o atendimento.\n-As horas devem respeitar o seguinte formato: HH:MM;\n-A data deve respeitar o seguinte formato: DD/MM/AAAA;\n-O nome do professor deve conter ao menos 3 caracteres;\n"
			end
	end

	def listaTodos 

		rs = @con.exec "SELECT a.nome, a.matricula, ate.codigo, ate.data, ate.hora_inicio, ate.hora_termino, ate.duvidas, ate.professor  FROM atendimentos ate INNER JOIN alunos a ON (ate.matricula = a.matricula)"
  		
		atendimentos = []

		rs.each do |registro|
			stringona = "Nome: " + registro['nome'].to_s + "\nDúvidas: " + registro['duvidas'].to_s +  "\nMatrícula: " + registro['matricula'].to_s + "\nCódigo: " + registro['codigo'].to_s + "\nData: " + registro['data'].to_s + "\nHora início: " + registro['hora_inicio'].to_s + "\nHora término: " + registro['hora_termino'].to_s + "\nProfessor: " + registro['professor'].to_s   
      		stringona =  stringona + "\n----------\n"
      		atendimentos.push(stringona)		
    	end 
 	
		atendimentos
	end


	def exclui (codigo) 
		@con.exec_params("DELETE FROM atendimentos WHERE codigo = $1", [codigo])
	end

	def validaProfessor(nome)
		retorno = true
		if (nome.length < 3)
			retorno = false
		end
		retorno
	end

	def validaData(d)
		data = d.dup
		retorno = true
		
		if data.length != 10
			retorno = false
		end
		if (!data[2].eql?("/")) 
			retorno  = false
		end
		if !(data[5].eql?("/"))
			retorno = false
		end

		data.sub! "/", ""
		data.sub! "/", ""

		j = 0

		while j < data.length 
			if (data[j] != "0" && data[j] != "1" && data[j] != "2" && data[j] != "3" && data[j] != "4" &&
			    data[j] != "5" && data[j] != "6" && data[j] != "7" && data[j] != "8" && data[j] != "9")
			retorno = false
			end
			j =  j + 1
		end

		retorno
	end

	def validaHora(h)
		hora = h.dup
		retorno = true
		
		if hora.length != 5
			retorno = false
		end
		if (!hora[2].eql?(":")) 
			retorno  = false
		end

		hora.sub! ":", ""

		j = 0

		while j < hora.length 
			if (hora[j] != "0" && hora[j] != "1" && hora[j] != "2" && hora[j] != "3" && hora[j] != "4" &&
			    hora[j] != "5" && hora[j] != "6" && hora[j] != "7" && hora[j] != "8" && hora[j] != "9")
			retorno = false
			end
			j =  j + 1
		end

		retorno
	end


end