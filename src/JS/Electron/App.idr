module JS.Electron.App

import JS

%default total
%access export



quit : JS_IO ()
quit = js "electron.app.quit()" (JS_IO ())



on : String -> JS_IO () -> JS_IO ()
on event func =
    assert_total $ js "electron.app.on(%0, %1)"
                      (String -> JsFn (() -> JS_IO ()) -> JS_IO ())
                      event
                      (MkJsFn $ const func)

onReady : JS_IO () -> JS_IO ()
onReady = on "ready"

onAllWindowsClosed : JS_IO () -> JS_IO ()
onAllWindowsClosed = on "window-all-closed"
