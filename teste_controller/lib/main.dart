import 'package:flutter/material.dart';
import 'package:flutter_application_4/controller/weather_controller.dart';
import 'package:flutter_application_4/provider/weather_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  final WeatherProvider provider = WeatherProvider(); //Colocando o Provider e instanciando ele para fazer o teste
  late final WeatherController ctlWeatherController; //Instanciar depois (late) e final porque é unica, e o metodo WeatherController

  @override
  void initState() {
    super.initState(); //Iniciando o App com ele aberto
    ctlWeatherController = WeatherController(
        provider: provider); //Colocando o controler com o provider que passamos na parte de cima
  }

  void _incrementCounter() {
    ctlWeatherController.getWeatherApi('Cotia'); //Puxando o metodo do controller GetWeatherApi
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedBuilder(
                animation: ctlWeatherController,
                builder: (_, child) {
                  return Text(
                      'Temperatura: ${ctlWeatherController.temp} C \n Descrição ${ctlWeatherController.description}');
                })
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
