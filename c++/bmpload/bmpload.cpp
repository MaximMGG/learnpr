#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <string.h>

#define uint unsigned int
#define ushort unsigned short
#define uchar unsigned char


struct Header {
    ushort signature;
    uint filesize;
    uint reserved;
    uint dataoffset;
};

struct InfoHeader {
    uint size;
    uint width;
    uint height;
    ushort planes;
    ushort bitcount;
    uint compression;
    uint imagesize;
    uint xpixelsperm;
    uint ypixelsperm;
    uint colorused;
    uint colorsimportant;
};

struct ColorTable {
    uchar red;
    uchar green;
    uchar blue;
    uchar reserved;
};

class BMP {
    public:
        Header header;
        InfoHeader infoheader;
        ColorTable *colortable;
        char *RaserData;

        BMP() {};
        ~BMP() {};
};




void load_bmp_image(std::string name, BMP& bmp) {
    char buf[512]{0};
    FILE *f = fopen(name.c_str(), "r");

    if (f != NULL) {
        fread(buf, 1, 14, f);
    }

    bmp.header.signature = *(&buf[0]);
    bmp.header.filesize = *(&buf[2]);
    bmp.header.reserved = *(&buf[6]);
    bmp.header.dataoffset = *(&buf[10]);
    memset(buf, 0, 512);

    fread(buf, 1, 40, f);

    bmp.infoheader.size = *(&buf[0]);
    bmp.infoheader.width = *(&buf[4]);
    bmp.infoheader.height = *(&buf[8]);
    bmp.infoheader.planes = *(&buf[12]);
    bmp.infoheader.bitcount = *(&buf[14]);
    bmp.infoheader.compression = *(&buf[16]);
    bmp.infoheader.imagesize = *(&buf[20]);
    bmp.infoheader.xpixelsperm = *(&buf[24]);
    bmp.infoheader.ypixelsperm = *(&buf[28]);
    bmp.infoheader.colorused = *(&buf[32]);
    bmp.infoheader.colorsimportant = *(&buf[36]);

    if (bmp.infoheader.bitcount <= 8) {
        switch(bmp.infoheader.bitcount) {
            case 1: {
                bmp.RaserData = new char[(bmp.infoheader.width * bmp.infoheader.height) / 8];
                fread(bmp.RaserData, 1, (bmp.infoheader.width * bmp.infoheader.height) / 8, f);



            }
        }

    }




    fclose(f);
}



int main() {

    BMP bmp;
    std::string file_name {"e.bmp"};
    load_bmp_image(file_name, bmp);

    delete[] (bmp.RaserData);

    return 0;
}
