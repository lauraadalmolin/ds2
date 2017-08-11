require 'sinatra'
require 'erb'
require './models.rb'

# @vet = Professor.all(:apelido.like => '%vidal%')
get '/' do

	#atributo nos parenteses é +- o mesmo que o WHERE

	#SELECT * FROM professores
	@vet1 = Professor.all

	#SELECT * FROM professores WHERE id > 2 AND id < 6 AND nome != 'marcio'
	@vet2 = Professor.all(:id.gt => 2, :id.lt => 6, :nome.not => "marcio")

	#SELECT * FROM professores ORDER BY nome DESC
	@vet3 = Professor.all(:order => [:nome.desc])

	#SELECT nome, apelido FROM professores
	@vet4 = Professor.all(:fields => [:nome, :apelido])

	#SELECT COUNT(*) FROM professores
	@count = Professor.count

	#SELECT * FROM professores WHERE id = 1
	@prof = Professor.get(1)

	@aluno = Aluno.all

	@atendimentos = Atendimento.all

	erb :index
end

get '/adicionar' do
	erb :adicionar
end

post '/adicionar' do
	professor = Professor.new
	professor.nome = params["nome"]
	professor.apelido = params["apelido"]
	#Faz o INSERT
	professor.save

	redirect '/'
end

get '/excluir/:id' do
	professor = Professor.get(params["id"].to_i)
	#Faz o DELETE

	vetAluno = professor.alunos
	vetAluno.each do |aluno|
		aluno.destroy
	end
	professor.destroy
	redirect '/'
end

get '/editar/:id' do
	@professor = Professor.get(params["id"])
	erb :editar
end

post '/editar' do
	professor = Professor.get(params["id"])

=begin
	#NÃO FUNCIONA

	professor.nome = params["nome"]
	professor.apelido = params["apelido"]

	professor.update
=end
	
	#Faz o update
	professor.update(:nome => params["nome"], :apelido => params["apelido"])

	redirect '/'
end

# CRUD

get "/tela_adicionar_aluno" do

	@vetProfessor = Professor.all
	erb :tela_adicionar_aluno
end

get "/tela_adicionar_atendimento" do
	erb :tela_adicionar_atendimento
end


post "/adicionar_aluno" do 
	aluno = Aluno.new
	aluno.nome = params[:nome]
	aluno.professor = Professor.get(params[:professor_id].to_i)

	aluno.save
	redirect "/"
end

post "/adicionar_atendimento" do 
	atendimento = Atendimento.new
	atendimento.dataHora = params[:dataHora]
	atendimento.save
	redirect "/"
end

get '/excluir_aluno/:id' do
	aluno = Aluno.get(params["id"].to_i)
	#Faz o DELETE
	aluno.destroy
	redirect '/'
end

get '/tela_alterar_aluno/:id' do
	aluno = Aluno.get(params['id'].to_i)
	@aluno = aluno
	@vetProfessor = Professor.all
	erb :tela_alterar_aluno
end


post '/editar_aluno' do
	aluno = Aluno.get(params["id"])
	professor = Professor.get(params[:professor_id].to_i)
=begin
	#NÃO FUNCIONA

	professor.nome = params["nome"]
	professor.apelido = params["apelido"]

	professor.update
=end
	
	#Faz o update
	#aluno.professor = professor
	aluno.update(:nome => params["nome"], :professor => professor)

	redirect '/'
end

get "/tela_incorporar_aluno/:atendimento_id" do
	@atendimento_id = params[:atendimento_id].to_i
	@vetAluno = Aluno.all
	erb :tela_incorporar_aluno
end

post "/incorporar_aluno" do
	atendimento = Atendimento.get(params[:atendimento_id].to_i)
	aluno = Aluno.get(params[:aluno_id])

	atendimento.alunos << aluno
	
	atendimento.save
	redirect '/'
end
