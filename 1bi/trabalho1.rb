class Contato
	attr_accessor :nome, :telefone, :cpf, :endereco
	def initialize(nome="", telefone="", cpf="", endereco="")
		@nome = nome
		@telefone = telefone
		@cpf = cpf
		@endereco = endereco
	end
end


class ContatoDAO

	def salva (contato)
		
			if (!File.exists?("contatos.csv"))
				arq = File.new("contatos.csv", "a+")
				arq.puts(contato.cpf + ";" + contato.nome + ";" + contato.telefone + ";" + contato.endereco + ";\n")
				arq.close
			else
				if (validaTelefone(contato.telefone) && validaNomeEndereco(contato.nome, contato.endereco) && validaExistencia(contato.cpf)) 
					arq = File.open("contatos.csv", "a+")
					arq.puts(contato.cpf + ";" + contato.nome + ";" + contato.telefone + ";" + contato.endereco + ";\n")
					arq.close
				else
					puts "Algum problema ocorreu ao tentar salvar o arquivo: \n-Nome curto demais;\n-Telefone inválido - formato aceito: (DD)NNNNNNNNN;\n-Contato já existente.\n"
				end
			end
		
	end

	def edita (contato, cpf)
		exclui(cpf)
		salva(contato)
	end

	def lista
		contatos = buscaTodos
		contatos = formata (contatos)
		contatos
	end

	def formata (contatos)
		printable = []
		i = 0 
		if (contatos == nil) 
			printable[0] = "-> Não há nenhum contato na agenda\n\n";
		else
			while i < contatos.length
				printable[i] = "Nome: " + contatos[i].nome + "\nTelefone: " + contatos[i].telefone + "\nCPF: " + contatos[i].cpf + "\nEndereco: " + contatos[i].endereco + "\n----------\n"
				i = i + 1
			end
		end
		printable
	end
	
	def exclui (cpf) 
		contatos = buscaTodos
		i = 0
		while i < contatos.length
			if (contatos[i].cpf.eql?(cpf))
				contatos[i] = 2
			end
			i = i + 1
		end
		File.delete("contatos.csv")
		j = 0
		while j < contatos.length
			if (contatos[j] != 2)
				salva(contatos[j])
				
			end
			j = j + 1
		end
		true
	end
	
	def exporta 
		if(File.exists?("contatos.html"))
			File.delete("contatos.html")
		end
		arq = File.new("contatos.html", "a+")
		contatos = buscaTodos
		arq.puts("<table style='border: 1px solid; border-collapse: collapse;'>\n")
		i = 0
		while i < contatos.length
			arq.puts("<tr style='border-collapse: collapse;'><td style='border: 1px solid; border-collapse: collapse;'>" + contatos[i].nome + "</td><td style='border: 1px solid;  border-collapse: collapse;'>" + contatos[i].telefone +  "</td><td style='border: 1px solid; border-collapse: collapse;'>" + contatos[i].endereco +  "</td><td style='border: 1px solid; border-collapse: collapse;'>" + contatos[i].cpf + "</td></tr>\n")
			i = i + 1
		end
		arq.puts("</table>")
		arq.close
	end
	
	def listaLetra (letra)
		contatos = buscaTodos
		retorno = []
		i = 0
		while i < contatos.length
			if ((contatos[i].nome[0].downcase).eql?(letra))
				retorno.push(contatos[i])
			end
			i = i + 1
		end
		retorno
	end
	
	def buscaTodos 
		contatos = []
		if (File.exists?("contatos.csv"))
			a = IO.readlines("contatos.csv")
			i = 0
			while i < a.length
				contato  = Contato.new
				linha = a[i]
				elementos = linha.split(";")
				contato.cpf = elementos[0]
				contato.nome = elementos[1]
				contato.telefone = elementos[2]
				contato.endereco =  elementos[3]
				contatos.push(contato)
				i = i + 1
			end
			contatos
		end

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

# open, new, puts, close, delete
sair = false
while sair == false
	print "--- Menu --- \n\n1-Novo contato\n2-Editar contato\n3-Excluir contato\n4-Listar contatos\n5-Exportar contatos\n6-Listar todos os contatos com determinada letra inicial\n7-Sair\n" +
		  "\n------------ \n\nDigite o número correspondente à opção desejada: \n"
	opcao = gets.chomp.to_i

	dao = ContatoDAO.new


	case opcao 
	when 1
		print "\nDigite o nome do contato\n-> "
		nome = gets.chomp
		print "Digite o telefone do contato\n-> "
		telefone = gets.chomp
		print "Digite o cpf do contato\n-> " 
		cpf = gets.chomp
		print "Digite o endereco do contato\n-> "
		endereco = gets.chomp
		contato = Contato.new(nome, telefone, cpf, endereco)
		dao.salva(contato)
		puts "\n"
	when 2
		puts "\nContatos\n----------\n"
		imprimir = dao.lista
		i = 0
		while i  < imprimir.length
			puts imprimir[i]
			i = i + 1		
		end
		contatos = dao.buscaTodos
		if (contatos != nil)
			print "\nDigite o cpf do contato a ser editado\n-> "
			cpf = gets.chomp
			contato = dao.buscaContato(cpf)
			if (contato.class != Contato)
				print contato
			else
				print "----------\nNome: " + contato.nome + "\nTelefone: " + contato.telefone + "\nCPF: " + contato.cpf + "\nEndereco: " + contato.endereco + "\n----------"
				puts "\nVocê pode editar uma informação por vez:\n1)Nome;\n2)Telefone;\n3)Endereço;\n4)CPF.\n-> Digite a informação que desejas editar:"
				op = gets.chomp.to_i
				print "\nDigite a nova informação\n-> "
				info = gets.chomp
				print "\n"
				case op
				when 1
					contato.nome = info
				when 2
					contato.telefone = info
				when 3 
					contato.endereco = info
				when 4
					contato.cpf = info
				end
		
				dao.edita(contato, cpf)
			end
		end
	when 3
		puts "\nContatos\n----------\n"
		imprimir = dao.lista
		i = 0
		while i  < imprimir.length
			puts imprimir[i]
			i = i + 1		
		end
		puts "\n"
		contatos = dao.buscaTodos
		if (contatos != nil)
			print "Digite o cpf do contato a ser excluído\n-> "
			cpf = gets.chomp
			teste = dao.exclui(cpf)
			if (teste) 
				puts "\nO contato foi excluído com sucesso.\n"
			end
		end
	when 4
		puts "\nContatos\n----------\n"
		imprimir = dao.lista
		i = 0
		while i  < imprimir.length
			puts imprimir[i]
			i = i + 1		
		end
		puts "\n"
	when 5		
		contatos = dao.buscaTodos
		if (contatos != nil)
			puts "Exportando os contatos para um arquivo HTML...\n"
			dao.exporta;
			puts "Feito!\n\n";
		else 
			puts "Não há nenhum contato na agenda.\n"
		end
	when 6
		contatos = dao.buscaTodos
		if (contatos != nil)
			print "\nDigite a letra para pesquisar\n-> "
			letra = gets.chomp
			puts "\n"
			if (letra.length != 1)
				puts "Você deve informar apenas uma letra!"
			else
				imprimir = dao.formata(dao.listaLetra(letra))
				if imprimir.length == 0 
					print("Não foi encontrado nenhum contato que comece com a letra informada.\n\n")
				else 
					puts "Contatos\n----------\n"
					i = 0
					while i < imprimir.length
						puts imprimir[i]
						i = i + 1
					end
					puts "\n"
				end
			end
		else
			puts "\nNão há nenhum contato na agenda.\n"
		end
	when 7
		sair = true
	else
		puts "Opção inválida"
	end
end
	# puts contato.nome + " " + contato.telefone

