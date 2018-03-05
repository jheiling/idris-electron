module JS.Electron.Window

import Control.Monad.Syntax
import Data.Foldable.Extras
import JS
import JS.Object

%default total
%access public export



record Options where
    constructor MkOptions
    title,
    url : Maybe String
    width,
    height : Maybe Nat
    fullscreen,
    frame : Bool

data Window = MkWindow Ptr



Cast Window Ptr where
    cast (MkWindow ptr) = ptr



defaults : Lazy Options
defaults = MkOptions Nothing Nothing Nothing Nothing False True



close : Window -> JS_IO ()
close = js "%0.close()" (Ptr -> JS_IO ()) . cast

setTitle : String -> Window -> JS_IO ()
setTitle title = js "%1.setTitle(%0)" (String -> Ptr -> JS_IO ()) title . cast

loadURL : String -> Window -> JS_IO ()
loadURL url = js "%1.loadURL(%0)" (String -> Ptr -> JS_IO ()) url . cast

setPosition : Nat -> Nat -> Window -> JS_IO ()
setPosition x y = js "%2.setPosition(%0, %1)" (Int -> Int -> Ptr -> JS_IO ()) (cast x) (cast y) . cast

centre : Window -> JS_IO ()
centre = js "%0.center()" (Ptr -> JS_IO ()) . cast

on : String -> JS_IO () -> Window -> JS_IO ()
on event func = assert_total $ js "(%2).on(%0, %1)" (String -> JsFn (() -> JS_IO ()) -> Ptr -> JS_IO ()) event (MkJsFn $ const func) . cast

onClosed : JS_IO () -> Window -> JS_IO ()
onClosed = on "closed"

create : Options -> JS_IO Window
create (MkOptions title url width height fullscreen frame) = do
    options <- empty
    iter (flip (setString "title") options) title
    iter (flip (setNat "width") options) width
    iter (flip (setNat "height") options) height
    setBool "fullscreen" fullscreen options
    setBool "frame" frame options
    win <- pure $ MkWindow !(js "new electron.BrowserWindow(%0)" (Ptr -> JS_IO Ptr) $ cast options)
    iter (flip loadURL win) url
    pure win
