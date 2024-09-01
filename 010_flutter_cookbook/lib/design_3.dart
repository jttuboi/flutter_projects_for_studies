import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Design3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("custom fonts"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "using font Qahiri by inside downloaded font",
              style: TextStyle(
                fontFamily: "Qahiri",
              ),
            ),
            Text(
              "using font raleway by inside downloaded font",
              style: TextStyle(
                fontFamily: "Raleway",
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "no custom font",
              style: GoogleFonts.lato(
                textStyle: TextStyle(color: Colors.blue, letterSpacing: .5),
              ),
            ),
            Text("no custom font"),
          ],
        ),
      ),
    );
  }
}
