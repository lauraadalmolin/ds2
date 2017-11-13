# 1) Inverta um número. Ex: 123 Saída: 321
puts "Digite um número"

n = gets.to_i
arr = []
i = 0

while (n != 0)
	arr[i] = n % 10
	n = n - arr[i]
	n = n / 10
	i = i + 1
end

res = 0
i = 0
j = arr.length - 1

while i < arr.length
	res = arr[i] * 10**(j) + res
	i = i + 1
	j = j -1
end

puts res