module GameState;

import Dgame.Window;
import Dgame.Window.Event;

import GameObject;

final struct GameState {

  private:

  Event evt;

  bool running = true;

  public:

  bool render(ref GameObject[string] objects, ref Window win) {

    while(win.poll(&evt)) {
      switch(evt.type) {
        case Event.Type.Quit:
          running = false;
        break;

        default: break;
      }
    }

    win.clear();
    foreach (object; objects) {
      win.draw(object);
    }
    win.display();
    return running;
  }
}
