=begin
5) Crie um programa em Ruby que receba uma string com seu nome
completo e mostre na tela somente o seu nome e sobrenome. Ex.:
"João Marcos Cavalcante Bezerra", o programa deverá mostrar
"João Bezerra". Dica: use o método split.
=end

print "Digite seu nome: "
# sem o chomp o gets salva um \n
nome = gets.chomp

arr = nome.split(" ")
print arr[0] + " " + arr[arr.length-1] + "\n"