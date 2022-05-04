import 'package:intl/intl.dart';
import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class EditAddressController extends GetxController {
  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();
  final streetAddressController = TextEditingController();
  final zipCodeController = TextEditingController();
  final country = TextEditingController();
  final state = TextEditingController();
  final city = TextEditingController();
  var isDefaultAddressSet = false.obs;

  AddressController addressController = Get.find();

  @override
  void dispose() {
    super.dispose();
    streetAddressController.clear();
    zipCodeController.clear();
    country.clear();
    state.clear();
    city.clear();
  }

    void toggleDefaultAddress(bool value) {
    isDefaultAddressSet.value = value;
   // print('is default value is: ${isDefaultAddressSet.value}');
    update();
  }

  void fetchSingleAddress(BuildContext context, String addressId) async {
    try {
      isLoading(true);
      var request = {
        'token': Storage.getValue(Constants.token),
        'api_key': Constants.apiKey,
        'sub_client_api_key': Storage.getValue(Constants.subClientApiKey),
      };

      var response = await DioClient().request(context: context,
          api: '/address/$addressId', method: Method.POST, params: request);

      GetSingleAddressResponse getSingleAddressResponse =
          GetSingleAddressResponse.fromJson(response);
      if (getSingleAddressResponse.status == Strings.success) {
        Utils.showSnackbar(context, Strings.success,
            getSingleAddressResponse.message!, AppColors.green);
      } else {
        return Utils.showSnackbar(
            context, Strings.error, response['message'].toString().toTitleCase(), AppColors.red);
      }
    } finally {
      isLoading(false);
    }
    update();
  }


  void setDefaultAddress(BuildContext context, String addressId) async {
    try {
      isLoading(true);
      var request = {
        'token': Storage.getValue(Constants.token),
        'api_key': Constants.apiKey,
        'sub_client_api_key': Storage.getValue(Constants.subClientApiKey),
      };

      var response = await DioClient().request(context: context,
          api: '/address/set-default-address/$addressId', method: Method.POST, params: request);

      SetDefaultAddressResponse setDefaultAddressResponse =
          SetDefaultAddressResponse.fromJson(response);
      if (setDefaultAddressResponse.status == Strings.success) {
        Utils.navigationReplace(
              context,
              Successful(
                  successTitle: Strings.addressChangedSuccessfully,
                  successMessage: DateFormat.jm().format(
                      DateTime.parse(DateTime.now().toString()).toLocal()),));
        Utils.showSnackbar(context, Strings.success,
            setDefaultAddressResponse.message!, AppColors.green);
            addressController.fetchUserAddress(context);
      } else {
        return Utils.showSnackbar(
            context, Strings.error, response['message'].toString().toTitleCase(), AppColors.red);
      }
    } finally {
      isLoading(false);
    }
    update();
  }

  void editAddress(
      BuildContext context, String addressId) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
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

        var response = await DioClient().request(context: context,
            api: '/address/update/$addressId',
            method: Method.POST,
            params: request);

        UpdateAddressResponse updateAddressResponse =
            UpdateAddressResponse.fromJson(response);
        if (updateAddressResponse.status == Strings.success) {
          if (isDefaultAddressSet.isTrue) {
          setDefaultAddress(context,addressId);
        } else {
          isLoading(false);
          Utils.navigationReplace(
              context,
              Successful(
                  successTitle: Strings.addressChangedSuccessfully,
                  successMessage: DateFormat.jm().format(
                      DateTime.parse(DateTime.now().toString()).toLocal()),));
          Utils.showSnackbar(context, Strings.success,
              updateAddressResponse.message!, AppColors.green);
          addressController.fetchUserAddress(context);
        }
      } else {
        isLoading(false);
          return Utils.showSnackbar(
              context, Strings.error, response['message'].toString().toTitleCase(), AppColors.red);
        }
    }
  }

  void deleteAddress(
      BuildContext context, String addressId) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      try {
        isLoading(true);
        var request = {
          'token': Storage.getValue(Constants.token),
          'api_key': Constants.apiKey,
          'sub_client_api_key': Storage.getValue(Constants.subClientApiKey),
        };

        var response = await DioClient().request(context: context,
            api: '/address/delete/$addressId',
            method: Method.POST,
            params: request);

        DeleteAddressResponse deleteAddressResponse =
            DeleteAddressResponse.fromJson(response);
        if (deleteAddressResponse.status == Strings.success) {
          Utils.navigationReplace(
              context,
              Successful(
                successTitle: Strings.addressDeletedSuccessfully,
                successMessage: DateFormat.jm().format(
                    DateTime.parse(DateTime.now().toString()).toLocal()),
              ));
          Utils.showSnackbar(context, Strings.success,
              deleteAddressResponse.message!, AppColors.green);
          addressController.fetchUserAddress(context);
        } else {
          return Utils.showSnackbar(
              context, Strings.error, response['message'].toString().toTitleCase(), AppColors.red);
        }
      } finally {
        isLoading(false);
      }
      update();
    }
  }

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
}
