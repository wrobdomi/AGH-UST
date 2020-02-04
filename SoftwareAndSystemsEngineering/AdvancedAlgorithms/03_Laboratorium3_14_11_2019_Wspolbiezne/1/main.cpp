#include <iostream>
#include <time.h>

using namespace std;

double f1(double x) {
    return 4 * (1 / (1 + x * x));
}

int main(void)
{
    double wynik = 0;
    double a = 0;
    double b = 1;
    double dx = 0.000000001;

    int start_s = clock();

    for (double x = a; x < b; x += dx)
        wynik += f1(x)*dx;

    int stop_s=clock();

    cout << wynik <<endl;
    cout << "time: " << (stop_s-start_s)/double(CLOCKS_PER_SEC) << "s" << endl;

    return 0;
}

