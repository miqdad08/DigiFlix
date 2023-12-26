import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List<Widget> promotionList(List<String> promotionImageFiles) => [
      Padding(
        padding: EdgeInsets.only(left: 24, bottom: 15),
        child: Text(
          'Promotions',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: promotionImageFiles
              .map(
                (e) => Container(
                  width: 240,
                  height: 160,
                  margin: EdgeInsets.only(
                    left: e == promotionImageFiles.first ? 24 : 10,
                    right: e == promotionImageFiles.last ? 24 : 0,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/$e'),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    ];
