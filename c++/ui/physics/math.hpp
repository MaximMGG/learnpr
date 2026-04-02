#ifndef MATH_HPP
#define MATH_HPP
#include "vector.hpp"
#include <cmath>

namespace FM {

  class Math {

    float length(FP::Vector v) {

      float dx = v.X - 0.0f;
      float dy = v.Y - 0.0f;

      return float(sqrt(dx * dx + dy * dy));
    }

    float distance(FP::Vector a, FP::Vector b) {
      return 0;
    }

    FP::Vector normalize(FP::Vector v) {

    }
    
    float dot(FP::Vector a, FP::Vector b) {

    }

    float cross(FP::Vector a, FP::Vector b) {

    }

  };

};
#endif
