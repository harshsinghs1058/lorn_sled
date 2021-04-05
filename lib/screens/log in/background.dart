import 'package:flutter/material.dart';
import 'dart:math';

class BackGroundLogInPage extends StatelessWidget {
  const BackGroundLogInPage({
    Key key,
    @required this.height,
    @required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            child: CustomPaint(
              size: MediaQuery.of(context).size,
              painter: OpenPainter(context, MediaQuery.of(context).size),
            ),
          ),
          _buildIconWidget(),
        ],
      ),
    );
  }

  Positioned _buildIconWidget() {
    return Positioned(
      top: height * 0.15,
      left: width * 0.6,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
          border: Border.all(
            width: 3,
            color: Colors.grey.shade400,
          ),
        ),
        child: Image.asset(
          "images/logo.png",
        ),
      ),
    );
  }
}

class OpenPainter extends CustomPainter {
  final context;
  final size1;
  OpenPainter(this.context, this.size1);
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Colors.yellow[800]
      ..style = PaintingStyle.fill;
    var rect = Rect.fromPoints(
      Offset(-size1.width, -size1.height / 3),
      Offset(size1.width, size1.height / 3),
    );
    var rect2 = Rect.fromPoints(
      Offset(0, size1.height * 2 / 3),
      Offset(size1.width * 2, size1.height * 4 / 3),
    );
    //draw arc
    canvas.drawArc(rect, pi, 10, true, paint1);
    canvas.drawArc(rect2, pi, 10, true, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
