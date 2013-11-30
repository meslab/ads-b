#include "squitter.h"
#include <string>
#include <iostream>
#include <assert.h>
#include <exception>

using namespace std;

squitter::squitter(std::string s_):in(s_) {
    //int len = in.length();
    for (unsigned int i = 0; i < in.length(); ++i){
        hex2dec(this->dec[i],s_[i]);
    }
}

std::string squitter::get_in()
{
    return this->in;
}

int* squitter::get_dec(){
    return this->dec;
}

int squitter::get_dec(int i){
    return this->dec[i];
}

void hex2dec(int& i, char& s){

    assert(i == 0);

        if (s <= '9' && s >= '0'){
            i = int(s - '0');
        } else if (s <= 'f' && s >= 'a'){
             i = (int(s) - 87);
        } else if (s <= 'F' && s >= 'A'){
             i = (int(s) - 55);
        } else {
            throw not_hex_exc();
        }
    }

squitter::~squitter()
{
    //dtor
}
