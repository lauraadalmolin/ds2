require "pg"

class ContatoDAO

	def initialize		
    	@con = PG.connect :dbname => 'trabalho', :user => 'postgres', :password => 'postgres', :host => 'localhost'    
	end

	def salva (contato)
			if (validaTelefone(contato.telefones[0]) && validaNomeEndereco(contato.nome, contato.endereco) && validaExistencia(contato.cpf)) 
				@con.exec_params("INSERT INTO contatos (nome, cpf, endereco) VALUES ($1, $2, $3)", [contato.nome, contato.cpf, contato.endereco])
				@con.exec_params("INSERT INTO telefones (telefone, cpf) VALUES ($1, $2)", [contato.telefones[0], contato.cpf])
			else
				puts "Algum problema ocorreu ao tentar salvar o arquivo: \n-Nome curto demais;\n-Telefone inválido - formato aceito: (DD)NNNNNNNNN;\n-Contato já existente.\n"
			end
	end

	def buscaTodos 

		rs = @con.exec "SELECT * FROM contatos"
  		
		contatos = []
		rs.each do |registro|
      		nome = registro['nome'].to_s
      		cpf = registro['cpf'].to_s
      		endereco = registro['endereco'].to_s      
      		contato = Contato.new(nome, cpf, endereco)
      		contatos.push(contato)		
    	end 
    	
    	rs = @con.exec "SELECT * FROM telefones"

    	rs.each do |registro| 

    		telefone = registro['telefone'].to_s
    		cpf = registro['cpf'].to_s
    		i = 0
    		while i < contatos.length
    			if contatos[i].cpf == cpf
    				contatos[i].telefones.push(telefone)
    			end
    			i = i + 1
    		end
    	end

    	contatos
	end

	def listaLetra (letra)
		contatos = buscaTodos
		retorno = []
		i = 0
		while i < contatos.length
			if ((contatos[i].nome[0].downcase).eql?(letra.downcase))
				retorno.push(contatos[i])
			end
			i = i + 1
		end
		retorno
	end

	def exporta 
		if(File.exists?("contatos.html"))
			File.delete("contatos.html")
		end
		arq = File.new("contatos.html", "a+")
		contatos = buscaTodos
		arq.puts("<ul>")
		i = 0
		while i < contatos.length
			arq.puts("<li>Nome: " + contatos[i].nome + "<br>CPF: " + contatos[i].cpf +  "<br>Endereco:" + contatos[i].endereco +  "<br>Telefones: <ul>")
			j = 0
			while j < contatos[i].telefones.length
				arq.puts("<li>" + contatos[i].telefones[j] + "</li>")
				j = j + 1
			end
			arq.puts("</ul></li>")
			i = i + 1
		end
		arq.puts("</ul>")
		arq.close
	end


	def adicionaTelefone(cpf, telefone)
		contatos = buscaTodos
		posicao = -1
		i = 0
		while i  < contatos.length
			if (contatos[i].cpf.downcase.eql?(cpf.downcase))
				posicao = i
			end
			i = i +1
		end
		if posicao == -1
			return ("Não foi encontrado contato correspondente\n\n")
		end
		if validaTelefone(telefone)
			@con.exec_params("INSERT INTO telefones (telefone, cpf) VALUES ($1, $2)", [telefone, cpf])
		end
		return true
	end

	def edita (contato, cpf)
		exclui(cpf)
		salva(contato)
	end

	def excluiTelefone(cpf, telefone)
		@con.exec_params("DELETE FROM telefones WHERE telefone = $1 AND cpf = $2", [telefone, cpf])

	end

	def buscaContato(cpf)

		contatos = buscaTodos
		posicao = -1
		i = 0
		while i  < contatos.length
			if (contatos[i].cpf.downcase.eql?(cpf.downcase))
				posicao = i
			end
			i = i +1
		end
		if posicao == -1
			contatos.push("Não foi encontrado contato correspondente\n\n")
			posicao = contatos.size - 1
		end
		contatos[posicao]

	end

	def formata (contatos)
		printable = []
		i = 0 
		if (contatos == nil) 
			printable[0] = "-> Não há nenhum contato na agenda\n\n";
		else
			while i < contatos.length
				printable[i] = "Nome: " + contatos[i].nome + "\nCPF: " + contatos[i].cpf + "\nEndereco: " + contatos[i].endereco + "\nTelefones:";
				j = 0
				#puts contatos[i].telefones.length.to_s
				while (j < contatos[i].telefones.length)
					printable[i] = printable[i] + "\n- " + contatos[i].telefones[j];
					j = j + 1
				end 	
				printable[i] = printable[i] + "\n----------\n";
				i = i + 1
			end
		end
		printable
	end


	def lista
		contatos = buscaTodos
		contatos = self.formata (contatos)
		contatos
	end

	def exclui (cpf) 
		@con.exec_params("DELETE FROM contatos WHERE cpf = $1", [cpf])
		@con.exec_params("DELETE FROM telefones WHERE cpf = $1", [cpf])

	end


	def validaTelefone(telefone)
		tel = telefone.dup
		retorno = true
		
		if tel.length != 13
			retorno = false
		end
		if (!tel[0].eql?("(")) 
			retorno  = false
		end
		if !(tel[3].eql?(")"))
			retorno = false
		end

		tel.sub! ")", ""
		tel.sub! "(", ""

		j = 0

		while j < tel.length 
			if (tel[j] != "0" && tel[j] != "1" && tel[j] != "2" && tel[j] != "3" && tel[j] != "4" &&
			    tel[j] != "5" && tel[j] != "6" && tel[j] != "7" && tel[j] != "8" && tel[j] != "9")
			retorno = false
			end
			j =  j + 1
		end

		retorno
	end



	def validaNomeEndereco(nome, endereco)
		retorno = true
		if (nome.length < 3 || endereco.length > 100)
			retorno = false
		end
		retorno
	end

	def validaExistencia (cpf)
		contatos = buscaTodos
		retorno = true
		i = 0
		while i < contatos.length
			if (cpf.eql?(contatos[i].cpf))
				retorno = false
			end
			i = i + 1
		end
		
		retorno
	end

end