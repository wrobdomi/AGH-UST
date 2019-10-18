sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' xs = foldr (\x acc -> x + acc) 0 xs

product' :: (Num a) => [a] -> a
product' [] = 1
product' xs = foldr (\x acc -> x * acc) 1 xs

reverse' :: [a] -> [a]
reverse' [] = []
reverse' xs = foldl (\acc x -> x : acc) [] xs

and' :: [Bool] -> Bool
and' [] = False
and' xs = foldr (\x acc -> x && acc) True xs

or' :: [Bool] -> Bool
or' [] = False
or' xs = foldr (\x acc -> x || acc) False xs

head' :: [a] -> a
head' [] = error "Empty list"
head' xs = foldr1(\x acc -> x) xs

last' :: [a] -> a
last' [] = error "Empty list"
last' xs = foldl1(\acc x -> x) xs