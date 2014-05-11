#!/usr/bin/env python

import xlrd
import sys
reload(sys)  
sys.setdefaultencoding('utf-8')

fname = "complain/complain.xls"
bk = xlrd.open_workbook(fname)
shxrange = range(bk.nsheets)
try:
	sh = bk.sheets()[1]
except:
	print "no sheet in %s named Sheet1" % fname
	exit()
nrows = sh.nrows

#cell_value = sh.cell_value(2,0)
#print cell_value

for i in range(1, nrows):
	f = open("complain/"+str(i)+".txt", 'wb')
	txt = sh.cell_value(i, 0)
	f.write(txt)
	f.close()
