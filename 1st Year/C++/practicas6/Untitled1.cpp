#include <iostream>
using namespace std;
const unsigned MAX=10;
typedef int Tarray[MAX];
int main(){
Tarray ar={3,2,5,3,6,3,1,2,3,2};
unsigned mayor;
mayor=6;
for(unsigned cont=mayor;cont>0;cont--)
{

        for(unsigned cont1=0;cont1<10;cont1++)
        {

            if(ar[cont1]>=cont)
            {
                cout<<" * ";
            }
            else
            {
                cout<<"   ";
            }


}
cout<<endl;
}
    return 0;
}
