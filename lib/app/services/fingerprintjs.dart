import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpjs_pro_plugin/fpjs_pro_plugin.dart';


class FingerPrintJs {
  
  void init() async {
    var apiKey = dotenv.env['fingerPrintJsApiKey'];
    await FpjsProPlugin.initFpjs(apiKey.toString()); 
  }

  Future<String?> getVisitorId() async {
    var apiKey = dotenv.env['fingerPrintJsApiKey'];
    await FpjsProPlugin.initFpjs(apiKey.toString()); 
    var vId = await FpjsProPlugin.getVisitorId();
    FpjsProPlugin.getVisitorId().then((visitorId) {
    });

    return vId;
  }
}