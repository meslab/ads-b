#include <iostream>
#include <unistd.h>

using namespace std;

int main()
{

    for (uint64_t t=1, i=0;i<64;++i,t <<= 1){
        cout << t << " ";
    }
    cout << endl;
}
