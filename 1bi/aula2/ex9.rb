=begin
9) Em Ruby, para a geração de um número aleatório usamos o
método rand(MAX), onde MAX determina o valor máximo a ser
gerado. Exemplo: par gerar um número entre 0 e 100 podemos aplicar a
seguinte linha num = rand(100)

Escreva um programa (jogo) que gere um número entre 0 e 1000 e
peça para o usuário adivinhar o número. A cada tentativa o
programa informa se o número informado pelo usuário é maior ou
menor que o número a ser descoberto. Ao final o programa deve
informar quantas tentativas foram feitas até a descoberta do
número.
=end

rnd = rand(1000)
bbreak = false
i = 0
loop do 
  	puts "Digite um número: "
  	n = gets.to_i
  	if (rnd > n) 
  		puts "O número é menor que o correto."
  	elsif (rnd < n)
  		puts "O número é maior que o correto."
  	else
  		puts "O número é o correto!"
  		bbreak = true
  	end
  	i = i + 1
	break if bbreak == true
end 

puts "Você acertou o número apos #{i} tentativas"