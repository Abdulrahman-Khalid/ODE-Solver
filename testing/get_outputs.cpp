
#include <bitset>
#include <vector>
#include <iostream>
#include <math.h>
#include <fstream>
using namespace std;

const int FIXED_POINT = 7;
const int BITS_NUM = 16;
const string OUT_FILE_NAME = "./outputs.txt";

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
		for (int i = 1; i < BITS_NUM; ++i)
		{
			if (binary[i] == '1')
				res += pow(2, (FIXED_POINT - i + 1));
		}
		res *= -1;
	}
	else
	{
		for (int i = 1; i < BITS_NUM; ++i)
		{
			if (binary[i] == '1')
				res += pow(2, (FIXED_POINT - i + 1));
		}
	}
	return res;
}

void add(bitset<BITS_NUM> a, bitset<BITS_NUM> b, bitset<BITS_NUM> &res, bitset<1> &of)
{
	res = bitset<BITS_NUM>(a.to_ulong() + b.to_ulong());
	if (a[15] == b[15] && a[15] != res[15])
		of = 1;
	else
		of = 0;
}

void mult(bitset<BITS_NUM> a, bitset<BITS_NUM> b, bitset<BITS_NUM> &res, bitset<1> &of)
{
	string a_str = a.to_string();
	string b_str = b.to_string();
	if (a[15] == 1)
		a_str = twos_complement(a_str);
	if (b[15] == 1)
		b_str = twos_complement(b_str);
	a = bitset<16>(a_str);
	b = bitset<16>(b_str);
	bitset<32> temp_res(a.to_ullong() * b.to_ullong());
	// if (temp_res[32] == 1)
	// 	temp_res = bitset<32>(twos_complement(temp_res.to_string()));

	bitset<10> check_overflow(temp_res.to_string().substr(0, 10));
	if (check_overflow.all() | check_overflow.none())
		of = 0;
	else
		of = 1;
	string res_str = temp_res.to_string().substr(9, 16);
	res = bitset<16>(res_str);
}

vector<bitset<BITS_NUM>> a{0b0101010101010101,
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
						   0b1000001000000000};

vector<bitset<BITS_NUM>> b{0b0011101010101001,
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
						   0b1000001000000000};
int main()
{
	vector<string> mult_1;
	vector<string> mult_2;
	vector<string> add_1;
	vector<string> add_2;
	ofstream output_file;
	output_file.open(OUT_FILE_NAME);
	for (int i = 0; i < a.size(); ++i)
	{
		bitset<BITS_NUM> res_mult, res_add;
		bitset<1> of_mult, of_add;
		mult(a[i], b[i], res_mult, of_mult);
		add(a[i], b[i], res_add, of_add);
		mult_1.push_back(res_mult.to_string());
		mult_2.push_back(of_mult.to_string());
		add_1.push_back(res_add.to_string());
		add_2.push_back(of_add.to_string());
		// output_file << output;
	}
	for (int i = 0; i < mult_1.size(); ++i)
	{
		string output = std::to_string(i) + " => \"" + mult_1[i] + "\",\n";
		output_file << output;
	}
	for (int i = 0; i < mult_2.size(); ++i)
	{
		string output = std::to_string(i) + " => '" + mult_2[i] + "',\n";
		output_file << output;
	}
	for (int i = 0; i < add_1.size(); ++i)
	{
		string output = std::to_string(i) + " => \"" + add_1[i] + "\",\n";
		output_file << output;
	}
	for (int i = 0; i < add_2.size(); ++i)
	{
		string output = std::to_string(i) + " => '" + add_2[i] + "',\n";
		output_file << output;
	}
	output_file.close();
	return 0;
}
