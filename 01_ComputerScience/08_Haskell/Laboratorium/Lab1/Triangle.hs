-- Basic Triangle
[(a,b,c) | a <- [3..17], b <- [3..17], c <- [3..17], a+b > c, a+c > b, c+b > a, a <= b, b <= c ]

-- Square Triangle
[(a,b,c) | a <- [3..17], b <- [3..17], c <- [3..17], a+b > c, a+c > b, c+b > a, a <= b, b <= c, (a^2 + b^2) == c^2 ]