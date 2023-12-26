import 'package:digi_flix/presentation/misc/methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget transactionRow({
  required String title,
  required String value,
  required double width,
}) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(title, style: const TextStyle(color: Colors.grey),),
          ),
          horizontalSpace(20),
          SizedBox(
            width: width - 110 - 20,
            child: Text(value,),
          ),
        ],
      ),
    );
