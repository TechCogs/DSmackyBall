module GameStatePlaying;

import Dgame.Window;
import Dgame.Window.Event;

import GameObject;
import GameState;

class GameStatePlaying : GameState {

  private:

  int ballmovex = 1;
  int ballmovey = 1;

  public:

  this(ref GameObject[string] objects, ref Window win) {
    super(objects, win);
  }

  override bool render() {
    while(win.poll(&evt)) {
      switch(evt.type) {
        case Event.Type.Quit:
          running = false;
        break;

        default: break;
      }
    }

    immutable uint t = sw.getElapsedTicks;
    ball.x = ball.x + ball.speed * ballmovex * t;
    ball.y = ball.y + ball.speed * ballmovey * t;
    sw.reset();

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

    win.clear();
    foreach (object; *objects) {
      win.draw(object);
    }
    win.display();
    return running;
  }
}
