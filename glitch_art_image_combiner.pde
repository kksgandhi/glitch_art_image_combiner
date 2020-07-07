String img1Path;
String img2Path;

PImage img1;
PImage img2;

int wid;

float avgBright1;
float avgBright2;

int mode = 0;

void setup() {
  // If command line arguments have been passed, just use those
  if (args != null && args.length == 2) {
    img1Path = args[0];
    img2Path = args[1];
  }
  // Otherwise, open a file picker dialogue
  else {
    // This dialogue calls functions getFile1 and getFile2 below
    // and populates img1Path & img2Path
    selectInput("First Image: ", "getFile1");
    selectInput("Second Image: ", "getFile2");
    // For our command line friends
    println("======================");
    println("IF YOU ARE RUNNING THIS FROM THE COMMAND LINE");
    println("CONSIDER PASSING THE FILES AS COMMAND LINE ARGUMENTS");
    println("======================");
  }
  while (img1Path == null || img2Path == null) {
    // Wait as the file picker populates the 2 image paths
    delay(100);
  }
  try {
    // Read the two images
    println("Loading image 1: " + img1Path);
    img1 = loadImage(img1Path);
    println("Loading image 2: " + img2Path);
    img2 = loadImage(img2Path);
  }
  catch (NullPointerException e) {
    // Didn't get a valid file? Exit
    println("Something went wrong loading your images");
    System.exit(1);
  }
  // Resize the images to the same height of a 1000 pixels
  // that way images can be very different sizes and still work reasonably
  img1.resize(0,1000);
  img2.resize(0,1000);
  // Ready the individual pixels to be read
  img1.loadPixels();
  img2.loadPixels();
  // placeholder initial size
  size(1900, 1000);

  // read the average brightness for each picture
  // we'll be using it later to determine which pixels to put on our final image
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

  // whichever image has a smaller width is
  // what we'll use for our final image
  wid = img1.width < img2.width ? img1.width : img2.width;
  surface.setSize(wid, 1000);
}

void draw() {
  /**
   * There are 4 modes:
   * darkest pixels of image 1 with darkest pixels of image 2
   * brigtest pixels of image 1 with darkest pixels of image 2
   * etc.
   *
   * In each draw step, one of the modes is chosen and that image is drawn to the screen
   * The coding style and beauty for this could be a lot better
   * like a lot
   * but it works and it wasn't too much of a pain
   */
  if (mode == 0) {
    for (int x = 0; x < wid; x++) {
      for (int y = 0; y < 1000; y++) {
        // Loop through all the pixels
        int i1 = img1.width * y + x;
        int i2 = img2.width * y + x;
        // and set that pixel based on the relative brightness values between the two images
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
    // mode 4? We're done, exit
    exit();
  }
  else {
    // save the image so you can look at it later
    save(str(mode) + ".jpg");
  }
  // increase the mode number so we can do a different thing on the next go around
  mode++;
}

void getFile1(File selection) {
  if (selection == null) {
    println("Something went wrong picking the image");
    System.exit(1);
  }
  else {
    // selector succeeded, set img1Path to what was selected
    img1Path = selection.getAbsolutePath();
  }
}
void getFile2(File selection) {
  if (selection == null) {
    println("Something went wrong picking the image");
    System.exit(1);
  }
  else {
    // selector succeeded, set img2Path to what was selected
    img2Path = selection.getAbsolutePath();
  }
}
