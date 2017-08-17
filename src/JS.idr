module JS

%default total
%access export



%inline
js : (fname : String) -> (ty : Type) -> {auto fty : FTy FFI_JS [] ty} -> ty
js fname ty = foreign FFI_JS fname ty

object : JS_IO Ptr
object = js "{}" (JS_IO Ptr)
