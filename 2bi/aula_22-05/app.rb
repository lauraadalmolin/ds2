require 'sinatra'
require 'erb'

enable :sessions
set :session_secret, 'palavrasecreta'
# before "rota" do ~só ocorre quando acionada alguma rota
before do 
	puts "------------------------"
	puts "Abrindo alguma rota"
	puts "------------------------"

end

get '/' do
	session[:ana] = "heitor"
	erb :index
end

after do 
	puts "------------------------"
	puts "Renderizando... a rota"
	puts "------------------------"
end

get '/mostra' do
	@variavelSessao = session[:ana]
	# para especificar um novo layout
	# erb :index, :layout => :post
	erb :mostra
end

get '/remove' do
	session.delete(:ana)
	redirect '/'
end

get '/mudanca' do
	session[:ana] = "bruno"
	erb :mostra
end


get '/utiliza_outro_layout' do
	#vai abrir batata utilizando layout_backup
	erb :batata, :layout => :layout_backup

end

post '/upload' do
	File.open('./public/upload/' + params['file'][:filename], "w") do |f|
		f.write(params['file'][:tempfile].read)
	end
end