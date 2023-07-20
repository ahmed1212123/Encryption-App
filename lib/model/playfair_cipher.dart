import 'package:encryption_decryption/admob/banner_ad.dart';
import 'package:flutter/material.dart';

import '../Style.dart';

class PlayfairCipher extends StatefulWidget {
  const PlayfairCipher({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PlayfairCipherState createState() {
    return _PlayfairCipherState();
  }
}

class _PlayfairCipherState extends State<PlayfairCipher> {
  final _wordController = TextEditingController();
  final _keyController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  String plainText = '';
  String cipherText = '';
  bool endKey = false;
  int index = -1;
  String textOfEncrypt = '';
  var matrixOfEncrypt = [];
  String text = '';

  void playfairEncrypt(String text, String key) {
    String table = '', result = '';
    text = text.replaceAll(' ', '');
    text = text.replaceAll('j', 'i');
    key = key.replaceAll(' ', '');
    text = text.toLowerCase();
    key = key.toLowerCase();
    for (var i = 0; i < text.length - 1; i++) {
      if (text[i] == text[i + 1]) {
        text =
        '${text.substring(0, i + 1)}x${text.substring(i + 1, text.length)}';
      }
    }
    if (text.length % 2 != 0) text += 'x';
    var matrix = List.generate(5, (i) => List.filled(5, '', growable: false)),
        index = 0;

    for (var i = 0; i < key.length; i++) {
      if (table.contains(key[i]) == false) {
        if (key[i] != 'j') table += key[i];
      }
    }

    for (var i = 'a'.codeUnitAt(0); i <= 'z'.codeUnitAt(0); i++) {
      if (table.contains(String.fromCharCode(i)) == false &&
          String.fromCharCode(i) != 'j') table += String.fromCharCode(i);
    }

    for (var i = 0; i < 5; i++) {
      for (var j = 0; j < 5; j++) {
        matrix[i][j] = table[index++];
      }
    }
    setState(() {
      matrixOfEncrypt = matrix;
    });

    for (var i = 0; i < text.length; i += 2) {
      late int row1, row2, col1, col2;
      for (var j = 0; j < 5; j++) {
        if (matrix[j].contains(text[i]) == true) {
          row1 = j;
          col1 = matrix[j].indexOf(text[i] as dynamic);
        }
        if (matrix[j].contains(text[i + 1]) == true) {
          row2 = j;
          col2 = matrix[j].indexOf(text[i + 1] as dynamic);
        }
      }
      if (row1 == row2) {
        result += matrix[row1][(col1 + 1) % 5].toString();
        result += matrix[row2][(col2 + 1) % 5].toString();
      } else if (col1 == col2) {
        result += matrix[(row1 + 1) % 5][col1].toString();
        result += matrix[(row2 + 1) % 5][col2].toString();
      } else {
        result += matrix[row1][col2].toString();
        result += matrix[row2][col1].toString();
      }
    }
    setState(() {
      cipherText = result;
      textOfEncrypt = text;
    });
  }

  void playfairDecrypt(String text, String key) {
    String table = '', result = '';
    text = text.replaceAll(' ', '');
    key = key.replaceAll(' ', '');
    text = text.toLowerCase();
    key = key.toLowerCase();

    var matrix = List.generate(5, (i) => List.filled(5, '', growable: false)),
        index = 0;

    for (var i = 0; i < key.length; i++) {
      if (table.contains(key[i]) == false) {
        if (key[i] != 'j') table += key[i];
      }
    }

    for (var i = 'a'.codeUnitAt(0); i <= 'z'.codeUnitAt(0); i++) {
      if (table.contains(String.fromCharCode(i)) == false &&
          String.fromCharCode(i) != 'j') {
        table += String.fromCharCode(i);
      }
    }

    for (var i = 0; i < 5; i++) {
      for (var j = 0; j < 5; j++) {
        matrix[i][j] = table[index++] as dynamic;
      }
    }

    for (var i = 0; i < text.length; i += 2) {
      late int row1, row2, col1, col2;
      for (var j = 0; j < 5; j++) {
        if (matrix[j].contains(text[i]) == true) {
          row1 = j;
          col1 = matrix[j].indexOf(text[i] as dynamic);
        }
        if (matrix[j].contains(text[i + 1]) == true) {
          row2 = j;
          col2 = matrix[j].indexOf(text[i + 1] as dynamic);
        }
      }
      if (row1 == row2) {
        result += matrix[row1][(col1 - 1) % 5].toString();
        result += matrix[row2][(col2 - 1) % 5].toString();
      } else if (col1 == col2) {
        result += matrix[(row1 - 1) % 5][col1].toString();
        result += matrix[(row2 - 1) % 5][col2].toString();
      } else {
        result += matrix[row1][col2].toString();
        result += matrix[row2][col1].toString();
      }
    }
    setState(() {
      plainText = result;
    });
  }

  String divideText(String word, int index, bool isExist) {
    return '${word[index]}${word[index + 1]}${isExist ? ': ' : ''}';
  }

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
        title: const Text('Playfair Cipher'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: sizeFromHeight(context, 1),
          width: sizeFromWidth(context, 1),
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
                          maxLines: 5,
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
                        padding: EdgeInsets.symmetric(vertical: 10),
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
                                playfairEncrypt(
                                    _wordController.text.trim(), _keyController.text.trim());
                              }
                            },
                            color: Colors.green,
                            child: const Text("Encrypt"),
                          ),
                          MaterialButton(
                            color: Colors.blue,
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                playfairDecrypt(
                                    cipherText.trim(), _keyController.text.trim());
                              }
                            },
                            child: const Text("Decrypt"),
                          ),
                          MaterialButton(
                            onPressed: (){
                              setState(() {
                              endKey = false;
                              index = -1;
                              plainText = '';
                              cipherText = '';
                              textOfEncrypt = '';
                              matrixOfEncrypt = [];
                              _wordController.clear();
                              _keyController.clear();
                            });
                              },
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
                        height: sizeFromHeight(context, 3),
                        decoration: BoxDecoration(
                            color: Colors.orange.shade100,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.orange, width: 3)),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Text(
                          '${cipherText != '' ? 'Cipher Text: $cipherText' : ''}\n${plainText != '' ? 'Plain Text: $plainText' : ''}',
                          style: const TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      AdBanner(),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Container(
                          height:sizeFromHeight(context, 2),
                          child: Table(
                            border: TableBorder.all(color: Colors.deepOrange.shade100),
                            children: [
                              if (cipherText.isNotEmpty && textOfEncrypt.isNotEmpty)
                                for (int i = 0; i < 5; i++)
                                  TableRow(
                                    children: [
                                      for (int x = 0; x < 5; x++)
                                        Center(
                                          child: Text(
                                            matrixOfEncrypt[i][x],
                                            style: const TextStyle(
                                              color: Colors.deepOrange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
