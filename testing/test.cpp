
#include <bitset>
#include <vector>
#include <iostream>
#include <math.h>
using namespace std;

const int FIXED_POINT = 7;

float binary_to_float(string binary)
{
    float res = 0;
    for (int i = 15; i >= 0; --i)
    {
        if (binary[i] == '1')
            res += pow(2, (FIXED_POINT - i));
    }
    if (binary[0] == '1')
        res *= -1;
    return res;
}

void add(bitset<16> a, bitset<16> b, bitset<16> &res, bitset<1> &of)
{
    res = bitset<16>(a.to_ulong() + b.to_ulong());
    if (a[15] == b[15] && a[15] != res[15])
        of = 1;
    else
        of = 0;
}

void mult(bitset<16> a, bitset<16> b, bitset<16> &res, bitset<1> &of)
{
    bitset<32> temp_res(a.to_ulong() * b.to_ulong());
    if (a[15] == b[15] && a[15] != res[15])
        of = 1;
    else
        of = 0;
}

int main()
{
    while (true)
    {
        bitset<16> a, b;
        cout << "Enter First number (binary): ";
        cin >> a >> b;
        cout << "Enter Second number (binary): ";
        bitset<16> res_mult, res_add;
        bitset<1> of_mult, of_add;
        add(a, b, res_add, of_add);
        cout << a << " + " << b << " = " << res_add << ", OverFlow = " << of_add << endl;
        mult(a, b, res_mult, of_mult);
        cout << a << " * " << b << " = " << res_mult << ", OverFlow = " << of_mult << endl;
    }
    return 0;
}