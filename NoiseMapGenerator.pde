class NoiseMapGenerator {
  final double PERSISTANCE = .5;
  final float LACUNARITY = 3;
  final int OCTAVES = 5;
  final int SCALE = 400;
  double[][] points;
  int w, h;

  public NoiseMapGenerator(int w, int h) {
    this.w = w;
    this.h = h;
    this.points = this.generate_noise_map();
    
    float max_val = 1;
    for (int i = 1; i < this.OCTAVES; i++) {
      max_val += Math.pow(this.PERSISTANCE, i);
    }

    for (int y = 0; y < this.h; y++) {
      for (int x = 0; x < this.w; x++) {
        this.points[y][x] = map((float) this.points[y][x], 0, max_val, 0, 1);
      }
    }
  }

  public double[][] generate_noise_map() {
    float[] x_off = new float[OCTAVES];
    float[] y_off = new float[OCTAVES];
    for (int i = 0; i < OCTAVES; i++) {
      x_off[i] = random(10000);
      y_off[i] = random(10000);
    }
    double[][] points = new double[this.h][this.w];
    
    for (int y = 0; y < this.h; y++) { // fills points with doubles between 0 and 1
      for (int x = 0; x < this.w; x++) {
        points[y][x] = noise((x + x_off[0]) / this.SCALE, (y + y_off[0]) / this.SCALE);
        for (int i = 1; i < OCTAVES; i++) {
          points[y][x] += pow((float) this.PERSISTANCE, i) * noise(this.LACUNARITY * ((x + x_off[i]) / this.SCALE), this.LACUNARITY * ((y + y_off[i]) / this.SCALE));
        }
      }
    }
    return points;
  }
}
