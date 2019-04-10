module GameStateTitle;

import std.stdio;

import Dgame.Window;
import Dgame.Window.Event;
import Dgame.Graphic.Text;
import Dgame.System.Font;
import Dgame.System.Keyboard;

import GameObject;
import GameState;
import StateTracker;

class GameStateTitle : GameState {

  private:

  float centerx;
  float topField;
  float bottomField;

  uint t;

  uint textx;
  uint texty;

  GameObject center;

  Text title;
  Text copyright;
  Text devName;
  Text pressEnter;

  public:

  this(ref GameObject[string] objects, ref Window win, ref Font font) {
    super(objects, win);
    center = objects["center"];
    centerx = center.getVertices()[0].tupleof[0].x;
    topField = objects["topField"].getVertices()[0].tupleof[0].y;
    bottomField = objects["bottomField"].getVertices()[0].tupleof[0].y;
    title = new Text(font, "DSmackyBall");
    copyright = new Text(font, "Copyright (c) 2019");
    devName = new Text(font, "Tech Cogs");
    pressEnter = new Text(font, "Press Enter to Play");
    textx = win.getSize().width / 2;
    texty = win.getSize().height / 2;
    title.setPosition(textx, texty);
    copyright.setPosition(textx, texty + 16);
    devName.setPosition(textx, texty + 32);
    pressEnter.setPosition(textx, texty + 48);
  }

  override void render() {
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
    win.draw(title);
    win.draw(copyright);
    win.draw(devName);
    win.draw(pressEnter);
    win.display();
  }
}
