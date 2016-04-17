__precompile__(true)

module ZLog

function __init__()
  path = joinpath(Pkg.dir("ZLog"), "deps/lib")
  push!(Libdl.DL_LOAD_PATH, path)
end

const libzlog = "libzlog"
const libzlogjl = "libzlogjl"

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

function argfmt(args::AbstractArray)
  "[$(join(map(a -> "$(a[1])=$(a[2])", args), ' '))]"
end

import Base.info,
       Base.warn

macro logfunc(name)
  cfunc = "log_$name"
  quote
    function $(esc(name))(cat::Category, msg::AbstractString; kwargs...)
      msg = "$msg $(length(kwargs) > 0 ? argfmt(kwargs) : "")"
      ccall(($cfunc, libzlogjl), Ptr{Void},
          (Ptr{Void}, Cstring),
          cat.__wrap, msg)
      return nothing
    end
    $(esc(name))(msg; args...) = $(esc(name))(Category("default"), msg; args...)
    export $(esc(name))
  end
end

@logfunc info
@logfunc warn
@logfunc debug
@logfunc err

end # module
