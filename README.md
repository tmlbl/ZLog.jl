ZLog
====
[![Build Status](https://travis-ci.org/tmlbl/ZLog.jl.svg?branch=master)](https://travis-ci.org/tmlbl/ZLog.jl)

This is a light wrapper around [zlog](http://hardysimpson.github.io/zlog/) to
provide highly performant logging for Julia.

Getting started is simple using the default configuration, which logs to `stdout`:

```julia
using ZLog

ZLog.init()

info("Testing info")
warn("Testing warn")
debug("Testing debug")
err("Testing error")
```

To use your own configuration file, simply provide the path to init:

```julia
ZLog.init(joinpath(pwd(), "myconfig.conf"))
```

Key-value data is supported via keyword arguments to the logging functions.

```julia
julia> info("Some data"; key="value")
2016-04-17 14:07:36 INFO   Some data [key=value]
```

The logging functions use the category "default" by default. If you are using
your own config and want to use the convenience functions, be sure to define the
"default" category. Other categories can be used like so:

```julia
mycat = ZLog.Category("mycat")
info(mycat, "A special message")
```

## TODO
* Make default config closer to syslog standard
