#!/usr/bin/env python
from kmeans_sim import *
from string import strip
from random import random
from random import uniform

def get_dim_range(file_name):
	f = open(file_name)
	line = f.readline()
	dim = len(strip(line).split("\t"))
	dim_ranges = [[] for i in range(0, dim)]
	while True:
		line = f.readline()
		if line == "\r\n" or line == "":
			break
		vec_str = strip(line).split("\t")
		vec = [float(vec_str[i]) for i in range(0, len(vec_str))]
		for i in range(0, dim):
			if vec[i] in dim_ranges[i]:
				continue
			dim_ranges[i].append(vec[i])
	return dim_ranges

def f_fitness(clusters, centers):
	k = len(centers);
	s = 0
	for i in range(0, k):
		for j in range(0, len(clusters[i])):
			s += compute_sim(clusters[i][j], centers[i])
	return s

def bin_search(tp, fitnesses, first, last):
	diff = last - first
	if diff == 1:
		if fitnesses[first] < tp and fitnesses[last] > tp:
			return last
		else:
			return 0
	if fitnesses[first+diff/2] < tp and fitnesses[first+diff/2+1] > tp:
		return first+diff/2+1
	elif tp < fitnesses[first+diff/2]:
		return bin_search(tp, fitnesses, first, first+diff/2)
	else:
		return bin_search(tp, fitnesses, first+diff/2+1, last)

def select(fitnesses, pop_size):
	fitness_sum = 0
	for i in range(0, len(fitnesses)):
		fitness_sum += fitnesses[i]
	p = [0.0 for i in range(0, pop_size)]
	p[0] = fitnesses[0] / fitness_sum
	for i in range(1, len(fitnesses)):
		p[i] = p[i-1] + fitnesses[i] / fitness_sum
	new_pop_num = [0 for i in range(0, len(fitnesses))]
	for i in range(0, len(fitnesses)):
		tp = random()
		num = bin_search(tp, fitnesses, 0, len(fitnesses)-1)
		new_pop_num[i] = num
	return new_pop_num

def crossover(new_population, p_crossover):
	for i in range(0, len(new_population)/2):
		p = random()
		if p < p_crossover:
			size1 = len(new_population[2*i]) - 1
			size2 = len(new_population[2*i+1]) - 1
			min_size = size1 < size2 and size1 or size2
			pos = randint(0, min_size-1)
			new_population[2*i][pos], new_population[2*i+1][pos] = new_population[2*i+1][pos], new_population[2*i][pos]

def mutation(new_population, p_mutation, dim_ranges):
	for i in range(0, len(new_population)):
		p = random()
		if p < p_mutation:
			size = len(new_population[i])
			pos = randint(0, size-1)
			d = len(dim_ranges)
			vec = [0.0 for j in range(0, d)]
			for j in range(0, d):
				vec[j] = dim_ranges[j][randint(0, len(dim_ranges[j])-1)]
			if pos == size - 1:
				new_population[i].append(new_population[i][size-1]+1)
				new_population[i][size-1] = vec
			else:
				new_population[i][pos] = vec

def ga_kmeans(vecs, k):
	pop_size = 8
	p_crossover = 0.8
	p_mutation = 0.05
	population = [[] for i in range(0, pop_size)]

	dim_ranges = get_dim_range("data.txt")

	#init population
	for i in range(0, pop_size):
		for j in range(0, k):
			population[i].append(vecs[randint(0,len(vecs)-1)])
		population[i].append(k)
	
	fitnesses = [0.0 for i in range(0, pop_size)]
	for loop in range(0, 50):
		#compute finess for each chromosome
		for i in range(0, pop_size):
			tmp_k = population[i][len(population[i])-1]
			pre_centers = population[i][0:tmp_k]
			_, centers, clusters = kmeans(vecs, tmp_k, pre_centers)
			fitnesses[i] = f_fitness(clusters, centers)

		#select
		new_pop_num = select(fitnesses, pop_size)
		new_population = [population[i] for i in range(0, pop_size)]

		#crossover
		crossover(new_population, p_crossover)

		#mutation
		mutation(new_population, p_mutation, dim_ranges)

		#replace population with new_population
		population = new_population
	
	max_fitness = 0.0
	best_num = 0
	for i in range(0, pop_size):
		if fitnesses[i] > max_fitness:
			max_fitness = fitnesses[i]
			best_num = i

	return population[i]

def ga_display_in_html(num_clusters, centers, words):
	f_txt_html = open("ga_txt_clusters.html", 'w')
	f_kw_html = open("ga_kw_clusters.html", 'w')
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
	chromosome = ga_kmeans(txt_vecs, 4)
	k = len(chromosome) - 1
	num_clusters, centers, _ = kmeans(txt_vecs, k, chromosome[0:k])
	ga_display_in_html(num_clusters, centers, words)
