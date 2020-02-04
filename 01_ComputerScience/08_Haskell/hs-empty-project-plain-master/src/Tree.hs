module Tree 
where
    
data Tree a =    
    Branch a (Tree a) (Tree a)
    | Leaf
-- deriving (Show)

instance Show a => Show (Tree a) where
    show (Leaf) = "I am leaf !"  
    show (Branch v l r) = "Value is " ++ show v ++ " || Left is " ++ show l ++ " || Right is " ++ show r

instance Eq a => Eq (Tree a) where  
    Leaf == Leaf = True
    (Branch v1 l1 r1) == (Branch v2 l2 r2) = (v1 == v2) && (l1 == l2) && (r1 == r2)

instance Functor Tree where
    fmap f Leaf = Leaf
    fmap f (Branch x left right) = Branch (f x) (fmap f left) (fmap f right)

-- instance Applicative Tree where
--     pure a = Tree a
--     liftA2 _ Leaf _ = Leaf
--     liftA2 Leaf _ = Leaf
--     liftA2 f (Branch x1 l1 r1) (Branch x2 l2 r2) = liftA2 (f x1 x2) (liftA2 f l1 l2) (liftA2 f r1 r2)


createTree :: a -> Tree a
createTree x = Branch x Leaf Leaf

insertTree :: (Ord a) => a  -> Tree a -> Tree a
insertTree x Leaf = createTree x
insertTree x (Branch y left right)
    | x == y = Branch x left right
    | x < y = Branch y (insertTree x left) right
    | x > y = Branch y left (insertTree x right)

searchTree :: (Ord a) => a -> Tree a -> Bool
searchTree y Leaf = False
searchTree y (Branch x left right) 
    | y == x = True
    | y < x = searchTree y left
    | y > x = searchTree y right

traverseLVR :: (Ord a) => Tree a -> [a] 
traverseLVR Leaf = []
traverseLVR (Branch x left right) = (traverseLVR left) ++ [x] ++ (traverseLVR right)

traverseVLR :: (Ord a) => Tree a -> [a]
traverseVLR Leaf = []
traverseVLR (Branch x left right) = [x] ++ (traverseVLR left) ++ (traverseVLR right)

traverseRLV :: (Ord a) => Tree a -> [a]
traverseRLV Leaf = []
traverseRLV (Branch x left right) = (traverseRLV right) ++ (traverseRLV left) ++ [x]

remove :: (Ord a) => a -> Tree a -> Tree a
remove a Leaf = error "Element is not here"
remove a (Branch x left right) 
    | x == a = removeNode (Branch x left right)
    | a < x = Branch x (remove a left) right
    | a > x = Branch x left (remove a right)

removeNode :: (Ord a) => Tree a -> Tree a
removeNode (Branch x Leaf right) = right
removeNode (Branch x left Leaf) = left
removeNode (Branch x left right) = Branch (mostLeft right) left right

mostLeft :: (Ord a) => Tree a -> a
mostLeft (Branch x Leaf right) = x
mostLeft (Branch x left right) = mostLeft left

