//
// Created by Dominik on 15.10.2019.
//

#ifndef UNTITLED_FUNCTIONS_H
#define UNTITLED_FUNCTIONS_H

#endif //UNTITLED_FUNCTIONS_H

void initializeArrays(int * da, int * pa, int vn, int sv);
void printArray(int * a, int vn);
void relax(int u, int v, int w, int * da, int * pa);
bool checkNegativeCycles(int u, int v, int w, int * da);