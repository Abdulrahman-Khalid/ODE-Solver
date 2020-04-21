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
string createPacket(int packetSize, int number);
string decimalToBinary(double num, int precisionMode);
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
    row = bitset<49>(Count).to_string() + bitset<2>(Fixedpoint).to_string() + bitset<1>(Mode).to_string() + bitset<6>(M).to_string() + bitset<6>(N).to_string() + decimalToBinary(H, Fixedpoint) + decimalToBinary(Err, Fixedpoint);
    rows.push_back(row);
    // cout << "row: " << row.length() << '\n';
    // b) row
    for (const auto &a : A)
    {
        row = "";
        for (const auto &val : a)
            row += decimalToBinary(val, Fixedpoint);
        rows.push_back(row);
        // cout << "row: " << row.length() << '\n';
    }
    // c) row
    for (const auto &b : B)
    {
        row = "";
        for (const auto &val : b)
        {
            // cout << val << " ";
            string tmp = decimalToBinary(val, Fixedpoint);
            // cout << tmp << '\n';
            row += tmp;
        }
        // cout << row << "\n";
        rows.push_back(row);
        // cout << "row: " << row.length() << '\n';
    }
    // d) row
    row = "";
    for (const auto &val : X0)
        row += decimalToBinary(val, Fixedpoint);
    rows.push_back(row);
    // cout << "row: " << row.length() << '\n';
    // e) row
    row = "";
    for (const auto &val : T)
        row += decimalToBinary(val, Fixedpoint);
    rows.push_back(row);
    // cout << "row: " << row.length() << '\n';
    // f) row
    row = "";
    for (const auto &val : U0)
        row += decimalToBinary(val, Fixedpoint);
    rows.push_back(row);
    // cout << "row: " << row.length() << '\n';
    // g) row
    for (const auto &u : Us)
    {
        row = "";
        for (const auto &val : u)
            row += decimalToBinary(val, Fixedpoint);
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
    cout << "______________________________________________________\n";
    cout << "max concequtive = " << max << '\n';
    int packetSize = countBits(max);
    {
        int i = 1;
        while (true)
        {
            if (i >= packetSize)
            {
                packetSize = i;
                break;
            }
            i *= 2;
        }
        string errMsg = "Error packet bigger than " + to_string(busSize) + " bit";
        assertm(packetSize <= busSize, errMsg);
    }
    cout << "packet size = " << packetSize << '\n';
    const int busSizeMin1 = busSize - 1;
    int numOfPackets = 0, i = 0;
    string encoding = str[i] + bitset<busSizeMin1>(packetSize).to_string(); // first bit in
    numOfPackets++;
    // cout << "packetSize: " << encoding << '\n';
    int cnt = 1;
    do
    {
        int cnt = 1;
        while (str[i] == str[i + 1])
            cnt++, i++;
        encoding += createPacket(packetSize, cnt);
        numOfPackets++;
    } while (++i < str.length());
    int padding = (busSize - (encoding.length() % busSize)) % busSize;
    cout << "encoding length = " << encoding.length() << '\n';
    cout << "padding = " << padding << '\n';
    if (padding != 0)
        encoding += string(padding, '0');
    cout << "encoding length after padding = " << encoding.length() << '\n';
    cout << "Num of Packets = " << numOfPackets << '\n';
    cout << "Num of Buses = " << ceil(((float)encoding.length() / busSize)) << '\n';
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

string decimalToBinary(double num, int precisionMode)
{
    const int ramWidth = 64;
    string binary = "";
    switch (precisionMode)
    {
    case 1:
        int number = num;
        const int numBits = 9;
        const int scaleFactorBits = 16 - numBits;
        if (num >= 0)
            binary = bitset<numBits>(number).to_string();
        else
            binary = string(numBits, '1'); // TODO to change
        double fractional = abs(num) - number;
        for (int i = 0; i < scaleFactorBits; ++i)
        {
            fractional *= 2;
            if ((int)(fractional) == 1)
            {
                fractional -= 1;
                binary += '1';
            }
            else
                binary += '0';
        }
        break;
    }
    if (binary.length() < ramWidth) // if binary length is less than 64 bit -> add padding of zeros on the left
        binary = string(ramWidth - binary.length(), binary[0]) + binary;
    return binary;
}

string createPacket(int packetSize, int number)
{
    string res = "";
    bin(number, res);
    int diff = packetSize - res.length();
    assertm(diff >= 0, "packet overflow");
    res = string(diff, '0') + res;
    return res;
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