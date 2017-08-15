require 'sinatra'
require 'erb'
require './models.rb'

get '/' do
	erb :index
end

get '/adiciona_cliente' do
	erb :adiciona_cliente
end

post '/salva_cliente' do
	cliente = Cliente.new
	cliente.cpf = params["cpf"]
	cliente.nome = params["nome"]
	cliente.comandaAberta = false
	#Faz o INSERT
	cliente.save

	redirect '/'
end

get '/adiciona_garcom' do
	erb :adiciona_garcom
end

post '/salva_garcom' do
	garcom = Garcom.new
	garcom.cpf = params["cpf"]
	garcom.nome = params["nome"]
	garcom.dataIngresso = params["dataIngresso"]
	if (params["dataDesligamento"] == '') 
		garcom.dataDesligamento = nil
	else
		garcom.dataDesligamento = params["dataDesligamento"]
	end
	garcom.save
	redirect '/'
end

get '/adiciona_comanda' do
	@vetCliente = Cliente.all(:comandaAberta => false)
	@vetGarcom = Garcom.all(:dataDesligamento => nil)
	erb :adiciona_comanda
end

post '/salva_comanda' do
	comanda = Comanda.new
	comanda.dataAbertura = params['dataAbertura']
	if comanda.dataEncerramento = ''
		comanda.dataEncerramento = nil
	else
		comanda.dataEncerramento = params['dataEncerramento']
	end
	idCliente = params['idCliente']
	cliente = Cliente.get(idCliente)
	idGarcom = params['idGarcom']
	garcom = Garcom.get(idGarcom)
	comanda.encerrada = false
	comanda.cliente = cliente
	comanda.garcom = garcom
	cliente.update(:comandaAberta => true)
	comanda.save
	redirect '/'
	
end

get '/adiciona_produto' do
	erb :adiciona_produto
end

post '/salva_produto' do
	produto = Produto.new
	produto.descricao = params['descricao']
	preco = params['preco'].gsub(',', '.').to_i
	produto.preco = preco
	produto.save
	redirect '/'
end

get '/lista_cliente' do
	@vetCliente = Cliente.all
	erb :lista_cliente
end

get '/lista_produto' do
	@vetProduto = Produto.all
	erb :lista_produto
end

get '/lista_garcom' do
	@vetGarcom = Garcom.all
	erb :lista_garcom
end

get '/lista_comanda' do
	@vetComanda = Comanda.all 
	erb :lista_comanda 
end

get '/incorpora_produto' do
	@vetProduto = Produto.all
	@vetComanda = Comanda.all(:encerrada => false)
	erb :tela_incorporar_produto
end

post '/salva_inc' do
	comanda = Comanda.get(params[:idComanda].to_i)
	produto = Produto.get(params[:idProduto])
	comanda.produtos << produto
	comanda.save
	redirect '/'
end

get '/exclui_cliente/:id' do

	cliente = Cliente.get(params["id"].to_i)		
	vetComanda = Comanda.all(:cliente => cliente)		
	vetComanda.each do |comanda|
		comanda.update(:produtos => [])
	end
	Comanda.all(:cliente => cliente).destroy
	cliente.destroy		

	redirect '/lista_cliente'
end

get '/exclui_garcom/:id' do
	garcom = Garcom.get(params["id"].to_i)
	vetComanda = Comanda.all(:garcom => garcom)		
	vetComanda.each do |comanda|
		if comanda.encerrada == false
			comanda.update(:encerrada => true)
			cliente = Cliente.get(comanda.cliente.idCliente)
			cliente.update(:comandaAberta => false)
		end
		comanda.update(:produtos => [])
	end
	Comanda.all(:garcom => garcom).destroy
	garcom.destroy
	redirect '/lista_garcom'
end

get '/exclui_produto/:id' do
	produto = Produto.get(params["id"].to_i)
	vetComanda = Comanda.all
	vetComanda.each do |comanda|
		vetProduto = comanda.produtos
		vetNovo = []
		vetProduto.each do |p2|
			if (p2.idProduto != produto.idProduto)
				vetNovo.push(p2)
			end
		end
		comanda.update(:produtos => vetNovo)
	end
	produto.destroy
	# resolver a exclusão do produto

	redirect '/lista_produto'
end

get '/exclui_comanda/:id' do
	comanda = Comanda.get(params["id"].to_i)
	cliente = Cliente.get(comanda.cliente.idCliente)
	cliente.update(:comandaAberta => false)
	vetProduto = Produto.all
	vetProduto.each do |produto|
		vetComanda = produto.comandas
		vetNovo = []
		vetComanda.each do |c2|
			if(c2.idComanda != comanda.idComanda)
				vetNovo.push(c2)
			end
		end
		produto.update(:comandas => vetNovo)
	end
	comanda.destroy
	redirect '/lista_comanda'
end




