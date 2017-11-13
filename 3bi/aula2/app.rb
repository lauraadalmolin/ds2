require "sinatra"
require "erb"
require "./models.rb"

get '/' do 
	post = Post.new(:title => "titulo", :text => nil)
	if (post.save) 
		@mensagem = "Sucesso"
	else 
		@mensagem = "Fracasso"
	end
	erb :index
end

get '/heranca' do
	masculino = Male.new(:name => "Pepeu Gomes...")
	masculino.save
end