=begin
	O que ainda falta:
	- Listagem ordenada dos clientes que mais vieram ao bar;
=end

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
	#uma vez que não faz sentido encerrar uma comanda no momento de sua criação
	comanda.dataEncerramento = nil
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

get '/edita_cliente/:id' do
	@cliente = Cliente.get(params["id"])
	erb :tela_edita_cliente
end

post '/salva_edicao_cliente' do
	cliente = Cliente.get(params["id"])
	cliente.update(:nome => params["nome"], :cpf => params["cpf"])
	redirect '/lista_cliente'
end

get '/edita_garcom/:id' do
	@garcom = Garcom.get(params["id"])
	erb :tela_edita_garcom
end

post '/salva_edicao_garcom' do
	garcom = Garcom.get(params["id"])
	if (params["dataDesligamento"] == '')
		params["dataDesligamento"] = nil
	end
	garcom.update(:nome => params["nome"], :cpf => params["cpf"], :dataIngresso => params["dataIngresso"], :dataDesligamento => params["dataDesligamento"])
	redirect '/lista_garcom'
end

get '/edita_produto/:id' do
	@produto = Produto.get(params["id"])
	erb :tela_edita_produto
end

post '/salva_edicao_produto' do
	produto = Produto.get(params["id"])
	produto.update(:descricao => params["descricao"], :preco => params["preco"])
	redirect '/lista_produto'
end

get '/edita_comanda/:id' do
	@comanda = Comanda.get(params["id"])
	@vetGarcom = Garcom.all
	@vetCliente = Cliente.all
	erb :tela_edita_comanda
end

post '/salva_edicao_comanda' do
	comanda = Comanda.get(params["idComanda"])
	cliente = Cliente.get(params["idCliente"])
	garcom = Garcom.get(params["idGarcom"])
	comanda.update(:cliente => cliente, :garcom => garcom)
	redirect '/lista_comanda'
end

get '/remove_produto_comanda/:id' do
	@comanda = Comanda.get(params["id"])
	erb :tela_remove_produto
end

get '/salva_remove_produto_comanda/:idProduto/:idComanda' do
	comanda = Comanda.get(params["idComanda"]);
	vet = []
	comanda.produtos.each do |produto|
		if produto.idProduto == params["idProduto"]
			vet.push(produto)
		end
	end
	comanda.update(:produtos => vet)
	redirect '/lista_comanda'
end

get '/encerra_comanda/:id' do 
	@comanda = Comanda.get(params["id"])
	@precoTotal = 0
	@dataAbertura = @comanda.dataAbertura.to_s.gsub('T', ' | ')
	@dataAbertura = @dataAbertura.to_s.gsub('T', ' ')[0,18]
	@comanda.produtos.each do |produto|
		@precoTotal = produto.preco + @precoTotal
	end
	erb :encerra_comanda
end

get '/salva_encerramento_comanda/:id' do
	timestamp = Time.now.getutc.to_s.gsub(' UTC', '')
	comanda = Comanda.get(params['id'])
	idCliente = comanda.cliente.idCliente
	cliente = Cliente.get(idCliente)
	cliente.update(:comandaAberta => false);
	comanda.update(:dataEncerramento => timestamp, :encerrada => true)
end

get '/lista_comandas_em_aberto' do
	@vetComanda = Comanda.all(:encerrada => false)
	erb :lista_comandas_em_aberto
end

get '/lista_melhores_garcons' do
	rs = repository(:default).adapter.select("SELECT g.id_garcom as id " +
											"FROM garcoms g INNER JOIN comandas c ON (c.garcom_id_garcom = g.id_garcom) "+
											"WHERE data_desligamento IS NULL GROUP BY g.id_garcom ORDER BY COUNT(g.id_garcom) DESC LIMIT 3 ")
	@vetGarcom = []
	rs.each do |registro|
		@vetGarcom.push(Garcom.get(registro.to_i))
	end
	erb :lista_garcom
end

get '/lista_clientela_frequente' do
	rs = repository(:default).adapter.select("SELECT cl.id_cliente as id " +
											"FROM clientes cl INNER JOIN comandas c ON (c.cliente_id_cliente = cl.id_cliente) "+
											"GROUP BY cl.id_cliente ORDER BY COUNT(cl.id_cliente) DESC ")
	@vetCliente = []
	rs.each do |registro|
		@vetCliente.push(Cliente.get(registro.to_i))
	end
	erb :lista_cliente
end