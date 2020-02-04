#include <iostream>


#include <iomanip>
#include <fstream>
#include <queue>
#include "limits.h"

using namespace std;

int max_flow = 0;

void printArr(int * arr, int length){
    for(int i = 0; i < length; i++){
        cout << arr[i];
        cout << " ";
    }
    cout << endl;
}

void printArr2D(int ** arr, int length){
    for(int i = 0; i < length; i++){
        for(int j = 0; j < length; j++){
            cout << arr[i][j];
            cout << " ";
        }
        cout << endl;
    }
    cout << endl;
}

bool breadthFirstSearch(int ** rGraph, int s, int e, int * path, int V){

    bool visited[V];
    for(int i = 0; i < V; i++){
        visited[i] = false;
    }

    queue<int> q;
    q.push(s);
    visited[s] = true;
    path[s] = -1;

    while(!q.empty()){
        int u = q.front();
        q.pop();

        for(int v = 0; v < V; v++){
            if(visited[v] == false && rGraph[u][v] > 0){
                q.push(v);
                path[v] = u;
                visited[v] = true;
            }
        }
    }

    return (visited[e] == true);
}

int findMinFlowInPath(int * path, int s, int e, int ** rGraph) {
    int minF = INT_MAX;
    for(int v = e; v != s; v = path[v]){
        int u = path[v]; // poprzednik v
        minF = min(minF, rGraph[u][v]);
    }
    return minF;
}

void updateResidualEdges(int * path, int **rGraph, int min_flow, int s, int e) {
    for(int v = e; v != s; v = path[v]){
        int u = path[v]; // poprzednik v
        rGraph[u][v] -= min_flow;
        rGraph[v][u] += min_flow;
    }
}

void updateFlowEdges(int *path, int **fGraph, int s, int e, int min_flow) {
    for(int v = e; v != s; v = path[v]){
        int u = path[v]; // poprzednik v
        fGraph[u][v] = fGraph[u][v] + min_flow ;
        fGraph[v][u] = fGraph[v][u] - min_flow;
    }
}


int FordFulkersonAlgorithm(int ** rGraph, int ** fGraph ,int * path, int s, int e, int V){
    int min_flow = 0;
    while(breadthFirstSearch(rGraph, s, e, path, V)){
        min_flow = findMinFlowInPath(path, s, e, rGraph);
//        cout << "Min flow found is " << min_flow << endl;
        updateResidualEdges(path, rGraph, min_flow, s, e);
        updateFlowEdges(path, fGraph, s, e, min_flow);
        max_flow += min_flow;
    }
    return max_flow;
}



int main() {

    const char * matrixGraphFile = "matrixGraph.txt";
    const char * listGraphFile = "listGraph.txt";

    // REPREZENTACJA MACIERZOWA GRAFU ----------------------------------------------- //

    ifstream inFile;
    inFile.open(matrixGraphFile);

    int VERTEX_NUMBER;
    int EDGE_NUMBER;
    int V_START;
    int V_END;

    inFile >> VERTEX_NUMBER;
    inFile >> EDGE_NUMBER;
    inFile >> V_START;
    inFile >> V_END;

    int ** weightMatrix = new int *[VERTEX_NUMBER];
    int ** residualMatrix = new int *[VERTEX_NUMBER];
    int ** flowMatrix = new int *[VERTEX_NUMBER];
    int path[VERTEX_NUMBER];

    for(int i = 0; i < VERTEX_NUMBER; i++){
        weightMatrix[i] = new int[VERTEX_NUMBER];
        residualMatrix[i] = new int[VERTEX_NUMBER];
        flowMatrix[i] = new int[VERTEX_NUMBER];
        path[i] = -1;
    }

    for(int i = 0; i < VERTEX_NUMBER; i++){
        for(int j = 0; j < VERTEX_NUMBER; j++){
            inFile >> weightMatrix[i][j];
            residualMatrix[i][j] = weightMatrix[i][j];
            flowMatrix[i][j] = 0;
        }
    }

//    printArr(path, VERTEX_NUMBER);
//    printArr2D(weightMatrix, VERTEX_NUMBER);
//    printArr2D(residualMatrix, VERTEX_NUMBER);
//    printArr2D(flowMatrix, VERTEX_NUMBER);

//    breadthFirstSearch(residualMatrix, V_START, V_END, path, VERTEX_NUMBER);
//    printArr(path, VERTEX_NUMBER);

    int f = FordFulkersonAlgorithm(residualMatrix, flowMatrix, path, V_START, V_END, VERTEX_NUMBER);

    cout << "MAX FLOW: " << endl;
    cout << f;
    cout << endl << endl;
    cout << "Residual Matrix: " << endl;
    printArr2D(residualMatrix, VERTEX_NUMBER);
    cout << "Flow Matrix: " << endl;
    printArr2D(flowMatrix, VERTEX_NUMBER);

    return 0;
}