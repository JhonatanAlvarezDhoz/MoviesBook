import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String apiKeyTMDB = dotenv.env['apiKeyTMDB'] ?? "No hay apiKey";
}
