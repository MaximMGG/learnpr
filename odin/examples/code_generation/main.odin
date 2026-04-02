package image_viewer

import "core:image"
import "core:image/png"


_ :: png

import "core:fmt"


main :: proc() {

    for &img, name in images {
        fmt.printfln("%v is %v x %v pixels and %v bytes large", name, img.width,
            img.height, len(img.data))

        if img.width > 15 {
            loaded_img, loaded_img_err := image.load_from_bytes(img.data)

            if loaded_img_err == nil {
                fmt.printfln("%v has width > 15, so we loaded it!", name)
                fmt.printfln("The loaded PNG image is indeed %v pixels wide!",
                    loaded_img.width)

            }
        }

    }
}
