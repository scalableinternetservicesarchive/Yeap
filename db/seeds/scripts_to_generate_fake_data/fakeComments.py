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

ofile = open('faked_comments.json','w')
json_array = []

for i in range(1,3):
  for j in xrange(10000):
      tmp = {}
      tmp["user_id"] = str(random.randint(1,500))
      tmp["content"] = "random generated content:"+ randomword(5)
      tmp["rate"] = random.randint(1,5)
      tmp["intro"] = "random generated " + randomword(10)
      tmp["upvote"] = "0"
      tmp["downvote"] = "0"
      tmp["location_id"] = str(i)
      json_array.append(tmp)
        
json.dump(json_array,ofile,indent = 4)
ofile.close()
