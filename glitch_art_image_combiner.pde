String img1Path;
String img2Path;
PImage img1;
PImage img2;
int wid;
float avgBright1;
float avgBright2;
String path;
int mode = 0;

void setup() {
  if (args != null && args.length == 2) {
    img1Path = args[0];
    img2Path = args[1];
  }
  else {
    selectInput("First Image: ", "getFile1");
    selectInput("Second Image: ", "getFile2");
    println("======================");
    println("IF YOU ARE RUNNING THIS FROM THE COMMAND LINE");
    println("CONSIDER PASSING THE FILES AS COMMAND LINE ARGUMENTS");
    println("======================");
  }
  while (img1Path == null || img2Path == null) {
    delay(100);
  }
  try {
    println("Loading image 1: " + img1Path);
    img1 = loadImage(img1Path);
    println("Loading image 2: " + img2Path);
    img2 = loadImage(img2Path);
  }
  catch (NullPointerException e) {
    println("Something went wrong loading your images");
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

void getFile1(File selection) {
  if (selection == null) {
    println("Something went wrong picking the image");
    System.exit(1);
  }
  else {
    img1Path = selection.getAbsolutePath();
  }
}
void getFile2(File selection) {
  if (selection == null) {
    println("Something went wrong picking the image");
    System.exit(1);
  }
  else {
    img2Path = selection.getAbsolutePath();
  }
}
