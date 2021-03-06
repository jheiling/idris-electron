module Js.Electron.Window

import Control.Monad.Syntax
import Data.Foldable.Extras
import Js
import Js.Object

%default total
%access export



public export
record Options where
    constructor MkOptions
    title,
    url : Maybe String
    width,
    height : Maybe Nat
    fullscreen,
    frame : Bool

defaults : Lazy Options
defaults = MkOptions Nothing Nothing Nothing Nothing False True



public export
data Window = MkWindow Ptr

Class Window where
    ptr (MkWindow p) = p

close : Window -> JS_IO ()
close = js "%0.close()" (Ptr -> JS_IO ()) . ptr

setTitle : String -> Window -> JS_IO ()
setTitle title = js "%1.setTitle(%0)" (String -> Ptr -> JS_IO ()) title . ptr

loadURL : String -> Window -> JS_IO ()
loadURL url = js "%1.loadURL(%0)" (String -> Ptr -> JS_IO ()) url . ptr

setPosition : Nat -> Nat -> Window -> JS_IO ()
setPosition x y = js "%2.setPosition(%0, %1)" (Int -> Int -> Ptr -> JS_IO ()) (cast x) (cast y) . ptr

centre : Window -> JS_IO ()
centre = js "%0.center()" (Ptr -> JS_IO ()) . ptr

on : String -> JS_IO () -> Window -> JS_IO ()
on event func = assert_total $ js "(%2).on(%0, %1)" (String -> JsFn (() -> JS_IO ()) -> Ptr -> JS_IO ()) event (MkJsFn $ const func) . ptr

onClosed : JS_IO () -> Window -> JS_IO ()
onClosed = on "closed"

create : Options -> JS_IO Window
create (MkOptions title url width height fullscreen frame) = do
    options <- empty
    iter (flip (set "title") options) title
    iter (flip (set "width") options) width
    iter (flip (set "height") options) height
    set "fullscreen" fullscreen options
    set "frame" frame options
    win <- MkWindow <$> js "new electron.BrowserWindow(%0)" (Ptr -> JS_IO Ptr) (ptr options)
    iter (flip loadURL win) url
    pure win
