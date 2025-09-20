/*
 retro pong, an attempt at recreating atari pong in processing with a retro look
 */

import processing.sound.*;
import processing.serial.*;

/* NTSC resolution */
static final int NTSC_W = 768;
static final int NTSC_H = 480;

/* pong's 'resolution' */
static final int GRID_W = 127;
static final int GRID_H = 95;

/* Game Parameters */
static final int MAX_SCORE = 15;
static final float MAX_BALL_VEL = 1.0f;
static final int PADDLE_HEIGHT = 11;
static final int PADDLE_WIDTH = 2;
static final int LPADDLE_XPOS = 6;
static final int RPADDLE_XPOS = 119;

/* Scores */
int player1Score;
int player2Score;

/* soundFX */
SoundFile wallSoundFX, paddleSoundFX, pointSoundFX;

/* Graphics related variables */
PShader scanlinesShader, bloomShader;
int squareSizeX, squareSizeY; // actual pixels per ingame 'pixel'
int canvasWidth, canvasHeight; // a rectangle proportional to the NTSC screen aspect ratio, in pixels
int canvasX, canvasY; // x&y offsets of the NTSC proportioned rectangle for it to be centered on the screen 

/* Game objects */
Ball ball = new Ball();
Paddle lPaddle = new Paddle(PaddleId.PADDLE_A);
Paddle rPaddle = new Paddle(PaddleId.PADDLE_B);
Court court = new Court();

/* Serial port for the controller */
Serial port;
SerialControllerState serialControllerState = new SerialControllerState();

void setup() { 
  // setup serial port
  // TODO: implement a port selection screen instead of picking the first port from the system's serial port list
  printArray(Serial.list());
  port = new Serial(this, Serial.list()[0], 115200); 
  port.bufferUntil(10);
  
  // setup display
  fullScreen(P2D);
  noCursor();
  background(25);
  noStroke();
  fill(255);
  frameRate(60);

  /* load shaders */
  scanlinesShader = loadShader("shaders/scanlines.glsl");
  scanlinesShader.set("u_resolution", float(width), float(height));

  bloomShader = loadShader("shaders/bloom.glsl");
  bloomShader.set("u_resolution", float(width), float(height));

  /* load soundFX */
  wallSoundFX = new SoundFile(this, "sounds/wall.wav");
  paddleSoundFX = new SoundFile(this, "sounds/paddle.wav");
  pointSoundFX = new SoundFile(this, "sounds/point.wav");

  /* calculate the canvas dimensions to approximate the NTSC aspect ratio and the mapping of real pixels to game grid squares */
  /* the render() functions of all the game objects use these variables to draw themselves */
  canvasWidth = floor(height * NTSC_W / NTSC_H);
  canvasHeight = height; //assuming landscape mode here
  canvasX = (width - canvasWidth) / 2; //x offset of 'canvas'
  canvasY = (height - canvasHeight) / 2; //y offest of 'canvas', should be 0 in landscape mode
  squareSizeX = canvasWidth / GRID_W;
  squareSizeY = canvasHeight / GRID_H;
}

void draw() {
  background(25);  
  lPaddle.update();
  rPaddle.update();
  ball.update();
  court.render();
  lPaddle.render();
  rPaddle.render();
  ball.render();
  filter(bloomShader);
  filter(scanlinesShader);
}

void serialEvent(Serial p) {
  serialControllerState.updateState(p.readString());
}
