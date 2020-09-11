// https://www.youtube.com/watch?v=PMb_hlb-ERY

import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final double width;
  final int value;
  final int totalValue;
  CustomProgressBar({this.width, this.value, this.totalValue});

  @override
  Widget build(BuildContext context) {
    double ratio = value / totalValue;
    double ratio_text = ratio * 100;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.timer,
              color: Colors.grey[700],
            ),
            SizedBox(
              width: 5,
            ),
            Stack(
              children: [
                Container(
                  width: width,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Material(
                  borderRadius: BorderRadius.circular(5),
                  child: AnimatedContainer(
                    height: 10,
                    width: width * ratio,
                    duration: Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      color: (ratio < 0.3)
                          ? Colors.red
                          : (ratio < 0.6)
                              ? Colors.amber[400]
                              : Colors.lightGreen,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        Text('$ratio_text % 완료')
      ],
    );
  }
}
