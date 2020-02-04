#include <random>
#include <iostream>
#include <omp.h>

using namespace std;

bool isInCircle(double x, double y, double r) {
    return ((x * x) + (y * y)) <= (r * r);
}

double calculate(int iterations, int radius) {
    std::random_device rd;
    std::mt19937 mt(rd());
    std::uniform_real_distribution<double> dist(-radius, radius);

    int square_qty = 0;
    int circle_qty = 0;

#pragma omp parallel for reduction (+ : circle_qty, square_qty)
    for (int i = 0; i < iterations; ++i) {
        square_qty += 1;
        circle_qty += isInCircle(dist(mt), dist(mt), radius) ? 1 : 0;
    }

    return ((4 * (double)circle_qty) / square_qty);
}

int main(){

    double start_time = omp_get_wtime();
    cout<< calculate(10000000,1)<<endl;
    double time = omp_get_wtime() - start_time;
    cout << "time: " << time << "s" << endl;

    return 0;
}