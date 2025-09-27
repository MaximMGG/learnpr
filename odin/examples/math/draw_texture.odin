package draw_texture

import "base:runtime"

import "core:os"
import "core:fmt"
import "core:math/linalg/glsl"
import "core:math/noise"
import "core:mem"

import "vendor:glfw"
import gl "vendor:OpenGL"

WIDTH :: 400
HEIGHT :: 400
TITLE :: cstirng("Open Simplex 2 Texture!")

GL_MAJOR_VERSION :: 4
GL_MINOR_VERSION :: 1

Adjust_Noise :: struct {
    seed:      i64,
    octaves:   i32,
    frequency: f64,
}

Vertices :: [16]f32

create_vertices :: proc(x, y, width, height, f32) -> Vertices {

/**

0 - x,y
1 - x, y + heigth
2 - x + width, y
3 - x + width, y + height

0      2
|-----/|
|   /  |
|  /   |
|/-----|
1      3

**/
    vertices: Vertices = {
	x, y, 0.0, 1.0,
	x, y + heigth, 0.0, 0.0,
	x + width, y, 1.0, 1.0,
	x + width, y + heigth, 1.0, 0.0,
    }
    return vertices
    
}

WAVELENGTH :: 120
Pixel :: [4]u8

noise_at :: proc(seed: i64, x, y: int) -> f32 {
    return (noise.noise_2d(seed, {f64(x) / 120, f64(y) / 120}) + 1.0) / 2.0
}

create_texture_noise :: proc(texture_id: u32, adjust_noise: Adjust_Noise) {
    texture_data := make([]u8, WIDTH * HEIGHT * 4)
    defer delete(texture_data)

    gl.BindTexture(gl.TEXTURE_2D, texture_id)
    gl.ActiveTexture(gl.TEXTURE0)

    gradient_location: glsl.vec2 = {f32(WIDTH / 2), f32(HEIGHT / 2)}

    pixels := mem.slice_data_cast([]Pixel, texture_data)

    for x in 0..<WIDTH {
	for y in 0..<HEIGHT {
	    using adjust_noise := adjust_noise

	    noise_val: f32
	    {
		for i in 0..<int(octaves) {
		    noise_val += 0.4 * ((noise.noise_2d(seed, {f64(x) / frequency / 2, f64(y) / frequency / 2 }) + 1.0) / 2.0)
		    noise_val += 0.6 * ((noise.noise_2d(seed, {f64(x) / frequency / 2, f64(y) / frequency / 2 }) + 1.0) / 2.0)
		}
		noise_val /= f32(octaves)
	    }

	    val := glsl.distance_vec2({f32(x), f32(y)}, gradient_location)
	    val /= f32(HEIGHT / 2)
	    noise_val = noise_val - val

	    if noise_val < 0.0 {
		noise_val = 0
	    }
	    val = glsl.clamp(val, 0.0, 1.0)
	    color := u8((noise_val) * 255.0)

	    switch {
	    case color < 20:
		noise_val = 0.75 + 0.25 * noise_at(seed, x, y)
		pixels[0] = {u8(51 * noise_val), u8(81 * noise_val), u8(251 * noise_val), 255}
	    }
    }
}
