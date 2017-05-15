require "./biblioteca.rb"
# quando estão no mesmo diretórios
# require_relative "biblioteca.rb"
=begin 
puts "Digite o nro1:"
nro1 = gets.to_i

puts "Digite o nro2:"
nro2 = gets.to_i

if (nro2 == 0)
	soma = soma(nro1)
else soma = soma(nro1, nro2)
end

puts "Resultado: " + soma.to_s

puts fatorial(gets.to_i)

puts 'Heitor insta Birl!! ' + heitorInsta().to_s
=end

puts 'Igor insta: ' + heitorInsta([1,2,3]).to_s