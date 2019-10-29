public class TerrainGenerator {
  public double[][] height_map;
  TerrainType[] regions = new TerrainType[] {
    new TerrainType("Snow", new int[]{195, 232, 229}, .9),
    new TerrainType("Mountain", new int[]{92, 79, 50}, .5),
    new TerrainType("Land", new int[]{0, 133, 31}, .07),
    new TerrainType("Sand", new int[]{214, 214, 152}, .05),
    new TerrainType("Water", new int[]{97, 184, 201}, 0)
  };

  public TerrainGenerator(int w, int h) {
    height_map = new NoiseMapGenerator(w, h).points;
    for (int y = 0; y < height_map.length; y++) {
      for (int x = 0; x < height_map[0].length; x++) {
        height_map[y][x] = pow(map((float)height_map[y][x], 0, 1, .1, 1.1), 4);
        double dist = sqrt(pow(abs(w/2 - x), 2) + pow(abs(h/2 - y), 2));
        dist = pow(map((float) dist, 0, sqrt((w*h)/4), 3, .2), 1.6);
        height_map[y][x] *= dist;
      }
    }
  }

  public int[] get_color(double h) {
    for (TerrainType r : this.regions) {
      if (h >= r.bottom) {
        return r.c;
      }
    }
    return new int[]{0, 0, 0};
  }
  
  public TerrainType get_region(double h) {
    for (TerrainType r : this.regions) {
      if (h >= r.bottom) {
        return r;
      }
    }
    return null;
  }
}
