import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class ConfirmOtp extends StatefulWidget {
  const ConfirmOtp({Key? key}) : super(key: key);

  @override
  _ConfirmOtpState createState() => _ConfirmOtpState();
}

class _ConfirmOtpState extends State<ConfirmOtp> {
  ConfirmOtpController controller = Get.put(ConfirmOtpController());

  @override
  void initState() {
    super.initState();
    controller.otpController.text = '';
    controller.otpController.addListener(() {
       if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.white,
          key: controller.globalKey,
          appBar: CustomAppbarWidget(
            centerTitle: true,
            addBackButton: true,
            backgroundColor: AppColors.white,
            backbuttonColor: AppColors.black,
            textColor: AppColors.black,
            title: Strings.confirmOtp,
            textSize: (Dimens.fontSize16),
            onBackPress: () {
              Navigator.pop(context);
            },
          ),
          body: confirmOtpBody(),
        ),
    );
  }

//--------------------------------------------------------
  Widget confirmOtpBody() {
    return Form(
        key: controller.formKey,
        child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: (20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //top content
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [otpDesc(), otpInput(), authoriseButton()],
                ),

                //bottom content
                Column(
                  children: [requestButton(),depositsLogo()],
                )
              ],
            )));
  }

//--------------------------------------------------------
  Widget otpDesc() {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.symmetric(vertical: (15)),
      child: CustomText(
        txtAlign: TextAlign.center,
        text: Strings.confrimOtpDesc +
            controller.loginController.emailController.text.toString(),
        font: (Dimens.fontSize14),
        fntweight: FontWeight.w400,
      ),
    );
  }

//--------------------------------------------------------
  Widget otpInput() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: (15)),
      child: CustomTextFieldWidget(
        controller: controller.otpController,
        keyboardType: TextInputType.text,
        addHint: true,
        inputFormatters: [FilteringTextInputFormatter.deny( RegExp('[\\.|\\,]')),],
        validator: (value) => Validators.validateOTP(value),
        hintText: Strings.enterOtp,
        textInputAction: TextInputAction.send,
      ),
    );
  }

//--------------------------------------------------------
  Widget authoriseButton() {
    return Obx(() => Offstage(
      offstage: controller.offStageAuthoriseButton.value,
      child: Container(
          margin: EdgeInsets.symmetric(vertical: (10)),
          child: CustomElevatedButton(
            onPressed: () => controller.authoriseOtp(context),
            minWidth: Get.width,
            title: Strings.authorize,
            isBusy: controller.isLoading.value,
            textStyle: TextStyle(
                color: controller.otpController.text.isEmpty
                    ? AppColors.white
                    : AppColors.black),
            buttonColor: controller.otpController.text.isEmpty
                ? AppColors.inActivButtonColor
                : AppColors.activButtonColor,
          )),
    ));
  }

//--------------------------------------------------------
  Widget requestButton() {
    return Obx(() => Offstage(
      offstage: controller.offStageRequestButton.value,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: (20)),
        child: CustomElevatedButton(
              onPressed: () => controller.resendOtp(context),
              minWidth: Get.width,
              addBorder: true,
              title: Strings.requestOtp,
              isBusy: controller.isResendLoading.value,
              textColor: AppColors.borderButtonColor,
              buttonColor: AppColors.white,
              loaderColor: AppColors.borderButtonColor,
            ),
      ),
    ));
  }
//--------------------------------------------------------
  Widget depositsLogo() {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Offstage(
                  offstage:isKeyboardOpen,
                  child:Container(
          alignment: Alignment.bottomCenter,
          margin:const EdgeInsets.only(bottom: (30)),
          child: SvgPicture.asset(AppImages.depositsLogo,package: 'deposits_oneclick_checkout')),
    );
  }
//--------------------------------------------------------
//--------------------------------------------------------
}
