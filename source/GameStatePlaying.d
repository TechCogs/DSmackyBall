module GameStatePlaying;

import Dgame.Window;
import Dgame.Window.Event;
import Dgame.System.Keyboard;

import GameObject;
import GameState;

class GameStatePlaying : GameState {

  private:

  int ballmovex = 1;
  int ballmovey = 1;

  uint t;

  bool p2moveUp = false;
  bool p2moveDown = false;

  public:

  this(ref GameObject[string] objects, ref Window win) {
    super(objects, win);
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
    ball.x = ball.x + ball.speed * ballmovex * t;
    ball.y = ball.y + ball.speed * ballmovey * t;

    if (ball.x + ball.width >= field.width) {
      ballmovex = -ballmovex;
    }
    if (ball.x <= field.x + 5) {
      ballmovex = -ballmovex;
    }
    if (ball.y <= field.y + 5) {
      ballmovey = -ballmovey;
    }
    if (ball.y + ball.height >= field.height) {
      ballmovey = -ballmovey;
    }

    if (p2moveUp) {
      paddle2.y = paddle2.y - paddle2.speed * t;
    }
    else if (p2moveDown) {
      paddle2.y = paddle2.y + paddle2.speed * t;
    }

    win.clear();
    foreach (object; *objects) {
      win.draw(object);
    }
    win.display();
    return running;
  }
}
