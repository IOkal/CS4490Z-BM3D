#include <vector>
#include <stdlib.h>
#include <stdio.h>
#include <iostream>

using namespace std;

int main(){
    vector<double> thisThing = {1, 2, 3, 4};
    cout << "Element at vector(vector.size()) = " << thisThing[thisThing.size()] << endl;
    std::cout << "Size: " << thisThing.size() << std::endl;
    return 0;
}