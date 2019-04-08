module GameStateTitle;

import std.stdio;

import Dgame.Window;
import Dgame.Window.Event;
import Dgame.System.Keyboard;

import GameObject;
import GameState;

class GameStateTitle : GameState {

  private:

  int ballmovex = 1;
  int ballmovey = 1;

  float centerx;
  float topField;
  float bottomField;

  uint t;

  bool p2moveUp = false;
  bool p2moveDown = false;

  GameObject center;

  public:

  this(ref GameObject[string] objects, ref Window win) {
    super(objects, win);
    center = objects["center"];
    centerx = center.getVertices()[0].tupleof[0].x;
    topField = objects["topField"].getVertices()[0].tupleof[0].y;
    bottomField = objects["bottomField"].getVertices()[0].tupleof[0].y;
  }

  override bool render() {
    while(win.poll(&evt)) {
      switch(evt.type) {
        case Event.Type.KeyDown:
          if (evt.keyboard.key == Keyboard.Key.Up) {
            p2moveUp = true;
          }
          else if (evt.keyboard.key == Keyboard.Key.Down) {
            p2moveDown = true;
          }
        break;
        case Event.Type.KeyUp:
          if (evt.keyboard.key == Keyboard.Key.Up) {
            p2moveUp = false;
          }
          else if (evt.keyboard.key == Keyboard.Key.Down) {
            p2moveDown = false;
          }
        break;
        case Event.Type.Quit:
          running = false;
        break;

        default: break;
      }
    }

    t = sw.getElapsedTicks;
    sw.reset();

    win.clear();
    foreach (object; *objects) {
      win.draw(object);
    }
    win.display();
    return running;
  }
}
