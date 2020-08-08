#!/usr/bin/env python3

import os
import time

#from multiprocessing import Process as Thread, Queue
from threading import Thread
from queue import Queue
import sched

import socket
import json

wallpaper_dir="/home/joaj/media/rotation"
period = 900
port=0xABBA


def loop(args, files):
    while True:
        print(f'feh --bg-fill {files[args["counter"]]}')
        os.system(f'feh --bg-fill {files[args["counter"]]}')
        args['counter']  = (args['counter'] + 1) % len(files)
        time.sleep(period)

def cmd_handler(args, files):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        sock.bind(("127.0.0.1", port))
    except Exception as e:
        return

    while True:
        msg, addr = sock.recvfrom(1024)
        msg = json.loads(msg)
        if msg.get('cmd') == 'next':
            print(msg)
            args['counter']  = (args['counter'] + (msg.get('skip') or 1)) % len(files)
            os.system(f'feh --bg-fill {files[args["counter"]]}')
        

def main():
    q = Queue()
    
    args = {'counter': 0}
    files = [os.path.join(wallpaper_dir, d) for d in os.listdir(wallpaper_dir)]
    print(files)

    cmd_handler_thread = Thread(target=cmd_handler, args=(args, files))
    loop_thread = Thread(target=loop, args=(args, files))

    cmd_handler_thread.start()
    loop_thread.start()
    


    cmd_handler_thread.join()
    loop.join()

if __name__ == '__main__':
    main()
