import JS.Node.Module
import JS.Electron.App
import JS.Electron.Window

%lib Node "electron"

%default total



win : String -> Options
win dir = record {title = Just "Hello Electron", url = Just ("file://" ++ dir ++ "/example_view.html"), width = Just 800, height = Just 600} defaults

main : JS_IO ()
main = onReady $ do centre !(create $ win !dir)
