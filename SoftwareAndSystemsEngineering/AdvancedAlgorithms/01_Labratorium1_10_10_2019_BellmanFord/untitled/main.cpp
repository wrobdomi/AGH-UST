#include <iostream>
#include "limits.h"
#include "functions.h"

int main() {
    std::cout << "Hello, World!" << std::endl;

    const int VERTEX_NUMBER = 5;
    const int EDGE_NUMBER = 10;
    const int START_VERTEX = 0;

    bool correctGraph = true;

    // List graph representation
    int listGraphArray[EDGE_NUMBER][3] =
            {
                { 0, 1, 6},
                { 0, 4, 7},
                { 1, 2, 5},
                { 1, 3, -4},
                { 1, 4, 8},
                { 2, 1, -2},
                { 3, 2, 7},
                { 3, 0, 2},
                { 4, 2, -3},
                { 4, 3, 9}
            };

    // matrix graph representation
    int matrixGraphArray[VERTEX_NUMBER][VERTEX_NUMBER] =
            {
                {0, 6, 0, 0, 7},
                {0, 0, 5, -4, 8},
                {0, -2, 0, 0, 0},
                {2, 0, 7, 0, 9},
                {0, 0, -3, 0, 0}
            };

    // Distance array and pi array
    int distanceArray[VERTEX_NUMBER];
    int piArray[VERTEX_NUMBER];

    // ListGraphRepresentation Processing START -------------------------------------------- //
    std::cout << "PROCESSING LIST GRAPH REPRESENTATION" << std::endl;
    initializeArrays(distanceArray, piArray, VERTEX_NUMBER, START_VERTEX);
    std::cout << "Initial distance array: " << std::endl;
    printArray(distanceArray, VERTEX_NUMBER);
    std::cout << "Initial pi array: " << std::endl;
    printArray(piArray, VERTEX_NUMBER);


    for(int i =0; i < VERTEX_NUMBER; i++){
        for(int j = 0; j < EDGE_NUMBER; j++){
            relax(listGraphArray[j][0], listGraphArray[j][1], listGraphArray[j][2], distanceArray, piArray);
        }
    }
    // Check negative cycles:
    for(int i = 0; i < EDGE_NUMBER; i++){
        correctGraph = checkNegativeCycles(listGraphArray[i][0], listGraphArray[i][1], listGraphArray[i][2], distanceArray);
        if(!correctGraph)
            break;
    }

    if(!correctGraph){
        std::cout << "Graph contains negative cycle !" << std::endl;
    }
    else{
        std::cout << "Solution distance array: " << std::endl;
        printArray(distanceArray, VERTEX_NUMBER);
        std::cout << "Solution pi array: " << std::endl;
        printArray(piArray, VERTEX_NUMBER);
    }

    // ListGraphRepresentation Processing ENDS -------------------------------------------- //

    // MatrixGraphRepresentation Processing START -------------------------------------------- //
    std::cout << "PROCESSING MATRIX GRAPH REPRESENTATION" << std::endl;
    initializeArrays(distanceArray, piArray, VERTEX_NUMBER, START_VERTEX);
    std::cout << "Initial distance array: " << std::endl;
    printArray(distanceArray, VERTEX_NUMBER);
    std::cout << "Initial pi array: " << std::endl;
    printArray(piArray, VERTEX_NUMBER);
    correctGraph = true;

    for(int i =0; i < VERTEX_NUMBER; i++){
        for(int j = 0; j < VERTEX_NUMBER; j++){
            for(int k = 0; k < VERTEX_NUMBER; k++){
                if(matrixGraphArray[j][k]==0){
                    continue;
                }
                else{
                    relax(j, k, matrixGraphArray[j][k], distanceArray, piArray);
                }
            }
        }
    }

    // Check negative cycles:
    for(int i = 0; i < VERTEX_NUMBER; i++){
        for(int j = 0; j < VERTEX_NUMBER; j++){
            if(matrixGraphArray[i][j] == 0){
                continue;
            }
            else{
                correctGraph = checkNegativeCycles(i, j, matrixGraphArray[i][j], distanceArray);
            }
            if(!correctGraph)
                break;
        }
        if(!correctGraph)
            break;
    }

    if(!correctGraph){
        std::cout << "Graph contains negative cycle !" << std::endl;
    }
    else{
        std::cout << "Solution distance array: " << std::endl;
        printArray(distanceArray, VERTEX_NUMBER);
        std::cout << "Solution pi array: " << std::endl;
        printArray(piArray, VERTEX_NUMBER);
    }

    // MatrixGraphRepresentation Processing ENDS -------------------------------------------- //
    return 0;
}


