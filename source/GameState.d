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
  Window* win;

  StopWatch sw;

  public:

  this(ref GameObject[string] objects, ref Window win) {
    this.objects = &objects;
    this.win = &win;
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
