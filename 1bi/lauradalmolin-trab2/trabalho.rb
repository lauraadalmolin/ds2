require "./contato.rb"
require "./contatoDAO.rb"

# open, new, puts, close, delete
sair = false
while sair == false
	print "--- Menu --- \n\n1-Novo contato\n2-Editar contato\n3-Excluir contato\n4-Listar contatos\n5-Exportar contatos\n6-Listar todos os contatos com determinada letra inicial\n7-Adicionar um telefone\n8-Excluir um telefone específico\n9-Sair\n" +
		  "\n------------ \n\nDigite o número correspondente à opção desejada: \n"
	opcao = gets.chomp.to_i

	dao = ContatoDAO.new


	case opcao 
	when 1
		print "\nDigite o nome do contato\n-> "
		nome = gets.chomp
		print "Digite o telefone do contato\n-> "
		telefones = []
		telefones[0] = gets.chomp
		puts telefones[0]
		print "Digite o cpf do contato\n-> " 
		cpf = gets.chomp
		print "Digite o endereco do contato\n-> "
		endereco = gets.chomp
		contato = Contato.new(nome, cpf, endereco, telefones)
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
			contatos = []
			contato = dao.buscaContato(cpf)
			contatos[0] = contato 
			if (contato.class != Contato)
				print contato
			else
				printable = dao.formata(contatos)
				puts printable
				puts "\nVocê pode editar uma informação por vez:\n1)Nome;\n2)Algum telefone;\n3)Endereço;\n4)CPF.\n-> Digite a informação que desejas editar:"
				op = gets.chomp.to_i
				
				case op
				when 1
					print "\nDigite a nova informação\n-> "
					info = gets.chomp
					print "\n"
					contato.nome = info
				when 2
					puts "Digite o telefone a ser alterado"
					telefone = gets.chomp
					puts "Digite o novo telefone"
					novo = gets.chomp
					j = 0
					while j < contato.telefones.length
						if (contato.telefones[j].eql?(telefone))
							contato.telefones[j] =  novo
						end
						j = j + 1
					end

				when 3 
					print "\nDigite a nova informação\n-> "
					info = gets.chomp
					print "\n"
					contato.endereco = info
				when 4
					print "\nDigite a nova informação\n-> "
					info = gets.chomp
					print "\n"
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
		puts "\nContatos\n----------\n"
		imprimir = dao.lista
		i = 0
		while i  < imprimir.length
			puts imprimir[i]
			i = i + 1		
		end
		puts "\n"
		print "Digite o cpf do contato ao qual o telefone deverá ser adicionado\n-> "
		cpf = gets.chomp.to_s
		print "Digite o telefone que deve ser adicionado\n-> "
		telefone = gets.chomp
		dao.adicionaTelefone(cpf, telefone)
	when 8
		puts "\nContatos\n----------\n"
		imprimir = dao.lista
		i = 0
		while i  < imprimir.length
			puts imprimir[i]
			i = i + 1		
		end
		print "Digite o cpf do contato ao qual o telefone está vinculado\n->"
		cpf = gets.chomp
		print "Digite o telefone a ser excluído\n->"
		telefone = gets.chomp
		dao.excluiTelefone(cpf, telefone)
		print "Telefone excluído com sucesso\n"
	when 9
		sair = true
	else
		puts "Opção inválida"
	end
end
	# puts contato.nome + " " + contato.telefone

