def soma (n1, n2) 
	n1 + n2
end

puts "Digite o nro1:"
nro1 = gets.to_i

puts "Digite o nro2:"
nro2 = gets.to_i

soma = soma(nro1, nro2)
puts "Resultado: " + soma.to_s
