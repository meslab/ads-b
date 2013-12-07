#ifndef SQUITTER_SHORT_H
#define SQUITTER_SHORT_H

#include <squitter.h>

class squitter_short : public squitter {

public:
    squitter_short();
    squitter_short(std::string s);
    virtual ~squitter_short();
protected:
private:
    int dec[14]{};
};


#endif // SQUITTER_SHORT_H
