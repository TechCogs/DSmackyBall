module GameStatePause;

import std.stdio;

import Dgame.Window;
import Dgame.Window.Event;
import Dgame.Graphic.Text;
import Dgame.System.Font;
import Dgame.System.Keyboard;

import GameObject;
import GameState;
import StateTracker;

class GameStatePause : GameState {

  private:

  float centerx;
  float topField;
  float bottomField;

  uint t;

  GameObject center;

  public:

  this(ref GameObject[string] objects, ref Window win) {
    super(objects, win);
    center = objects["center"];
    centerx = center.getVertices()[0].tupleof[0].x;
    topField = objects["topField"].getVertices()[0].tupleof[0].y;
    bottomField = objects["bottomField"].getVertices()[0].tupleof[0].y;
  }

  override void render() {
    Font font = Font("resources/font.ttf", 16);
    Text title = new Text(font, "Paused");
    while(win.poll(&evt)) {
      switch(evt.type) {
        case Event.Type.KeyDown:
          if (evt.keyboard.key == Keyboard.Key.P) {
            StateTracker.state = "playing";
            StateTracker.sw.reset();
          }
        break;
        case Event.Type.Quit:
          StateTracker.running = false;
        break;

        default: break;
      }
    }

    win.clear();
    foreach (object; *objects) {
      win.draw(object);
    }
    win.draw(title);
    win.display();
  }
}
