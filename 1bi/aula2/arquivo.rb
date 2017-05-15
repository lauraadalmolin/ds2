#arq = File.new("arquivo.txt", "w")
#arq.write("PHP\n")
arq = File.open("arquivo.txt")
linha = arq.readline
puts linha
arq.close
