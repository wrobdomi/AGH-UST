#include <random>
#include <iostream>
#include <omp.h>

using namespace std;

bool isInCircle(double x, double y, double r) {
    return ((x * x) + (y * y)) <= (r * r);
}

double calculate(int iterations, int radius) {
   double pi_res = 0;

    int square_qty = 0;
    int circle_qty = 0;

    std::random_device rd;
    std::mt19937 mt(rd());
    std::uniform_real_distribution<double> dist(-radius, radius);

    for (auto i = 0; i < iterations; ++i) {
        ++square_qty;
        circle_qty += isInCircle(dist(mt), dist(mt), radius) ? 1 : 0;
    }

    pi_res = ((4 * (double)circle_qty) / square_qty);

    return pi_res;
}

int main(){

    // Start counting time now
    double startTime = omp_get_wtime();


    cout<< calculate(10000000,1)<<endl;
    double time = omp_get_wtime() - startTime;
    cout << "time: " << time << "s" << endl;

    return 0;
}