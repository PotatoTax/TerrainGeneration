import peasy.*;
int w, h;

void setup() {
  fullScreen(P3D);
  //PeasyCam cam = new PeasyCam(this, 0, height/3, 0, 0);
  w = 2000;
  h = 2000;
}


void draw() {
  TerrainGenerator t = new TerrainGenerator(w, h);
  rotateX((1 * PI) / 4);
  translate(width/2 - w/2, height/2 - h/2 - 700, -500);
  
  int scale = 5;
  directionalLight(255, 200, 200, 0, 1, -.5);
  ambientLight(100, 100, 100);
  background(51);
  for (int y = 0; y < t.height_map.length - scale; y += scale) {
    noStroke();
    fill(0, 0, 255);
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < t.height_map[0].length; x += scale) {
      int[] c = t.get_color(t.height_map[y][x]);
      fill(c[0], c[1], c[2]);
      vertex(x, y, (float) t.height_map[y][x]*200);
      vertex(x, y + scale, (float) t.height_map[y+scale][x]*200);
    }
    endShape();
  }
  
  /*
  
  t = new TerrainGenerator();
  for (int y = 0; y < height; y += 5) {
    for (int x = 0; x < width; x += 5) {
      double val = t.height_map[y][x];
      int[] c = t.get_color(val);
      stroke(c[0], c[1], c[2]);
      fill(c[0], c[1], c[2]);
      rect(x, y, 5, 5);
    }
  }*/
}
