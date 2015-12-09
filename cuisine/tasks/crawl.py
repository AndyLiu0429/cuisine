
__author__ = 'liutianyuan'

import os
import requests, urllib
import json

#BASE_URL = 'http://54.218.5.250'
BASE_URL = 'http://10.128.4.98:3000'


RES = []

def url_join(*args):

    return '/'.join(list(args))

def request(word):
    #print word
    response = requests.get(url = url_join(BASE_URL, 'search'), params = {
        'term' : word,
    })

    #print response.json()['result'][0]['desc']
    if not response:
        return

    raw = [{
        'image_url' : resp['image_url'],
        'desc' : resp['desc'],
        'name' : resp['name']
    } for resp in response.json()['result'] if resp and 'desc' in resp]

    RES.extend(raw)

def keep_request():
    with open('./food.list', 'r') as f:
        for line in f.readlines():
            request(line.strip())
    print "done"

if __name__ == '__main__':
    keep_request()
    print len(RES)
    with open('image.json', 'w') as outfile:
        json.dump(RES, outfile)
