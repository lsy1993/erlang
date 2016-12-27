#include <stdio.h>
long long sum1(long long x) 
{ 
      long long i,sum=0; 
      for(i = 1; i <= x; i++) 
             sum += i; 
      return sum; 
} 
//recursion 
long long sum2(long long x) 
{ 
       if(x == 1) 
             return 1; 
       else 
            return x + sum2(x-1); 
} 
int main() 
{ 
        long long x; 
        scanf("%lld",&x); 
        printf("sum=%lld\n",sum1(x)); 
        printf("sum=%lld\n",sum2(x)); 
} 