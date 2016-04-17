__precompile__(true)

module ZLog

macro lib(name, path)
  pathstr = eval(path)
  quote
    const $(esc(name)) = $pathstr
  end
end

@lib libzlog joinpath(Pkg.dir("ZLog"), "deps/zlog-latest-stable/src/libzlog.$(Libdl.dlext)")
@lib libzlogjl joinpath(Pkg.dir("ZLog"), "deps/libzlogjl.$(Libdl.dlext)")

function init(conf::AbstractString)
  rc = ccall((:zlog_init, libzlog), Cint,
      (Cstring,), conf)
  if rc == C_NULL
    error("There was an error.")
  end
  rc
end

init() = init(joinpath(Pkg.dir("ZLog"), "default.conf"))

type Category
  __wrap::Ptr{Void}
end

function Category(name::AbstractString)
  rc = ccall((:zlog_get_category, libzlog), Ptr{Void},
      (Cstring,), name)
  if rc == C_NULL
    error("Failed to get category $name")
  end
  Category(rc)
end

import Base.info,
       Base.warn

function info(cat::Category, msg::AbstractString)
  ccall((:log_info, libzlogjl), Ptr{Void},
      (Ptr{Void}, Cstring),
      cat.__wrap, msg)
  return nothing
end

info(msg::AbstractString) = info(Category("default"), msg)

function warn(cat::Category, msg::AbstractString)
  ccall((:log_warn, libzlogjl), Ptr{Void},
      (Ptr{Void}, Cstring),
      cat.__wrap, msg)
  return nothing
end

warn(msg::AbstractString) = warn(Category("default"), msg)

function debug(cat::Category, msg::AbstractString)
  ccall((:log_debug, libzlogjl), Ptr{Void},
      (Ptr{Void}, Cstring),
      cat.__wrap, msg)
  return nothing
end

debug(msg::AbstractString) = debug(Category("default"), msg)

export info, warn, debug

end # module
