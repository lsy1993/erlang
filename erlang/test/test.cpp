#include <stdio.h>
#include <stdlib.h>
#include "mysql.h"
 
int main(int argc,char *argv[])
{
   MYSQL conn;
   int res;
   printf("connect success!\n");
   mysql_init(&conn);
   if(mysql_real_connect(&conn,"localhost","root","123","db_test",0,NULL,0))
   {
   　　printf("connect success!\n");
   　　res=mysql_query(&conn,"insert into db_test values(4,'xiaoming','m', 11; NULL)");
     if(res)
   　　{
      　　 printf("error\n");
   　　}
     else
   　　{
       　　printf("OK\n");
   　　}
     mysql_close(&conn);
   }
   return 0;
}
