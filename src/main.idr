import Node
import Electron.App
import Electron.Window

%lib Node "electron"

%default total



main : JS_IO ()
main = onReady $ do win <- windowWith [Title "Hello Electron", Width 800, Height 600]
                    loadURL ("file://" ++ !getDir ++ "/view.html") win
