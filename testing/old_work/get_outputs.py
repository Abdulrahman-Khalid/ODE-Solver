from test import mult, add
def main():
    file1 = open('inputs.txt', 'r') 
    lines = file1.readlines() 
    file1.close()
    for i in range(1,len(lines)):
        lines[i] = lines[i][:-1]
    inputs_num =int(lines[0])
    A_arr=lines[1:inputs_num+1]
    B_arr=lines[-inputs_num:]
    print("A_arr:",A_arr,len(A_arr))
    print("B_arr:",B_arr,len(B_arr))
    output_file = open('outputs.txt', 'w') 
    res_mult=[]
    res_add=[]
    for i in range(inputs_num):
        res_mult.append(mult(A_arr[i],B_arr[i]))
        res_add.append(add(A_arr[i],B_arr[i]))
    for i in range(inputs_num):
        ans = "\"{}\" => \"{}\",\n".format(i,res_mult[i][0])
        output_file.write(ans)
    for i in range(inputs_num):
        ans = "\"{}\" => \"{}\",\n".format(i,res_mult[i][1])
        output_file.write(ans)  
    for i in range(inputs_num):
        ans = "\"{}\" => \"{}\",\n".format(i,res_add[i][0])
        output_file.write(ans)
    for i in range(inputs_num):
        ans = "\"{}\" => \"{}\",\n".format(i,res_add[i][1])
        output_file.write(ans)  
    output_file.close()
if __name__ == "__main__":
    main()