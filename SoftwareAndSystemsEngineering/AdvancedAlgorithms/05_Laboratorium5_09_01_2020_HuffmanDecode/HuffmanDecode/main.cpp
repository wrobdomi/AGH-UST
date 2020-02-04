#include <bits/stdc++.h>
#include <fstream>
#include <sstream>
#include <string>

using namespace std;

map<string, char> codesMap;


string decodeText(string text)
{
    string result = "";
    string temp;

    for (int i = 0; i < text.size(); i++)
    {
        temp += text[i];

        if(codesMap.count(temp)){
            result += codesMap[temp];
            temp = "";
        }

    }

    return result;
}



void decode(){
    ifstream file;
    string fileName = "encoded.txt";
    string text, decodedText;

    file.open(fileName);
    getline(file, text);
    file.close();

    decodedText = decodeText(text);

    ofstream resultFile;
    string resultFileName = "decoded.txt";

    resultFile.open(resultFileName, ios_base::app);
    resultFile << decodedText;
    resultFile.close();
}


void getMap() {

     bool isSpace = true;

    ifstream file;
    string fileName = "frequencies.txt";
    string line;

    file.open(fileName);

    while(getline(file, line)){

        std::replace(line.begin(), line.end(), ':', ' ');  // replace ':' by ' '

        vector<string> array;
        stringstream ss(line);
        string temp;
        while (ss >> temp) {
            array.push_back(temp);
        }

        if(isSpace == true) {
            codesMap[array[0]] = ' ';
            isSpace = false;
            continue;
        }

        // cout << array.size();
        cout << array[0];
        cout << array[1];

        cout << endl;
        codesMap[array[1]] = array[0][0];

    }

    file.close();

}


int main() {
    getMap();


// print codes map
//    for(auto it = codesMap.cbegin(); it != codesMap.cend(); ++it)
//    {
//        std::cout << it->first << " " << it->second << " " << "\n";
//    }

    decode();

}