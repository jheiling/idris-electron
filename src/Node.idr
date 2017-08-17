module Node

import JS

%default total
%access export


getDir : JS_IO String
getDir = js "__dirname" (JS_IO String)
