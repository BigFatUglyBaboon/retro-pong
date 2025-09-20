# The game code

Disclaimer: Since this has been a hardware/software exercise for teaching my children the basics of programming do not expect a professional game developer quality of the code.

## Classes

* The pong sketch itself
* The SerialControllerState
* The Game Objects (Court, Paddles and Ball)

## The sketch

responsible for initializing the display, serial port, shaders, sound effects, game objects and for running the main loop.

### Display

The screen is initialized as 2D fullscreen hardware accelerated (we had problems doing this on raspberry pis - pies? - )

The game tries to imitate an NTSC screen on contemporary monitors.  Since the aspect ratios are different it creates an NTSC proportioned box (called canvas in the code) and centers it to your screen.  It also calculates how to fit a grid of the estimated size of the original pong (taken from screenshots of the game) into the canvas.

### Serial port

Since this was not intended for distribution it is very customized to my specs, the arduino always connects to the first serial port so the game just connects to the first serial port of the system's serial port list.  Something TODO is a port selection screen, or passing the port as an environment variable.

The serial port's speed is set to 115200 which may be wasteful.

Once initialized, all serial port input is forwarded to the SerialControllerState object (see below).

### Shaders

The game tries to imitate an old school look by using a couple of shaders (scanlines with screen curvature and a bloom shader which has very little visual impact)

The shaders are loaded in the setup() function and applied in the draw() function.

I know very little about shader programming, the shaders provided here were downloaded from shadertoy and merely adapted for use with processing by me.

Sources:
* [scanlines](https://www.shadertoy.com/view/WsVSzV)
* [bloom](https://www.shadertoy.com/view/lsXGWn)

Shaders are (c) their respective authors.

### Sound efects

The original pong uses 3 sound effects (paddle, point and wall) which were recreated using the original specs and audacity.  The sketch preloads the sounds and they are used by the game objects when needed.

### Game objects

The setup() function creates instances of the game objects while the draw() function updates them and draws them.  The objects are described below.

## SerialControllerState

This object is updated asynchronously by the sketch when a line of data arrives at the serial port and can be queried for the position of each paddle and the state of the buttons.

One of the tasks of this object is to map the position of the paddles to a value between 0 and 1.  Here I had to learn about logarithmic vs linear variable resistors (the paddle is waaaay more sensitive towards the top), and I think there is lots of room for improvement in this area.  One important issue is that the paddle positions sometimes oscillate by one grid square so they paddles look like they are jumping one pixel up and down.  Feel free to contact me with any improvements you may have on this (and any other areas).

## Game Objects

These objects have in common the update() and render() methods.  On every cycle the game calls all the update() methods and then all the render() methods.

There are three classes defined by the game:

### The court
(1 instance)

This object paints the mid-line in the court and the player score.

### The paddles
(2 instances)

Each instance of this class tracks the position of a paddle and is responsible for painting it.

### The ball
(1 instance)

Since the ball's position determines most of the behaviour of the game, most of the logic is within this object's update() method.  It will check if it has hit a wall (upper or lower), one of the paddles or if it has scored.

