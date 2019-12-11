# -*- coding: utf-8 -*-

from image_match.goldberg import ImageSignature
from elasticsearch import Elasticsearch
from image_match.elasticsearch_driver import SignatureES
import statistics
import sys, os
import json


sys.path.append(os.path.dirname(os.path.dirname(__file__)))
import crossparser_tools

temp_folder = crossparser_tools.temp_folder
config_folder = crossparser_tools.config_folder
data_folder = crossparser_tools.data_folder
website_root = crossparser_tools.website_root
proj_root_dir = crossparser_tools.proj_root_dir

img_folder = crossparser_tools.img_folder
img_module_folder = crossparser_tools.img_module_folder


img_db_products = {}

dist_cutoff = 0.7


def one_img_search(img):
    res = ses.search_image(img)

    match_prods = {}

    for img in res:
        dist = img['dist']
        prod_id = img['metadata']['prod_id']
        if prod_id not in match_prods:
            match_prods[prod_id] = dist

    return match_prods


def mul_img_search(imgs):

    match_prods = {}

    img_ind = -1

    for img in imgs:
        img_ind += 1
        match_prods_new = one_img_search(img)


        #Increase not found items
        for prod_id, dist in match_prods.items():
            if prod_id not in match_prods_new:
                match_prods[prod_id] = str(match_prods[prod_id]) + '||' + str(dist_cutoff)

        #Copy new found and increase found
        for prod_id, dist in match_prods_new.items():
            if prod_id not in match_prods:
                for i in range(img_ind):
                    match_prods[prod_id] = str(dist_cutoff) + '||'
                if img_ind > 0 :
                    match_prods[prod_id] += str(dist)
                else:
                    match_prods[prod_id] = str(dist)

            else:
                match_prods[prod_id] = str(match_prods[prod_id]) + '||' + str(dist)


    for prod_id, dists in match_prods.items():
        dists = str(dists).split('||')
        dist_sum = 0.0
        for dis in dists:
            dist_sum += float(dis)

        dist_sum = dist_sum / len(dists)

        match_prods[prod_id] = dist_sum



    return match_prods

def dic_to_list(dic):

    dic_list = []

    for prod_id, dist in dic.items():
        dic_list.append({'prod_id' : prod_id, 'dist' : dist})

    dic_list = sorted(dic_list, key = lambda k:k['dist'],  reverse=False)
    return dic_list


def parse_img_db():
    with open(data_folder + 'img_db_prods', 'r') as cr_file:
        for line in cr_file:
            if not line.strip().startswith('#'):
                if line.strip():
                    k, v = line.strip().split('$$')
                    img_db_products[k.strip()] = v.strip()


def search_products_for(prod_id):
    imgs = []

    for img, id in img_db_products.items():
        if prod_id == id:
            imgs.append(img_folder + img)

    if len(imgs) == 0:
        print('No image found')
        return

    is_one_img_search = False


    if is_one_img_search:

        return dic_to_list(one_img_search(imgs[0]))

    else:

        return dic_to_list(mul_img_search(imgs))



if __name__ == '__main__':

    parse_img_db()

    if len(sys.argv) == 2:
        prod_id = sys.argv[1]
    else:
        if len(img_db_products) > 0:
            prod_id = img_db_products[next(iter(img_db_products))]
        else:
            prod_id = '219720bed2MP002XW1GZVD'

    #print('prod_id', prod_id)

    es = Elasticsearch()
    ses = SignatureES(es, distance_cutoff=5.0)


    print(json.dumps(search_products_for(prod_id)))

    quit()

