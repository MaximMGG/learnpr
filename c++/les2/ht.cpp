#include <iostream>
#include <stdio.h>
#include <cmath>

const int fut{12};
const double MITERS_IN_EANCH{0.0254};
const double KG_IN_POUDS{2.2};

using namespace std;



void sixs() {
    int km;
    int lt;
    cout << "Enter distanse in km: ";
    cin >> km;
    cout << "Enter gas volume: ";
    cin >> lt;
    double distanse = double(km) / double(lt);
    cout.setf(ios_base::fixed, ios_base::floatfield);
    cout << "Distanse per one litter is: " << distanse << endl; 

}


void fives() {
    long people_count;
    long counry_count;
    cout << "Enter the world's population: ";
    cin >> people_count;
    cout << "Enter the population of the counry: ";
    cin >> counry_count;
    double population_persent = (double(counry_count * 100.0) / double(people_count));
    cout.setf(ios_base::fixed, ios_base::floatfield);
    cout << "The population of the country is " << population_persent << " of the world population." << endl;
}


//----------
const int S_MIN{60};
const int S_HOUR{S_MIN * 60};
const int S_DAY{S_HOUR * 24};

//----------

void fours() {
    long seconds = 0;
    cout << "Enter the number of seconds: ";
    cin >> seconds;
    cout << seconds << " seconds = " << seconds / S_DAY << " days, "; 
    seconds %= S_DAY;
    cout << seconds / S_HOUR << " hours, ";
    seconds %= S_HOUR;
    cout << seconds / S_MIN << " minutes, " << seconds % S_MIN << " seconds\n";

}

const int ARC_MINUTES{60};

void therd() {
    int degrees = 0;
    int minutes = 0;
    int seconds = 0;
    cout << "Enter a latitude in degrees, minutes and seconds\n";
    cout << "First, enter the degrees: ";
    cin >> degrees;
    cout << "Next, enter the minutes of arc: ";
    cin >> minutes;
    cout << "Finally, enter the seconds of arc: ";
    cin >> seconds;
    double arc_minutes = double(minutes);
    double arc_seconds = double(seconds);
    arc_seconds /= 100;
    arc_minutes += arc_seconds;
    arc_minutes = (arc_minutes * 100) / ARC_MINUTES;
    arc_minutes /= 100;
    double arc_degrees = double(degrees);
    arc_degrees += arc_minutes;
    cout << degrees << " degrees, " << minutes << " minutes, " << seconds << " seconds = ";
    printf("%lf degrees\n", arc_degrees);
}



void second() {
    int futs = 0;
    int eanches = 0;
    int weight = 0;
    cout << "Enter your height in fut and eanches " << endl;
    cin >> futs >> eanches;
    cout << "Enter your weight in pounds\n";
    cin >> weight;
    eanches += futs * fut;
    double h_m = eanches / MITERS_IN_EANCH;
    double k_w = weight / KG_IN_POUDS;
    double index = weight / (h_m * h_m);
    cout << "Your body index is " << index << endl;
}


void first() {
    int d = 0;
    cout << "Enter tall in enches: _\b";
    cin >> d;
    int d_a = d / fut;
    int d_lost = d % fut;
    cout << "Your height is " << d_a << " futs, and " << d_lost << " enches" << endl;
}

int main() {
    // first();
    // second();
    // therd();
    // fours();
    // fives();
    sixs();

    return 0;
}
