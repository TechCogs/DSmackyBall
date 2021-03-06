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

  uint textx;
  uint texty;

  GameObject center;

  Text title;

  public:

  this(ref GameObject[string] objects, ref Window win, ref Font font) {
    super(objects, win);
    center = objects["center"];
    centerx = center.getVertices()[0].tupleof[0].x;
    topField = objects["topField"].getVertices()[0].tupleof[0].y;
    bottomField = objects["bottomField"].getVertices()[0].tupleof[0].y;
    title = new Text(font, "Paused");
    textx = win.getSize().width / 2;
    texty = win.getSize().height / 2;
    title.setPosition(textx, texty);
  }

  override void render() {
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
