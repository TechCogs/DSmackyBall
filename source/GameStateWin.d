module GameStateWin;

import std.stdio;

import Dgame.Window;
import Dgame.Window.Event;
import Dgame.Graphic.Text;
import Dgame.System.Font;
import Dgame.System.Keyboard;

import GameObject;
import GameState;
import StateTracker;

class GameStateWin : GameState {

  private:

  float centerx;
  float topField;
  float bottomField;

  uint t;

  uint textx;
  uint texty;

  GameObject center;

  Text message;
  Text pressEnter;

  public:

  this(ref GameObject[string] objects, ref Window win, ref Font font) {
    super(objects, win);
    center = objects["center"];
    centerx = center.getVertices()[0].tupleof[0].x;
    topField = objects["topField"].getVertices()[0].tupleof[0].y;
    bottomField = objects["bottomField"].getVertices()[0].tupleof[0].y;
    message = new Text(font);
    pressEnter = new Text(font, "Press Enter to Play Again");
    textx = win.getSize().width / 2;
    texty = win.getSize().height / 2;
    message.setPosition(textx, texty);
    pressEnter.setPosition(textx, texty + 16);
  }

  override void render() {
    message.setData(StateTracker.message);
    while(win.poll(&evt)) {
      switch(evt.type) {
        case Event.Type.KeyDown:
          if (evt.keyboard.key == Keyboard.Key.Return) {
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
    win.draw(message);
    win.draw(pressEnter);
    win.display();
  }

  void setText(string t) {
    message.setData(t);
  }
}
