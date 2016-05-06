#!/usr/bin/python
import xmlrpc.server
import sys
import os

savepath = sys.argv[1]
if not os.path.exists(savepath):
  os.makedirs(savepath)

def save(data, name):
  with open(os.path.join(savepath, name), "w) as DATA_PATH:
    DATA_PATH.write(data)
  return True

server = xmlrpc.server.SimpleXMLRPCServer(("0.0.0.0", 5000))
print("Listening on port 5000")
server.register_function(save, "save")
server.serve_forever()
