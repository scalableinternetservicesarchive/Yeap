from scrapy.spider import BaseSpider
from scrapy.selector import HtmlXPathSelector
import csv
from scrapy.http import Request
from scrapy.utils.response import get_base_url
from scrapy.utils.url import urljoin_rfc
import urllib
import json


import os
import sys

#from scrapy.selector import Selector

class DmozSpider(BaseSpider):
    name = "yeap"
    #allowed_domains = ["http://www.dianping.com/search/category/2/10"]
    #allowed_domains = ["yelp.com"]
    i = 0
    start_urls = []
    for i in range (0, 500, 10):
      start_urls.append('http://www.yelp.com/search?start='+str(i)+'#find_desc&find_loc=Los+Angeles,+CA&start=0&l=p:CA:Los_Angeles::Beverly_Hills')
    
  
    def parse(self, response):
      hxs = HtmlXPathSelector(response)
      #hxs = Selector(response)
      #sites = hxs.select('//title/text()')
      #items = response.selector.xpath('//div[contains(@id, "classfy")]')
      items = hxs.select('//div[contains(@class, "biz-listing-large")]')
      #items = items[0].select('./a')
      #print items

      shops = []
	
      for i in range(0,len(items) - 1):
        shop_info = {}
        item = items[i]
        name = item.select('.//a[contains(@class, "biz-name")]/text()')[0].extract()
        rating = item.select('.//div[contains(@class, "rating-large")]/i/@title')#[0].extract()
        if len(rating)>0:
          rating = rating[0].extract()
        else:
          rating = ""
        price = item.select('.//span[contains(@class, "price-range")]/text()')#[0].extract()
        if len(price) > 0:
          price = price[0].extract()
        else:
          price = ""
        categories = item.select('.//span[contains(@class, "category-str-list")]/a')
        intro = ""

        for j in range(0, len(categories) - 1):
          category = categories[j]
          category = category.select('./text()')[0].extract()
          intro = intro +  category + ', '
          #print "  subcategory: " + category
          #print "  intro =" + intro
        intro = intro + categories[len(categories) - 1].select('./text()')[0].extract()

        addrs = item.select('.//div[contains(@class, "secondary-attributes")]/address/text()')#[0].extract()      
        address = ""
        #print "length of addrs: " + str(len(addrs))
        for k in range(0, len(addrs) - 1):
          #print "k: " + str(k)
          address = address + addrs[k].extract() + ', '
        address = address + addrs[len(addrs) - 1].extract()

        img_url = item.select('.//img[contains(@class, "photo-box-img")]/@src')[0].extract()
        
        print "name: " + name
        print "rating: " + rating[0:3]
        print "price: " + price
        print "intro: " + intro
        print "img_name: " + img_url.split('/')[-2]
        print "img_url: " + img_url
        print "address: " + address.strip()

        shop_info['name'] = name
        shop_info['address'] = address.strip()
        shop_info['rate'] = rating[0:3]
        shop_info['intro'] = intro
        shop_info['avg_price'] = price
        shop_info['img_name'] =  img_url.split('/')[-2]
        # shop_info['img_url'] = 
        shops.append(shop_info)

        if not os.path.exists('imgs/'):
	        os.makedirs('imgs/')

        if len(img_url) > 0:
          urllib.urlretrieve("http:"+img_url, "imgs/" + shop_info['img_name'] +".jpg")

      ofile = open('data.json', 'a+')
      json.dump(shops, ofile, indent = 4)
      ofile.close()

        #relative_url = item.select('./@href')[0].extract().encode('ascii')
        #url =  urljoin_rfc(get_base_url(response),relative_url)
        #subcategory_name = item.select('./span/text()')[0].extract().encode('utf-8')
        #print url,subcategory_name
        #yield Request(url, callback = self.parse_link_pages)	
	  

