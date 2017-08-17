module Document

import JS

%default total
%access export



write : String -> JS_IO ()
write = js "document.write(%0)" (String -> JS_IO ())
