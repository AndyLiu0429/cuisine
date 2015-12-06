
__author__ = 'liutianyuan'

import os
import requests, urllib

#BASE_URL = 'http://54.218.5.250'
BASE_URL = 'http://127.0.0.1:3000'
def url_join(*args):

    return '/'.join(list(args))

def request(word):
    print word
    response = requests.get(url = url_join(BASE_URL, 'search'), params = {
        'term' : word,
    })

    print response

def keep_request():
    with open('./food.list', 'r') as f:
        for line in f.readlines():
            request(line.strip())
    print "done"

if __name__ == '__main__':
    keep_request()
