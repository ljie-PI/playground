/**
 * usage: kmp_match str pattern
 * It returns the index of pattern in str, starting from 0
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compute_back(const char *pattern, int *back)
{
	int len = strlen(pattern);
	back[0] = -1;
	int pos = 1, prefix_pos = -1;
	while(pos < len){
		if(pattern[pos] == pattern[prefix_pos+1]){
			prefix_pos++;
		}else{
			while(prefix_pos != -1 && pattern[pos] != pattern[prefix_pos+1]){
				prefix_pos = back[prefix_pos];
			}
			if(pattern[pos] == pattern[prefix_pos+1]){
				prefix_pos++;
			}
		}
		back[pos] = prefix_pos;
		pos++;
	}
}

int kmp_match(const char *str, const char *pattern)
{
	int str_len = strlen(str);
	int pattern_len = strlen(pattern);
	int *back = (int *)malloc(sizeof(int) * pattern_len);
	compute_back(pattern, back);
	int pos = 0, pattern_pos = -1;
	while(pos < str_len){
		if(str[pos] == pattern[pattern_pos+1]){
			pattern_pos++;
		}else{
			while(pattern_pos != -1 && str[pos] != pattern[pattern_pos+1]){
				pattern_pos = back[pattern_pos];
			}
			if(str[pos] == pattern[pattern_pos+1]){
				pattern_pos++;
			}
		}
		if(pattern_pos+1 == pattern_len){
			break;
		}
		pos++;
	}
	free(back);
	if(pos == str_len && pattern_pos != pattern_len){
		return -1;
	}else{
		return pos - pattern_len + 1;
	}
}

int main(int argc, char **argv){
	if(argc != 3){
		printf("Wrong usage:\nUsage:\"kmp_match str pattern\"\nIt returns the index of pattern in str, starting from 0\n");
	}
	char *str = argv[1]; 
	char *pattern = argv[2]; 
	int pos = kmp_match(str, pattern);
	printf("The index of %s in %s is %d\n", pattern, str, pos);
}
