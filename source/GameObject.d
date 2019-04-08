module GameObject;

import Dgame.Graphic.Shape;
import Dgame.Math.Geometry;
import Dgame.Math.Vertex;
import Dgame.Math.Vector2;

final class GameObject : Shape {

  private:

  int height_;
  int width_;
  float speed_ = 0;

  string name_;

  public:

  this(in int x, in int y, in int width, in int height, in string name) {
    super(Geometry.Quads,
      [
      Vertex(x, y),
      Vertex(x + width, y),
      Vertex(x + width, y + height),
      Vertex(x, y + height)
      ]
      );

      width_ = width;
      height_ = height;
      name_ = name;
  }

  this(in Vector2f first, in Vector2f second, in string name) {
    super(Geometry.Lines);
    append(first);
    append(second);
    name_ = name;
  }

  @property int height() const {
    return height_;
  }

  @property void height(int h) {
    height_ = h;
  }

  @property string name() const {
    return name_;
  }

  @property void name(string n) {
    name_ = n;
  }

  @property float speed() const {
    return speed_;
  }

  @property void speed(float s) {
    speed_ = s;
  }

  @property int width() const {
    return width_;
  }

  @property void width(int w) {
    width_ = w;
  }
}
