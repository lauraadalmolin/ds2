#encoding: utf-8

#para rotas
require 'sinatra'
#para templates
require 'erb'

require './presenteDAO.rb'

enable :sessions

get '/' do
	dao = PresenteDAO.new
	session[:max] = dao.bmax
	session[:min] = dao.bmin
	session[:avg] = dao.bavg

	erb :index
end

get '/cadastra' do
	erb :cadastra
end

get '/cadastra' do
	erb :cadastra
end

get '/altera' do
	erb :altera
end

post '/adicionar_presente' do
	presente = Presente.new
	presente.nome = params['nome'].to_s 
	presente.preco = params['preco'].to_i 
	dao = PresenteDAO.new
	file = params['file'][:tempfile]
	accepted_formats = [".png", ".jpeg", ".jpg", ".img"]
	if accepted_formats.include? File.extname(file)		
		presente.imagem = params['file'][:filename]
		begin 
		id = dao.adiciona(presente)
		File.open('./public/imagens/presente/' + id + File.extname(file), "w") do |f|
			f.write(params['file'][:tempfile].read)
		end
		presente.imagem = id + File.extname(file)
		presente.id = id
		dao.editaImg(presente)
		@m = "<div class='alert alert-success' role='alert'>Presente adicionado com sucesso!</div>"
		rescue Exception => e
		@m = "<div class='alert alert-danger' role='alert'>Não foi possível adicionar o presente</div>"
		end
	end
	session[:max] = dao.bmax
	session[:min] = dao.bmin
	session[:avg] = dao.bavg
	
	erb :cadastra
end

get '/lista' do
	dao = PresenteDAO.new
	session[:max] = dao.bmax
	session[:min] = dao.bmin
	session[:avg] = dao.bavg
	@max = session[:max]
	@min = session[:min]
	@avg = session[:avg]
	@vetpresente = dao.lista
	erb :lista
end

get '/exclui/:id' do
	dao = PresenteDAO.new
	imagem = dao.retImagem(params['id'].to_i)
	
	File.delete("./public/imagens/presente/" + imagem)
	
	dao.exclui(params['id'].to_i)
	session[:max] = dao.bmax
	session[:min] = dao.bmin
	session[:avg] = dao.bavg
	redirect '/lista'
end


get '/busca' do
	dao = PresenteDAO.new
	pre = dao.busca()
	puts pre
	return pre
end
