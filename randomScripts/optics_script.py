angle = [21,31,41,51,61,71,81,101,111,121,131,141,151,161]
raw = [3.224, 2.995, 2.667,2.11,1.592,1.064,0.546, 0.613,1.170,1.726,2.101,2.581,2.850,3.061]
base = 0.2
dop = []
v = []
v_rev = []
rad = 20.58*10**(-3)
wave = 1550*10**(-9) 
import math
for i in range(len(raw)):
    val = raw[i]*10**6
    dop += [val]
    val_v = val*wave/(2*math.cos(angle[i]*math.pi/180))
    v += [val_v]
    v_rev += [(60*val_v)/(2*math.pi*rad)]
print(v)
print('---------')
print(v_rev)