using ZLog

ZLog.init()

my_cat = ZLog.Category("default")

ZLog.info(my_cat, "dingdong")
