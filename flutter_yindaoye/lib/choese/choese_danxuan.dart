import 'package:flutter/material.dart';

class ChoeseDanxuanPage extends StatefulWidget {
  const ChoeseDanxuanPage({super.key});

  @override
  State<ChoeseDanxuanPage> createState() => _ChoeseDanxuanPageState();
}

class _ChoeseDanxuanPageState extends State<ChoeseDanxuanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("单选"),
      ),
      body: Center(
        child: Column(
          children: [
            CustomRadioButton("吃饭", 1),
            CustomRadioButton("睡觉", 2),
            CustomRadioButton("打豆豆", 3),
            CustomRadioButton("塞尔达", 4),
          ],
        ),
      ),
    );
  }

  int value = 0;
  Widget CustomRadioButton(String text, int index) {
    return 
    OutlinedButton(
      onPressed: () {
        setState(() {
          value = index;
        });
      },
      child: Text(
        text,
        style: TextStyle(
          color: (value == index) ? Colors.green : Colors.black,
        ),
      ),
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        side: WidgetStateProperty.all(
          BorderSide(color: (value == index) ? Colors.green : Colors.black),
        ),
      ),
    );
  }
}
