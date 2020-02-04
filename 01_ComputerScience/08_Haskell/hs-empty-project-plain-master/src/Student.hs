module Student where
    
    data Student = Student {
        firstName :: String,
        lastName :: String,
        age :: Int
    } deriving (Show)

    data StudentsFirstNameChangeEvent = StudentsFirstNameChangeEvent {
        oldName :: String,
        newName :: String
    } deriving (Show)

    instance Eq Student where
        (Student fn1 ln1 a1) == (Student fn2 ln2 a2) = fn1 == fn2 && ln1 == ln2 && a1 == a2


    listToProcess = [Student "Alicja" "Akla" 21, Student "Bartek" "Bodo" 20, 
        Student "Celina" "Czyzyk" 21, Student "Damian" "Dab" 22, Student "Eustachy" "Elo" 20]

    modifiedList = [Student "AlicjaX" "Akla" 21, Student "BartekX" "Bodo" 20, 
        Student "Celina" "Czyzyk" 21, Student "DamianX" "Dab" 22, Student "Eustachy" "Elo" 20]

    fullName :: Student -> String
    fullName student = firstName student ++ " " ++ lastName student

    -- Utworzyc listę zawierającą pełne imiona i nazwiska studentów w postaci łańcuchów znaków
    -- -- --
    listFullNames :: [Student] -> [String]
    listFullNames studentsList = [fullName s | s <- studentsList]
    -- -- --

    -- Przy uzyciu map
    -- -- --
    listFullNames' :: [Student] -> [String]
    listFullNames' studentsList = map fullName studentsList
    -- -- --

    -- Przy uzyciu foldl
    -- -- -- 
    listFullNames1' :: [Student] -> [String]
    listFullNames1' xs = foldl (\acc (Student f l a) -> (f ++ " " ++ l) : acc) [] xs


    -- Utworzyć listę zawierającą pary w postaci krotek: numer porządkowy, student
    
    -- Przy uzyciu zip
    -- -- --
    listNumberedStudents :: [Student] -> [(Int, Student)]
    listNumberedStudents studentsList = zip [1,2..] studentsList
    -- -- --

    -- Przy uzyciu czystej rekurencji
    -- -- -- 
    listNumberedStudents' :: Int -> [Student] -> [(Int, Student)]
    listNumberedStudents' _ [] = []
    listNumberedStudents' a (x:xs) = (a,x) : listNumberedStudents' (a+1) xs
    -- -- -- 

    -- Przetworzyć listę z powyższego punktu na raport tekstowy w formacie
    -- 1. student: Nazwisko I. wiek: Wiek
    -- 2. student: Nazwisko2 I2. wiek: Wiek
    listReport :: [Student] -> IO ()
    listReport studentsList = mapM_ putStrLn ( [((show n) ++ ". student: " ++ naz ++ " " ++ ([(im !! 0)]) ++ ". wiek: " ++ (show wiek) )  
                                        | (n, (Student im naz wiek)) <- (listNumberedStudents studentsList)] )

    -- analogiczna funkcje mozna napisac przy uzyciu map oraz foldl

    -- Wygenerowac liste zmian w postaci typu wydarzenia, StudentsFirstNameChangeEvent oldName newName, 
    -- przez utworzenie zmodyfikowanej listy studentów, a następnie porównanie (pod tymi samymi
    -- pozycjami powinni się znajdowć ci sami studenci )
    listChanges :: [Student] -> [Student] -> [StudentsFirstNameChangeEvent]
    listChanges [] [] = []
    listChanges ((Student oi on ow):orginalStudents) ((Student mi mn mw):modifiedStudents) 
        | oi /= mi = (StudentsFirstNameChangeEvent oi mi) : (listChanges orginalStudents modifiedStudents)
        | oi == mi = listChanges orginalStudents modifiedStudents

  
    