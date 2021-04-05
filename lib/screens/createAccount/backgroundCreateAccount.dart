import 'package:flutter/material.dart';

class BackGroundCreateAccountPage extends StatelessWidget {
  const BackGroundCreateAccountPage({
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
              painter: TrianglePainter(),
            ),
          ),
          _buildIconWidget(),
        ],
      ),
    );
  }

  Widget _buildIconWidget() {
    return SizedBox(
      height: height * 1 / 3,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 30,
            ),
            Text(
              "  Sign\n  Up!",
              style: TextStyle(
                fontSize: 48,
                decoration: TextDecoration.none,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 125,
            ),
            Container(
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
          ],
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellow[800]
      ..strokeWidth = 10
      ..style = PaintingStyle.fill;

    final path1 = Path();
    path1.moveTo(0, 0);
    path1.lineTo(size.width, 0);
    path1.lineTo(0, size.height * 1 / 3);
    path1.close();
    canvas.drawPath(path1, paint);

    final path2 = Path();
    path2.moveTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.lineTo(size.width, size.height * 2 / 3);
    path2.close();
    canvas.drawPath(path2, paint);

    final paint1 = Paint()
      ..color = Colors.lightBlue
      ..strokeWidth = 10
      ..style = PaintingStyle.fill;

    final path3 = Path();
    path3.moveTo(size.width, size.height * 2 / 3);
    path3.lineTo(0, size.height);
    path3.lineTo(0, size.height * 1 / 3);
    path3.close();
    canvas.drawPath(path3, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
