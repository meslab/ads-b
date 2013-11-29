#include <iostream>

using namespace std;

class B {
public:
    int i;
    virtual void print_i() const {
        cout << i << " inside B" << endl;
    }
};

class D:public B {
public:
    void print_i() const {
        cout << i << " inside D" << endl;
    }
};

int main()
{

    B b;
    B* pb = &b;
    D d;
    d.i = 1 + (b.i = 1);

    pb->print_i();
    b.print_i();
    d.print_i();
    pb = &d;
    pb->print_i();

    b.print_i();
    d.print_i();


    return 0;
}
