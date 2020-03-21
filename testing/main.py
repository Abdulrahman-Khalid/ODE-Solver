import struct

FIXED_POINT = 7
BITS_NUM = 16


def change_to_signed_binary(binary):
    if(binary[FIXED_POINT] == '.'):
        numOfBits = BITS_NUM
    else:
        numOfBits = BITS_NUM+1
    if(binary[0] == '-'):
        binary = binary[3:]
        return '1'+"0"*(numOfBits - len(binary)-1)+binary
    if(binary[:2] == "0b"):
        binary = binary.lstrip("0b")
    return "0"*(numOfBits - len(binary))+binary


def dec_convert(num):
    while num > 1:
        num /= 10
    return num


def float_to_bin(number):
    if(number == int(number)):
        # BITS_NUM+2-FIXED_POINT number of dec bits
        res = bin(int(number))
        # -1 is for the sign
        if(number < 0):
            res = res[3:]
            res = (BITS_NUM-FIXED_POINT-len(res)-1)*"0" + res + "0"*FIXED_POINT
            res = "-0b"+res
        else:
            res = res[2:]
            res = (BITS_NUM-FIXED_POINT-len(res)-1)*"0" + res + "0"*FIXED_POINT
            res = "0b"+res
        return res
    num, dec = str(number).split(".")
    num = int(num)
    dec = int(dec)
    res = bin(num)
    for _ in range(FIXED_POINT):
        num, dec = str((dec_convert(dec)) * 2).split(".")
        dec = int(dec)
        res += num
    return res


def strip_fixed_point(binary):
    res = ""
    for bit in binary:
        if(bit != '.'):
            res += bit
    return res


def add_fixed_point(binary):
    indx = BITS_NUM-FIXED_POINT
    if(binary[indx] == '.'):
        return binary
    return binary[:indx] + '.' + binary[indx:indx+FIXED_POINT]


def binary_to_float(binary):
    temp = strip_fixed_point(binary)[1:]  # 1: to remove sign
    res = 0
    temp = temp.replace('.', '')
    for i in range(BITS_NUM-1):
        if(temp[i] == '1'):
            res += 2**(FIXED_POINT-i)
    if(binary[0] == '1'):
        res *= -1
    return res


def to_signed(binary):
    if(binary[:2] == "0b"):
        return '0'+binary[2:]
    elif(binary[:3] == "-0b"):
        return '1'+binary[3:]


def mult(A, B):
    a = int(A, 2)
    b = int(B, 2)
    res = bin(a * b)
    ################## SOME CLEANSING TO GET 32 BITS as the vhdl code gets #############
    if(res[0] == '-'):
        res = res[3:]
        res = (BITS_NUM-len(res)+FIXED_POINT-1)*"0"+res
        res = '1'*(BITS_NUM*2-len(res))+res
    else:
        res = res[2:]
        res = (BITS_NUM-len(res)+FIXED_POINT-1)*"0"+res
        res = '0'*(BITS_NUM*2-len(res))+res
    ################## END OF CLEANSING #############
    # 22 downto 7 in the code
    start = -FIXED_POINT-BITS_NUM  # -22
    end = -FIXED_POINT  # -7
    num_extended_sign = BITS_NUM*2+start+1  # 10
    if(res[:start+1] == "0" * num_extended_sign or res[:start+1] == "1" * num_extended_sign):
        over_flow = '0'
    else:
        over_flow = '1'
    res = res[start:end]  # 22 downto 7 in the code to get the result
    return res, over_flow


def add(A, B):
    a = int(A, 2)
    b = int(B, 2)
    res = bin(a+b)
    print("res1:", res)
    ################## SOME CLEANSING TO GET 17 BITS as the vhdl code gets #############
    if(res[0] == '-'):
        res = res[3:]
        print("res2:", res, len(res))
        num = BITS_NUM-len(res)+1
        if(num > 0):
            res = "01"+(num-2)*"0"+res
        print("res3:", res, len(res))
    else:
        res = res[2:]
        num = BITS_NUM-len(res)+1
        if(num > 0):
            res = num*"0"+res
    ####################################################################################
    over_flow = res[0]
    res = res[1:]
    return res, over_flow


def is_binary(binary):
    if(binary[:2] == "0b"):
        for i in range(2, len(binary)):
            if binary[i] != '0' and binary[i] != '1':
                print(binary)
                return False
    elif(binary[:3] == "-0b"):
        for i in range(3, len(binary)):
            if binary[i] != '0' and binary[i] != '1':
                print(binary)

                return False
    else:
        for i in range(len(binary)):
            if binary[i] != '0' and binary[i] != '1':
                print(binary)
                return False
    return True


def signed_to_binary(signed):
    if(signed[0] == '0'):
        signed = "0b"+signed[3:]
    else:
        signed = "-0b"+signed[4:]


def main():
    print("-------------------------START-------------------------------")
    while(True):
        choice = input("Enter 1 to use binary or anything to use decimal: ")
        if(choice == '1'):
            a_num = input("Enter 1st number (binary): ")
            b_num = input("Enter 2nd number (binary): ")
            if(len(a_num) != BITS_NUM or len(b_num) != BITS_NUM):
                print("Error: inputs must be {} bit binary numbers".format(BITS_NUM))
                exit(0)
            else:
                input_1 = binary_to_float(a_num)
                input_2 = binary_to_float(b_num)
        else:
            input_1 = float(input("Enter 1st number (decimal): "))
            input_2 = float(input("Enter 2nd number (decimal): "))
            a_num = float_to_bin(input_1)
            b_num = float_to_bin(input_2)
        if(is_binary(a_num) and is_binary(b_num)):
            mult_res, overflow_flag = mult(a_num, b_num)
            mult_res = add_fixed_point(mult_res)
            print("########MULTIPLICATION########")
            print("Binary: {} * {} = {} and overflow = {}".format(a_num,
                                                                  b_num, mult_res, overflow_flag))
            print("Dec: {} * {} = {} and overflow = {}".format(input_1,
                                                               input_2, binary_to_float(mult_res), overflow_flag))
            add_res, overflow_flag = add(a_num, b_num)
            add_res = add_fixed_point(add_res)
            print("###########Addition###########")
            print("Binary: {} + {} = {} and overflow = {}".format(a_num,
                                                                  b_num, add_res, overflow_flag))
            print("Dec: {} + {} = {} and overflow = {}".format(input_1,
                                                               input_2, binary_to_float(add_res), overflow_flag))

        else:
            print("Error: inputs must be {} bit binary numbers".format(BITS_NUM))
            exit(0)
        print("------------------------------------------------------------")


if __name__ == "__main__":
    main()
