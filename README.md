
<img  src="https://assets.deposits.com/img/checkout/sdk-image.png"  height="36"  />

  

# Deposits One Click Checkout SDK

  

[![pub package](https://img.shields.io/pub/v/flutter_stripe.svg)](https://pub.dev/packages/deposits_oneclick_checkout) 

  

The Deposits One-Click Checkout SDK allows allows merchants to quickly enroll, onboard, and checkout customers. We provide powerful and customizable UI screens that can be used out-of-the-box to collect payments from your users with or without a deposit account

  

![deposits-one-click-checkout-flutter_cover](https://assets.deposits.com/img/checkout/sdk-banner.png)

  

## Features

  

**Simplified Security**: We make it simple for you to collect sensitive data such as credit card numbers, ACH details and remain PCI compliant. This means the sensitive data is sent directly to Deposits instead of passing through your server.

  

**Payment methods**: Accepting card and ACH payments helps your business expand its global reach and improve checkout conversion.

  

**Native UI**: We provide native screens and elements to securely collect payment details on Android and iOS.

  

## Installation

  

pubspec.yaml :

```sh

dependencies:

flutter:

sdk: flutter

deposits_oneclick_checkout: <Latest version>

```

  

Terminal :

  

```sh

flutter pub add deposits_one_click_checkout

```

  
  

### Requirements

  

#### Android

  

This plugin requires several changes to be able to work on Android devices. Please make sure you follow all these steps:

  

1. Use Android 5.0 (API level 21) and above

2. Rebuild the app, as the above changes don't update with hot reload

  

#### iOS

  

Compatible with apps targeting iOS 10 or above.

  

#### Web

  

We do not support the web via this plugin for now you can use our [JS SDK](https://api.deposits.dev/sdk/checkout.js) instead, you can check an example of how to use the JS SDK [here](https://api.deposits.dev/example/checkout)

  

## Usage

  

The library provides a UI componet for accepting card payments.

  

### Example

  

```dart

// main.dart(import this)

import  'package:deposits_oneclick_checkout/app/modules/deposits_oneclick_checkout_button.dart';

  
  

void  main() async {

WidgetsFlutterBinding.ensureInitialized();

runApp(PaymentScreen());

}

  

// payment_screen.dart

class  PaymentScreen  extends  StatelessWidget {

  

@override

Widget  build(BuildContext context) {

return  Scaffold(

appBar: AppBar(),

body: Column(

crossAxisAlignment: CrossAxisAlignment.start,

mainAxisAlignment: MainAxisAlignment.center,

children: <Widget>[

const  Text(

'Fill the form below.',

),

Container(

child: TextFormField(

readOnly: isEmailExist,

controller: userEmailController,

validator: (val) {

if (val == null || val.trim().isEmpty) {

return  'Please enter your email address';

}

// Check if the entered email has the right format

if (!RegExp(r'\S+@\S+\.\S+').hasMatch(val)) {

return  'Please enter a valid email address';

}

// Return null if the entered email is valid

return  null;

},

keyboardType: TextInputType.emailAddress,

textInputAction: TextInputAction.next,

decoration: const  InputDecoration(

hintText: "Enter Email",

border: OutlineInputBorder(),

enabledBorder: OutlineInputBorder(

borderSide: BorderSide(color: Color(0xFFC0C4C9)),

),

disabledBorder: OutlineInputBorder(

borderSide: BorderSide(color: Color(0xFFC0C4C9)),

),

focusedBorder: OutlineInputBorder(

borderSide: BorderSide(color: Color(0xFFC0C4C9)),

),

),

),

margin: const  EdgeInsets.only(

top: (30.0)

)

),

Container(

child: TextFormField(

validator: (val) => val!.isEmpty ? 'Amount is required!' : null,

keyboardType: const  TextInputType.numberWithOptions(decimal: true),

inputFormatters: [

CurrencyTextInputFormatter(

decimalDigits: 2,

symbol: '\$ ',

)

],

textInputAction: TextInputAction.done,

controller: amountController,

decoration: const  InputDecoration(

hintText: "Enter Amount",

border: OutlineInputBorder(),

enabledBorder: OutlineInputBorder(

borderSide: BorderSide(color: Color(0xFFC0C4C9)),

),

disabledBorder: OutlineInputBorder(

borderSide: BorderSide(color: Color(0xFFC0C4C9)),

),

focusedBorder: OutlineInputBorder(

borderSide: BorderSide(color: Color(0xFFC0C4C9)),

),

),

),

margin: const  EdgeInsets.only(top: (10.0))

),

Container(

child: FlatButton(

minWidth: MediaQuery.of(context).size.width,

height: 56,

color: Colors.blue, //Color(0xFF0DB9E9),

child: const  Text(

'Checkout',

style: TextStyle(color: Colors.white, fontSize: 16)

),

onPressed: () async {

if (formKey.currentState!.validate()) {

depositsCheckout(

context,

ButtonConfig(

amount: double.parse(amountController.text.toString()

.replaceAll('\$', '')

.toString()),

),

initialScreen: MyHomePage(

title: 'One Click-Checkout Demo',

),

userEmail: userEmailController.text.toString(),

subClientApiKey: 'money-by-deposits-user',

envMode: true,

chargeFundsResponse: (response) {

// manage process after the transaction is completed

},

);

}

},

),

margin: const  EdgeInsets.only(top: (30.0))

)

],

)

);

}

}

```

  

## Deposit One Click Checkout SDK initialization

  

To initialize Deposit One Click Checkout SDK in your Flutter app, use the `pay` base class.

  

`pay` offers `context`, `buttonConfig`, `initialScreen`, `envMode`, `chargeFundsResponse` and `userEmail`, `subClientApiKey`. Only `userEmail`, `subClientApiKey`, `envMode`, `chargeFundsResponse` and `buttonConfig` (which has the following params : `amount` required, `textStyle`, `height`, `minwidth` , etc as customizable widgets ) is required. `envMode` is either true or false as a bool and `chargeFundsResponse` is a callback function to manage or run other processes after payment has been made abd you can check if it was successful or not. You have to change your `subClientApiKey` as the `envMode` changes and you can get the Key from the test or live console and the URL to the console is listed in the next section

  

## Dart API

deposits

The library offers several methods to handle deposits checkout related actions:

  

```dart

void  depositsCheckout();

class  ButtonConfig()

```

  

The example app offers examples on how to use these methods.

  

## Run the example app

  

- Navigate to the example folder `cd example`

- Install the dependencies

-  `flutter pub get`

- Set up env vars for the flutter app and a local backend.

- [Get your test API keys](https://console.deposits.dev)

- [Get your live API keys](https://console.deposits.com)

- Start the example

- Terminal 1: `flutter run`

  

## Contributing

  

Only members of the deposits team can contribute to this. You can create an issue if you find a bug or have any challenge using this SDK.