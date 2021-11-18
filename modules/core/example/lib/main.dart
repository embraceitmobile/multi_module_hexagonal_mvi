import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

//  flutter pub run easy_localization:generate --source-dir ./assets/translations

Future<void> main() async {
  
  // runApp(const MyApp());

  WidgetsFlutterBinding.ensureInitialized();

  // For local localization 
  const basePath = 'assets/translations'; // <-- change the path of the translation files 

  // For network localization
  // final basePath = await findBasePath();
  // print('basepath is $basePath');
  // await downloadTranslationContent(basePath);

  await EasyLocalization.ensureInitialized();
  
  runApp(
    EasyLocalization(
      supportedLocales: [ const Locale('en'), const Locale('de') ],
      path: basePath,
      fallbackLocale: Locale('en'),
      child: const MyApp()
    ),
  );
}

Future<String> findBasePath() async {
  final appDocDir = await getApplicationDocumentsDirectory();
  return '${appDocDir.path}/langs';
}

Future downloadTranslationContent(final String basePath) async {

  await Future.delayed(const Duration(seconds: 3), () async {
    final file = File('$basePath/en.json');
    // final translationContentResponse = await http.get(Uri.https('opensource.adobe.com', '/Spry/data/json/object-02.js'));
    
    final translationContentResponse = await json.encode({
      "sadkmnalsdmn" : "This is Key from Local !!",
      "title" : "my title",
      "msg":"{} are written in the {} language",
      "msg_named":"Easy localization are written in the {lang} language",
      "msg_mixed":"{} are written in the {lang} language",
      "gender":{
        "male":"Hi man ;) {}",
        "female":"Hello girl :) {}",
        "other":"Hello {}"
      }
    });

    await file.create(recursive: true);
    await file.writeAsString(translationContentResponse, flush: true);

  });
  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }


  String abc = "sadkmnalsdmn";

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
     
        title: Text(widget.title),
      ),
      body: Center(
       
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(abc).tr(),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
