#ifndef SQUITTER_H
#define SQUITTER_H

#include <string>

using namespace std;

class not_hex_exc: public exception {
    virtual const char* what() const throw(){
        return "Not a hex value";
    }
};

void hex2dec(int& i, char& s);

class squitter
{
public:
    squitter(std::string s_);
    virtual ~squitter();
    std::string get_in();
    long int get_dec();
    // void hex2dec(int& i_, char& c_);
protected:
private:
    std::string in;
    unsigned long int dec = 0;
};

#endif // SQUITTER_H
