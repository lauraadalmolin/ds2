# 2) Escreva um programa leia um nome e o ano de nascimento e
# mostre a seguinte frase: Oi FULANO, você tem ### anos.

print "Digite seu nome: "
# sem o chomp o gets salva um \n
nome = gets.chomp
print "Digite seu ano de nascimento: "
ano = gets.to_i
ano = 2017 - ano
puts "Sua idade é #{ano}"