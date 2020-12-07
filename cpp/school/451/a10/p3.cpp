#include <iostream>
using namespace std;

class String {
    public:
        String(char* ch){myString = ch;}
        String(){myString=NULL;}
        char* getString(){return myString;}
        char* myString;    
};

template <class T,const int n> class MyClass {
    public:
        void add(int m,T* T1){a[m] = T1;}
        T* get(int m) {return a[m];}
    private:
        T* a[n];
};

int main(){
    int i = 10;
    MyClass<String,i> MyClass1;
    String String1("string1");
    String String2("string2");
    MyClass1.add(0,&String1);
    MyClass1.add(1,&String2);
    cout << MyClass1.get(1)->getString();
}
