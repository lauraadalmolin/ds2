=begin

vetor = Array.new(5, "teste")
vetor[0].upcase!
puts vetor
nome = "laura"
puts nome*5
# outro jeito de declarar array:

a = %w(john paul george ringo)
a.push("stu")
# => ["john", "paul", "george", "ringo", "stu"]
matriz = [[0,1,0], [2,3,4], [3,4,5]]
puts matriz


comentário de bloco

professoresDC = { :linux => "Igor", :android => "Márcio", :ogro => "Ogro", :java => "Raquel", :uml => "Cibele", :pinta => "Thiago"};
resultadoConcatena = professoresDC[:linux] + professoresDC[:android]
print resultadoConcatena
# por alguma razão o print de cima não funciona

professoresDC[:linux] << professoresDC[:android]
print professoresDC
print "\n";
n = "1"

puts n.class

n = n.to_i

puts n.class

=end

puts "Digite seu nome"
# sem o chomp o gets salva um \n
nome = gets.chomp
# puts nome
# puts nome.size
if nome.downcase == "laura"
	puts "ata"
elsif nome.downcase == "beatriz"
	puts "opa"
else 
	puts "wow"
end

i = 0
while i != 10 
	i+=1
end
puts i
# não existe i++ nessa linguagem
# 