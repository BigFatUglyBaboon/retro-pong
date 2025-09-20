class Court {
  final int[][][] digits =
    {
    {
      { 1, 1, 1, 1},
      { 1, 0, 0, 1},
      { 1, 0, 0, 1},
      { 1, 0, 0, 1},
      { 1, 0, 0, 1},
      { 1, 1, 1, 1}
    },
    {
      { 0, 0, 0, 1},
      { 0, 0, 0, 1},
      { 0, 0, 0, 1},
      { 0, 0, 0, 1},
      { 0, 0, 0, 1},
      { 0, 0, 0, 1}
    },
    {
      { 1, 1, 1, 1},
      { 0, 0, 0, 1},
      { 1, 1, 1, 1},
      { 1, 0, 0, 0},
      { 1, 0, 0, 0},
      { 1, 1, 1, 1}
    },
    {
      { 1, 1, 1, 1},
      { 0, 0, 0, 1},
      { 0, 1, 1, 1},
      { 0, 0, 0, 1},
      { 0, 0, 0, 1},
      { 1, 1, 1, 1}
    },
    {
      { 1, 0, 0, 1},
      { 1, 0, 0, 1},
      { 1, 1, 1, 1},
      { 0, 0, 0, 1},
      { 0, 0, 0, 1},
      { 0, 0, 0, 1}
    },
    {
      { 1, 1, 1, 1},
      { 1, 0, 0, 0},
      { 1, 1, 1, 1},
      { 0, 0, 0, 1},
      { 0, 0, 0, 1},
      { 1, 1, 1, 1}
    },
    {
      { 1, 1, 1, 1},
      { 1, 0, 0, 0},
      { 1, 1, 1, 1},
      { 1, 0, 0, 1},
      { 1, 0, 0, 1},
      { 1, 1, 1, 1}
    },
    {
      { 1, 1, 1, 1},
      { 0, 0, 0, 1},
      { 0, 0, 0, 1},
      { 0, 0, 0, 1},
      { 0, 0, 0, 1},
      { 0, 0, 0, 1}
    },
    {
      { 1, 1, 1, 1},
      { 1, 0, 0, 1},
      { 1, 1, 1, 1},
      { 1, 0, 0, 1},
      { 1, 0, 0, 1},
      { 1, 1, 1, 1}
    },
    {
      { 1, 1, 1, 1},
      { 1, 0, 0, 1},
      { 1, 1, 1, 1},
      { 0, 0, 0, 1},
      { 0, 0, 0, 1},
      { 0, 0, 0, 1}
    }
  };

  void draw_digit(int digit, int posX, int posY) {
    for (int j = 0; j<6; j++) {
      for (int i=0; i<4; i++) {
        if (digits[digit][j][i]==1) {
          rect(canvasX + (posX + i) * squareSizeX, canvasY + (posY + j) * squareSizeY, squareSizeX, squareSizeY);
        }
      }
    }
  }

  void draw_score() {
    int tp1 = player1Score / 10;
    int up1 = player1Score - tp1 * 10;
    int tp2 = player2Score / 10;
    int up2 = player2Score - tp2 * 10;

    draw_digit(tp1, 10, 1);
    draw_digit(up1, 15, 1);
    draw_digit(tp2, GRID_W - 19, 1);
    draw_digit(up2, GRID_W - 14, 1);
  }


  void render() {
    int x = canvasX + (GRID_W / 2) * squareSizeX;
    for (int i = 0; i < GRID_H; i+=3) {
      rect(x, canvasY + i * squareSizeY, squareSizeX, 2 * squareSizeY);
    }
    draw_score();
  }
}
