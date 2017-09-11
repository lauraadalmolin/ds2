
require "./aluno.rb"

require "./atendimento.rb"

require "./alunodao.rb"
require "./atendimentodao.rb"

# open, new, puts, close, delete
sair = false
while sair == false
	print "--- Menu --- \n\n1-Novo aluno\n2-Apagar aluno\n3-Listar aluno\n4-Listar os atendimentos\n5-Desmarcar atendimento\n6-Agendar atendimento\n7-Sair\n" +
		  "\n------------ \n\nDigite o número correspondente à opção desejada: \n"
	opcao = gets.chomp.to_i

	dao1 = AlunoDAO.new
	dao2 = AtendimentoDAO.new

	case opcao 
	when 1
		print "\nDigite o nome do aluno\n-> "
		nome = gets.chomp
		aluno = Aluno.new(nome)
		dao1.salva(aluno)
		puts "\n"
	when 2
		puts "\nAlunos\n----------\n"
		imprimir = dao1.lista
		i = 0
		while i  < imprimir.length
			puts imprimir[i]
			i = i + 1		
		end
		puts "\n"
		alunos = dao1.buscaTodos
		if (alunos != nil)
			print "Digite a matricula do aluno a ser excluído\n-> "
			matricula = gets.chomp
			teste = dao1.exclui(matricula)
			if (teste) 
				puts "\nO aluno foi excluído com sucesso.\n\n"
			end
		else
			puts "Não há nenhum aluno registrado.\n"
		end
	when 3
		puts "\nAlunos\n----------\n"
		imprimir = dao1.lista
		i = 0
		while i  < imprimir.length
			puts imprimir[i]
			i = i + 1		
		end
		puts "\n"
	when 4
		puts "\nAtendimentos\n----------\n"
		imprimir = dao2.listaTodos
		i = 0
		while i  < imprimir.length
			puts imprimir[i]
			i = i + 1		
		end
		puts "\n"

	when 5
		puts "\nAtendimentos\n----------\n"
		imprimir = dao2.listaTodos
		i = 0
		while i  < imprimir.length
			puts imprimir[i]
			i = i + 1		
		end
		puts "\n"
		print "Digite o codigo do atendimento a ser excluído\n-> "
		codigo = gets.chomp
		teste = dao2.exclui(codigo)
		if (teste) 
			puts "\nO aluno foi excluído com sucesso.\n\n"
		else
			puts "\nO aluno não foi excluído.\n\n"
		end
	when 6 
		print "Digite a matrícula do aluno\n-> "
		matricula = gets.chomp.to_i 
		print "Digite o professor em questão\n-> "
		professor = gets.chomp
		print "Data do atendimento (DD/MM/AAAA)\n-> "
		data = gets.chomp
		print "Hora de início (HH:MM)\n-> "
		hora_inicio = gets.chomp
		print "Hora de término (HH:MM)\n-> "
		hora_termino = gets.chomp
		print "Dúvidas\n-> "
		duvidas = gets.chomp
		aluno = dao1.buscaAluno(matricula)
		if (aluno != nil)
			atendimento = Atendimento.new(data, hora_termino, hora_inicio, duvidas, professor, aluno)
			dao2.salva(atendimento)

		end

	when 7
		sair = true
	else
		puts "Opção inválida"
	end
end