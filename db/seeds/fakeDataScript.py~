import json
import re
import sys
import os
import shutil
import random
from random import randint
import random, string
from random import randint
def randomword(length):
   return ''.join(random.choice(string.lowercase) for i in range(length))

ofile = open('faked_data.json','w')
json_array = []
records = set([])

for i in xrange(10):
    tmp = {}
    tmp["name"] = randomword(15)
    while tmp["name"] in records:
      tmp["name"] = randomword(15)   
      print "duplicate "+str(i)
    tmp["address"] = "#"+str(i)+ " random street, "  + randomword(5)
    tmp["rate"] = "5.0"
    tmp["intro"] = "random generated " + randomword(10)
    tmp["avg_price"] = "$$"
    tmp["img_name"] = "default.jpg"
    records.add(tmp["name"])
    json_array.append(tmp)
        
json.dump(json_array,ofile,indent = 4)
ofile.close()
