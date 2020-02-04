#include <iostream>
#include <algorithm>
#include <omp.h>
#include <chrono>
#include <vector>

using namespace std;

void mergeSort(vector<int> &array);
void sort(vector<int> &array, int lo, int hi);
void merge(vector<int> &array,  int lo, int mid, int hi);

int SIZE = 100000;

int main() {
    vector<int> array(SIZE);
    for(int i = 0; i < SIZE; i++) {
        array[i] = i;
    }
    random_shuffle(array.begin(), array.end());

    auto start = std::chrono::system_clock::now();
    mergeSort(array);
    auto end = std::chrono::system_clock::now();
    chrono::duration<double> time = end - start;
    cout << time.count() << endl;
    cout << "Sorted: " << is_sorted(array.begin(), array.end()) << endl;
}


void mergeSort(vector<int> &array){
    sort(array, 0, SIZE-1);
}

void sort(vector<int> &array, int lo, int hi){
    if (hi <= lo) {
        return;
    }

    int mid = lo + (hi - lo) / 2;
    sort(array, lo, mid);
    sort(array, mid+1, hi);
    merge(array,  lo, mid, hi);
}

void merge(vector<int> &array,  int lo, int mid, int hi){
    vector<int> auxiliary = array;

    int i = lo;
    int j = mid + 1;

    for (int k = lo; k<= hi; k++) {
        if (i > mid ) {
            array[k] = auxiliary[j++];
        } else if (j > hi) {
            array[k] = auxiliary[i++];
        } else if (auxiliary[j] < auxiliary[i]) {
            array[k] = auxiliary[j++];
        } else if (auxiliary[j] > auxiliary[i]) {
            array[k] = auxiliary[i++];
        }
    }
}

