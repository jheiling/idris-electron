module Utils

%default total
%access export



infixl 5 >=>

(>=>) : Monad m => (a -> m b) -> (b -> m c) -> a -> m c
(>=>) f g x = f x >>= g

iter : Foldable t => Monad m => (a -> m ()) -> t a -> m ()
iter f = foldlM (\(), x => f x) ()
