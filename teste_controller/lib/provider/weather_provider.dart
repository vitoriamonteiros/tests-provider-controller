import 'package:dio/dio.dart';

class WeatherProvider {
  Dio dio = Dio();

  initDio() {
    //Método para iniciar o Dio
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 10);
  }

  final endPointWeather = //Endpoint para puxar a Cidade
      'https://api.hgbrasil.com/weather/?format=json-cors&key=development&woeid={code}';

  final endPointCodeCity = //Endpoint para o Woied
      'https://api.hgbrasil.com/stats/find_woeid?key=17284dd0&format=json-cors&sdk_version=console&city_name={cidade}';

  Future<int?> getRequestCodeCity(String city) async {
    //Utiliza o Future pois o retorno virá futuro que será Inteiro (conforme na API)
    //e pra consultar você precisa saber o nome da Cidade, por isso utiliza o String City
    //Semmpre utilizar async e await
    try {
      initDio(); // Inicilizando o Dio
      var url = endPointCodeCity.replaceAll(
          '{cidade}', city); //Fazendo a troca colocando a variavel no {cidade}
      final response = await dio.get(url);

      return response.data['woeid']; //Returnando o resultado desejado

      //print(response.data); //Printando a resposta no terminal
    } on DioException catch (e) {
      print(e);
    }
    return null;
  }

  Future<Response?> getRequestWeather(int codeCity) async {
    try {
      initDio();
      var url = endPointWeather.replaceAll('{code}', codeCity.toString());
      final response = await dio.get(url);

      //print(response); //Printando a resposta no terminal
      return response;
    } on DioException catch (e) {
      print(e);
    }
    return null;
  }
}
