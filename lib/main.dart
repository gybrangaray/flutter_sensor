import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sensors',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<double> _accelerometerValues;

  @override
  Widget build(BuildContext context) {
    final List<String> accelerometer =
    _accelerometerValues?.map((double A) => A.toStringAsFixed(1))?.toList();
    final double accelerometer2 = _accelerometerValues.last;
    double opacidad = proc(accelerometer2);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Rojo  Gybran Garay'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: Padding(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Inclinar eje X "<-- || -->" para modificar opacidad'),
                ],
              ),
              padding: const EdgeInsets.all(25.0),
            ),
          ),
          Center(
            child:  Opacity(opacity: opacidad,
                child: Container(
                  margin: EdgeInsets.all(120.0),
                  constraints: BoxConstraints.expand(
                    height: Theme.of(context).textTheme.headline4.fontSize * 1.1 + 50.0,

                  ),

                  color: Colors.deepOrange,
                  alignment: Alignment.center,
                  child: Text('Sensor', style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white70)
                  ),
                ),

            ),
          ),
          Padding(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Cambio de valores en el eje "X": $accelerometer'),
              ],
            ),
            padding: const EdgeInsets.all(19.0),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = <double>[event.x];
      });
    });
  }

  double proc(double N) {
    if(N.isNegative){
      return N/-11; 
    }else{
      return N/11;
    }
  }

}