module MyApp where

    import qualified Data.Map as Map

    data MyStudent = MyStudent {
        name :: String, 
        age :: Int, 
        id :: String
    } deriving (Show)

    studentsMap = Map.empty

    main :: Map.Map String MyStudent -> IO ()
    main myMap = do
        putStrLn("1. Dodaj nowego studenta.")
        putStrLn("2. Wyswietl wszystkich studentow.")
        putStrLn("3. Usun studenta o zadanym numerze indeksu")
        putStrLn("4. Zakoncz prace z programem")
        choice <- getLine
        let number = read choice :: Int
        case number of 1 -> do
                                putStrLn("Students name:")
                                sName <- getLine
                                putStrLn("Students age:")
                                age <- getLine
                                let sAge = read age :: Int
                                putStrLn("Students id:")
                                sId <- getLine
                                let studentsMap = Map.insert sId (MyStudent sName sAge sId) myMap
                                main studentsMap
                       2 -> do 
                                putStrLn ( show myMap )
                                main myMap
                       3 -> do
                                putStrLn("Remove student with id:")
                                sId <- getLine
                                let studentsMap = Map.delete sId myMap
                                main studentsMap
                       4 -> return ()
                       