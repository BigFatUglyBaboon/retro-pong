class Ball {
  float posX, posY;
  float velX, velY;

  public Ball() {
    reset();
  }

  void updateVelocity(float newVelocityX, float newVelocityY) {
    this.velX = floor(constrain(newVelocityX, -MAX_BALL_VEL, MAX_BALL_VEL));
    this.velY = floor(constrain(newVelocityY, -MAX_BALL_VEL, MAX_BALL_VEL));
  }

  void update() {
    float prevPosX = posX;
    float prevPosY = posY;
    float newPosX = posX + velX;
    float newPosY = posY + velY;

    posX = newPosX;
    posY = newPosY;

    int paddleP1x=0, paddleP1y=0, paddleP2x=0, paddleP2y=0;
    float alignedX = 0;

    boolean checkCollision = false; // only check for collitions if ballX is 'close' to either paddle
    if (newPosX <= lPaddle.posX + PADDLE_WIDTH) {
      //LEFT PADDLE
      paddleP1x = lPaddle.posX + PADDLE_WIDTH;
      paddleP1y = lPaddle.posY;
      paddleP2x = lPaddle.posX + PADDLE_WIDTH;
      paddleP2y = lPaddle.posY + PADDLE_HEIGHT;
      alignedX = lPaddle.posX + PADDLE_WIDTH;
      checkCollision = true;
    } else if (newPosX >= rPaddle.posX) {
      //RIGHT PADDLE
      paddleP1x = rPaddle.posX;
      paddleP1y = rPaddle.posY;
      paddleP2x = rPaddle.posX;
      paddleP2y = rPaddle.posY + PADDLE_HEIGHT;
      alignedX = rPaddle.posX ;
      checkCollision = true;
    }

    /* check for collision if necessary */
    if (checkCollision) {
      if (
        intersects(paddleP1x, paddleP1y, paddleP2x, paddleP2y, prevPosX, prevPosY, newPosX, newPosY)
        )
      {
        paddleSoundFX.play();
        float newVelX = velX * -1.2;
        float newVelY = velY + floor(3*(posY - paddleP1y) / PADDLE_HEIGHT)-1; // resolves to -1, 0 or 1 depending on which 3d of the paddle was hit
        updateVelocity(newVelX, newVelY);
        posX = alignedX;
      }
    }


    if (posX < 0) {
      player2Score = player2Score+1;
      posX = 0;
      pointSoundFX.play();
      reset();
    }

    if (posX > GRID_W) {
      player1Score = player1Score+1;
      posX = GRID_W;
      pointSoundFX.play();
      reset();
    }

    if (posY < 0) {
      posY = 0;
      velY = -1 * velY;
      wallSoundFX.play();
    }

    if (posY > GRID_H) {
      posY = GRID_H;
      velY = -1 * velY;
      wallSoundFX.play();
    }
  }

  void reset() {
    if (player1Score==MAX_SCORE || player2Score==MAX_SCORE) {
      player1Score = 0;
      player2Score = 0;
    }
    posX = GRID_W/2;
    posY = GRID_H/2;
    int newDir = (velX>0?-1:1);
    int newVelX = floor(random(-MAX_BALL_VEL/3, MAX_BALL_VEL/3));
    float newVelY = random(-MAX_BALL_VEL/3, MAX_BALL_VEL/3);
    if (newVelX == 0) newVelX = 1;

    updateVelocity(newDir * newVelX, newVelY);
  }

  void render() {
    rect(canvasX + posX * squareSizeX, canvasY + posY * squareSizeY, squareSizeX, squareSizeY);
  }
}

static boolean intersects(
  float s1p1x, float s1p1y,
  float s1p2x, float s1p2y,
  float s2p1x, float s2p1y,
  float s2p2x, float s2p2y
  )
{
  //check bounding boxes
  if (
    max(s1p1x, s1p2x)>=min(s2p1x, s2p2x) &&
    max(s2p1x, s2p2x)>=min(s1p1x, s1p2x) &&
    max(s1p1y, s1p2y)>=min(s2p1y, s2p2y) &&
    max(s2p1y, s2p2y)>=min(s1p1y, s1p2y)
    )
    return true;

  //TODO: check if the trajectory intersects instead of the two boxes (this will allow for faster ball movement, i.e. ball X speed > PADDLE_WIDTH squares per frame).
  return false;
}
