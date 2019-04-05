module GameObject;

import Dgame.Graphic.Shape;
import Dgame.Math.Geometry;
import Dgame.Math.Vertex;
import Dgame.Math.Vector2;

class GameObject : Shape {

  private:

  float speed_ = 0;

  public:

  final this(in int x, in int y, in int width, in int height) {
    super(Geometry.Quads,
      [
      Vertex(x, y),
      Vertex(x + width, y),
      Vertex(x + width, y + height),
      Vertex(x, y + height)
      ]
      );
  }

  final this(in Vector2f first, in Vector2f second) {
    super(Geometry.Lines);
    append(first);
    append(second);
  }

  final @property float speed() const {
    return speed_;
  }

  final @property void speed(float s) {
    speed_ = s;
  }
}
