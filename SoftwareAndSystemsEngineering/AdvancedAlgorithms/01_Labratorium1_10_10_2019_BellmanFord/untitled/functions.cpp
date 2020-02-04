//
// Created by Dominik on 15.10.2019.
//

#include "functions.h"

#include <iostream>
#include "limits.h"
//
// Created by Dominik on 15.10.2019.
//
void initializeArrays(int * da, int * pa, int vn, int sv){
    for(int i = 0; i < vn; i++ ){
        pa[i] = -1;
        da[i] = INT_MAX;
    }
    da[sv] = 0;
}


void printArray(int * a, int vn){
    for(int i = 0; i < vn; i++){
        std::cout << " " << a[i] << " ";
    }
    std::cout << std::endl;
}

void relax(int u, int v, int w, int * da, int * pa){
    if(da[v] > da[u] + w){
        da[v] = da[u] + w;
        pa[v] = u;
    }
}

bool checkNegativeCycles(int u, int v, int w, int * da){
    if(da[v] > da[u] + w){
        return false;
    }
    return true;
}