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
import GameStateTitle;
import GameStatePlaying;
import GameStatePause;
import GameStateWin;
import StateTracker;

enum WIDTH = 800;
enum HEIGHT = 600;

enum PADDLEW = 10;
enum PADDLEH = 65;

enum BALLW = 15;
enum BALLH = 15;

void main() {
	Window win = Window(WIDTH, HEIGHT, "DSmackyBall");
	win.setVerticalSync(Window.VerticalSync.Enable);
	win.setClearColor(Color4b.Black);

	GameObject[string] titleObjects;
	GameObject[string] playingObjects;
	GameObject[string] pauseObjects;
	GameObject[string] winObjects;
	GameState[string] state;

	/*Vertex[4] v;
	v[0] = Vertex(10, 10);
	v[1] = Vertex(100, 10);
	v[2] = Vertex(100, 100);
	v[3] = Vertex(10, 100);

	Shape field = new GameObject(Geometry.Quads, v);*/
	/*GameObject field = new GameObject(5, 5, WIDTH - 10, HEIGHT - 15);
	field.setPosition(0, 0);
	field.setColor(Color4b.White);
	field.fill = Shape.Fill.Line;
	//objects["field"] = field;*/

	GameObject topField = new GameObject(Vector2f(5, 5), Vector2f(WIDTH - 5, 5), "topField");
	topField.setColor(Color4b.White);
	titleObjects[topField.name] = topField;
	playingObjects[topField.name] = topField;
	pauseObjects[topField.name] = topField;
	winObjects[topField.name] = topField;

	GameObject bottomField = new GameObject(Vector2f(5, HEIGHT - 10), Vector2f(WIDTH - 5, HEIGHT - 10), "bottomField");
	bottomField.setColor(Color4b.White);
	titleObjects[bottomField.name] = bottomField;
	playingObjects[bottomField.name] = bottomField;
	pauseObjects[bottomField.name] = bottomField;
	winObjects[bottomField.name] = bottomField;

	GameObject center = new GameObject(Vector2f((WIDTH - 10) / 2, 5), Vector2f((WIDTH - 10) / 2, HEIGHT - 10), "center");
	center.setColor(Color4b.White);
	//center.fill = Shape.Fill.Line;
	titleObjects[center.name] = center;
	playingObjects[center.name] = center;
	pauseObjects[center.name] = center;
	winObjects[center.name] = center;

	GameObject paddle1 = new GameObject(0, 0, PADDLEW, PADDLEH, "paddle1");
	paddle1.setPosition(20, 20);
	paddle1.setColor(Color4b.White);
	paddle1.speed = 0.2;
	playingObjects[paddle1.name] = paddle1;

	GameObject paddle2 = new GameObject(0, 0, PADDLEW, PADDLEH, "paddle2");
	paddle2.setPosition(WIDTH - PADDLEW - 20, 20);
	paddle2.setColor(Color4b.White);
	paddle2.speed = 0.2;
	playingObjects[paddle2.name] = paddle2;

	GameObject ball = new GameObject(0, 0, BALLW, BALLH, "ball");
	ball.setPosition(50, 50);
	ball.setColor(Color4b.White);
	ball.speed = 0.2;
	playingObjects[ball.name] = ball;
	//float ballmovex, ballmovey;
	//int ballmovex = 1;
	//int ballmovey = 1;

	Event evt;
	StopWatch sw = StopWatch();
	import Dgame.System.Font;
	Font font = Font("resources/font.ttf", 16);
	state["title"] = new GameStateTitle(titleObjects, win, font);
	state["playing"] = new GameStatePlaying(playingObjects, win, font);
	state["pause"] = new GameStatePause(pauseObjects, win, font);
	state["win"] = new GameStateWin(winObjects, win, font);

	while(StateTracker.running) {
		/*ballmovex = ball.speed * sw.getElapsedTicks();
		ballmovey = ballmovex;*/
		//immutable uint t = sw.getElapsedTicks;
		//ball.setPosition(ball.x + ball.speed * t, ball.y + ball.speed * t);
		/*ball.x = ball.x + ball.speed * ballmovex * t;
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
		}*/
		//if (ball.y + ball.height >= HEIGHT - 15) {
			//ball.setPosition(ball.x, ball.y);
			//ball.setPosition(ball.x, HEIGHT - 15);
			//ballmovey = -ballmovey;
			//ballmovey = -ballmovey;
			/*writeln("Before times:  ", ballmovey);
			//ballmovey *= -1;
			ballmovey = -ballmovey;
			writeln("After times:  ", ballmovey);*/
		//}
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
		state[StateTracker.state].render();
	}
}
