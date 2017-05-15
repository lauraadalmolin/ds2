# 4) Qual a diferença entre fazer uma atribuição de um array a outro
# (ex.: array1=array2) e usar o método dup (ex.: array1=array2.dup)?

array1=[1,2,3]
array2=array1
array2[0] = 55
print array2.to_s + array1.to_s + "\n"

v1 = [1,2,3]
v2 = v1.dup
v2[0] = 1111
print v1.to_s + v2.to_s + "\n"