def soma (n1, n2=0) 
	n1 + n2
end

def fatorial(n)
	resultado = 1
	while (n > 1)
		resultado = resultado * n
		n = n - 1
	end
	resultado
end

def heitorInsta(vLikes = [2, 100, 200])
	tamanho = vLikes.size
	i = 0
	soma = 0
	while i < tamanho
		soma = soma + vLikes[i]
		i = i + 1
	end
	soma
end

=begin
	
def qualifica(nota, msg="Obrigado")
	# o #{} concatena uma variável no puts
	puts "A nota foi #{nota}. #{msg}"
end
	
=end