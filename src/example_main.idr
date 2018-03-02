import JS.Node.Module
import JS.Electron.App
import JS.Electron.Window

%lib Node "electron"

%default total



main : JS_IO ()
main = onReady $ do win <- windowWith [Title "Hello Electron", Width 800, Height 600]
                    loadURL ("file://" ++ !dir ++ "/example_view.html") win
