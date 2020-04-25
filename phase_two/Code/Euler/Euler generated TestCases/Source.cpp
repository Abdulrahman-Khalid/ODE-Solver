#include <bitset>
#include <vector>
#include <iostream>
#include <fstream>
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

float fixedPoint_to_float(string binary)
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


int binaryToDecimal(string n) 
{ 
    string num = n; 
    int dec_value = 0; 
  
    // Initializing base value to 1, i.e 2^0 
    int base = 1; 
  
    int len = num.length(); 
    for (int i = len - 1; i >= 0; i--) { 
        if (num[i] == '1') 
            dec_value += base; 
        base = base * 2; 
    } 
 
    return dec_value; 
}

int main()
{
    while (true)
    {
    bitset<16> Xprev, h,temp, n, m;
	vector<bitset<16>> A, B, X, U;
	vector<float> Af, Bf, Xf, Uf;
	int N, M, hf;
	cout<< "Enter N"<<endl;
	cin>>n;
	cout<< "Now M"<<endl;
	cin>>m;
	N = binaryToDecimal(n.to_string());
	M = binaryToDecimal(m.to_string());
	cout<<"Enter matrix A (row by row)"<<endl;
	for (int i =0; i<N; i++)
		for (int j=0; j< N; j++)
			{
				cin>>temp;
				A.push_back(temp);
				Af.push_back(fixedPoint_to_float(temp.to_string()));
			}
	cout<<"Enter matrix B (row by row)"<<endl;
	for (int i =0; i<M; i++)
		for (int j=0; j< N; j++)
			{
				cin>>temp;
				B.push_back(temp);
				Bf.push_back(fixedPoint_to_float(temp.to_string()));
			}
	cout<<"Enter Xn "<<endl; 
	for (int i=0; i< N; i++)
	{
		cin>>temp;
		X.push_back(temp);
		Xf.push_back(fixedPoint_to_float(temp.to_string()));
	}
	cout<<"Enter U "<<endl; 
	for (int i=0; i< M; i++)
	{
		cin>>temp;
		U.push_back(temp);
		Uf.push_back(fixedPoint_to_float(temp.to_string()));
	}
	
	cout<< "Enter h"<<endl;
	cin>>h;
	hf = fixedPoint_to_float(h.to_string());
	vector<float>result;
	for ( int i=0; i< N; i++)
	{
		int sumA=0, sumB=0;
		for (int j=0; j<N; j++)
			sumA+= Af[j]*Xf[j];
		for (int k=0; k<M; k++)
			sumB+= Bf[k]*Uf[k];
		result.push_back(hf*(sumA+sumB)+Xf[i]);
	}
	cout<< "Output vector is as follows:-"<<endl;
	for (int i=0; i<result.size(); i++)
		cout<<result[i]<<"  ";
	cout<<endl;


	ofstream outfile;
	outfile.open("output.DO");
	//0000000100000000
	//0000000000000010
	outfile<<"force -freeze sim:/euler/rst 1 0" <<endl;
	outfile<<"force -freeze sim:/euler/clk 1 0, 0 {50 ps} -r 100"<<endl;
	outfile<<"run"<<endl;
	outfile<<"force -freeze sim:/euler/rst 0 0"<<endl;
	outfile<<"force -freeze sim:/euler/decOut 0001100000 0"<<endl;
	outfile<<"force -freeze sim:/euler/Add 1 0"<<endl;
	outfile<<"force -freeze sim:/euler/N "<< n <<" 0"<<endl;
	outfile<<"force -freeze sim:/euler/M "<< m <<" 0"<<endl;
	outfile<<"force -freeze sim:/euler/initialize 1 0"<<endl;
	outfile<<"force -freeze sim:/euler/h_out "<<h<<" 0"<<endl;
	outfile<<"run"<<endl;
	outfile<<"force -freeze sim:/euler/initialize 0 0"<<endl;
	outfile<<"run"<<endl;
	for(int j=0; j<N; j++){ 
		outfile<<"force -freeze sim:/euler/Xprev "<<X[j]<<" 0"<<endl;
		for (int i=0; i< max(N,M); i++){
			outfile<<"force -freeze sim:/euler/A "<<A[min(i, N-1)]<<" 0"<<endl;
			outfile<<"force -freeze sim:/euler/B "<<B[min(i, M-1)] <<" 0"<<endl;
			outfile<<"force -freeze sim:/euler/U "<<U[min(i, M-1)] <<" 0"<<endl;
			outfile<<"force -freeze sim:/euler/Xn "<<X[min(i, N-1)] <<" 0"<<endl;
			outfile<<"run"<<endl;
			outfile<<"run"<<endl;
			}
		if(j<N-1)
			outfile<<"examine -binary FinalOutput"<<endl;
		}
	outfile<<"run"<<endl;
	outfile<<"run"<<endl;
	outfile<<"examine -binary FinalOutput"<<endl;
	}
}

