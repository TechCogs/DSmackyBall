module GameState;

import Dgame.Window;
import Dgame.Window.Event;
import Dgame.System.StopWatch;

import GameObject;

class GameState {

  protected:

  Event evt;

  bool running = true;

  GameObject[string]* objects;
  GameObject ball;
  GameObject field;
  GameObject paddle1;
  GameObject paddle2;
  Window* win;

  StopWatch sw;

  public:

  this(ref GameObject[string] objects, ref Window win) {
    this.objects = &objects;
    this.win = &win;
    ball = objects["ball"];
    field = objects["field"];
    paddle1 = objects["paddle1"];
    paddle2 = objects["paddle2"];
    sw = StopWatch();
  }

  bool render() {

    while(win.poll(&evt)) {
      switch(evt.type) {
        case Event.Type.Quit:
          running = false;
        break;

        default: break;
      }
    }

    win.clear();
    foreach (object; *objects) {
      win.draw(object);
    }
    win.display();
    return running;
  }
}
