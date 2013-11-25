#include <iostream>
#include <unistd.h>
#include <thread>

using namespace std;

void read_input()
{
    string in_line;
    cin >> in_line;
    try
    {
        unsigned int length = in_line.length();
        const char * line = in_line.c_str();

        while(length)
        {
            if (length == 16 || length == 30)
            {
                length = in_line.length();
                cout << line << " " << length << endl;
                cin >> in_line;
            }
        }
    }
    catch (exception& e)
    {
        cerr << e.what() << endl;
    }
}

void hello()
{
    while (true)
    {
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
