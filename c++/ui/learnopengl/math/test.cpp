#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>
#include <glm/glm.hpp>
#include <iostream>


int main() {
    std::cout << "start\n";

    glm::vec4 a(1.2, 1.2, 1.1, 1.0);
    glm::vec4 b(3.3, 4.4, 5.5, 1.0);

    glm::vec4 c = a * b;

    std::cout << c.x << " " << c.y << " " << c.z << " " <<  c.w << '\n';
    

    std::cout << "end\n";
    return 0;
}
