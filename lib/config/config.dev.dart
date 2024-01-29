import 'package:flutter_dotenv/flutter_dotenv.dart';

// final String API_URL = "https://oarfish-great-warthog.ngrok-free.app/api";
final String API_URL = dotenv.env['API_URL'] ?? '';
