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

  public:

  this(in int x, in int y, in int width, in int height) {
    super(Geometry.Quads,
      [
      Vertex(x, y),
      Vertex(x + width, y),
      Vertex(x + width, y + height),
      Vertex(x, y + height)
      ]
      );
  }

  this(in Vector2f first, in Vector2f second) {
    super(Geometry.Lines);
    append(first);
    append(second);
  }

  @property int height() const {
    return height_;
  }

  @property void height(int h) {
    height_ = h;
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
