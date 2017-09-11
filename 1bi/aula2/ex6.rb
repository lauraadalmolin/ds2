=begin
6) Escreva uma função, chamada fat, que retorne o fatorial de um
número. A função deve verificar se o parâmetro passado é inteiro e
maior do que zero, caso contrário deve retornar -1.
=end

def fatorial (n)
	fat = 1
	if (n < 0)  
		fat = -1		
	else 
		i = 2
		while i <= n
			fat = fat * i
			i = i + 1
		end
	end
	fat
end

puts "Digite um número:"
n = gets.chomp
j = 0
isint = true
while j < n.length
	if (n[j] != "0" && n[j] != "1" && n[j] != "2" && n[j] != "3" && n[j] != "4" && n[j] != "5" && n[j] != "6" && n[j] != "7" && n[j] != "8" && n[j] != "9") 
		isint = false
	end
	j = j + 1
end

if (isint) 
	fat =  fatorial(n.to_i)
	puts "Fatorial de #{n} = " + fat.to_s
else
	puts "Não é um número"
end