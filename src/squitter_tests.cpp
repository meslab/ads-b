#include "squitter.h"
#include "UnitTest++.h"
#include <iostream>

namespace
{

TEST(get_in_test)
{
    std::string in = "ffffdebeaf";
    squitter* a = new squitter(in);
    CHECK_EQUAL(in,a->get_in());

    delete a;
}

TEST(hex_test_1)
{
        int t = 0;
        char c = '1';
        hex2dec(t,c);
        CHECK_EQUAL(1,t);
}


TEST(hex_test_over)
{
        int t = 0;
        char c = 'g';
        // hex2dec(t,c);
        CHECK_THROW(hex2dec(t,c), exception);
}

/*
TEST(get_bin_test1)
{
    std::string in = "ffffdebeaf";
    squitter* a = new squitter(in);
    CHECK_EQUAL(1099509448367,a->get_dec());

    delete a;
}
*/
}
