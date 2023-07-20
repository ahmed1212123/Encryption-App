import 'package:encryption_decryption/admob/banner_ad.dart';
import 'package:flutter/material.dart';

import '../Style.dart';

class AutoKeyCipher extends StatefulWidget {
  const AutoKeyCipher({super.key});

  @override
  _AutoKeyCipherState createState() {
    return _AutoKeyCipherState();
  }
}

class _AutoKeyCipherState extends State<AutoKeyCipher> {
  final _wordController = TextEditingController();
  final _keyController = TextEditingController();
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text('Auto-Key Cipher'),
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
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(
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
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10,),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: 'Input your key',
                            fillColor: Colors.grey[300],
                            filled: true,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          MaterialButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                autoKeyEncryption(
                                    _wordController.text, _keyController.text);
                              }
                            },
                            color: Colors.green,
                            child: const Text("Encrypt"),
                          ),
                          MaterialButton(
                            color: Colors.blue,
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                autoKeyDecryption(
                                    _wordController.text, _keyController.text);
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
                      Text(
                        'Output :',
                        style: TextStyle(fontSize: 24.0),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        width: sizeFromWidth(context, 1),
                        height: sizeFromHeight(context, 2.5),
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
                    ]
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void autoKeyEncryption(String text, String key) {
    String result = '';
    text = text.toLowerCase();
    // text= text.split(' ') as String;
    String newKey = key + text;
    newKey = newKey.substring(0, (newKey.length) - (key.length));

    for (var i = 0; i < text.length; i++) {
      int y = text.codeUnitAt(i) - 97;
      int w = newKey.codeUnitAt(i) - 97;
      int x = ((y + w) % 26) + 97;
      result += String.fromCharCode(x);
    }

    setState(() {
      _result = result;
    });
  }

  void autoKeyDecryption(String text, String key) {
    String result = '';
    text = text.toLowerCase();
    for (var i = 0; i < text.length; i++) {
      int y = text.codeUnitAt(i) - 97;
      int w = key.codeUnitAt(i) - 97;
      int x = ((y - w) % 26) + 97;
      key = key + String.fromCharCode(x);
      result += String.fromCharCode(x);
    }

    setState(() {
      _result = result;
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
