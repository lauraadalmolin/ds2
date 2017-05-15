=begin
8) Escreva um programa que leia um número inteiro positivo n, calcule
e mostre a soma:
1/1+1/2+1/3+1/4+...+1/(n-1)+1/n
=end

puts "Digite um número n: "
n = gets.to_i
i = 1
soma = 0.0
while i <= n
	soma = 1.0/i + soma
	i = i + 1
end

puts soma