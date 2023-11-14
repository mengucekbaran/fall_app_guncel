import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import '../const/api_consts.dart';
import '../models/models_model.dart';

class ApiService {
  // APİ LİNKİNİ ALIR
  static String apiBaseLink = '';
  
   static Future<void> initializeApiBaseLink() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('api')
          .limit(1)
          .get();

      if (querySnapshot.size > 0) {
        QueryDocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        apiBaseLink = documentSnapshot.get('api_base_link');
      }
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(
        Uri.parse("$BASE_URL/models"),
        headers: {"Authorization": "Bearer $API_KEY"},
      );
      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse["error"] != null) {
        print("jsonResponse['error'] ${jsonResponse["error"]["message"]}");
        throw HttpException(jsonResponse["error"]["message"]);
      }
      {}
      // print("jsonResponse $jsonResponse");
      List temp = [];
      for (var value in jsonResponse["data"]) {
        temp.add(value);
        // log("temp ${value["id"]}");
      }
      return (ModelsModel.modelsFromSnapshot(temp));
    } catch (e) {
      log("error $e");
      rethrow;
    }
  }
  static String? fal;
  //send message fct
  static Future<void> sendMessage(
      {required String message}) async {
    try {
      var response = await http.post(Uri.parse("$BASE_URL/chat/completions"),
          headers: {
            "Authorization": "Bearer $API_KEY",
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            "max_tokens": 1000,
            "messages": [
              {"role": "user", "content": message}
            ]
          },));
      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse["error"] != null) {
        print("jsonResponse['error'] ${jsonResponse["error"]["message"]}");
        throw HttpException(jsonResponse["error"]["message"]);
      }
      {}
      // print("jsonResponse $jsonResponse");
      if(jsonResponse["choices"].length>0){
        // log("jsonResponse['choices']text ${jsonResponse["choices"][0]['message']['content']}");
        fal= jsonResponse["choices"][0]['message']['content'];
        fal= utf8.decode(fal!.runes.toList());
        log(fal.toString());
      }
    } catch (e) {
      log("error $e");
      rethrow;
    }
  }

  //GET GOOGLE STATUS AND CODE
  
  //MİSAFİR GİRİŞ Mİ? GOOGLE İLE GİRİŞ Mİ
  static Future<bool> fetchGirisSekli() async {
    try {
      final response =
          await http.get(Uri.parse('${apiBaseLink}status.php'));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        bool result = data == 1; // true olarak değerlendirilir
        return result;
        // Veri işlemlerini burada gerçekleştirin
      } else {
        print('API isteği başarısız oldu. Hata kodu: ${response.statusCode}');
      }
    } catch (e) {
      print('Hata oluştu: $e');
    }
    return false;
  }
}

