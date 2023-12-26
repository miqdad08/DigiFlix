import 'package:flutter/material.dart';

Widget cardPattern() => Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        3,
        (rowindex) => Row(
          children: List.generate(
            rowindex + 4,
            (columnIndex) => Container(
              width: 30,
              height: 30,
              margin: EdgeInsets.only(
                left: columnIndex == 0 ? 3 : 0,
                right: 3,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity((0.05 * (rowindex + 1)) + 0.05),
                    Colors.white.withOpacity((0.05 * rowindex) + 0.05),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: columnIndex == 0 && rowindex == 0
                      ? Radius.circular(10)
                      : Radius.zero,
                  bottomLeft: columnIndex == 0 && rowindex == 2
                      ? Radius.circular(10)
                      : Radius.zero,
                ),
              ),
            ),
          ),
        ),
      ),
    );
