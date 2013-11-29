#include "squitter.h"
#include "UnitTest++.h"

namespace
{

TEST(get_in_test)
{
    std::string in = "ffffdebeaf";
    squitter* a = new squitter(in);
    CHECK_EQUAL(in,a->get_in());

    delete a;
}

TEST(get_bin_test)
{
    std::string in = "ffffdebeaf";
    squitter* a = new squitter(in);
    CHECK_EQUAL(1099509448367,a->get_dec());

    delete a;
}
}
