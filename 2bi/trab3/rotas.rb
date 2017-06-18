#encoding: utf-8

#para rotas
require 'sinatra'
#para templates
require 'erb'
require './comunicadorDAO.rb'
require './programaDAO.rb'
require './administradorDAO.rb'

enable :sessions

before '/admin/*' do
  if ((session[:logado].nil?) || session[:logado] == false)
  	halt 404, 'sai da ai...'
  end
end

get '/tela_login' do
	erb :tela_login,:layout => :layout_publico
end

get '/logout' do
	session.clear
	redirect '/tela_login' 
end

post '/login' do
	login = params['login']
	senha = params['senha']
	# colocar false como default
	dao = AdministradorDAO.new
	retorno = dao.verifica(login, senha)
	
	# retirar essa linha...
	if (retorno == true)
		session[:logado] = true
		redirect '/admin/'
	else 
		@m = "deu xabum...."
		erb :tela_login,:layout => :layout_publico
	end
	
end

get '/' do
	erb :index, :layout => :layout_publico
end

get '/admin/' do
	erb :index
end

get '/admin/cadastra' do
	erb :cadastra
end

get '/admin/altera' do
	erb :altera
end

post '/admin/adicionar_comunicador' do
	comunicador = Comunicador.new
	comunicador.nome = params['nome'].to_s 
	dao = ComunicadorDAO.new
	file = params['file'][:tempfile]
	accepted_formats = [".png", ".jpeg", ".jpg", ".img"]
	if accepted_formats.include? File.extname(file)		
		comunicador.imagem = params['file'][:filename]
		begin 
		id = dao.adiciona(comunicador)
		File.open('./public/imagens/comunicador/' + id + File.extname(file), "w") do |f|
			f.write(params['file'][:tempfile].read)
		end
		comunicador.imagem = id + File.extname(file)
		comunicador.id_c = id
		dao.editaImg(comunicador)
		@m = "<div class='alert alert-success' role='alert'>Comunicador adicionado com sucesso!</div>"
		rescue Exception => e
		@m = "<div class='alert alert-danger' role='alert'>Não foi possível adicionar o comunicador</div>"
		end
	end

	
	erb :cadastra
end

post '/admin/adicionar_programa' do
	pro = Programa.new
	pro.nome = params['nome'].to_s
	pro.id_c = params['id_c'].to_i         
    pro.duracao = params['duracao'].to_i          
    pro.dias_da_semana = params['dias_da_semana'].to_s          
    pro.hora_inicio = params['hora_inicio'].to_i         
    pro.hora_fim = params['hora_fim'].to_i 
	dao = ProgramaDAO.new
	file = params['file'][:tempfile]
	accepted_formats = [".png", ".jpeg", ".jpg", ".img"]
	if accepted_formats.include? File.extname(file)		
		pro.imagem = params['file'][:filename]
		begin 
			id = dao.adiciona(pro)
			File.open('./public/imagens/programa/' + id + File.extname(file), "w") do |f|
				f.write(params['file'][:tempfile].read)
			end
			pro.imagem = id + File.extname(file)
			pro.id_p = id
			dao.editaImg(pro)
			@m = "<div class='alert alert-success' role='alert'>Programa adicionado com sucesso!</div>"
		rescue Exception => e
			@m = "<div class='alert alert-danger' role='alert'>Não foi possível adicionar o programa</div>"
		end
	end
	erb :cadastra
end


get '/lista_comunicadores' do
	dao = ComunicadorDAO.new
	@vetcomunicador = dao.lista
	erb :lista_comunicadores, :layout => :layout_publico
end

get '/lista_programas' do
	dao = ProgramaDAO.new
	@vetprograma = dao.lista
	erb :lista_programas, :layout => :layout_publico
end

get '/programacao' do
	dao = ComunicadorDAO.new
	@vetcomunicador = dao.lista
	erb :programacao, :layout => :layout_publico
end

get '/admin/exclui_comunicador/:id_c' do
	dao = ComunicadorDAO.new
	imagem = dao.retImagem(params['id_c'].to_i)
	
	File.delete("./public/imagens/comunicador/" + imagem)
	vet = dao.retImagensProgramas(params['id_c'].to_i)
	i = 0
	
	while (i < vet.length)
		
		File.delete("./public/imagens/programa/" + vet[i])
		i = i + 1
	end
	dao.exclui(params['id_c'].to_i)
	redirect '/lista_comunicadores'
end


get '/admin/exclui_programa/:id_p' do
	dao = ProgramaDAO.new
	imagem = dao.retImagem(params['id_p'].to_i)
	dao.exclui(params['id_p'].to_i)
	File.delete("./public/imagens/programa/" + imagem)

	redirect '/lista_programas'
end

get '/admin/tela_altera_comunicador/:id_c' do
	dao = ComunicadorDAO.new
	@comunicador = dao.busca(params['id_c'].to_i)

	erb :tela_altera_comunicador
end

post '/admin/altera_comunicador' do 
	comunicador = Comunicador.new
	comunicador.nome = params['nome'].to_s 
	comunicador.id_c = params['id_c'].to_i
	dao = ComunicadorDAO.new
	dao.edita(comunicador)
	redirect '/lista_comunicadores'
end

get '/admin/tela_altera_programa/:id_p' do
	dao = ProgramaDAO.new
	@programa = dao.busca(params['id_p'].to_i)
	erb :tela_altera_programa
end

post '/admin/altera_programa' do
	pro = Programa.new
	pro.nome = params['nome'].to_s
	pro.id_c = params['id_c'].to_i         
    pro.duracao = params['duracao'].to_i          
    pro.dias_da_semana = params['dias_da_semana'].to_s          
    pro.hora_inicio = params['hora_inicio'].to_i         
    pro.hora_fim = params['hora_fim'].to_i
    pro.id_p = params['id_p'].to_i   
	dao = ProgramaDAO.new
	dao.edita(pro)
	redirect '/lista_programas'
end
