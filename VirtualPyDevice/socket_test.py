# send socket to server:port

import socket
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect(("127.0.0.1", 10016))
s.send(b'hello')
s.close()