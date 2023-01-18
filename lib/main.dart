import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/screen/sight_list_screen.dart';

void main() {
  runApp(const App());
}
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)=>const MaterialApp(
    home: SightListScreen(),
    title: 'Places',
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
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
            const Text(
              'You have pushed the button this many times:',
            ),
            const MyFirstWidget(),
            const MySecondWidget(),
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

class MyFirstWidget extends StatelessWidget {
  const MyFirstWidget({Key? key}) : super(key: key);
  final int counter=0;
  // Object customMethod(){
  //   return context.runtimeType;
  // }
  @override
  Widget build(BuildContext context){
    ///StatelessWidget должен быть иммутабелен,поэтому
    ///не допускается использование не final или не const переменных внутри виджета
    ///counter++ в таком случае будет недоступна.
    ///Значение будет равно инициализируемому
    //counter++
    if (kDebugMode) {
      print(counter);
    }
    return const Center(
      child: Text('Hello!'),
    );
  }
}

class MySecondWidget extends StatefulWidget {
  const MySecondWidget({Key? key}) : super(key: key);
  @override
  State<MySecondWidget> createState() => _MySecondWidgetState();
}

class _MySecondWidgetState extends State<MySecondWidget> {
  int counter=0;
  Object customMethod(){
    return context.runtimeType;
  }
  @override
  Widget build(BuildContext context) {
    counter++;
    customMethod();
    if(kDebugMode)print(counter);
    return const Center(
      child: Text('Hello!'),
    );
  }
}




