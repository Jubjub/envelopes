from godot import exposed, export
from godot.bindings import *
from godot.globals import *


@exposed
class Polygon2D(Polygon2D):

    # member variables here, example:
    a = export(int)
    b = export(str, default='foo')

    def _ready(self):
        """
        Called every time the node is added to the scene.
        Initialization here.
        """
        self.set_process(True)

    def _process(self, delta):
        self.translate(Vector2(10, 10) * delta)

