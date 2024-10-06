import 'package:ct484_project/themes/chanhub_colors.dart';
import 'package:flutter/material.dart';

class WaterShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ChanHubColors.primary
      ..style = PaintingStyle.fill; // Chế độ vẽ (fill)

    final path = Path();

    // Tạo hình dạng nước
    path.moveTo(0, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.0,
        size.width * 0.5, size.height * 0.0);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.4, size.width, size.height * 0.7);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.4, size.width, size.height * 0.7);
    // path.lineTo(size.width, size.height); // Kết thúc hình dạng
    path.lineTo(0, size.height); // Quay về điểm bắt đầu

    canvas.drawPath(path, paint); // Vẽ hình dạng
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // Không cần repaint nếu không có thay đổi
  }
}

class WaterShapeExample extends StatelessWidget {
  const WaterShapeExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vẽ Hình Nước trên Canvas'),
      ),
      body: Center(
        child: CustomPaint(
          size: const Size(double.infinity, 200), // Kích thước của canvas
          painter: WaterShapePainter(), // Sử dụng WaterShapePainter
        ),
      ),
    );
  }
}
