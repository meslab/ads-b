#include <iostream>
#include <unistd.h>
#include <thread>

using namespace std;

void read_input()
{
    string in_line;
    cin >> in_line;
    try {
        while(in_line.length()){
            cout << in_line << endl;
            cin >> in_line;
        }
    } catch (exception& e){
        cerr << e.what() << endl;
    }
}

void hello() {
    while (true) {
        cout << "Hello!" << endl;
        sleep(5);
    }
}

int main()
{
    try
    {
        thread t(read_input);
        thread h(hello);

        t.join();
        h.join();

    }
    catch (exception& e)
    {
        cout << e.what() << endl;
    }

    return 0;
}
