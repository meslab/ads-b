#ifndef SQUITTER_H
#define SQUITTER_H

#include <string>

class squitter
{
public:
    squitter(std::string s_);
    virtual ~squitter();
    std::string get_in();
    long int get_dec();
    void hex2dec(long int& i_, std::string& s_);
protected:
private:
    std::string in;
    long int dec;
};

#endif // SQUITTER_H
