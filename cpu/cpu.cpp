#include <iostream>
#include <string.h>
#include <exception>
#include <fstream>
#include "json.hpp"
#include <bitset>
#include <vector>
#include <cassert>
#define assertm(exp, msg) assert(((void)msg, exp))
using namespace std;
const unsigned int scaleFactor = 7;
const unsigned int busSize = 32;

using json = nlohmann::json;
unsigned int maxConsequtive(string str);
void bin(unsigned int n, string &res);
string createPacket(int packetSize, int number, bool lastPacket = false);
string decimalToBinary(double num);
int countBits(int num);
string RLE(string str);

int main(int argc, char *argv[])
{
    if (argc < 3)
        return 0;
    ifstream input((string)argv[1]);
    json j;
    input >> j;
    int N = j["N"].get<int>();
    int M = j["M"].get<int>();
    int Mode = j["Mode"].get<int>();
    float H = j["H"].get<float>();
    float Err = 0;
    try
    {
        Err = j["Err"].get<float>();
    }
    catch (exception e)
    {
    }
    int Fixedpoint = j["Fixedpoint"].get<int>();
    int Count = j["Count"].get<int>();
    vector<vector<double>> A = j["A"].get<vector<vector<double>>>();
    vector<vector<double>> B = j["B"].get<vector<vector<double>>>();
    vector<double> X0 = j["X0"].get<vector<double>>();
    vector<double> T = j["T"].get<vector<double>>(); // floats ?
    vector<double> U0 = j["U0"].get<vector<double>>();
    vector<vector<double>> Us = j["Us"].get<vector<vector<double>>>();
    vector<string> rows;
    string row = "";
    // a) row
    row = decimalToBinary(N) + decimalToBinary(M) + decimalToBinary(Mode) +
          decimalToBinary(H) + decimalToBinary(Err) + decimalToBinary(Fixedpoint) +
          decimalToBinary(Count);
    rows.push_back(row);
    // cout << "row: " << row.length() << '\n';
    // b) rowf
    for (const auto &a : A)
    {
        row = "";
        for (const auto &val : a)
            row += decimalToBinary(val);
        rows.push_back(row);
        // cout << "row: " << row.length() << '\n';
    }
    // c) row
    for (const auto &b : B)
    {
        row = "";
        for (const auto &val : b)
            row += decimalToBinary(val);
        rows.push_back(row);
        // cout << "row: " << row.length() << '\n';
    }
    // d) row
    for (const auto &val : X0)
        row += decimalToBinary(val);
    rows.push_back(row);
    // cout << "row: " << row.length() << '\n';
    // e) row
    for (const auto &val : T)
        row += decimalToBinary(val);
    rows.push_back(row);
    // cout << "row: " << row.length() << '\n';
    // f) row
    for (const auto &val : U0)
        row += decimalToBinary(val);
    rows.push_back(row);
    // cout << "row: " << row.length() << '\n';
    // g) row
    for (const auto &u : Us)
    {
        row = "";
        for (const auto &val : u)
            row += decimalToBinary(val);
        rows.push_back(row);
        // cout << "row: " << row.length() << '\n';
    }
    // loop on data row by row and compute bit-lvl RLE
    ofstream outputfile;
    outputfile.open((string)argv[2]);
    for (const string &r : rows)
    {
        string rle = RLE(r);
        outputfile << rle << '\n';
        // cout << rle.length() << '\n';
    }
    outputfile.close();
    return 0;
}

string RLE(string str)
{
    int max = maxConsequtive(str);
    cout << "max: " << max << '\n';
    int packetSize = countBits(max) + 1;
    {
        int i = 2;
        while (true)
        {
            if (i >= packetSize)
            {
                packetSize = i;
                break;
            }
            i *= 2;
        }
    }
    assertm(packetSize < busSize, "Error packet bigger than 32 bit");
    cout << "packetSize: " << packetSize << '\n';
    string encoding = bitset<31>(packetSize).to_string();
    encoding = str[0] + encoding; // first bit in
    // cout << "packetSize: " << encoding << '\n';
    int i = 0;
    int cnt = 1;
    while (str[i] == str[i + 1])
        cnt++, i++;
    encoding += createPacket(packetSize, cnt);
    i++;
    assert(i < str.length() && "Should be more than one packet");
    while (true)
    {
        cnt = 1;
        while (str[i] == str[i + 1])
            cnt++, i++;
        i++;
        if (i < str.length())
            encoding += createPacket(packetSize, cnt);
        else
        {
            encoding += createPacket(packetSize, cnt, true);
            break;
        }
    }
    int padding = encoding.length() % busSize;
    if (padding != 0)
        encoding += string((busSize - padding), '0');
    return encoding;
}

unsigned int maxConsequtive(string str)
{
    if (str.size() == 0)
        return 0;
    int res = 1;
    int cnt = 1;
    char c = str[0];
    for (int i = 1; i < str.length(); i++)
    {
        if (c == str[i])
        {
            cnt++;
        }
        else
        {
            res = max(res, cnt);
            cnt = 1;
        }
    }
    res = max(res, cnt);
    return res;
}

string decimalToBinary(double num)
{
    int number = num;
    string binary = bitset<9>(number).to_string();
    double fractional = num - number;
    int scale = 7; // 9+7 = 16 bits
    while (scale--)
        if ((int)(fractional * 2) == 1)
            fractional -= 1, binary += '1';
        else
            binary += '0';
    return binary;
}

string createPacket(int packetSize, int number, bool finalPacket, char firstPacketBitType)
{
    string res = "";
    bin(number, res);
    int diff = packetSize - res.length();
    assert(diff >= 1 && "packet overflow");
    // first bit indicat if this is the final packet in the row
    if (firstPacketBitType == '0' || firstPacketBitType == '1')
        return firstPacketBitType + string(diff - 1, '0') + res;
    if (finalPacket)
        return '1' + string(diff - 1, '0') + res;
    return string(diff, '0') + res;
}

string createPacket(int packetSize, int number, bool lastPacket)
{
    string res = "";
    bin(number, res);
    int diff = packetSize - res.length();
    assert(diff >= 1 && "packet overflow");
    // first bit indicat if this is the final packet in the row
    if (!lastPacket)
        return string(diff, '0') + res;
    else
        return '1' + string(diff - 1, '0') + res;
}

void bin(unsigned int n, string &res)
{
    if (n > 1)
        bin(n >> 1, res);
    res += to_string(n & 1);
}

int countBits(int num)
{
    return (int)log2(num) + 1;
}