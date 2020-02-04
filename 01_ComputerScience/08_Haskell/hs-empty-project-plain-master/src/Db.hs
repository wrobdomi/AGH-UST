module Db where

import Database.HDBC
import Database.HDBC.Sqlite3

data Student = Student {
    firstName::String,
    lastName::String,
    age::Int
} deriving (Show, Eq, Read)

queryCreateTable = "CREATE TABLE Students ( firstName CHAR(50) PRIMARY KEY NOT NULL, lastName CHAR(50) NOT NULL, age INT NOT NULL);"

s1 = Student "Damian" "Dab" 23
s2 = Student "Kamila" "Rodzynek" 22
s3 = Student "Filemon" "Kot" 21
s4 = Student "Bonifacy" "Kot" 23
s5 = Student "Alicja" "Czyzyk" 20

main :: IO ()
main = do
    putStrLn "Database App"

    -- *Connect to databse / created in hs-empty-project-plain-master from cmd line by typing: sqlite3 Students.db
    connection <- connectSqlite3 "Students.db"

    -- *Create table in database / run only once and commit connection
    -- runRaw connection queryCreateTable

    -- *Insert student to the table
    -- state <- prepare connection "INSERT INTO Students values (?,?,?);"
    -- execute state (studentToSql s2)
    -- commit connection

    -- *Fetch all rows from the table
    select <- prepare connection "SELECT * FROM Students"
    execute select []
    result <- fetchAllRows select
    putStrLn $ show result 

    -- *Delete student from the table
    -- delete <- prepare connection "DELETE FROM Students WHERE firstName == (?)"
    -- execute delete [toSql "Janek"]
    -- execute select []
    -- result <- fetchAllRows select
    -- putStrLn $ show result 


    -- *Update student in the table
    -- update <- prepare connection "UPDATE Students SET age = (?) WHERE firstName == (?)"
    -- execute update [toSql (25::Int), toSql "Marian"]
    -- commit connection
    -- execute select []
    -- result <- fetchAllRows select
    -- putStrLn $ show result 

    -- *Disconnect db
    disconnect connection

    return ()


studentToSql :: Student -> [SqlValue]
studentToSql (Student fn ln a) = [toSql fn, toSql ln, toSql (a::Int)]