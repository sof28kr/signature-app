# formulario_cite

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

propiedades del signature controller:
Before we continue, let’s review the properties of the SignatureController:

SignatureController(
  Color penColor,
  double penStrokeWidth,
  Color exportBackgroundColor,
  List points,
  VoidCallback onDrawStart,
  VoidCallback onDrawMove,
  VoidCallback onDrawEnd,
)
Based on the properties above,

penColor: This is the color of the signature line drawn on the pad.
penStrokeWidth: This determines the width or thickness of the signature line drawn.
exportBackgroundColor: This will determine the color of the exported png image.
point: this is a setter representing the position of the signature on the 2D canvas.
onDrawStart: A callback function that notifies us when the drawing has started.
onDrawMove: A callback function that notifies us while drawing our signature.
onDrawEnd: A callback function that notifies us when the drawing has stopped.
