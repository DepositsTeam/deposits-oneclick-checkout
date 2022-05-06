import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginController controller = Get.put(LoginController());
  bool isMount = true;
// //--------------------------------------------------------
  @override
  void initState() {
    super.initState();
    controller.emailController.text = Storage.getValue(Constants.userEmail);
    controller.emailController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    isMount = false;
    // code omitted..
    super.dispose();
  }

//--------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        key: controller.loginGlobalKey,
        appBar: CustomAppbarWidget(
          centerTitle: true,
          addBackButton: true,
          backgroundColor: AppColors.white,
          backbuttonColor: AppColors.black,
          textColor: AppColors.black,
          title: Strings.loginWithDeposit,
          textSize: (Dimens.fontSize16),
          onBackPress: () {
            Navigator.pop(context);
          },
        ),
        body: loginBody(),
      ),
    );
  }

//--------------------------------------------------------
  Widget loginBody() {
    return Form(
        key: controller.formKey,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: (20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //top content
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [loginDesc(), loginInput(), saveInfoContainer()],
                ),

                //bottom content
                Column(
                  children: [byClicking(), logInButton(), depositsLogo()],
                )
              ],
            )));
  }

//--------------------------------------------------------
  Widget loginDesc() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: (15)),
      child: CustomText(
        text: Strings.loginDesc,
        font: (Dimens.fontSize14),
        fntweight: FontWeight.w400,
      ),
    );
  }

//--------------------------------------------------------
  Widget loginInput() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: (15)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CustomText(
              text: Strings.emailOrPhone,
              font: (Dimens.fontSize14),
              fntweight: FontWeight.w400),
          verticalSpaceTiny,
          CustomTextFieldWidget(
            controller: controller.emailController,
            keyboardType: TextInputType.name,
            addHint: true,
            readOnly: true,
            validator: (value) => Validators.validateEmailPhone(value),
            hintText: Strings.hintEmailPhone,
            textInputAction: TextInputAction.send,
          ),
        ]));
  }

//--------------------------------------------------------
  Widget saveInfoContainer() {
    return Container(
      color: AppColors.saveInfoContainerColor,
      height: (50),
      margin: EdgeInsets.symmetric(vertical: (7)),
      padding: EdgeInsets.symmetric(vertical: (10), horizontal: (10)),
      child: Row(
        children: [
          SvgPicture.asset(
            AppImages.iconInfo,
            package: 'deposits_oneclick_checkout',
            width: (15),
            height: (15),
          ),
          horizontalSpaceSmall,
          CustomText(
            text: Strings.saveInfoLater,
            font: (Dimens.fontSize14),
            fntweight: FontWeight.w400,
          )
        ],
      ),
    );
  }

//--------------------------------------------------------
  Widget byClicking() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: CustomRichTextWidget(
          title: Strings.terms1,
          title2: Strings.terms4,
          subtitle: Strings.terms2,
          onSubtitleTap: controller.termsOnClick,
          onSubtitleTap2: controller.policyOnClick,
          onSubtitleTap3: controller.cookieOnClick,
          subtitle2: Strings.terms3,
          subtitle3: Strings.terms5),
    );
  }

//--------------------------------------------------------
  Widget logInButton() {
    return Obx(() => Container(
        margin: const EdgeInsets.symmetric(vertical: (15)),
        child: CustomElevatedButton(
          onPressed: () => controller.signIn(context),
          minWidth: Get.width,
          title: Strings.login,
          isBusy: controller.isLoading.value,
          textStyle: TextStyle(
              color: controller.emailController.text.isEmpty
                  ? AppColors.white
                  : AppColors.black),
          buttonColor: controller.emailController.text.isEmpty
              ? AppColors.inActivButtonColor()
              : AppColors.activButtonColor(),
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
