#include "squitter.h"
#include <string>

squitter::squitter(std::string s_):in(s_) {

    hex2dec(dec,in);
}

std::string squitter::get_in()
{
    return this->in;
}

long int squitter::get_dec(){
    return this->dec;
}

void squitter::hex2dec(long int& i_, std::string& s_){

    this->dec = i_;
    this->in = s_;




}

squitter::~squitter()
{
    //dtor
}
