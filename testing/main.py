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
        return change_to_signed_binary(format(int(number), "#0{}b".format(BITS_NUM+2)))
    num, dec = str(number).split(".")
    num = int(num)
    dec = int(dec)
    res = bin(num).lstrip("0b") + "."
    for _ in range(FIXED_POINT):
        num, dec = str((dec_convert(dec)) * 2).split(".")
        dec = int(dec)
        res += num
    return change_to_signed_binary(res)


def binary_to_float(binary):
    indx = BITS_NUM-FIXED_POINT
    temp = binary[1:indx] + binary[indx+1:]
    res = 0
    for i in range(BITS_NUM-1):
        if(temp[i] == '1'):
            res += 2**(FIXED_POINT-i)
    if(binary[0] == '1'):
        res *= -1
    return res


def multiplication(a_num, b_num):
    reg = format(0, "#0{}b".format(BITS_NUM+2))
    a_binary = format(a_num, "#0{}b".format(BITS_NUM+2))
    a_binary = a_binary[len(a_binary)-BITS_NUM:]
    b_binary = format(b_num, "#0{}b".format(BITS_NUM+2))
    b_binary = b_binary[len(b_binary)-BITS_NUM:]
    # print("hello:{}".format(b_binary))
    # b_binary = bin(b_num)[2:]
    # b_binary = (BITS_NUM-len(b_binary))*"0"+b_binary
    for i in range(len(b_binary)):
        idx = BITS_NUM-i-1
        if(b_binary[BITS_NUM-i-1] == '1'):
            reg = bin(int(reg, 2)+int(a_binary[1:]+"0"*i, 2))
    return int(reg, 2) if (a_num < 0 and b_num < 0) or(a_num >= 0 and b_num >= 0) else int('-'+reg, 2)


def addition(a_num, b_num):
    return bin(a_num+b_num)[2:]


def main():
    a_num = float(input("Enter 1st number (dec): "))
    b_num = float(input("Enter 2nd number (dec): "))
    print(binary_to_float(float_to_bin(a_num)))
    print(binary_to_float(float_to_bin(b_num)))
    # mult_res = multiplication(a_num, b_num)
    # print("Dec: {} * {} = {}".format(a_num, b_num, mult_res))
    # print("Binary: {} * {} = {}".format(bin(a_num), bin(b_num), bin(mult_res)))
    # print("Hexa: {} * {} = {}".format(hex(a_num), hex(b_num), hex(mult_res)))
    # print("{} * {} = {}".format(hex(a_num), hex(b_num), mult_res))


if __name__ == "__main__":
    main()
