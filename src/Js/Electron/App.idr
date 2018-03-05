module Js.Electron.App

import Js

%default total
%access export



name : JS_IO String
name = js "electron.app.getName()" (JS_IO String)

setName : String -> JS_IO ()
setName = js "electron.app.setName(%0)" (String -> JS_IO ())

version : JS_IO String
version = js "electron.app.getVersion()" (JS_IO String)

path : JS_IO String
path = js "electron.app.getAppPath()" (JS_IO String)



-- macOS
show : JS_IO ()
show = js "electron.app.show()" (JS_IO ())

-- macOS
hide : JS_IO ()
hide = js "electron.app.hide()" (JS_IO ())

focus : JS_IO ()
focus = js "electron.app.focus()" (JS_IO ())

quit : JS_IO ()
quit = js "electron.app.quit()" (JS_IO ())

exit : JS_IO ()
exit = js "electron.app.exit()" (JS_IO ())

exitWith : Int -> JS_IO ()
exitWith = js "electron.app.exit(%0)" (Int -> JS_IO ())

relaunch : JS_IO ()
relaunch = js "electron.app.relaunch()" (JS_IO ())



on : String -> JS_IO () -> JS_IO ()
on event func = assert_total $ js "electron.app.on(%0, %1)" (String -> JsFn (() -> JS_IO ()) -> JS_IO ()) event (MkJsFn $ const func)

onWillFinishLaunching : JS_IO () -> JS_IO ()
onWillFinishLaunching = on "will-finish-launching"

onReady : JS_IO () -> JS_IO ()
onReady = on "ready"

onAllWindowsClosed : JS_IO () -> JS_IO ()
onAllWindowsClosed = on "window-all-closed"
