=begin
# Somar todos elementos de uma vetor. O vetor deve ser alimentado por um usuário

puts "Somar todos elementos de uma vetor. O vetor deve ser alimentado por um usuário"

array = Array.new(5)
i = 0
soma = 0

while i < array.size 
	puts "Digite valores numéricos para o seu vetor"
	array[i] = gets.to_f
	soma+=array[i]
	i+=1
end

puts "A soma desses valores é " + soma.to_s

# Maior elemento de um vetor

puts "Maior elemento de um vetor"

array2 = Array.new(5)
i = 1
puts "Digite valores numéricos para o seu vetor"
max = gets.to_f
array2[0] =  max

while i < array.size
	puts "Digite valores para o seu vetor"
	array2[i] = gets.to_f
	if (max < array2[i])
		max = array2[i]
	end
	i+=1
end

puts "O maior elemento do vetor é " + max.to_s

# Menor elemento de um vetor

puts "Menor elemento de um vetor"

array3 = Array.new(5)
i = 1
puts "Digite valores numéricos para o seu vetor"
min = gets.to_f
array3[0] =  min

while i < array.size
	puts "Digite valores para o seu vetor"
	array3[i] = gets.to_f
	if (min > array3[i])
		min = array3[i]
	end
	i+=1
end

puts "O menor elemento do vetor é " + min.to_s



# Verificar se um número é primo

puts "Digite um número"

num = gets.to_f

divisores = 0;

cont = 1;

while cont < num 
	if (num % cont == 0)
		divisores+=1
	end
	cont+=1
end

if(divisores != 1) 
	puts "O número não é primo"
else
	puts "O número é primo"
end

# Misturar dois nomes. Ex: "Igor" com "Ana". Resultado: "IAgnoar"

puts 'Digite uma palavra'
nome1 = gets.chomp
puts 'Digite outro nome'
nome2 = gets.chomp

i = 0;
j = 0;
contnov = 0;
contnov2 = 1;
nov = Array.new(nome1.size+nome2.size)

while (i < nome1.size) 
	nov[contnov] = nome1[i]
	i+=1
	contnov+=2
end
while (j < nome2.size)
	nov[contnov2] = nome2[j]
	j+=1
	contnov2+=2
end
i = 0
novapalavra = ""
while i < nov.size 
	novapalavra+= nov[i]
	i+=1
end

puts novapalavra

# Média entre elementos de 2 vetores.

array = Array.new(5)
i = 0
soma = 0

while i < array.size 
	puts "Digite valores numéricos para o seu vetor 1"
	array[i] = gets.to_f
	soma+=array[i]
	i+=1
end

array2 = Array.new(5)
j = 0
soma2 = 0

while j < array2.size 
	puts "Digite valores numéricos para o seu vetor 2"
	array2[j] = gets.to_f
	soma2+=array2[j]
	j+=1
end

media1 = soma/array.size
media2 = soma2/array2.size
mediatotal = (soma+soma2)/(array.size + array2.size)
puts media1
puts media2
puts mediatotal

=end

# Determinante de matrizes de 3x3

matriz = [[0,1,0], [2,3,4], [3,4,5]]

ed1 = matriz[0][0] * matriz[1][1] * matriz[2][2]
ed2 = matriz[0][1] * matriz[1][2] * matriz[2][0]
ed3 = matriz[0][2] * matriz[1][0] * matriz[2][1]
de1 = matriz[0][1] * matriz[1][0] * matriz[2][2]
de2 = matriz[0][0] * matriz[1][2] * matriz[2][1]
de3 = matriz[0][2] * matriz[1][1] * matriz[2][0]

det = ed1+ed2+ed3-de1-de2-de3

puts det