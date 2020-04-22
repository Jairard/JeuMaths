import json

dict= []
frac = []
chain = ".png"

file = open("Godot_Fractions.txt", "r")
dict = file.read()
file.close
frac = json.loads(dict)
##print (dict)

print (frac)

