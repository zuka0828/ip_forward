#include <stdio.h>

int main(int argc, char *argv[])
{
	FILE *fp;

	fp = fopen("/proc/sys/net/ipv4/ip_forward", "w");
	if (!fp) {
		perror("fopen");
		return 1;
	}

	if (fprintf(fp, "0\n") < 0) {
		perror("fprintf");
		return 1;
	}
	return 0;
}
