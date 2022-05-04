import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../utils/utils.dart';

class Constants{
//base url
// static const String baseUrl = 'https://api.checkout.deposits.dev/api/v1';
 static String baseUrl() {
    bool isDev = Utils.getEnviromentUrl();
    // print(isProd);
    if (isDev) {
      var url = dotenv.env['stagingBaseUrl'];
      // print('base url is $url');
      return url.toString();
    } else {
      var url = dotenv.env['prodBaseUrl'];
      // print('base url is $url');
      return url.toString();
    }
  }
//timeout interval
static const timeout = Duration(seconds: 30);
// token
static String apiKey = dotenv.env['masterApiKey'].toString();

  //STORAGE KEYS
  static const String isCardAdded = 'yes';
  static const String envMode = 'envMode';
  static const String amountToProcess = 'amount';
  static const String userEmail = 'userEmail';
  static const String subClientApiKey = 'sub_client_api_key';
  static const String token = 'token';
  static const String cardId = 'card_id';
  static const String bankId = 'account_id';
  static const String cardNumber = 'card_number';
  static const String accountNumber = 'account_number';
  // static const String savedCard = 'savedCard';
}