# https://docs.google.com/spreadsheets/d/1QPnddpGNczMlVo3a5F_CgwcaXSFdVf4HhidSI5oBG8Y/edit#gid=297552551

b = 109900
c = 126900
d = 0
e = 0
f = 0
g = 0
h = 0
loop
  f = 1
  d = 2
  loop
    if b % d == 0
      f = 0
    d++
    break unless d != b
  if f == 0
    h++
  b += 17
  break unless b <= c
console.log 'h = ' + h