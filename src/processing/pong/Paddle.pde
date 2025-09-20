enum PaddleId {
  PADDLE_A, PADDLE_B
}

class Paddle {
  PaddleId paddleId;
  int posX, posY;

  Paddle(PaddleId paddleId) {
    this.paddleId = paddleId;
    
    posX = paddleId.equals(PaddleId.PADDLE_A)?LPADDLE_XPOS:RPADDLE_XPOS;
    posY = GRID_H/2;
  }

  void update() {
    // map the controller position to a game grid Y position
    posY = (int)map(paddleId.equals(PaddleId.PADDLE_A)?serialControllerState.positionPaddleA:serialControllerState.positionPaddleB, 0, 1, -1*PADDLE_HEIGHT - 3, GRID_H + 3);
  }
  void render() {
    rect(canvasX + posX * squareSizeX, canvasY + posY * squareSizeY, squareSizeX * PADDLE_WIDTH, squareSizeY * PADDLE_HEIGHT);
  }

}
