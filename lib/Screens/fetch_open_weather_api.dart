// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class WeatherService {
//   final String API_KEY = "54f1961e2dfc8528c791acc2fa6c26d8";
//
//   Future<Map<String, dynamic>> fetchWeatherData(String city) async {
//     final response = await http.get('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$API_KEY');
//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to load weather data');
//     }
//   }
// }