/* DSmackyBall
 *
 * A game that's very similar to Pong.
 *
 * Licensed under the GPLv3
 * Copyright (c) 2019 Tech Cogs
 * @TechCogs on GitHub and Twitter
 */

import std.stdio;

import Dgame.Window;
import Dgame.Window.Event;
import Dgame.Graphic.Color;
import Dgame.Graphic.Shape;
import Dgame.Math.Geometry;
import Dgame.Math.Vertex;
import Dgame.Math.Vector2;
import Dgame.System.Keyboard;
import Dgame.System.StopWatch;

import GameObject;
import GameState;
import GameStatePlaying;

enum WIDTH = 800;
enum HEIGHT = 600;

enum PADDLEW = 10;
enum PADDLEH = 65;

void main() {
	Window win = Window(WIDTH, HEIGHT, "DSmackyBall");
	win.setVerticalSync(Window.VerticalSync.Enable);
	win.setClearColor(Color4b.Black);

	GameObject[string] objects;
	GameState[string] state;

	/*Vertex[4] v;
	v[0] = Vertex(10, 10);
	v[1] = Vertex(100, 10);
	v[2] = Vertex(100, 100);
	v[3] = Vertex(10, 100);

	Shape field = new GameObject(Geometry.Quads, v);*/
	GameObject field = new GameObject(5, 5, WIDTH - 10, HEIGHT - 15);
	field.setPosition(0, 0);
	field.setColor(Color4b.White);
	field.fill = Shape.Fill.Line;
	objects["field"] = field;

	GameObject center = new GameObject(Vector2f((WIDTH - 10) / 2, 5), Vector2f((WIDTH - 10) / 2, HEIGHT - 10));
	center.setColor(Color4b.White);
	center.fill = Shape.Fill.Line;
	objects["center"] = center;

	GameObject paddle1 = new GameObject(0, 0, PADDLEW, PADDLEH);
	paddle1.setPosition(20, 20);
	paddle1.setColor(Color4b.White);
	objects["paddle1"] = paddle1;

	GameObject paddle2 = new GameObject(0, 0, PADDLEW, PADDLEH);
	paddle2.setPosition(WIDTH - PADDLEW - 20, 20);
	paddle2.setColor(Color4b.White);
	objects["paddle2"] = paddle2;

	GameObject ball = new GameObject(0, 0, 15, 15);
	ball.setPosition(50, 50);
	ball.setColor(Color4b.White);
	ball.speed = 0.2;
	objects["ball"] = ball;
	//float ballmovex, ballmovey;
	int ballmovex = 1;
	int ballmovey = 1;

	bool running = true;
	Event evt;
	StopWatch sw = StopWatch();
	state["playing"] = new GameStatePlaying();

	while(running) {
		/*ballmovex = ball.speed * sw.getElapsedTicks();
		ballmovey = ballmovex;*/
		immutable uint t = sw.getElapsedTicks;
		//ball.setPosition(ball.x + ball.speed * t, ball.y + ball.speed * t);
		ball.x = ball.x + ball.speed * ballmovex * t;
		ball.y = ball.y + ball.speed * ballmovey * t;
		sw.reset();

		if (ball.x + ball.width >= WIDTH - 10) {
			ballmovex = -ballmovex;
		}
		if (ball.x <= 5) {
			ballmovex = -ballmovex;
		}
		if (ball.y <= 5) {
			ballmovey = -ballmovey;
		}
		if (ball.y + ball.height >= HEIGHT - 15) {
			//ball.setPosition(ball.x, ball.y);
			//ball.setPosition(ball.x, HEIGHT - 15);
			ballmovey = -ballmovey;
			//ballmovey = -ballmovey;
			/*writeln("Before times:  ", ballmovey);
			//ballmovey *= -1;
			ballmovey = -ballmovey;
			writeln("After times:  ", ballmovey);*/
		}
		//ball.move(ballmovex, ballmovey);
		//ball.setPosition(ball.x + ballmovex, ball.y + ballmovey);
		/*while(win.poll(&evt)) {
			switch(evt.type) {
				case Event.Type.Quit:
					running = false;
				break;

				default:
				break;
			}
		}*/

		/*win.clear();
		win.draw(field);
		win.draw(center);
		win.draw(paddle1);
		win.draw(paddle2);
		win.draw(ball);
		win.display();*/
		running = state["playing"].render(objects, win);
	}
}
