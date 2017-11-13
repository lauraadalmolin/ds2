require 'sinatra'
require 'erb'
require './models.rb'

get '/' do
	erb :index
end

get '/adiciona_heroi' do
	@vetEquipe = Equipe.all
	erb :adiciona_heroi
end

post '/salva_heroi' do
	equipe = Equipe.get(params["id_equipe"])
	if (params["tipo"] == "1") 
		terrestre = Terrestre.new
		terrestre.nome = params["nome"]
		terrestre.nomeVerdadeiro = params["nomeVerdadeiro"]
		terrestre.equipe = equipe
		terrestre.save
	else
		extraterrestre = Extraterrestre.new
		extraterrestre.nome = params["nome"]
		extraterrestre.nomeVerdadeiro = params["nomeVerdadeiro"]
		extraterrestre.equipe = equipe
		extraterrestre.save
	end
	redirect '/'
end

get '/adiciona_habilidade' do
	erb :adiciona_habilidade
end

post '/salva_habilidade' do
	habilidade = Habilidade.new
	habilidade.nivelImpacto = params["impacto"]
	habilidade.nome = params["nome"]
	habilidade.descricao = params["descricao"]
	habilidade.save
	redirect '/'
end 

get '/adiciona_equipe' do
	erb :adiciona_equipe
end

post '/salva_equipe' do
	equipe = Equipe.new
	equipe.nome = params["nome"]
	equipe.save
	redirect '/'
end

get '/lista_herois' do
	@vetHeroi = Heroi.all
	erb :lista_herois
end

get '/lista_habilidades' do
	@vetHabilidade = Habilidade.all
	erb :lista_habilidades
end

get '/lista_equipes' do
	@vetEquipe = Equipe.all
	erb :lista_equipes
end

get '/exclui_heroi/:id' do
	heroi = Heroi.get(params["id"].to_i)
	heroi.update(:habilidades => [])
	heroi.destroy		
	redirect '/lista_herois'
end

get '/exclui_habilidade/:id' do
	habilidade = Habilidade.get(params["id"].to_i)
	habilidade.update(:herois => [])
	habilidade.destroy
	redirect '/lista_habilidades'
end

get '/exclui_equipe/:id' do
	equipe = Equipe.get(params["id"].to_i)
	equipe.destroy
	redirect '/lista_equipes'
end

get '/adiciona_habilidade_heroi' do
	@vetHeroi = Heroi.all 
	@vetHabilidade = Habilidade.all
	erb :adiciona_habilidade_heroi
end

post '/salva_inc' do
	heroi = Heroi.get(params[:id_heroi].to_i)
	habilidade = Habilidade.get(params[:id_habilidade])
	heroi.habilidades << habilidade
	heroi.save
	redirect '/'
end

get '/edita_equipe/:id' do
	@equipe = Equipe.get(params["id"])
	erb :tela_edita_equipe
end

post '/salva_edicao_equipe' do
	equipe = Equipe.get(params["id"])
	equipe.update(:nome => params["nome"])
	redirect '/lista_equipes'
end

get '/edita_habilidade/:id' do
	@habilidade = Habilidade.get(params["id"])
	erb :tela_edita_habilidade
end

post '/salva_edicao_habilidade' do
	habilidade = Habilidade.get(params["id"])
	habilidade.update(:nome => params["nome"], :descricao => params["descricao"], :nivelImpacto => params["impacto"])
	redirect '/lista_habilidades'
end

get '/edita_heroi/:id' do
	@heroi = Heroi.get(params["id"])
	@vetEquipe = Equipe.all
	erb :tela_edita_heroi
end

post '/salva_edicao_heroi' do
	heroi = Heroi.get(params["id"])
	equipe = Equipe.get(params["id_equipe"])
	heroi.update(:nome => params["nome"], :nomeVerdadeiro => params["nomeVerdadeiro"], :equipe => equipe)
	redirect '/lista_herois'
end

get '/exclui_habilidade_heroi/:id' do
	@heroi = Heroi.get(params["id"])
	erb :tela_exclui_habilidade_heroi
end

get '/salva_remove_habilidade_heroi/:idHabilidade/:idHeroi' do
	heroi = Heroi.get(params["idHeroi"]);
	vet = []
	heroi.habilidades.each do |habilidade|
		if habilidade.id != params["idHabilidade"].to_i
			vet.push(habilidade)
		end
	end
	heroi.update(:habilidades => vet)
	redirect '/lista_herois'
end
