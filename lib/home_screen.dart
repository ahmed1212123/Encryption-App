import 'package:encryption_decryption/Style.dart';
import 'package:encryption_decryption/admob/banner_ad.dart';
import 'package:encryption_decryption/model/auto_key_cipher.dart';
import 'package:encryption_decryption/model/caesar_cipher.dart';
import 'package:flutter/material.dart';

import 'model/playfair_cipher.dart';
import 'model/vigenere_cipher.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, 0);
    path_0.lineTo(size.width * 0.0006666667, 0);
    path_0.lineTo(size.width * 0.0006666667, size.height * 0.7813108);
    path_0.lineTo(0, size.height * 0.7813108);
    path_0.lineTo(0, size.height * 0.9973351);
    path_0.cubicTo(
        size.width * 0.00009748507,
        size.height * 0.8823189,
        size.width * 0.08880400,
        size.height * 0.7883243,
        size.width * 0.2006669,
        size.height * 0.7816838);
    path_0.lineTo(size.width * 0.7866667, size.height * 0.7816838);
    path_0.cubicTo(size.width * 0.9044880, size.height * 0.7816838, size.width,
        size.height * 0.6848811, size.width, size.height * 0.5654676);
    path_0.lineTo(size.width, 0);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Colors.black.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;


    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: Size(width, (height * 0.3).toDouble()),
                  //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                  painter: RPSCustomPainter(),
                ),
                Text(
                  'Encryption & Decryption',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: sizeFromHeight(context, 1.65),
              //color: Colors.red,
              child: ListView(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CaesarCipher(),
                          ));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: sizeFromWidth(context, 12), vertical: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/caesar-cipher.png'),
                            radius: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              'Caesar Cipher',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.blue[900]),
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayfairCipher(),
                          ));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: sizeFromWidth(context, 12), vertical: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/playfire-icon.png'),
                            radius: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child:  Text(
                              'Playfire Cipher',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.blue[900]),
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VigenereCipher(),
                          ));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: sizeFromWidth(context, 12), vertical: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/vigenere.png'),
                            radius: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              'Vigenere Cipher',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.blue[900]),
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AutoKeyCipher(),
                          ));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: sizeFromWidth(context, 12), vertical: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/autokey.png'),
                            radius: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              'AutoKey Cipher',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.blue[900]),
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AdBanner(),
          ],
        ),
      ),
    );
  }
}
