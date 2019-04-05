module GameState;

import Dgame.Window;
import Dgame.Window.Event;

import GameObject;

final struct GameState {

  void render(ref GameObject[string] objects, ref Window win) {

    win.clear();
    foreach (object; objects) {
      win.draw(object);
    }
    win.display();
  }
}
