
#include <bitset>
#include <vector>
#include <iostream>
#include <math.h>
using namespace std;

const int FIXED_POINT = 7;

string twos_complement(string binary)
{
    int n = binary.length();
    int i;
    for (i = n - 1; i >= 0; i--)
        if (binary[i] == '1')
            break;
    if (i == -1)
        return '1' + binary;
    for (int j = i - 1; j >= 0; j--)
    {
        if (binary[j] == '0')
            binary[j] = '1';
        else
            binary[j] = '0';
    }
    return binary;
}

float binary_to_float(string binary)
{
    float res = 0;
    if (binary[0] == '1')
    {
        binary = twos_complement(binary);
        for (int i = 1; i < 16; ++i)
        {
            if (binary[i] == '1')
                res += pow(2, (FIXED_POINT - i + 1));
        }
        res *= -1;
    }
    else
    {
        for (int i = 1; i < 16; ++i)
        {
            if (binary[i] == '1')
                res += pow(2, (FIXED_POINT - i + 1));
        }
    }
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
    bitset<32> temp_res((short)a.to_ullong() * (short)b.to_ullong());
    bitset<10> check_overflow(temp_res.to_string().substr(0, 10));
    if (check_overflow.all() | check_overflow.none())
        of = 0;
    else
        of = 1;
    string res_str = temp_res.to_string().substr(9, 16);
    res = bitset<16>(res_str);
}

int main()
{
    while (true)
    {
        bitset<16> a, b;
        cout << "Enter First number (binary): ";
        cin >> a;
        cout << "Enter Second number (binary): ";
        cin >> b;
        bitset<16> res_mult, res_add;
        bitset<1> of_mult, of_add;
        cout << "______________________________ADDITION_____________________________\n";
        add(a, b, res_add, of_add);
        cout << a << " + " << b << " = " << res_add << ", OverFlow = " << of_add << endl;
        cout << binary_to_float(a.to_string()) << " + " << binary_to_float(b.to_string()) << " = " << binary_to_float(res_add.to_string()) << ", OverFlow = " << of_add << endl;
        cout << "___________________________MULTIPLICATION___________________________\n";
        mult(a, b, res_mult, of_mult);
        cout << a << " * " << b << " = " << res_mult << ", OverFlow = " << of_mult << endl;
        cout << binary_to_float(a.to_string()) << " * " << binary_to_float(b.to_string()) << " = " << binary_to_float(res_mult.to_string()) << ", OverFlow = " << of_mult << endl;
        cout << "____________________________________________________________________\n";
    }
    return 0;
}