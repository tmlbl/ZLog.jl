using ZLog

ZLog.init()

info("Testing info")
warn("Testing warn")
debug("Testing debug")
err("Testing error")

info("Testing args"; key="value", bing=:bong)
