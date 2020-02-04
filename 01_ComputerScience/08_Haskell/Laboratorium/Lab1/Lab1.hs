-- -------------------------------------------------------
-- head 

head'1 :: [a] -> a
head'1 [] = error "Empty list"
head'1 (x:xs) = x

-- head'2 :: [a] -> a
-- head'2 xs = case xs of [] -> error "Empty list"
-- 					   (x:_) -> x

-- -------------------------------------------------------
-- length 

length'1 :: (Num a) => [b] -> a
length'1 [] = 0
length'1 xs = sum [1 | x <- xs]

length'2 :: (Num a) => [b] -> a
length'2 [] = 0
length'2 (_:xs) = 1 + length'2 xs

-- -------------------------------------------------------
-- take
take'1 :: (Num a, Ord a) => a -> [b] -> [b]
take'1 a _
	| a <= 0 = []
take'1 _ [] = [] 
take'1 a (x:xs) = x : take'1 (a-1) xs


-- -------------------------------------------------------
-- map
map'1 :: (a -> b) -> [a] -> [b]
map'1 _ [] = []
map'1 f xs = foldr (\x acc -> f x : acc) [] xs

map'2 :: (a -> b) -> [a] -> [b]
map'2 _ [] = []
map'2 f xs = [f x | x <- xs]

map'3 :: (a -> b) -> [a] -> [b]
map'3 _ [] = []
map'3 f (x:xs) = f x : map'3 f xs

-- -------------------------------------------------------
-- ++ 
(++--) :: [a] -> [a] -> [a]
(++--) xs [] = xs
(++--) [] xs = xs
(++--) (x1:xs) xp = x1 : (++--) xs xp

-- -------------------------------------------------------
-- maximum
maximum' :: (Ord a) => [a] -> a
maximum' [] = error "Empty list"
maximum' [x] = x
maximum' (x:xs)
	| x > maxValue = x
	| otherwise = maxValue
	where maxValue = maximum' xs
	
-- -------------------------------------------------------
-- replicate
replicate' :: (Num a, Ord a) => a -> b -> [b]
replicate' a b
	| a <= 0 = []
	| otherwise = b : replicate' (a-1) b

-- -------------------------------------------------------
-- zip
zip' :: [a] -> [b] -> [(a,b)]
zip' _ [] = []
zip' [] _ = []
zip' (x:xs) (y:xp) = (x, y) : zip' xs xp

-- -------------------------------------------------------
-- elem
elem' :: (Eq a) => a -> [a] -> Bool
elem' _ [] = False
elem' a (x:xs)
	| a == x = True
	| otherwise = elem' a xs