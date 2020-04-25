#include <bitset>
#include <vector>
#include <iostream>
#include <math.h>
using namespace std;
const int FIXED_POINT = 7;
const int N = 16;

bitset<N> Division(bitset<N> Dividend, bitset<N> Divisor, bitset<1>& Reset, bitset<1>& OverFlow, bitset<1>& Err, bitset<1>& Done)
{
	int index= N - 2 + FIXED_POINT;
	int FIRST_ONE_DIVIDEND;
	int FIRST_ONE_DIVISOR;
	bitset<1> Done_bit, FIRST_ONE, Q_FIRST_ONE, start;
	bitset<N> Dividend2;
	bitset<N> Quotient;
	bitset<N> Add1;
	bitset<N> Add2;
	bitset<N - 1> twosCompliment;
	bitset<N - 1> divisorWithoutSign;
	bitset<N - 1> dividendWithoutSign;
	bitset<(2 * N) - 3> Divisor2;
	start.set();
	Done_bit.set();
	Done.reset();
	while (index >= 0 && Done[0]==0)
	{
		if (Reset[0] == 0)
		{
			if (Done_bit.test(0) == 1 && start.test(0) == 1)
			{
				start.reset();
				Done.reset(0);
				Err.reset(0);
				OverFlow.reset(0);
				Done_bit.reset(0);
				index = N - 2 + FIXED_POINT;
				bitset<1>sign = (Dividend.test(N - 1)) ^ (Divisor.test(N - 1));
				Quotient[N - 1] = sign.test(0);
				Divisor2.reset();
				for (int i = N - 2; i >= 0; i--)
				{
					divisorWithoutSign[i] = Divisor[i];
					dividendWithoutSign[i] = Dividend[i];
				}

				if (((int)(divisorWithoutSign.to_ulong())) == 128 || ((int)(dividendWithoutSign.to_ulong())) == 0)
				{
					for (int i = N - 2; i >= 0; i--)
					{
						Quotient[i] = Dividend[i];
					}

					Done_bit.set();
					Done.set();
				}

				else if ((int)divisorWithoutSign.to_ulong() == 0)
				{
					Err.set();
					Done.set();
					Done_bit.set();
				}
				else
				{
					FIRST_ONE.reset();
					if (Dividend[N - 1] == 1)
					{
						twosCompliment = dividendWithoutSign;
						unsigned long tmpp = (~twosCompliment).to_ulong() + 1;
						bitset<N - 1> tmp(tmpp);
						for (int i = N - 2; i >= 0; i--)
						{
							Dividend2[i] = tmp[i];
						}
					}
					else
					{
						for (int i = N - 2; i >= 0; i--)
						{
							Dividend2[i] = Dividend[i];
						}
					}
					if (Divisor[N - 1] == 1)
					{
						twosCompliment = divisorWithoutSign;
						unsigned long tmpp = (~twosCompliment).to_ulong() + 1;
						bitset<N - 1> tmp(tmpp);
						int j = N - 2;
						for (int i = 2 * N - 4; i >= N - 2; i--)
						{
							Divisor2[i] = tmp[j];
							j--;
						}
					}
					else
					{
						int j = N - 2;
						for (int i = 2 * N - 4; i >= N - 2; i--)
						{
							Divisor2[i] = Divisor[j];
							j--;
						}
					}
					//CHECK OVERFLOW
					FIRST_ONE_DIVISOR = 20; //To handle if divisor is zero do not raise overflow
					FIRST_ONE_DIVIDEND = 0; //to handle if dividend is zero
					for (int i = N - 2; i >= 0; i--)
					{
						if (Divisor[i] == 1)
						{
							FIRST_ONE_DIVISOR = i;
							break;
						}
					}
					for (int i = N - 2; i >= 0; i--)
					{
						if (Dividend[i] == 1)
						{
							FIRST_ONE_DIVIDEND = i;
							break;
						}
					}
					if (FIRST_ONE_DIVISOR <= N / 2 - 2 and FIRST_ONE_DIVIDEND > N / 2 - 2)
					{
						if (FIRST_ONE_DIVIDEND - FIRST_ONE_DIVISOR >= N / 2) {
							Done_bit.set();
							Done.set();
							OverFlow.set();
						}
					}
					FIRST_ONE.reset();
				}


			}
			else if (Done_bit[0] == 0)
			{
				if ((((int)(Dividend2.to_ulong())) >= ((int)(Divisor2.to_ulong()))) && ((int)(Dividend2.to_ulong())) != 0)
				{
					Add1= Dividend2;
					for (int i = N-1; i >=0; i--)
					{
						Add2[i] = ~Divisor2[i];
					}
					unsigned long diff = Add1.to_ulong() + Add2.to_ulong() + 1;
					bitset<N>x(diff);
					Dividend2 = x;
					Quotient[index] = 1;
				}
				Divisor2 = Divisor2 >> 1;
				if (index == 0) {
					Done.set();
					Done_bit.set();
					Q_FIRST_ONE = 0;
					if (Quotient[N - 1] == 1)
					{
						bitset<N - 1>resultWithoutsign;
						for (int i = N - 2; i >= 0; i--)
						{
							resultWithoutsign[i] = Quotient[i];
						}
						twosCompliment = resultWithoutsign;
						unsigned long tmpp = (~twosCompliment).to_ulong() + 1;
						bitset<N - 1> tmp(tmpp);
						for (int i = N - 2; i >= 0; i--)
						{
							Quotient[i] = tmp[i];
						}
					}
				}
				index = index - 1;
			}
		}
		else
		{
			Done_bit.set();
			Reset.reset();
		}
	}
	return Quotient;
}

int main()
{
	bitset<N>Dividend("0000010101000000"); //--     10.5 /
	bitset<N>Divisor("0000000100000000"); //--        2 =
	bitset<1>of;
	bitset<1>err;
	bitset<1>done;
	bitset<1>reset("0");
	bitset<N> res=Division(Dividend, Divisor, reset, of, err, done);
	cout << res.to_string()<<endl;
	cout << "Done = " + done.to_string()<<endl;
	cout << "Error = " + err.to_string() << endl;
	cout << "overflow = " + of.to_string() << endl;

	return 0;
}