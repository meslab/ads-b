#include "squitter.h"
#include "squitter_short.h"
#include "UnitTest++.h"
#include <iostream>

namespace
{

SUITE(Squitter)
{
    TEST(get_in_test)
    {
        std::string in = "ffffdebeaf";
        squitter* a = new squitter(in);
        CHECK_EQUAL(in,a->get_in());

        delete a;
    }

    TEST(get_bin_test_1)
    {
        std::string in = "f";
        squitter* a = new squitter(in);
        CHECK_EQUAL(15,(a->get_dec(0)));

        delete a;
    }

    TEST(get_bin_test_2)
    {
        std::string in = "ff";
        squitter* a = new squitter(in);
        CHECK_EQUAL(255,(a->get_dec(0)*16 + a->get_dec(1)));

        delete a;
    }
}

SUITE(hex2dec)
{
    TEST(hex_test_1)
    {
        int t {};
        char c = '1';
        hex2dec(t,c);
        CHECK_EQUAL(1,t);
    }


    TEST(hex_test_over)
    {
        int t = 0;
        char c = 'g';
        CHECK_THROW(hex2dec(t,c), exception);
    }
}

SUITE(Squitter_short)
{
    TEST(get_bin_test_3)
    {
        std::string in = "ff";
        squitter_short* a = new squitter_short(in);
        CHECK_EQUAL(255,(a->get_dec(0)*16 + a->get_dec(1)));

        delete a;
    }

    /*
    TEST(get_bin_test1)
    {
        std::string in = "ffffdebeaf";
        squitter_short* a = new squitter_short(in);
        CHECK_EQUAL(1099509448367,a->get_dec());

        delete a;
    }
    }
    */
}
}
