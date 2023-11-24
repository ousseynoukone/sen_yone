import 'package:SenYone/Shared/shared_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';

class OpenAIHttpRequest {
  static var logger = Logger();
  static getAPIKey() {
    return SharedConfig().apiKey;
  }

  static sendMessage(message) async {
    var apiKey = getAPIKey();
    try {
      var response = await http.post(
        Uri.parse("https://api.openai.com/v1/chat/completions"),
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({"model": "gpt-3.5-turbo", "messages": message}),
      );
      logger.d("Response from open ai ${response.statusCode}");

      return response;
    } catch (e, stacktrace) {
      logger.e("Erreur lors de l'envoi : $e");
      // Vous pouvez ajouter ici d'autres traitements ou renvoyer une réponse d'erreur spécifique si nécessaire.
    }
  }
}
