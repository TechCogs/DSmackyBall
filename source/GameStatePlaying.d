module GameStatePlaying;

import std.stdio;

import Dgame.Window;
import Dgame.Graphic.Text;
import Dgame.Window.Event;
import Dgame.System.Keyboard;
import Dgame.System.Font;
import Dgame.System.StopWatch;

import GameObject;
import GameState;
import StateTracker;

class GameStatePlaying : GameState {

  private:

  int ballmovex = 1;
  int ballmovey = 1;
  int p1score = 0;
  int p2score = 0;

  float centerx;
  float topField;
  float bottomField;

  uint t;

  bool p2moveUp = false;
  bool p2moveDown = false;

  GameObject ball;
  //GameObject field;
  GameObject center;
  GameObject paddle1;
  GameObject paddle2;

  Text p1display;
  Text p2display;

  public:

  this(ref GameObject[string] objects, ref Window win, ref Font font) {
    super(objects, win);
    ball = objects["ball"];
    //field = objects["field"];
    center = objects["center"];
    paddle1 = objects["paddle1"];
    paddle2 = objects["paddle2"];
    centerx = center.getVertices()[0].tupleof[0].x;
    topField = objects["topField"].getVertices()[0].tupleof[0].y;
    bottomField = objects["bottomField"].getVertices()[0].tupleof[0].y;
    p1display = new Text(font, "0");
    p2display = new Text(font, "0");
    p1display.setPosition(5, 10);
    p2display.setPosition(win.getSize().width - p2display.width() - 20, 10);
  }

  override void render() {
    while(win.poll(&evt)) {
      switch(evt.type) {
        case Event.Type.KeyDown:
          if (evt.keyboard.key == Keyboard.Key.Up) {
            p2moveUp = true;
          }
          else if (evt.keyboard.key == Keyboard.Key.Down) {
            p2moveDown = true;
          }
          else if (evt.keyboard.key == Keyboard.Key.P) {
            StateTracker.state = "pause";
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
          StateTracker.running = false;
        break;

        default: break;
      }
    }

    t = StateTracker.sw.getElapsedTicks;
    StateTracker.sw.reset();
    ball.x = ball.x + ball.speed * ballmovex * t;
    ball.y = ball.y + ball.speed * ballmovey * t;

    /*if (ball.x + ball.width >= field.width) {
      ballmovex = -ballmovex;
      ball.x = field.width - ball.width;
    }*/
    /*if (ball.x <= field.x + 5) {
      ballmovex = -ballmovex;
      ball.x = field.x + 5;
    }*/
    if (ball.y <= topField) {
      ballmovey = -ballmovey;
      ball.y = topField;
    }
    if (ball.y + ball.height >= bottomField) {
      ballmovey = -ballmovey;
      ball.y = bottomField - ball.height;
    }
    if (ball.x > paddle2.x + 50) {
      ball.setPosition(paddle1.x + 10, paddle1.y + 10);
      ++p1score;
      p1display.setData(p1score);
    }
    else if (ball.x < paddle1.x - 50) {
      ball.setPosition(paddle2.x - 10, paddle2.y - 10);
      ++p2score;
      p2display.setData(p2score);
    }

    /*if (ball.x + ball.width >= paddle2.x && ball.y >= paddle2.y && ball.y <= paddle2.y + paddle2.height) {
      ballmovex = -ballmovex;
      ball.x = paddle2.x - ball.width;
    }*/
    if (ball.x + ball.width >= paddle2.x) {
      // Ball hits on top edge of the paddle
      if (ball.y + ball.height >= paddle2.y && ball.y <= paddle2.y) {
        ballmovex = -ballmovex;
        ball.x = paddle2.x - ball.width;
      }
      // Ball hits in the middle of paddle
      else if (ball.y >= paddle2.y && ball.y + ball.height <= paddle2.y + paddle2.height) {
        ballmovex = -ballmovex;
        ball.x = paddle2.x - ball.width;
      }
      // Ball hits on the bottom edge of the paddle
      else if (ball.y + ball.height >= paddle2.y + paddle2.height && ball.y <= paddle2.y + paddle2.height) {
        ballmovex = -ballmovex;
        ball.x = paddle2.x - ball.width;
      }
    }

    else if (ball.x <= paddle1.x + paddle1.width) {
      // Ball hits on top edge of the paddle
      if (ball.y + ball.height >= paddle1.y && ball.y <= paddle1.y) {
        ballmovex = -ballmovex;
        ball.x = paddle1.x + paddle1.width;
      }
      // Ball hits in the middle of paddle
      else if (ball.y >= paddle1.y && ball.y + ball.height <= paddle1.y + paddle1.height) {
        ballmovex = -ballmovex;
        ball.x = paddle1.x + paddle1.width;
      }
      // Ball hits on the bottom edge of the paddle
      else if (ball.y + ball.height >= paddle1.y + paddle1.height && ball.y <= paddle1.y + paddle1.height) {
        ballmovex = -ballmovex;
        ball.x = paddle1.x + paddle1.width;
      }
    }

    if (ball.x < centerx) {
      if (ball.y < paddle1.y) {
        paddle1.y = paddle1.y - paddle1.speed * t;
      }
      else {
        paddle1.y = paddle1.y + paddle1.speed * t;
      }
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
    win.draw(p1display);
    win.draw(p2display);
    win.display();
  }
}
