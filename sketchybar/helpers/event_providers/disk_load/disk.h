#include <stdio.h>
#include <unistd.h>
#include <sys/statvfs.h>

typedef struct {
    unsigned long long total_bytes;
    unsigned long long used_bytes;
    unsigned long long free_bytes;
    unsigned int usage_percent;
} disk_info_t;

int get_disk_info(disk_info_t *disk) {
    if (disk == NULL) {
        return -1;
    }

    struct statvfs stat;
    if (statvfs("/", &stat) != 0) {
        fprintf(stderr, "Failed to get disk statistics\n");
        return -1;
    }

    disk->total_bytes = (unsigned long long)stat.f_frsize * stat.f_blocks;
    disk->free_bytes = (unsigned long long)stat.f_frsize * stat.f_bavail;
    disk->used_bytes = disk->total_bytes - disk->free_bytes;
    disk->usage_percent = (unsigned int)((disk->used_bytes * 100.0 / disk->total_bytes) + 0.5);

    return 0;
}
