#ifndef SQUITTER_H
#define SQUITTER_H

#include <string>

using namespace std;

class not_hex_exc : public exception {
    virtual const char* what() const throw(){
        return "Not a hex value";
    }
};

void hex2dec(int& i, char& s);

class squitter
{
public:
    squitter(std::string s);
    virtual ~squitter();
    std::string get_in();
    int* get_dec();
    int get_dec(int i);
    // void hex2dec(int& i_, char& c_);
protected:
    std::string in;
    int dec[28]{};
};

#endif // SQUITTER_H
