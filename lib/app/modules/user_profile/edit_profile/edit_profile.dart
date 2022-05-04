import 'dart:io';
import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';
import 'package:deposits_oneclick_checkout/app/model/me/me_response.dart';

class EditProfile extends StatefulWidget {
  final User? user;
  EditProfile({Key? key, this.user}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  EditProfileController controller = Get.put(EditProfileController());

  @override
  void initState() {
    super.initState();
    controller.firstNameController.text = widget.user!.firstName??'';
    controller.lastNameController.text = widget.user!.lastName??'';
    controller.emailController.text = widget.user!.email??'';
    controller.mobilenumberController.text = widget.user!.phoneNumber??'';
    controller.dobController.text = widget.user!.dob??"";
    controller.firstNameController.addListener(() {
     if (mounted) setState(() {});
    });
    controller.lastNameController.addListener(() {
     if (mounted) setState(() {});
    });
    controller.emailController.addListener(() {
     if (mounted) setState(() {});
    });
    controller.mobilenumberController.addListener(() {
     if (mounted) setState(() {});
    });
    controller.dobController.addListener(() {
     if (mounted) setState(() {});
    });
  }

//--------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        key: controller.editProfileGlobalKey,
        appBar: CustomAppbarWidget(
          centerTitle: true,
          addBackButton: true,
          backgroundColor: AppColors.white,
          backbuttonColor: AppColors.black,
          textColor: AppColors.black,
          title: Strings.editProfile,
          textSize: (Dimens.fontSize16),
          onBackPress: () {
            Navigator.pop(context);
          },
        ),
        body: profileBody(),
      ),
    );
  }

//--------------------------------------------------------
  Widget profileBody() {
    return Form(
        key: controller.formKey,
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: (15)),
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: constraints.maxWidth,
                      minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                      child: Column(mainAxisSize: MainAxisSize.max, children: [
                    //top content
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          firstNameInput(),
                          lastNameInput(),
                          emailInput(),
                          dateOfBirthInput(),
                          phoneNumberInput(),
                        ])),
                    // bottom content
                    Column(
                      children: [saveButton(), depositsLogo()],
                    )
                  ]))));
        }));
  }

//--------------------------------------------------------
  Widget firstNameInput() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CustomText(
              text: Strings.firstName,
              font: (Dimens.fontSize14),
              fntweight: FontWeight.w400),
          verticalSpaceTiny,
          CustomTextFieldWidget(
            controller: controller.firstNameController,
            keyboardType: TextInputType.name,
            addHint: true,
            validator: (value) => Validators.validateEmpty(value),
            hintText: Strings.fullname,
            textInputAction: TextInputAction.next,
          ),
        ]));
  }

  ///--------------------------------------------------------
  Widget lastNameInput() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CustomText(
              text: Strings.lastName,
              font: (Dimens.fontSize14),
              fntweight: FontWeight.w400),
          verticalSpaceTiny,
          CustomTextFieldWidget(
            controller: controller.lastNameController,
            keyboardType: TextInputType.name,
            addHint: true,
            validator: (value) => Validators.validateEmpty(value),
            hintText: Strings.fullname,
            textInputAction: TextInputAction.next,
          ),
        ]));
  }

//--------------------------------------------------------
  Widget emailInput() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: (10)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CustomText(
              text: Strings.emailAddress,
              font: (Dimens.fontSize14),
              fntweight: FontWeight.w400),
          verticalSpaceTiny,
          CustomTextFieldWidget(
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            addHint: true,
            readOnly: true,
            validator: (value) => Validators.validateEmail(value),
            hintText: Strings.emailAddress,
            textInputAction: TextInputAction.next,
          ),
        ]));
  }

//--------------------------------------------------------
  Widget dateOfBirthInput() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: (10)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CustomText(
              text: Strings.dob,
              font: (Dimens.fontSize14),
              fntweight: FontWeight.w400),
          verticalSpaceTiny,
          CustomTextFieldWidget(
            controller: controller.dobController,
            keyboardType: TextInputType.name,
            addHint: true,
            readOnly: true,
            suffixIcon: const Icon(
              Icons.arrow_drop_down,
              color: AppColors.borderColor,
            ),
            validator: (value) => Validators.validateEmpty(value),
            hintText: Strings.selectDob,
            textInputAction: TextInputAction.next,
            onTap: () {
              Platform.isIOS
                  ? controller.iosDatePicker(context)
                  : controller.androidDatePicker(context);
            },
          ),
        ]));
  }

//--------------------------------------------------------
  Widget phoneNumberInput() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: (10)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CustomText(
              text: Strings.mobileNumber,
              font: (Dimens.fontSize14),
              fntweight: FontWeight.w400),
          verticalSpaceTiny,
          CustomTextFieldWidget(
            controller: controller.mobilenumberController,
            keyboardType: TextInputType.number,
            addHint: true,
            validator: (value) => Validators.validatePhone(value),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
            hintText: Strings.mobileNumber,
            textInputAction: TextInputAction.send,
          ),
        ]));
  }

//--------------------------------------------------------
  Widget saveButton() {
    return Obx(() => Container(
        margin: const EdgeInsets.symmetric(vertical: (20)),
        child: CustomElevatedButton(
          onPressed: () =>
              controller.editProfile(context),
          minWidth: Get.width,
          title: Strings.saveChanges,
          isBusy: controller.isLoading.value,
          textStyle: TextStyle(
              color: controller.validateInput()
                  ? AppColors.black
                  : AppColors.white),
          buttonColor: controller.validateInput()
              ? AppColors.activButtonColor
              : AppColors.inActivButtonColor,
        )));
  }

//--------------------------------------------------------
  Widget depositsLogo() {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Offstage(
      offstage: isKeyboardOpen,
      child: Container(
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.only(bottom: (30)),
          child: SvgPicture.asset(AppImages.depositsLogo,
              package: 'deposits_oneclick_checkout')),
    );
  }
//--------------------------------------------------------
}
