#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <inttypes.h>
#include <string.h>
#include <math.h>
#include <ctype.h>
#include <assert.h>
#include <iso646.h>

typedef struct num{
    int64_t data[1<<(12-6)];
} num;


int8_t get_sign;
int get_c;
#define get_int(res)\
{\
	get_sign=1;\
	while (get_c=getchar_unlocked(),isspace(get_c)){\
	}\
    memset(&res, 0, sizeof(res));\
	if (get_c=='-'){\
		get_sign*=-1;\
	}else{\
		res.data[0]=get_c-'0';\
	}\
	while (get_c=getchar_unlocked(),get_c!=EOF and !isspace(get_c)){\
        tmp.data[0]=10;\
		mul(&res, &tmp); \
		tmp.data[0]=get_c-'0';\
		add(&res, &tmp); \
	}\
    tmp.data[0]=get_sign;\
    mul(&res, &tmp); \
}
char put_data[99999];
num put_t;
num put_tt;
num tmp;
unsigned put_ds;
#define put_int(q)\
{\
    if (q.data[sizeof(q)/sizeof(q.data[0])-1]<0){\
		putchar_unlocked('-');\
		memset(&put_t, 0, sizeof(put_t));\
        sub(&put_t, &q);\
	}else{\
	    memcpy(&put_t, &q, sizeof(put_t));\
	}\
	put_ds=0;\
	while(tmp.data[0]=0, memcmp(&tmp, &put_t, sizeof(tmp))){\
        memcpy(&put_tt, &put_t, sizeof(put_t));\
		tmp.data[0]=10;\
        srem(&put_tt, &tmp);\
        put_data[++put_ds]=put_tt.data[0]+(unsigned)('0');\
		sdiv(&put_t, &tmp);\
	}\
	if (put_ds==0){\
		putchar_unlocked('0');\
	}\
	for (;put_ds;--put_ds){\
		putchar_unlocked(put_data[put_ds]);\
	}\
}


void add(num*, num*);
void sub(num*, num*);
void mul(num*, num*);
void sdiv(num*, num*);
void srem(num*, num*);

int main(){
    memset(&tmp, 0, sizeof(tmp));
    num left, right, prod1;

    memset(&left, 0, sizeof(left));
    left.data[0]=1;
    tmp.data[0]=3;
    for (size_t q=0; q<999; ++q){
        mul(&left, &tmp);
    }

    memset(&right, 0, sizeof(right));
    right.data[0]=1;
    tmp.data[0]=5;
    for (size_t q=0; q<999; ++q){
        mul(&right, &tmp);
    }

    mul(&left, &right);

    memset(&right, 0, sizeof(right));
    right.data[0]=1;
    tmp.data[0]=15;
    for (size_t q=0; q<999; ++q){
        mul(&right, &tmp);
    }

    putchar(48 + memcmp(&left, &right, sizeof(num)));
    putchar_unlocked(10);
}
