#include <iostream>
using namespace std;

ostream* function(ostream *aOut) {
    *(aOut) << "Hello" << endl;
    return aOut;
    
}

int main () {
    function(function(&cout));
}