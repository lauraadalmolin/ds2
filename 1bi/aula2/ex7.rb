# 7) Escreva um programa que mostre todos os números entre 1 e 100
# que são múltiplos de 3 e 7.

i = 1

puts "Os múltiplos de 3 e 7 são:"
while i <= 100
	if (i % 3 == 0 && i % 7 == 0) 
		puts i
	end
	i = i + 1
end