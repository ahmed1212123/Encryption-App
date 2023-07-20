import 'package:encryption_decryption/Style.dart';
import 'package:encryption_decryption/admob/banner_ad.dart';
import 'package:flutter/material.dart';

class VigenereCipher extends StatefulWidget {
  const VigenereCipher({super.key});

  @override
  _VigenereCipherState createState() {
    return _VigenereCipherState();
  }
}

class _VigenereCipherState extends State<VigenereCipher> {
  final _wordController = TextEditingController();
  final _keyController = TextEditingController();
  String _result = '';
  var formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    _wordController.dispose();
    _keyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        title: const Text('Vigenere Cipher'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
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
                            VigenereCipher(_wordController.text,
                                _keyController.text, true);
                          }
                        },
                        color: Colors.green,
                        child: const Text("Encrypt"),
                      ),
                      MaterialButton(
                        color: Colors.blue,
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            VigenereCipher(_wordController.text,
                                _keyController.text, false);
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
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Text(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void VigenereCipher(String text, String key, bool encrypt) {
    int j = 0;
    String result = '';
    String textAfterEdit = '';
    String keyAfterEdit = '';

    for (var i = 0; i < text.length; i++) {
      if (text[i] != ' ') {
        textAfterEdit += text[i];
      }
    }
    for (var i = 0; i < key.length; i++) {
      if (key[i] != ' ') {
        keyAfterEdit += key[i];
      }
    }
    textAfterEdit = textAfterEdit.toUpperCase();
    keyAfterEdit = keyAfterEdit.toUpperCase();
    for (var i = 0; i < textAfterEdit.length; i++) {
      if (encrypt) {
        int x =
            (textAfterEdit.codeUnitAt(i) + keyAfterEdit.codeUnitAt(j)) % 26 +
                65;
        result += String.fromCharCode(x);
      } else {
        int y =
            ((textAfterEdit.codeUnitAt(i) - keyAfterEdit.codeUnitAt(j)) % 26 +
                    26) %
                26;
        result += String.fromCharCode(y + 65);
      }
      if (j < key.length - 1) {
        j++;
      } else {
        j = 0;
      }
    }
    setState(() {
      _result = result;
    });
  }

  void _delete() {
    _wordController.clear();
    _keyController.clear();
    setState(() {
      _result = '';
    });
  }
}
