import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textEditingController = TextEditingController();
  GoogleTranslator translator = GoogleTranslator();
  var output;
  String? dropdownValue;

  static const Map<String, String> lang = {
    "대한민국": "ko",
    "미국": "en",
    "중국": "zh-cn",
    "일본": "ja",
    "베트남": "vi",
  };

  void trans() {
    translator
        .translate(textEditingController.text, to: "$dropdownValue")
        .then((value) {
      setState(() {
        output = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: RichText(
              text: TextSpan(
                  children: [
                    TextSpan(text: 'Multi',style: TextStyle(fontSize: 28.0)),
                    TextSpan(text: 'Language', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28)),
                    TextSpan(text: 'Translator',style: TextStyle(fontSize: 28.0)),
                  ])
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                style: TextStyle(fontSize: 24),
                controller: textEditingController,
                onTap: () {
                  trans();
                },
                decoration: InputDecoration(
                    labelText: 'Type Here',
                    labelStyle: TextStyle(fontSize: 15)),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Select Language here =>"),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue;
                      trans();
                    });
                  },
                  items: lang
                      .map((string, value) {
                    return MapEntry(
                      string,
                      DropdownMenuItem<String>(
                        value: value,
                        child: Text(string),
                      ),
                    );
                  })
                      .values
                      .toList(),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Text('Translated Text'),


            SizedBox(
              height: 10,
            ),
            Text(
              output == null ? "Please Select Language" : output.toString(),
              style: TextStyle(
                  fontSize: 17,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: (){
                    print("파이어베이스 원본 등록");
                  },
                  child: Text('등록 (Registration)'),
                ),
                ElevatedButton(
                  onPressed: (){
                    print("파이어베이스 번역 등록");
                  },
                  child: Text(' 번역 등록 (Trans. Reg)'),
                ),
              ],
            ),

          ],
        ));
  }
}

