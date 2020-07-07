PImage img1;
PImage img2;
int wid;
float avgBright1;
float avgBright2;
String path;
int mode = 0;

void setup() {
  try {
    img1 = loadImage(args[0]);
    img2 = loadImage(args[1]);
  }
  catch (NullPointerException e) {
     println("Unable to find image, please see Readme");
     System.exit(1);
  }
  img1.resize(0,1000);
  img2.resize(0,1000);
  img1.loadPixels();
  img2.loadPixels();
  size(1900, 1000);

  float totalBright1 = 0;
  for (int i = 0; i < img1.width * img1.height; i++) { 
    totalBright1 += brightness(img1.pixels[i]);
  }
  avgBright1 = totalBright1 / (float)(img1.width * img1.height);

  float totalBright2 = 0;
  for (int i = 0; i < img2.width * img2.height; i++) { 
    totalBright2 += brightness(img2.pixels[i]);
  }
  avgBright2 = totalBright2 / (float)(img2.width * img2.height);
  wid = img1.width < img2.width ? img1.width : img2.width;
  surface.setSize(wid, 1000);
}

void draw() {
  if (mode == 0) {
    for (int x = 0; x < wid; x++) {
      for (int y = 0; y < 1000; y++) {
        int i1 = img1.width * y + x;
        int i2 = img2.width * y + x;
        if (brightness(img1.pixels[i1]) / avgBright1 > brightness(img2.pixels[i2]) / avgBright2) {
          set(x, y, img1.pixels[i1]);
        }
        else {
          set(x, y, img2.pixels[i2]);
        }
      }
    }
  }
  if (mode == 1) {
    for (int x = 0; x < wid; x++) {
      for (int y = 0; y < 1000; y++) {
        int i1 = img1.width * y + x;
        int i2 = img2.width * y + x;
        if (brightness(img1.pixels[i1]) / avgBright1 < brightness(img2.pixels[i2]) / avgBright2) {
          set(x, y, img1.pixels[i1]);
        }
        else {
          set(x, y, img2.pixels[i2]);
        }
      }
    }
  }
  if (mode == 2) {
    for (int x = 0; x < wid; x++) {
      for (int y = 0; y < 1000; y++) {
        int i1 = img1.width * y + x;
        int i2 = img2.width * y + x;
        if (avgBright1 / brightness(img1.pixels[i1]) > brightness(img2.pixels[i2]) / avgBright2) {
          set(x, y, img1.pixels[i1]);
        }
        else {
          set(x, y, img2.pixels[i2]);
        }
      }
    }
  }
  if (mode == 3) {
    for (int x = 0; x < wid; x++) {
      for (int y = 0; y < 1000; y++) {
        int i1 = img1.width * y + x;
        int i2 = img2.width * y + x;
        if (avgBright1 / brightness(img1.pixels[i1]) < brightness(img2.pixels[i2]) / avgBright2) {
          set(x, y, img1.pixels[i1]);
        }
        else {
          set(x, y, img2.pixels[i2]);
        }
      }
    }
  }
  if (mode == 4) {
    exit();
  }
  else {
    save(str(mode) + ".jpg");
  }
  mode++;
}

color invert(color c) {
  float r = red(c);
  float g = green(c);
  float b = blue(c);
  return color(255 - r, 255 - g, 255 - b);
}
