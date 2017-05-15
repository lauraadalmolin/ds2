#encoding: utf-8

#para rotas
require 'sinatra'
#para templates
require 'erb'
require './database.rb'

get '/' do
	@m = ""
	erb :form
	
end

post '/alterar' do 
	animal = Animal.new
	animal.id = params['id'].to_i
	animal.nome = params['nome'].to_s
	animal.especie = params['especie'].to_s
	animalDAO = AnimalDAO.new
	animalDAO.editar(animal)
	redirect '/listar'

end

get '/tela_alterar/:id' do
	animalDAO = AnimalDAO.new
	@animal = animalDAO.obter(params['id'].to_i)
	erb :tela_alterar
end

get '/listar' do
	animalDAO = AnimalDAO.new
	@vetAnimal = animalDAO.listar
	erb :listar
end

get '/excluir/:id' do
	animalDAO = AnimalDAO.new
	animalDAO.excluir(params['id'].to_i)
	redirect '/listar'
end

post '/adicionar' do
	animal = Animal.new
	animal.nome = params['nome'].to_s 
	animal.especie = params['especie'].to_s 
	animalDAO = AnimalDAO.new
	begin 
		animalDAO.adicionar(animal)
		# mensagem de sucesso - vai para onde? => para o form
		@m = "Funfou"
	rescue Exception => e
		# mensagem de fracasso - vai para onde? => para o form tmb
		@m = "Deu xabum!!!"
	end

	erb :form
	# DICA: redirecionamento
	# redirect '/'
	
end