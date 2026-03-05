#ifndef VECTOR_HPP
#define VECTOR_HPP


namespace FP {
  class Vector {
  public:
    float X;
    float Y;

    Vector(float x, float y) : X(x), Y(y){}

    Vector operator+(Vector a) {
      return Vector(this->X + a.X, this->Y + a.Y);
    }
    Vector operator-(Vector a) {
      return Vector(this->X - a.X, this->Y - a.Y);
    }
    Vector operator*(Vector a) {
      return Vector(this->X * a.X, this->Y * a.Y);
    }
    Vector operator/(Vector a) {
      return Vector(this->X / a.X, this->Y / a.Y);
    }
    Vector operator-() {
      return Vector(-this->X, -this->Y);
    }
    bool operator==(Vector a) {
      if (this->X == a.X && this->Y == a.Y) {
        return true;
      } else {
        return false;
      }
    }
  };
};


#endif
