
import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with WidgetsBindingObserver {
  ProfileController controller = Get.put(ProfileController());

 @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    controller.fetchUserProfile(context);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      controller.fetchUserProfile(context);
    }
}
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.symmetric(horizontal: (18)),
      child:Obx(() {
        if (controller.isLoading.value) {
          return Utils.loader();
        }
        if (controller.isError.value) {
        return CustomNoInternetRetry(message: controller.errorMessage.value, onPressed: () { controller.fetchUserProfile(context); }, title: Strings.error,);
        }
        return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //top content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              fullName(),
              email(),
              dateOfBirth(),
              mobileNumber()
            ],
          ),
          //bottom content
          Column(
            children: [
              bottomContent()
            ],
          )
        ],
      );
 }),
    );
  }
//----------------------------------------------
  Widget bottomContent() {
    return SizedBox(
      width: double.infinity,
      child: ListView(shrinkWrap: true, children: [
        CustomElevatedButton(
          onPressed: () => controller.editProfile(context),
          minWidth: Get.width,
          addBorder: true,
          title: Strings.editProfile,
          textColor: AppColors.borderButtonColor,
          buttonColor: AppColors.white,
        ),
        Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(top: (20),bottom:(20)),
            child: SvgPicture.asset(AppImages.depositsLogo,package: 'deposits_oneclick_checkout'))
      ]),
    );
  }
//----------------------------------------------
  Widget fullName() {
    return Container(
      margin:const EdgeInsets.symmetric(vertical:(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
         const CustomText(
            text: Strings.fullname,
            font: (Dimens.fontSize15),
            fntweight: FontWeight.w400,
          ),
          verticalSpaceTiny,
          CustomText(
            text: "${controller.user.value.firstName??''} ${controller.user.value.lastName??''}",
            font: (Dimens.fontSize16),
            fntweight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
//----------------------------------------------
 Widget email() {
    return Container(
      margin:const EdgeInsets.symmetric(vertical: (10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
        const  CustomText(
            text: Strings.emailAddress,
            font: (Dimens.fontSize15),
            fntweight: FontWeight.w400,
          ),
          verticalSpaceTiny,
         CustomText(
            text: controller.user.value.email??'null',
            font: (Dimens.fontSize16),
            fntweight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
//----------------------------------------------
 Widget dateOfBirth() {
    return Container(
      margin:const EdgeInsets.symmetric(vertical:(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: Strings.dob,
            font: (Dimens.fontSize15),
            fntweight: FontWeight.w400,
          ),
          verticalSpaceTiny,
          CustomText(
            text: controller.user.value.dob??'null',
            font: (Dimens.fontSize16),
            fntweight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

//----------------------------------------------
 Widget mobileNumber() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        const  CustomText(
            text: Strings.mobileNumber,
            font: (Dimens.fontSize15),
            fntweight: FontWeight.w400,
          ),
          verticalSpaceTiny,
          CustomText(
            text: controller.user.value.phoneNumber??'null',
            font: (Dimens.fontSize16),
            fntweight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

//----------------------------------------------
//----------------------------------------------
//----------------------------------------------

}