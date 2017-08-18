module Electron.Window

import JS
import Foldable.Extras
import Monad.Extras

%default total
%access public export



data Window = MkWindow Ptr

data Option = Title String
            | Fullscreen
            | Width Nat
            | Height Nat

Cast Window Ptr where
  cast (MkWindow ptr) = ptr



utWindow : JS_IO Ptr
utWindow = js "new electron.BrowserWindow()" (JS_IO Ptr)

utSetOption : Option -> Ptr -> JS_IO ()
utSetOption (Title t) = js "%1.title = %0" (String -> Ptr -> JS_IO ()) t
utSetOption Fullscreen = js "%0.fullscreen = true" (Ptr -> JS_IO ())
utSetOption (Width w) = js "%1.width = %0" (Double -> Ptr -> JS_IO ()) $ cast w
utSetOption (Height h) = js "%1.height = %0" (Double -> Ptr -> JS_IO ()) $ cast h

utOptions : Foldable f => f Option -> JS_IO Ptr
utOptions opts = do optsObj <- object
                    iter (flip utSetOption optsObj) opts
                    pure optsObj

utWindowWith : Ptr -> JS_IO Ptr
utWindowWith = js "new electron.BrowserWindow(%0)" (Ptr -> JS_IO Ptr)

utClose : Ptr -> JS_IO ()
utClose = js "%0.close()" (Ptr -> JS_IO ())

utSetTitle : String -> Ptr -> JS_IO ()
utSetTitle = js "%1.setTitle(%0)" (String -> Ptr -> JS_IO ())

utLoadURL : String -> Ptr -> JS_IO ()
utLoadURL = js "%1.loadURL(%0)" (String -> Ptr -> JS_IO ())

utSetPosition : Int -> Int -> Ptr -> JS_IO ()
utSetPosition = js "%2.setPosition(%0, %1)" (Int -> Int -> Ptr -> JS_IO ())

utCentre : Ptr -> JS_IO ()
utCentre = js "%0.center()" (Ptr -> JS_IO ())

utOn : String -> JS_IO () -> Ptr -> JS_IO ()
utOn event func obj = assert_total $
  js "(%2).on(%0, %1)" (String -> JsFn (() -> JS_IO ()) -> Ptr -> JS_IO ())
     event (MkJsFn $ const func) obj



window : JS_IO Window
window = utWindow >>= (pure . MkWindow)

windowWith : Foldable f => f Option -> JS_IO Window
windowWith = utOptions >=> utWindowWith >=> (pure . MkWindow)

close : Window -> JS_IO ()
close = utClose . cast

setTitle : String -> Window -> JS_IO ()
setTitle title = utSetTitle title . cast

loadURL : String -> Window -> JS_IO ()
loadURL url = utLoadURL url . cast

setPosition : Nat -> Nat -> Window -> JS_IO ()
setPosition x y = utSetPosition (cast x) (cast y) . cast

centre : Window -> JS_IO ()
centre = utCentre . cast

on : String -> JS_IO () -> Window -> JS_IO ()
on event func = utOn event func . cast

onClosed : JS_IO () -> Window -> JS_IO ()
onClosed = on "closed"
