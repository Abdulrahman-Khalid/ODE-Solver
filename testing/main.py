
FIXED_POINT = 7
BITS_NUM = 16


def dec_to_binary(num):
    while num > 1:
        num /= 10
    return num


def float_to_bin(number):
    num, dec = str(number).split(".")
    num = int(num)
    dec = int(dec)
    res = format(num, "#0{}b".format(BITS_NUM+2)).lstrip("0b") + "."
    for _ in range(FIXED_POINT):
        num, dec = str((dec_to_binary(dec)) * 2).split(".")
        dec = int(dec)
        res += num
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
    a_num = int(input("Enter 1st number (dec): "))
    b_num = int(input("Enter 2nd number (dec): "))
    add_result = addition(a_num, b_num)
    mult_res = multiplication(a_num, b_num)
    print("Dec: {} * {} = {}".format(a_num, b_num, mult_res))
    print("Binary: {} * {} = {}".format(bin(a_num), bin(b_num), bin(mult_res)))
    print("Hexa: {} * {} = {}".format(hex(a_num), hex(b_num), hex(mult_res)))
    # print("{} * {} = {}".format(hex(a_num), hex(b_num), mult_res))


if __name__ == "__main__":
    main()
