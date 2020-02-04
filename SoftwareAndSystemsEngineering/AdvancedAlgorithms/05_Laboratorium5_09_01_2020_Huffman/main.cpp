#include <bits/stdc++.h>
#include <fstream>
#include <sstream>
#include <string>

using namespace std;

map<char, string> huffmanValues; // char -> code mapping

// node representation
struct Node
{
	char character;
	int frequency;
	Node *left, *right;

	Node(char character, int frequency)
	{
		left = right = NULL;
		this->character = character;
		this->frequency = frequency;
	}
};

// compare values on the heap
struct Comparator
{
	bool operator()(Node* left, Node* right)
	{
		return (left->frequency > right->frequency);
	}
};

// Priority queue storing Huffman Tree according to number of occurrences in non increasing order
priority_queue<Node*, vector<Node*>, Comparator> tree; // <data type, container, comparator>

// Go from tree root to leaves and generate Huffman code for every character
void storeHuffmanValues(struct Node* root, string text)
{
	if (root == NULL)
		return;

	if (root->character != '@')
		huffmanValues[root->character] = text;

	storeHuffmanValues(root->left, text + "0");
	storeHuffmanValues(root->right, text + "1");
}

// Build Huffman tree
void buildHuffmanTree(string text)
{
	struct Node *left, *right, *top;

	map<char, int> frequencies; // char -> number of occurrences

	// Filling char -> number of occurrences map
	for (int i = 0; i < text.size(); i++)
		frequencies[text[i]]++;

	for (map<char, int>::iterator it = frequencies.begin(); it != frequencies.end(); it++)
		tree.push(new Node(it->first, it->second));


	while (tree.size() != 1)
	{
	    cout << tree.size();
		left = tree.top(); // access top element, with highest frequency value
		tree.pop();
		right = tree.top();
		tree.pop();
		top = new Node('@', left->frequency + right->frequency);
		top->left = left;
		top->right = right;
		tree.push(top);
	}

	storeHuffmanValues(tree.top(), "");
}

// Funkcja dekodująca zakodowany tekst, przechodzi po każdym znaku w tekście,
// jeśli napotka 0 to idzie w lewego child'a, jeśli jeden to w prawego
// jeśli natrafi na węzeł liścia dodaje znak do wynikowego tekstu
string decodeText(struct Node* root, string text)
{
	string result = "";
	struct Node* current = root;

	for (int i = 0; i < text.size(); i++)
	{
		if (text[i] == '0')
			current = current->left;
		else
			current = current->right;

		// Jeśli osiągnelismy węzeł liscia -> dodaj znak do wyniku
		if (current->left == NULL and current->right == NULL)
		{
			result += current->character;
			current = root;
		}
	}

	return result;
}

void encode(){
	ifstream file;
	string fileName = "text.txt"; // input file
	string text, encodedText;
	ofstream frequenciesFile, resultFile;
	string frequenciesFileName = "frequencies.txt";
	string resultFileName = "encoded.txt";


	file.open(fileName);


	getline(file, text);
	// cout << "File content is: ";
	// cout << text;
	// cout << "Content size is: ";
	// cout << text.size();
	file.close();

	buildHuffmanTree(text);

    // iterate over every character and concatenate its huffman code
	for (auto i: text)
		encodedText += huffmanValues[i];

	// save codes to file
	frequenciesFile.open(frequenciesFileName, ios_base::app);

	for (auto it = huffmanValues.begin(); it != huffmanValues.end(); it++)
		frequenciesFile << it->first << ": " << it->second << endl;

	frequenciesFile.close();

	resultFile.open(resultFileName, ios_base::app);

	// save result to file
	resultFile << encodedText;
	resultFile.close();
}

void decode(){
	ifstream file;
	string fileName = "encoded.txt";
	string text, decodedText;

	file.open(fileName);
	getline(file, text);
	file.close();

	decodedText = decodeText(tree.top(), text);

	ofstream resultFile;
	string resultFileName = "decoded.txt";

	resultFile.open(resultFileName, ios_base::app);
	resultFile << decodedText;
	resultFile.close();
}

int main()
{
  	encode();

	decode();

	cout << "SUCCESS!!!" << endl;

	return 0;
}
