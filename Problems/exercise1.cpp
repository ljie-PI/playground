#include  <stdio.h>
#include  <stdlib.h>
#include  <stdint.h>
#include  <assert.h>
#include  <string.h>


int  encode(const  void*  raw_in,  void*  raw_out,  uint32_t  password,  size_t  len)
{
const  uint8_t*  in  =  (const  uint8_t*)raw_in;
uint8_t*  out  =  (uint8_t*)raw_out;

uint32_t  seed  =  password  ^  0xfc7a297cu;
for  (size_t  i  =  0  ;  i  <  len;  ++i)  {
uint8_t  a  =  (  in[i]  ^  seed  )  >>  4;
uint8_t  b  =  (  (  ((uint32_t)in[i])  <<  19  )  ^  seed  )  >>  (19-4);
a  &=  15;
b  &=  240;
a  =  15  &  (  a  ^  (b  <<  3));
out[i]  =  a  |  b;
seed  =  ((seed  ^  in[i])  *  144123481  +  in[i]);
}
}


int  decode(const  void*  raw_in,  void*  raw_out,  uint32_t  password,  size_t  len)
{
const  uint8_t*  in  =  (const  uint8_t*)raw_in;
uint8_t*  out  =  (uint8_t*)raw_out;

uint32_t  seed  =  password  ^  0xfc7a297cu;
for  (size_t  i  =  0  ;  i  <  len;  ++i)  {
//  请在此处补全代码
uint8_t a = 15 & in[i];
uint8_t b = 240 & in[i];
a  =  (a << 4) ^ seed & 240;
b  =  ((((uint32_t)b) << 15) ^ seed) >> 19;
b = b & 15;
out[i] = a | b;
seed  =  ((seed  ^  out[i])  *  144123481  +  out[i]);
}
}
int  main()
{
const  uint8_t  buf1[]  =  {0x2d,  0x1e,  0xd8,  0x9c,  0x72,  0x3f,  0x9c,  0x78,  0xb4,  0xdc,  0xe8,  0x0e,  0x08,  0x56,  0xf6,  0x9b,  0xb2,  0x92,  0x40,  0xad,  0x89,  0xf6,  0xda,  0xcf,  0xef,  0x64,  0x13,  0x3c,  0xee,  0x00,  0x8e,  0xa0,  0x3f,  0xb4,  0x0f,  0x6b,  0xda,  0x3b,  0x7e,  0x72,  };
uint8_t  buf2[100]  =  {};
const  uint32_t  password  =  0xab7786eu;
const  size_t  len  =  sizeof(buf1);
decode(buf1,  buf2,  password,  len);
printf("%s\n",  buf2);
}
