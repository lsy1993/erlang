#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mysql.h"

int main(int argc, char *argv[])
{
	MYSQL conn;
	int res;
	mysql_init(&conn);
	if(mysql_real_connect(&conn,"localhost","root","123","db_test",
	0,NULL,0))
	{
		printf("connect success!\n");
		res = mysql_query(&conn,
		"insert into student values('5','xm','f',2,'NULL')");
		if(res)
		{
			printf("error\n");
			fprintf(stderr, "Insert error %d: %sn",
			mysql_errno(&conn),mysql_error(&conn));  
		}
		else
		{
			printf("OK\n");
		}
		mysql_close(&conn);
	}
	return 0;
}
