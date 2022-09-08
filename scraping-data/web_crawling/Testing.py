


dic = {'a':1}
print(dic['a'])
try:
  print(dic['b'])
except KeyError:
  print("해당키는 없습니다.")