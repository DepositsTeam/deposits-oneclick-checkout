import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:deposits_oneclick_checkout/app/model/update_profile/update_profile_response.dart';

class EditProfileController extends GetxController {
  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final editProfileGlobalKey = GlobalKey<ScaffoldState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();
  final mobilenumberController = TextEditingController();
  
  ProfileController profileController = Get.find();

//------------------------------------------
  void editProfile(BuildContext context)async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
        try {
      isLoading(true);
      var request = {
        'token': Storage.getValue(Constants.token),
        'api_key': Constants.apiKey,
        'sub_client_api_key': Storage.getValue(Constants.subClientApiKey),
        'first_name' : firstNameController.text.toString(),
        'last_name' : lastNameController.text.toString(),
        'phone_number' : mobilenumberController.text.toString(),
        'date_of_birth' : dobController.text.toString(),
      };
      var response = await DioClient()
          .request(context: context,api: '/update-profile', method: Method.POST, params: request);

       UpdateProfileResponse updateProfileResponse = UpdateProfileResponse.fromJson(response);
        if (updateProfileResponse.status == Strings.success) {
          Utils.navigationReplace(context,Successful(
                  successTitle: Strings.profileUpdatedSuccessfully,
                  successMessage: DateFormat.jm().format(DateTime.parse(DateTime.now().toString()).toLocal()),));
          Utils.showSnackbar(context,Strings.success, updateProfileResponse.message!, AppColors.green);
          profileController.fetchUserProfile(context);
        }else{
         return Utils.showSnackbar(context, Strings.error,response['message'].toString().toTitleCase(),  AppColors.red);
        }
    } finally {
      isLoading(false);
    }
    update();
    }
  }

//------------------------------------------
  bool validateInput() {
    if (firstNameController.text.isEmpty) {
      return false;
    } else if (lastNameController.text.isEmpty) {
      return false;
    } else if (emailController.text.isEmpty) {
      return false;
    } else if (dobController.text.isEmpty) {
      return false;
    } else if (mobilenumberController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

//-------------------------------------------
  void iosDatePicker(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
            height: 190,
            color: Color.fromARGB(255, 255, 255, 255),
            child: Column(
              children: [
                Container(
                  height: 180,
                  child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      maximumDate: DateTime.now(),
                      initialDateTime: DateTime(1990, 07, 04),
                      onDateTimeChanged: (val) {
                        dobController.text =
                            DateFormat('dd/MM/yyyy').format(val);
                      }),
                ),
              ],
            )));
  }
//-------------------------------------------
  void androidDatePicker(BuildContext context){
    showModalBottomSheet(
                          context:context,
                          builder: (_) => Container(
                              height: 190,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              child: Column(
                                children: [
                                  Container(
                                    height: 180,
                                    child: CupertinoDatePicker(
                                        mode: CupertinoDatePickerMode.date,
                                        maximumDate: DateTime.now(),
                                        initialDateTime: DateTime(1990, 07, 04),
                                        onDateTimeChanged: (val) {
                                          dobController.text =
                                          DateFormat('dd/MM/yyyy').format(val);
                                        }),
                                  ),
                                ],
                              )));
  }
//-------------------------------------------
//-------------------------------------------
//-------------------------------------------
}
