// vlsi.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <bitset>
#include<vector>
using namespace std;

template<std::size_t R, std::size_t L, std::size_t N>
std::bitset<N> project_range(std::bitset<N> b)
{
	static_assert(R <= L && L <= N, "invalid bitrange");
	b >>= R;            // drop R rightmost bits
	b <<= (N - L + R);  // drop L-1 leftmost bits
	b >>= (N - L);      // shift back into place
	return b;
}

int main()
{
	vector<bitset<16>> a{	0b0101010101010101,
							0b1101010101010101,
							0b0101010101010101,
							0b1101010101010101,
							0b1101010101010101,
							0b0000000001010000,
							0b1111111111111111,
							0b1000000000000000,
							0b0000000000000000,
							0b1111111000001111,
							0b0000000000000000,
							0b0000000000000000,
							0b0000001001111111,
							0b1000000101111111,
							0b0000000100000000,
							0b1000001000000000 };

	vector<bitset<16>> b{ 0b0011101010101001,
				0b0011101010101001,
				0b1011101010101001,
				0b1011101010101001,
				0b0101010101010101,
				0b1111111110101111,
				0b1111111111111111,
				0b1000000000000000,
				0b0000000000000000,
				0b1010010111111111,
				0b1010010111111111,
				0b0010010111111111,
				0b1000000101111111,
				0b0000001001111111,
				0b1000001000000000,
				0b1000001000000000 };

	/*for (int i = 0; i < 16; i++)
	{
		bitset<16> x(a[i].to_ulong() + b[i].to_ulong());
		bitset<1> of;
		if (a[i][15] == b[i][15] && !(a[i][15] == x[15]))
			of = 1;
		else
			of = 0;
		cout << x << " " << of << endl;
	}this code for addition testing*/

	/*for (int i = 0; i < 16; i++)
	{
		bitset<32> x(a[i].to_ulong() * b[i].to_ulong());
		x >>= 7;
		string s = x.to_string().substr(7);
		bitset<25> x2(s);
		bitset<1> of;
		
		if ((x[15] & x[16] & x[17] & x[18] & x[19] & x[20] & x[21] & x[22] & x[23] & x[24]) | (!x[15] & !x[16] & !x[17] & !x[18] & !x[19] & !x[20] & !x[21] & !x[22] & !x[23] & !x[24]))
			of = 0;
		else
			of = 1;

		s = x2.to_string().substr(9);
		bitset<16> res(s);
		x2 >>= 16;
		s = x2.to_string().substr(16);
		bitset<9> over(s);

		//cout << res << " " << over << " " << of << endl;
		cout << of << endl;
	}*/

	for (int i = 0; i < 16; i++)
	{
		unsigned long long temp = a[i].to_ullong() * b[i].to_ullong();
		bitset<32> x(temp);
		bitset<1> of;

		if ((x[31] & x[30] & x[29] & x[28] & x[27] & x[26] & x[25] & x[24] & x[23] & x[22]) | (!x[31] & !x[30] & !x[29] & !x[28] & !x[27] & !x[26] & !x[25] & !x[24] & !x[23] & !x[22]))
			of = 0;
		else
			of = 1;

		string s = x.to_string().substr(9,16);
		bitset<16> res(s);

		//cout << res << " " << over << " " << of << endl;
		cout << res << endl;
		//cout << of << endl;
	}

}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
