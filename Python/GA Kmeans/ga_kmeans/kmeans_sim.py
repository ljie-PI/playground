#!/usr/bin/env python

from string import strip
from math import sqrt
from random import randint

def parse_file(file_name):	#input is data.txt
	f_data = open(file_name, 'r')
	line = f_data.readline()
	words = strip(line).split("\t")
	txt_vecs = []
	while True:
		line = f_data.readline()
		if line == "\r\n" or line == "":
			break
		vec_str = strip(line).split("\t")
		vec = [float(vec_str[i]) for i in range(0, len(vec_str))]
		txt_vecs.append(vec)
	return txt_vecs, words

def compute_sim(vec1, vec2):
	vec_len = len(vec1)
	s12 = 0
	s1 = 0
	s2 = 0
	for i in range(0, vec_len):
		s12 += vec1[i] * vec2[i]
		s1 += pow(vec1[i], 2)
		s2 += pow(vec2[i], 2)
	if s1==0 or s2==0:
		return 0
	return s12 / (sqrt(s1) * sqrt(s2))

def adjust_center(clusters):
	width = len(clusters[0])
	s = [0 for i in range(0, width)]
	clu_size = len(clusters)
	for i in range(0, clu_size):
		for j in range(0, width):
			s[j] += clusters[i][j]
	return [s[i]/clu_size for i in range(0, width)]

def kmeans(vecs, k, pre_centers=False):
	if(not pre_centers):
		centers = []
		ini_centers = []
		clusters = [[] for i in range(0, k)]
		num_clusters = [[] for i in range(0, k)]
		for i in range(0, k):
			rand_pos = randint(0, len(vecs)-1)
			centers.append(vecs[rand_pos])
			ini_centers.append(rand_pos)
			clusters[i].append(vecs[rand_pos])
			num_clusters[i].append(rand_pos)
	else:
		centers = pre_centers
		ini_centers = []
		clusters = [[] for i in range(0, k)]
		num_clusters = [[] for i in range(0, k)]
		for i in range(0, k):
			clusters[i].append(centers[i])
			#num_clusters[i].append(ini_centers[i])

	for i in range(0, len(vecs)):
		if i in ini_centers:
			continue
		clu_num = 0
		max_sim = 0
		for j in range(0, k):
			tmp_sim = compute_sim(vecs[i], centers[j])
			if tmp_sim > max_sim:
				max_sim = tmp_sim
				clu_num = j
		clusters[clu_num].append(vecs[i])
		num_clusters[clu_num].append(i)
		centers[clu_num] = adjust_center(clusters[clu_num])
			
	return num_clusters, centers, clusters

def display_in_html(num_clusters, centers, words):
	f_txt_html = open("txt_clusters.html", 'w')
	f_kw_html = open("kw_clusters.html", 'w')
	for i in range(0, len(num_clusters)):
		f_txt_html.write("<hr/>")
		f_kw_html.write("KEYWORD:&nbsp")
		f_txt_html.write("KEYWORD:&nbsp")
		print("KEYWORD: "),
		for j in range(0, len(centers[i])):
			if centers[i][j] > 0.5:
				f_kw_html.write(words[j]+"&nbsp")
				f_txt_html.write(words[j]+"&nbsp")
				print "%s " %  words[j],
		f_kw_html.write("<br/>")
		f_txt_html.write("<br/>")
		print
		for j in range(0, len(num_clusters[i])):
			f_txt_html.write("<p>")
			num = str(num_clusters[i][j]+1)
			f_in = open("complain/"+num+".txt", 'r')
			txt = f_in.readlines()
			f_in.close()
			f_txt_html.write("<font color='red'>compain"+num+".txt&nbsp&nbsp</font>")
			f_txt_html.write("<br/>".join(txt))
			f_txt_html.write("</p>")
		f_txt_html.write("<hr/>")
	f_txt_html.close()
	f_kw_html.close()

if __name__ == "__main__":
	txt_vecs, words = parse_file("data.txt")
	num_clusters, centers, _ = kmeans(txt_vecs, 4)
	display_in_html(num_clusters, centers, words)
