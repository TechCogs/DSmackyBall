module GameState;

import Dgame.Window;
import Dgame.Window.Event;

import GameObject;
import StateTracker;

class GameState {

  protected:

  Event evt;

  GameObject[string]* objects;
  Window* win;

  public:

  this(ref GameObject[string] objects, ref Window win) {
    this.objects = &objects;
    this.win = &win;
  }

  void render() {

    while(win.poll(&evt)) {
      switch(evt.type) {
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
    win.display();
  }
}
