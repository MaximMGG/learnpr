#include <SDL2/SDL.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define SCREEN_WIDTH  900
#define SCREEN_HEIGHT  600
#define COLOR_WHITE  0xffffffff
#define COLOR_BLACK 0x00000000
#define POINT_SIZE  5
#define COORDINATE_SYSTEM_OFFSET_X  SCREEN_WIDTH / 2
#define COORDINATE_SYSTEM_OFFSET_Y  SCREEN_HEIGHT / 2


typedef struct {
    double x;
    double y;
    double z;
} Point;

void apply_rotation(Point *point, double alpha, double beta, double gamma) {
    double rotation_matrix[3][3] = {
        {cos(alpha) * cos(beta), 
         cos(alpha) * sin(beta) * sin(gamma) - sin(alpha) * cos(gamma), 
         cos(alpha) * sin(beta) * cos(gamma) + sin(alpha) * sin(gamma)},
        {sin(alpha) * cos(beta),
        sin(alpha) * sin(beta) * sin(gamma) + cos(alpha) * cos(gamma),
        sin(alpha) * sin(beta) * cos(gamma) - cos(alpha) * sin(gamma)},
        {-sin(beta), cos(beta) * sin(gamma), cos(beta) * cos(gamma)}
    };
    double point_vector[3] = {point->x, point->y, point->z};
    double result_point[3];

    for(int i = 0; i < 3; i++) {
        double dot_product = 0;
        for(int j = 0; j < 3; j++) {
            dot_product += rotation_matrix[i][j] * point_vector[j];
        }
        result_point[i] = dot_product;
    }

    point->x = result_point[0];
    point->y = result_point[1];
    point->z = result_point[2];
}


int draw_point(SDL_Surface *surface, double x, double y) {
    SDL_Rect rect = (SDL_Rect){x, y, POINT_SIZE, POINT_SIZE};
    SDL_FillRect(surface, &rect, COLOR_WHITE);

    return 0;
}


int draw_point_3d(SDL_Surface *surface, Point p[], int length) {

    
    for(int i = 0; i < length; i++) {
        double x_2d = p[i].x + (double)COORDINATE_SYSTEM_OFFSET_X;
        double y_2d = p[i].y + (double)COORDINATE_SYSTEM_OFFSET_Y;
        draw_point(surface, x_2d, y_2d);

    }

    return 0;
}


Point *initialize_cube(Point points[], int number_of_points) {

    int point_per_size = number_of_points / 12;
    const double SIDE_LENGHT = 200;
    int step_size = SIDE_LENGHT / point_per_size;


    //step 1
    for(int i = 0; i < point_per_size; i++) {
        points[i] = (Point){-SIDE_LENGHT / 2 + i * step_size, 
                            -SIDE_LENGHT / 2, SIDE_LENGHT / 2};
        printf("Line 1 point at x=%lf, y=%lf, z=%lf\n", points[i].x, points[i].y, points[i].z);
    }

    //step 2
    for(int i = 0; i < point_per_size; i++) {
        points[i+point_per_size] = (Point){-SIDE_LENGHT / 2 + i * step_size, 
                            SIDE_LENGHT / 2, SIDE_LENGHT / 2};
        printf("Line 2 point at x=%lf, y=%lf, z=%lf\n", points[i].x, points[i].y, points[i].z);
    }
    //step 3
    for(int i = 0; i < point_per_size; i++) {
        points[i+ 2 * point_per_size] = (Point){-SIDE_LENGHT / 2, 
                            -SIDE_LENGHT / 2 + i * step_size, SIDE_LENGHT / 2};
        printf("Line 3 point at x=%lf, y=%lf, z=%lf\n", points[i].x, points[i].y, points[i].z);
    }
    //step 4
    for(int i = 0; i < point_per_size; i++) {
        points[i+ 3 * point_per_size] = (Point){SIDE_LENGHT / 2, 
                                    -SIDE_LENGHT / 2 + i * step_size, 
                                    SIDE_LENGHT / 2};
        printf("Line 4 point at x=%lf, y=%lf, z=%lf\n", points[i].x, points[i].y, points[i].z);
    }
    //step 5
    for(int i = 0; i < point_per_size; i++) {
        points[i+ 4 * point_per_size] = (Point){-SIDE_LENGHT / 2 + i * step_size, 
                                    -SIDE_LENGHT / 2, 
                                    -SIDE_LENGHT / 2};
        printf("Line 5 point at x=%lf, y=%lf, z=%lf\n", points[i].x, points[i].y, points[i].z);
    }
    //step 6
    for(int i = 0; i < point_per_size; i++) {
        points[i+ 5 * point_per_size] = (Point){-SIDE_LENGHT / 2 + i * step_size, 
                                    SIDE_LENGHT / 2, 
                                    -SIDE_LENGHT / 2};
        printf("Line 6 point at x=%lf, y=%lf, z=%lf\n", points[i].x, points[i].y, points[i].z);
    }
    //step 7
    for(int i = 0; i < point_per_size; i++) {
        points[i+ 6 * point_per_size] = (Point){-SIDE_LENGHT / 2, 
                                    -SIDE_LENGHT / 2 + i * step_size, 
                                    -SIDE_LENGHT / 2};
        printf("Line 7 point at x=%lf, y=%lf, z=%lf\n", points[i].x, points[i].y, points[i].z);
    }
    //step 8
    for(int i = 0; i < point_per_size; i++) {
        points[i+ 7 * point_per_size] = (Point){SIDE_LENGHT / 2, 
                                    -SIDE_LENGHT / 2 + i * step_size, 
                                    -SIDE_LENGHT / 2};
        printf("Line 8 point at x=%lf, y=%lf, z=%lf\n", points[i].x, points[i].y, points[i].z);
    }
    //step 9
    for(int i = 0; i < point_per_size; i++) {
        points[i+ 8 * point_per_size] = (Point){-SIDE_LENGHT / 2, 
                                    -SIDE_LENGHT / 2, 
                                    -SIDE_LENGHT / 2 + i * step_size};
        printf("Line 9 point at x=%lf, y=%lf, z=%lf\n", points[i].x, points[i].y, points[i].z);
    }
    //step 10
    for(int i = 0; i < point_per_size; i++) {
        points[i+ 9 * point_per_size] = (Point){SIDE_LENGHT / 2, 
                                    -SIDE_LENGHT / 2, 
                                    -SIDE_LENGHT / 2 + i * step_size};
        printf("Line 10 point at x=%lf, y=%lf, z=%lf\n", points[i].x, points[i].y, points[i].z);
    }
    //step 11
    for(int i = 0; i < point_per_size; i++) {
        points[i+ 10 * point_per_size] = (Point){SIDE_LENGHT / 2, 
                                    SIDE_LENGHT / 2, 
                                    -SIDE_LENGHT / 2 + i * step_size};
        printf("Line 11 point at x=%lf, y=%lf, z=%lf\n", points[i].x, points[i].y, points[i].z);
    }
    //step 12
    for(int i = 0; i < point_per_size; i++) {
        points[i+ 11 * point_per_size] = (Point){-SIDE_LENGHT / 2, 
                                    SIDE_LENGHT / 2, 
                                    -SIDE_LENGHT / 2 + i * step_size};
        printf("Line 12 point at x=%lf, y=%lf, z=%lf\n", points[i].x, points[i].y, points[i].z);
    }

    return points;
}




int main() {

    SDL_Init(SDL_INIT_VIDEO);

    SDL_Window *window = 
        SDL_CreateWindow("3D Cube", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, SCREEN_WIDTH, SCREEN_HEIGHT, 0); 
    SDL_Surface *surface = SDL_GetWindowSurface(window);
    int delay = 5;


    //Point p = {0, 0, 0};
    SDL_Rect black_screen_rect = {0, 0, SCREEN_WIDTH, SCREEN_HEIGHT};
    int number_of_points = 1200;
    Point points[number_of_points];
    initialize_cube(points, number_of_points);
//    draw_point_3d(surface, points, number_of_points);
    

    SDL_Event e;
    int simulation_running = 1;
    double alpha = -0.01;
    double beta = 0.02;
    double gamma = 0.03;
    while(simulation_running) {

        while(SDL_PollEvent(&e)) {
            if (e.type == SDL_QUIT) {
                simulation_running = 0;
            } else if (e.type == SDL_KEYDOWN) {
                switch(e.key.keysym.sym) {
                    case 'q': {
                        simulation_running = 0;
                    } break;
                    default: {}

                }

            }
        }

        SDL_FillRect(surface, &black_screen_rect, COLOR_BLACK);
        for(int i = 0; i < number_of_points; i++) {
            alpha += 0.000000000001;
            beta += 0.000000000002;
            gamma += 0.000000000003;
            apply_rotation(&points[i], alpha, beta, gamma);
        }
        draw_point_3d(surface, points, number_of_points);
        SDL_UpdateWindowSurface(window);
        SDL_Delay(delay);
    }

    SDL_DestroyWindow(window);


    return 0;
}
