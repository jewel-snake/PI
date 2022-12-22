import copy

def sSR(s):
  ret = s
  for c in s:
    if c*2 in ret:
      ret = ret.replace(c*2,'',1)
  if ret == '':
    return 'Empty String'
  else:
    return ret
  

i = input()
o = sSR(i)
print(o)