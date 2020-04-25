#include <stdio.h>
float Tk,Tz,Tn,Un,Uz,Uk,Tz_Reg,Tn_Reg,Div_Result_Reg;
char DivFlag,Shift,DoneFlag;
void interpolation_Division()
{
    if(DivFlag == '1' ){
        Div_Result_Reg= (Tk-Tn)/(Tz-Tn);
        DoneFlag ='1';}
}
void interpolation_Logic()
{
    if(DoneFlag == '1')
        Uk = Un + Div_Result_Reg*(Uz-Un);
}
int main(void)
{
    Tn_Reg = 0;
    while(true)
    {
        printf("enter Tk,TZ,Un,Uz respectively\n");
        scanf(" %f %f %f %f",&Tk,&Tz,&Un,&Uz);
        printf("enter division enable => 1 to enable divison and zero Otherwise \n");
        scanf(" %c",&DivFlag);
        printf("enter shift enable => 1 to enable shifiting Tz to Tn  \n");
        scanf (" %c",&Shift);
        if(Shift =='1')
        {
            Tn_Reg = Tz_Reg;
            Tz_Reg = Tz;
        }
        interpolation_Division();
        interpolation_Logic();
        printf("divison result = %f \n",Div_Result_Reg);
        printf("Uk value = %f \n",Uk);
    }
    return 0;
}