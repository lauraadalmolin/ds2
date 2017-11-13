require "data_mapper"
require "dm-migrations"

	DataMapper.setup(:default, 'postgres://postgres:postgres@localhost/aula2')

class Post 
	include DataMapper::Resource
	#chave
	property :id, Serial
	property :title, String, :required => true, :unique => true
	property :text, Text, :default => "Sem texto", :length => 9..20
	#property :cpf_owner, String, :length => 11..11
	#validates_with_method :methodCpf

	def methodCpf
		return false
=begin
		alfabeto = ['a', 'b', 'c', 'd']
		alfabeto.each do |letra|
			self.cpf.each do |caracter|
				if (caracter == letra)
					return false
				end 
			end
		end
		return true
=end
	end
end


class Person
	include DataMapper::Resource
	property :id, Serial
	property :name, String
	property :job, String
	#por causa da herança
	property :type, Discriminator
end

class Male < Person

end

DataMapper.finalize
DataMapper.auto_migrate!
DataMapper.auto_upgrade!