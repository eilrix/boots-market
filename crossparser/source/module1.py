import os.path
import urllib.request
import crossparser_tools

temp_folder = crossparser_tools.temp_folder
file_path = temp_folder + 'fhtthv.jpg'

img = 'https://cdn.sptmr.ru/upload/resize_cache/iblock/8be/600_600_1/20108320299.jpg'

urllib.request.urlretrieve(img, file_path)

size = os.stat(file_path).st_size

print(size)