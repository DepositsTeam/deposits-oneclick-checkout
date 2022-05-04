import 'package:intl/intl.dart';
import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class AddAddressController extends GetxController {
  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  var autovalidate = false.obs;
  final globalKey = GlobalKey<ScaffoldState>();
  final streetAddressController = TextEditingController();
  final zipCodeController = TextEditingController();
  final country = TextEditingController();
  final state = TextEditingController();
  final city = TextEditingController();
  AddressController addressController = Get.find();

  @override
  void onInit() {
    super.onInit();
    clearInputs();
    streetAddressController.addListener(() {
      update();
    });
    zipCodeController.addListener(() {
      update();
    });
    country.addListener(() {
      update();
    });
    state.addListener(() {
      update();
    });
    city.addListener(() {
      update();
    });
  }

  void clearInputs() {
    streetAddressController.clear();
    zipCodeController.clear();
    country.clear();
    state.clear();
    city.clear();
  }

  // @override
  // void dispose() {
  //   streetAddressController.clear();
  //   zipCodeController.clear();
  //   country.clear();
  //   state.clear();
  //   city.clear();
  //   super.dispose();
  // }

  void addAddress(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      try {
        isLoading(true);
        var request = {
          'token': Storage.getValue(Constants.token),
          'api_key': Constants.apiKey,
          'sub_client_api_key': Storage.getValue(Constants.subClientApiKey),
          'city': city.text.toString(),
          'zip': zipCodeController.text.toString(),
          'state': state.text.toString(),
          'country': country.text.toString(),
          'address': streetAddressController.text.toString(),
        };
        var response = await DioClient().request(
            context: context,
            api: '/address/create',
            method: Method.POST,
            params: request);

        CreateAddressResponse createAddressResponse =
            CreateAddressResponse.fromJson(response);
        if (createAddressResponse.status == Strings.success) {
          Utils.navigationReplace(
              context,
              Successful(
                successTitle: Strings.addressAddedSuccessfully,
                successMessage: DateFormat.jm().format(
                    DateTime.parse(DateTime.now().toString()).toLocal()),
              ));
          Utils.showSnackbar(context, Strings.success,
              createAddressResponse.message!, AppColors.green);
          addressController.fetchUserAddress(context);
        } else {
          return Utils.showSnackbar(context, Strings.error,
              response['message'].toString().toTitleCase(), AppColors.red);
        }
      } finally {
        isLoading(false);
      }
      update();
    }
  }

  //------------------------------------------
  bool validateInput() {
    if (streetAddressController.text.isEmpty) {
      return false;
    } else if (zipCodeController.text.isEmpty) {
      return false;
    } else if (country.text.isEmpty) {
      return false;
    } else if (state.text.isEmpty) {
      return false;
    } else if (city.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  // if (formKey.currentState.validate()) {
  //   //form is valid, proceed further
  //   formKey.currentState!.save();//save once fields are valid, onSaved method invoked for every form fields

  // } else {
  //     _autovalidate = true; //enable realtime validation
  // }

}
