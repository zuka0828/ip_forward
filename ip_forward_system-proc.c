#include <stdio.h>

int main(int argc, char *argv[])
{
	if (system("echo 0 > /proc/sys/net/ipv4/ip_forward") < 0)
		perror("system()");
	return 0;
}
