#include <iostream>
#include <omp.h>
using namespace std;

double fun(double x)
{
    return 4 * 1/(1+x*x);
}

int main(void)
{  
    double suma = 0;
    double a = 0;
    double b = 1;
    double dx = 0.000000001;
    int lp = (b-a)/dx;
    
    double start_time = omp_get_wtime();

	#pragma omp parallel for reduction(+:suma)
    for(int i=0; i<lp; i++)
    {
        suma += fun(dx*i)*dx;
    }

    double time = omp_get_wtime() - start_time;

    cout << suma << endl;
    cout << "time: " << time << "s" << endl;
    return 0;
}