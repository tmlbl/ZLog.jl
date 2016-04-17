#include <stdio.h>

#include "zlog.h"

void log_info (zlog_category_t *cat, char *msg)
{
  zlog_info(cat, msg);
}

void log_warn (zlog_category_t *cat, char *msg)
{
  zlog_warn(cat, msg);
}
