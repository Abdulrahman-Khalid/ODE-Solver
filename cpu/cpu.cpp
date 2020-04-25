#include <iostream>
#include <string.h>
#include <exception>
#include <fstream>
#include "json.hpp"
#include <bitset>
#include <vector>
#include <cassert>
#include <sstream>
#define assertm(exp, msg) assert(((void)msg, exp))
using namespace std;
const unsigned int scaleFactor = 7;
const unsigned int busSize = 32;
const unsigned int ramWidth = 64;

using json = nlohmann::json;
unsigned int maxConsequtive(string str);
void bin(unsigned int n, string &res);
string createPacket(int packetSize, int number);
string towsComp(string binary);
string decimalToBinary(double num, int precisionMode);
int countBits(int num);
string RLE(string str);
string binaryToHexa(bitset<ramWidth> binary);
void decompress(string inputFile, string outputFile); //simulate decompress in vhdl
int main(int argc, char *argv[])
{
    if (argc == 4 && ((string)argv[1]) == "--decompress")
    {
        // To decompress run the following command:
        // make clean && make && ./cpu --decompress output.txt output_decompress.txt
        decompress((string)argv[2], (string)argv[3]);
        return 0;
    }
    // To compress run the following command:
    // make clean && make && ./cpu input.json output.txt
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
    string row = "", debug = "";
    // a) row
    row = bitset<49>(Count).to_string() + bitset<2>(Fixedpoint).to_string() + bitset<1>(Mode).to_string() + bitset<6>(M).to_string() + bitset<6>(N).to_string() + decimalToBinary(H, Fixedpoint) + decimalToBinary(Err, Fixedpoint);
    rows.push_back(row);
    ofstream debugFile;
    debugFile.open("debug.txt");
    debug = bitset<49>(Count).to_string() + bitset<2>(Fixedpoint).to_string() + bitset<1>(Mode).to_string() + bitset<6>(M).to_string() + bitset<6>(N).to_string();
    debugFile << "First row\n";
    bitset<ramWidth> binarySet(debug);
    debugFile << "Binary: " << debug << ", Hex: " << binaryToHexa(binarySet) << '\n';
    debug = decimalToBinary(H, Fixedpoint);
    {
        bitset<ramWidth> binarySet(debug);
        debugFile << "Binary: " << debug << ", Hex: " << binaryToHexa(binarySet) << '\n';
    }
    debug = decimalToBinary(Err, Fixedpoint);
    {
        bitset<ramWidth> binarySet(debug);
        debugFile << "Binary: " << debug << ", Hex: " << binaryToHexa(binarySet) << '\n';
    }
    debugFile << "_____________________________________________________________________\n";
    // cout << "row: " << row.length() << '\n';
    // b) row
    debugFile << "Start Matrix A\n";
    for (const auto &a : A)
    {
        row = "";
        for (const auto &val : a)
        {
            debug = decimalToBinary(val, Fixedpoint);
            bitset<ramWidth> binarySet(debug);
            debugFile << "Binary: " << debug << ", Hex: " << binaryToHexa(binarySet) << '\n';
            row += debug;
        }
        rows.push_back(row);
        // cout << "row: " << row.length() << '\n';
    }
    debugFile << "_____________________________________________________________________\n";
    // c) row
    debugFile << "Start Matrix B\n";
    for (const auto &b : B)
    {
        row = "";
        for (const auto &val : b)
        {
            debug = decimalToBinary(val, Fixedpoint);
            bitset<ramWidth> binarySet(debug);
            debugFile << "Binary: " << debug << ", Hex: " << binaryToHexa(binarySet) << '\n';
            row += debug;
        }
        // cout << row << "\n";
        rows.push_back(row);
        // cout << "row: " << row.length() << '\n';
    }
    debugFile << "_____________________________________________________________________\n";
    // d) row
    row = "";
    debugFile << "Start vector X0\n";
    for (const auto &val : X0)
    {
        debug = decimalToBinary(val, Fixedpoint);
        bitset<ramWidth> binarySet(debug);
        debugFile << "Binary: " << debug << ", Hex: " << binaryToHexa(binarySet) << '\n';
        row += debug;
    }
    rows.push_back(row);
    debugFile << "_____________________________________________________________________\n";
    // cout << "row: " << row.length() << '\n';
    // e) row
    debugFile << "Start vector T\n";
    row = "";
    for (const auto &val : T)
    {
        debug = decimalToBinary(val, Fixedpoint);
        bitset<ramWidth> binarySet(debug);
        debugFile << "Binary: " << debug << ", Hex: " << binaryToHexa(binarySet) << '\n';
        row += debug;
    }
    rows.push_back(row);
    debugFile << "_____________________________________________________________________\n";
    // cout << "row: " << row.length() << '\n';
    // f) row
    row = "";
    debugFile << "Start vector U0\n";
    for (const auto &val : U0)
    {
        debug = decimalToBinary(val, Fixedpoint);
        bitset<ramWidth> binarySet(debug);
        debugFile << "Binary: " << debug << ", Hex: " << binaryToHexa(binarySet) << '\n';
        row += debug;
    }
    rows.push_back(row);
    debugFile << "_____________________________________________________________________\n";
    // cout << "row: " << row.length() << '\n';
    // g) row
    debugFile << "Start Matrix Us\n";
    for (const auto &u : Us)
    {
        row = "";
        for (const auto &val : u)
        {
            debug = decimalToBinary(val, Fixedpoint);
            bitset<ramWidth> binarySet(debug);
            debugFile << "Binary: " << debug << ", Hex: " << binaryToHexa(binarySet) << '\n';
            row += debug;
        }
        rows.push_back(row);
        // cout << "row: " << row.length() << '\n';
    }
    debugFile << "_____________________________________________________________________\n";
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
    debugFile.close();
    return 0;
}

string RLE(string str)
{
    int max = maxConsequtive(str);
    // cout << "______________________________________________________\n";
    // cout << "max concequtive = " << max << '\n';
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
    // cout << "packet size = " << packetSize << '\n';
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
    // cout << "encoding length = " << encoding.length() << '\n';
    // cout << "padding = " << padding << '\n';
    if (padding != 0)
        encoding += string(padding, '0');
    // cout << "encoding length after padding = " << encoding.length() << '\n';
    // cout << "Num of Packets = " << numOfPackets << '\n';
    // cout << "Num of Buses = " << ceil(((float)encoding.length() / busSize)) << '\n';
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
        if (c == str[i])
            cnt++;
        else
        {
            res = max(res, cnt);
            cnt = 1;
        }
    res = max(res, cnt);
    return res;
}

string decimalToBinary(double num, int precisionMode)
{
    string binary = "";
    switch (precisionMode)
    {
    case 1:
        int number = abs(num); // abs because I get the 2's complement in the end if it was negative number
        const int numBits = 9;
        const int scaleFactorBits = 16 - numBits;
        binary = bitset<numBits>(number).to_string();
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
    if (num < 0)
        binary = towsComp(binary);                                 // get twos complement if number less than zero
    if (binary.length() < ramWidth)                                // if binary length is less than 64 bit -> add padding of zeros on the left
        binary = string(ramWidth - binary.length(), '0') + binary; // TODDO could be change to sign extend
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

string towsComp(string binary)
{
    int i;
    for (i = binary.length() - 1; i >= 0; --i)
        if (binary[i] == '1')
            break;
    if (i == -1)
        return '1' + binary;
    for (int j = i - 1; j >= 0; --j)
        if (binary[j] == '1')
            binary[j] = '0';
        else
            binary[j] = '1';
    return binary;
}

string binaryToHexa(bitset<ramWidth> binary)
{
    stringstream res;
    res << hex << uppercase << binary.to_ulong();
    int length = (ramWidth / 4);
    string ans = res.str();
    int diff = length - ans.length();
    ans = string(diff, '0') + ans;
    return ans;
}

void decompress(string inputFile, string outputFile)
{
    ifstream input(inputFile);
    ofstream output(outputFile);
    string row;
    output << "Start Decoding ...\n";
    while (getline(input, row))
    {
        const int bitsetSafeSize = 33;
        string metaData = row.substr(0, busSize);
        char firstBitType = metaData[0];                                         // get first packet type if '0' or '1'
        long packetSize = bitset<bitsetSafeSize>(metaData.substr(1)).to_ulong(); // get how many bits the packet is
        row = row.substr(busSize);
        int end_r = row.length() - busSize;
        string reg64Bit = "";
        for (int r = 0; r <= end_r; r += busSize)
        {
            string bus = row.substr(r, busSize);
            int end_b = bus.length() - packetSize;
            for (int b = 0; b <= end_b; b += packetSize)
            {
                string packet = bus.substr(b, packetSize);
                int numOfBits = bitset<bitsetSafeSize>(packet).to_ulong();
                if (firstBitType == '0')
                    reg64Bit += string(numOfBits, '0'), firstBitType = '1';
                else if (firstBitType == '1')
                    reg64Bit += string(numOfBits, '1'), firstBitType = '0';
                else
                    assert("Error wrong bit type");
                while (reg64Bit.length() >= ramWidth)
                {
                    output << reg64Bit.substr(0, ramWidth) << '\n';
                    reg64Bit = (reg64Bit.length() == ramWidth) ? "" : reg64Bit.substr(ramWidth);
                }
            }
        }
    }
    input.close();
    output.close();
}