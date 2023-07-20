import 'package:encryption_decryption/admob/banner_ad.dart';
import 'package:encryption_decryption/home_screen.dart';
import 'package:flutter/material.dart';

import '../Style.dart';

class CaesarCipher extends StatefulWidget {
  @override
  _CaesarCipherState createState() => _CaesarCipherState();
}

class _CaesarCipherState extends State<CaesarCipher> {
  TextEditingController _wordController = TextEditingController();
  TextEditingController _keyController = TextEditingController();
  String _result = "";
  var formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    _wordController.dispose();
    _keyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: black,
          elevation: 0,
          title: const Text('Caeser Cipher'),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/2.jpg'), fit: BoxFit.cover),
            ),
            child: Form(
              key: formkey,
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: SizedBox(

                      child: TextFormField(
                        maxLines: 4,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Input your text here',
                          fillColor: Colors.grey[300],
                          filled: true,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your text";
                          }
                          return null;
                        },
                        controller: _wordController,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Container(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fillColor: Colors.grey[300],
                          filled: true,
                          hintText: 'Input your key',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your Key";
                          }
                          return null;
                        },
                        controller: _keyController,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        MaterialButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              _Encrypt();
                            }
                          },
                          color: Colors.green,
                          child: const Text("Encrypt"),
                        ),
                        MaterialButton(
                          color: Colors.blue,
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              _Dycrypt();
                            }
                          },
                          child: const Text("Decrypt"),
                        ),
                        MaterialButton(
                          onPressed: _delete,
                          color: Colors.red,
                          child: const Text("Delete"),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: const Text(
                      'Output :',
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: sizeFromWidth(context, 1),
                    height: sizeFromHeight(context, 3),
                    decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.orange, width: 3)),
                    padding: const EdgeInsets.all(10),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Text(
                      _result,
                      style: const TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  AdBanner(),
                  Container(
                    height: sizeFromHeight(context, 2),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _Encrypt() {
    late String _text = _wordController.text;
    late int _key;
    late String _temp = "";

    try {
      _key = int.parse(_keyController.text);
    } catch (e) {
      print(e);
    }

    for (int i = 0; i < _text.length; i++) {
      late int ch = _text.codeUnitAt(i);
      late int offset;
      late String h;

      if (ch >= 'a'.codeUnitAt(0) && ch <= 'z'.codeUnitAt(0)) {
        offset = 97;
      } else if (ch >= 'A'.codeUnitAt(0) && ch <= 'Z'.codeUnitAt(0)) {
        offset = 65;
      } else if (ch == ' '.codeUnitAt(0)) {
        _temp += " ";
        continue;
      } else {
        _temp = "";
        break;
      }

      int c;

      c = (ch + _key - offset) % 26;

      h = String.fromCharCode(c + offset);
      _temp += h;
    }

    setState(() {
      _result = _temp;
    });
  }

  void _Dycrypt() {
    late String _text = _wordController.text;
    late int _key;
    late String _temp = "";

    try {
      _key = int.parse(_keyController.text);
    } catch (e) {
      print(e);
    }
    for (int i = 0; i < _text.length; i++) {
      late int charater = _text.codeUnitAt(i);
      late int offset;
      late String h;

      if (charater >= 'a'.codeUnitAt(0) && charater <= 'z'.codeUnitAt(0)) {
        offset = 97;
      } else if (charater >= 'A'.codeUnitAt(0) &&
          charater <= 'Z'.codeUnitAt(0)) {
        offset = 65;
      } else if (charater == ' '.codeUnitAt(0)) {
        _temp += " ";
        continue;
      } else {
        _temp = "";
        break;
      }

      int c;

      c = (charater - _key - offset) % 26;

      h = String.fromCharCode(c + offset);
      _temp += h;
    }

    setState(() {
      _result = _temp;
    });
  }

  void _delete() {
    _wordController.clear();
    _keyController.clear();
    setState(() {
      _result = "";
    });
  }
}
