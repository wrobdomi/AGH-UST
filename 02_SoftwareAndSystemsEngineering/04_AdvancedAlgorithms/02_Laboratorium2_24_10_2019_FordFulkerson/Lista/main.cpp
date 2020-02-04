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

void printArr2D(int ** arr, int row, int col){
    for(int i = 0; i < row; i++){
        for(int j = 0; j < col; j++){
            cout << arr[i][j];
            cout << " ";
        }
        cout << endl;
    }
    cout << endl;
}

bool breadthFirstSearch(int **rList, int s, int e, int *path, int EDGE_NUM, int VERTEX_NUM) {

    bool visited[VERTEX_NUM];
    for(int i = 0; i < VERTEX_NUM; i++){
        visited[i] = false;
    }

    queue<int> q;
    q.push(s);
    visited[s] = true;
    path[s] = -1;

//    cout << s << " is s" << endl;

    while(!q.empty()){
        int u = q.front();
        q.pop();

        for(int i = 0; i < EDGE_NUM; i++){

            if(rList[i][0] == u){
                if(visited[rList[i][1]] == false && rList[i][2] > 0){
                    q.push(rList[i][1]);
                    path[rList[i][1]] = u;
                    visited[rList[i][1]] = true;
                }
            }
            if(rList[i][1] == u){
                if(visited[rList[i][0]] == false && rList[i][3] > 0){
                    q.push(rList[i][0]);
                    path[rList[i][0]] = u;
                    visited[rList[i][1]] = true;
                }
            }

        }

//        for(int v = 0; v < VERTEX_NUM; v++){
//            if(visited[v] == false && rList[u][v] > 0){
//                q.push(v);
//                path[v] = u;
//                visited[v] = true;
//            }
//        }
    }

    return (visited[e] == true);

}

int findMinFlowInPath(int *path, int s, int e, int **rList, int EDGE_NUM) {
    int minF = INT_MAX;
    for(int v = e; v != s; v = path[v]){
        int u = path[v]; // poprzednik v
        for(int i = 0; i < EDGE_NUM; i++) {
            if(u == rList[i][0] && v == rList[i][1]){
                minF = min(minF, rList[i][2]);
            }
            if(u == rList[i][1] && v == rList[i][0]){
                minF = min(minF, rList[i][3]);
            }
        }
    }
    return minF;
}

void updateResidualEdges(int *path, int **rList, int min_flow, int s, int e, int EDGE_NUM) {
    for(int v = e; v != s; v = path[v]){
        int u = path[v]; // poprzednik v
        for(int i = 0; i < EDGE_NUM; i++) {
            if(u == rList[i][0] && v == rList[i][1]){
                rList[i][2] -= min_flow;
                rList[i][3] += min_flow;
            }
            if(u == rList[i][1] && v == rList[i][0]){
                rList[i][2] += min_flow;
                rList[i][3] -= min_flow;
            }
        }
    }
}

void updateFlowEdges(int *path, int **fList, int s, int e, int min_flow, int EDGE_NUM) {
    for(int v = e; v != s; v = path[v]){
        int u = path[v]; // poprzednik v
        for(int i = 0; i < EDGE_NUM; i++) {
            if(u == fList[i][0] && v == fList[i][1]){
                fList[i][2] = fList[i][2] + min_flow;
                fList[i][3] = fList[i][3] - min_flow;
            }
            if(u == fList[i][1] && v == fList[i][0]){
                fList[i][2] = fList[i][2] - min_flow;
                fList[i][3] = fList[i][2] + min_flow;
            }
        }
    }

}


int FordFulkersonAlgorithm(int **rList, int **fList, int * path, int s, int e, int EDGE_NUM, int VERTEX_NUM) {
    int min_flow = 0;

    while(breadthFirstSearch(rList, s, e, path, EDGE_NUM, VERTEX_NUM)){
//        cout << "BFS" << endl;
//        printArr(path, VERTEX_NUM);
        min_flow = findMinFlowInPath(path, s, e, rList, EDGE_NUM);
//        cout << "Min flow found " << min_flow << endl;
        updateResidualEdges(path, rList, min_flow, s, e, EDGE_NUM);
        updateFlowEdges(path, fList, s, e, min_flow, EDGE_NUM);

        max_flow += min_flow;
    }

    return max_flow;
}



int main() {

    const char * listGraphFile = "listGraph.txt";

    // REPREZENTACJA LISTOWA GRAFU ----------------------------------------------- //

    ifstream inFile;
    inFile.open(listGraphFile);

    int VERTEX_NUMBER;
    int EDGE_NUMBER;
    int V_START;
    int V_END;

    inFile >> VERTEX_NUMBER;
    inFile >> EDGE_NUMBER;
    inFile >> V_START;
    inFile >> V_END;

    int ** weightList = new int *[EDGE_NUMBER];
    int ** residualList = new int *[EDGE_NUMBER];
    int ** flowList = new int *[EDGE_NUMBER];
    int path[VERTEX_NUMBER];

    for(int i = 0; i < EDGE_NUMBER; i++){
        weightList[i] = new int[3];
        residualList[i] = new int[4];
        flowList[i] = new int[4];
        path[i] = -1;
    }

    for(int i = 0; i < EDGE_NUMBER; i++){
        for(int j = 0; j < 4; j++){
            if(j < 3){
                inFile >> weightList[i][j];
                residualList[i][j] = weightList[i][j];
            }
            else{
                residualList[i][j] = 0;
            }
            if(j < 2){
                flowList[i][j] = weightList[i][j];
            }
            else{
                flowList[i][j] = 0;
            }
        }
    }

//    printArr2D(weightList, EDGE_NUMBER, 3);
//    printArr2D(residualList, EDGE_NUMBER, 4);
//    printArr2D(flowList, EDGE_NUMBER, 4);
//    printArr(path, VERTEX_NUMBER);

    int f = FordFulkersonAlgorithm(residualList, flowList, path, V_START, V_END, EDGE_NUMBER, VERTEX_NUMBER);

    cout << "MAX FLOW: " << endl;
    cout << f;
    cout << endl << endl;
    cout << "Residual Matrix: " << endl;
    printArr2D(residualList, EDGE_NUMBER, 4);
    cout << "Flow Matrix: " << endl;
    printArr2D(flowList, EDGE_NUMBER, 4);

    return 0;

    return 0;
}

