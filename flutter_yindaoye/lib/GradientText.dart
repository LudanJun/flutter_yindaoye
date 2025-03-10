import 'package:flutter/material.dart';

/** 
 * 使用
 *        GradientText(
              data: subHead,
              gradient:
                  LinearGradient(colors: [Colors.blue, Colors.deepPurple]),
              style: TextStyle(
                fontSize: 25,
              ),
            ),
 */
//渐变字体颜色
class GradientText extends StatelessWidget {
  final String data;
  final Gradient gradient;
  final TextStyle style;
  final TextAlign textAlign;
  const GradientText(
      {super.key,
      required this.data,
      required this.gradient,
      required this.style,
      this.textAlign = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient.createShader(Offset.zero & bounds.size);
      },
      child: Text(
        data,
        textAlign: textAlign,
        style: (style == null)
            ? TextStyle(color: Colors.white)
            : style.copyWith(color: Colors.white),
      ),
    );
  }
}
