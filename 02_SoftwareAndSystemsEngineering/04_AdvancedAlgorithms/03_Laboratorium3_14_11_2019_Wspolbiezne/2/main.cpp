#include<iostream>
#include <omp.h>
#include <time.h>
#include <ctime>
using namespace std;

double areaFromThread[256];

double fun(double x) {
    return 4 * 1/(1+x*x);
}

int main()
{
    double overallSum = 0;
    double sumFromA = 0;
    double sumToB = 1;
    double dx = 0.000000001;

    double start_time = omp_get_wtime(); // returns number of seconds since the
                                        // initial value of the operating system

    #pragma omp parallel // parallel execution starts
    {
        int threads = omp_get_num_threads(); // returns number of threads currently
                                            // executing parallel block
        int currentThread = omp_get_thread_num(); // returns id of current thread

        double tempSum = 0;

        for(double x = sumFromA + (currentThread - 1) * dx; x < sumToB; x += threads * dx)
        {
            tempSum += fun(x) * dx;
        }
        areaFromThread[currentThread] = tempSum;
    }
    
    double time = omp_get_wtime() - start_time;

    for(int i = 0; i < 4; i++)
    {
        //cout << areaFromThread[i] << endl;
        overallSum += areaFromThread[i];
    }

    cout << "Sum equals " << overallSum << endl;
    cout << "time: " << time << "s" << endl;
    return 0;
}
