#encoding: utf-8

#para rotas
require 'sinatra'
#para templates
require 'erb'
require './comunicadorDAO.rb'
require './programaDAO.rb'

get '/' do
	@m = ""
	erb :index
	
end

get '/cadastra' do
	erb :cadastra
end



get '/altera' do
	erb :altera
end


post '/adicionar_comunicador' do
	comunicador = Comunicador.new
	comunicador.nome = params['nome'].to_s 
	dao = ComunicadorDAO.new
	begin 
		dao.adiciona(comunicador)
		@m = "<div class='alert alert-success' role='alert'>Comunicador adicionado com sucesso!</div>"
	rescue Exception => e
		@m = "<div class='alert alert-danger' role='alert'>Não foi possível adicionar o comunicador</div>"
	end
	erb :cadastra
end

post '/adicionar_programa' do
	pro = Programa.new
	pro.nome = params['nome'].to_s
	pro.id_c = params['id_c'].to_i         
    pro.duracao = params['duracao'].to_i          
    pro.dias_da_semana = params['dias_da_semana'].to_s          
    pro.hora_inicio = params['hora_inicio'].to_i         
    pro.hora_fim = params['hora_fim'].to_i 
	dao = ProgramaDAO.new
	begin 
		dao.adiciona(pro)
		@m = "<div class='alert alert-success' role='alert'>Programa adicionado com sucesso!</div>"
	rescue Exception => e
		@m = "<div class='alert alert-danger' role='alert'>Não foi possível adicionar o programa</div>"
	end
	erb :cadastra
end


get '/lista_comunicadores' do
	dao = ComunicadorDAO.new
	@vetcomunicador = dao.lista
	erb :lista_comunicadores
end

get '/lista_programas' do
	dao = ProgramaDAO.new
	@vetprograma = dao.lista
	erb :lista_programas
end

get '/programacao' do
	dao = ComunicadorDAO.new
	@vetcomunicador = dao.lista
	erb :programacao
end

get '/exclui_comunicador/:id_c' do
	dao = ComunicadorDAO.new
	dao.exclui(params['id_c'].to_i)
	redirect '/lista_comunicadores'
end


get '/exclui_programa/:id_p' do
	dao = ProgramaDAO.new
	dao.exclui(params['id_p'].to_i)
	redirect '/lista_programas'
end

get '/tela_altera_comunicador/:id_c' do
	dao = ComunicadorDAO.new
	@comunicador = dao.busca(params['id_c'].to_i)
	erb :tela_altera_comunicador
end

post '/altera_comunicador' do 
	comunicador = Comunicador.new
	comunicador.nome = params['nome'].to_s 
	comunicador.id_c = params['id_c'].to_i
	dao = ComunicadorDAO.new
	dao.edita(comunicador)
	redirect '/lista_comunicadores'

end

get '/tela_altera_programa/:id_p' do
	dao = ProgramaDAO.new
	@programa = dao.busca(params['id_p'].to_i)
	erb :tela_altera_programa
end

post '/altera_programa' do
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
