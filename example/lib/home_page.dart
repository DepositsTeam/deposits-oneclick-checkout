import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:deposits_oneclick_checkout/app/modules/deposits_oneclick_checkout_button.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final bool _autoValidate = false;
  final userEmailController = TextEditingController();
  final amountController = TextEditingController();
  static bool isEmailExist = false;
  bool isSwitched = false;
  var apiKey = dotenv.env['API_KEY'];
  var envMode = false;

  Color pickerColor = const Color(0xFF0DB9E9);
  Color currentColor = const Color(0xFF0DB9E9);
  ValueChanged<Color>? onColorChanged;
  // bind some values with [ValueChanged<Color>] callback
  changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: pickerColor,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Fill the form below.',
                  style: TextStyle(fontSize: 20),
                ),
                Container(
                    child: TextFormField(
                      readOnly: isEmailExist,
                      controller: userEmailController,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Please enter your email address';
                        }
                        // Check if the entered email has the right format
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(val)) {
                          return 'Please enter a valid email address';
                        }
                        // Return null if the entered email is valid
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
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
                    margin: const EdgeInsets.only(top: (30.0))),
                Container(
                    child: TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? 'Amount is required!' : null,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        CurrencyTextInputFormatter(
                          decimalDigits: 2,
                          symbol: '\$ ',
                        )
                      ],
                      textInputAction: TextInputAction.done,
                      controller: amountController,
                      decoration: const InputDecoration(
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
                    margin: const EdgeInsets.only(top: (10.0))),
                Container(
                  margin: const EdgeInsets.only(top: (10.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Use in DEVELOPMENT',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      FlutterSwitch(
                        value: isSwitched,
                        activeColor: pickerColor,
                        showOnOff: true,
                        onToggle: (value) {
                          setState(() {
                            isSwitched = value;
                          });
                          if (isSwitched) {
                            setState(() {
                              apiKey = dotenv.env['API_KEY_TEST'];
                              envMode = true;
                            });
                          } else {
                            setState(() {
                              apiKey = dotenv.env['API_KEY'];
                              envMode = false;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: (2.0)),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                       backgroundColor: MaterialStateProperty.all(pickerColor),
                    ),
                    onPressed: () {
                      // raise the [showDialog] widget
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Pick a color!'),
                          content: SingleChildScrollView(
                            child: ColorPicker(
                              pickerColor: pickerColor,
                              onColorChanged: changeColor,
                              pickerAreaHeightPercent: 0.8,
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child:const Text('Got it'),
                              onPressed: () {
                                setState(() => currentColor = pickerColor);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    child:const Text('SELECT CUSTOMIZATION COLOR'),
                  ),
                ),
                Container(
                    child: FlatButton(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 56,
                      color: pickerColor, //Color(0xFF0DB9E9),
                      child: const Text('Checkout',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      onPressed: () async {
                        String selectedColor = pickerColor.toString().replaceAll('Color(0xf', '').replaceAll(')', '');
                        if (formKey.currentState!.validate()) {
                          depositsCheckout(
                            context,
                            ButtonConfig(
                              buttonColor: selectedColor,
                              textColor: 'FFFFFF',
                              // loaderColor: 'FFFFFF',
                              buttonBorderColor: Colors.black,
                              amount: double.parse(amountController.text
                                  .toString()
                                  .replaceAll('\$', '')
                                  .toString()),
                            ),
                            userEmail: userEmailController.text.trim(),
                            apiKey: apiKey.toString(),
                            envMode: envMode,
                            chargeFundsResponse: (response) {
                              //print('transaction Id is brought back:' + response.data!.transactionId.toString());
                            },
                          );
                        }
                      },
                    ),
                    margin: const EdgeInsets.only(top: (30.0)))
              ],
            ),
          ),
        ),
      )),
    );
  }
}
