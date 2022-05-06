import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class Address extends StatefulWidget {
  const Address({Key? key}) : super(key: key);

  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> with WidgetsBindingObserver {
  AddressController controller = Get.put(AddressController());

@override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    controller.fetchUserAddress(context);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      controller.fetchUserAddress(context);
    }
}
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.symmetric(horizontal: (18)),
      child: Obx(() {
        if (controller.isLoading.value) {
          return Utils.loader();
        }
        if (controller.isError.value) {
        return CustomNoInternetRetry(message: controller.errorMessage.value, onPressed: () { controller.fetchUserAddress(context); }, title: Strings.error,);
      }
        return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children : [
          //top content
          Column(
            children: [
              allAddress(),
              addMailButton()
            ],
          ),
          //bottom content
          Column(
            children: [
              depositsLogo()
            ],
          )
        ]
         );
      }),
    );
  }
//----------------------------------------------
//----------------------------------------------
//----------------------------------------------
  Widget allAddress(){
    return ListView.builder(
      shrinkWrap : true,
      padding:const EdgeInsets.symmetric(vertical: (10)),
      itemCount: controller.addresses.length,
      itemBuilder: (context, i) {
        var address = controller.addresses[i];
       return CustomListTileWidget(
          title: address.address??'null',
          onTap: (){
           controller.editMailingAddress(context,address);
          },
          subTitle: "${address.city??''} ${address.state??''} (${address.zip??''}) ",
          leading: null,
          trailing: address.isDefault == 'true'? const CustomTextTag(text: Strings.defaultStr,) : null,
          );
      },
    );
  }
//----------------------------------------------
  Widget addMailButton() {
    return  CustomElevatedButton(
          onPressed: () => controller.addMailingAddress(context),
          minWidth: Get.width,
          addBorder: true,
          title: Strings.addMailingAddress,
          textColor: AppColors.borderButtonColor(),
          buttonColor: AppColors.white,
    );
  }
//----------------------------------------------
  Widget depositsLogo() {
    return Container(
          alignment: Alignment.bottomCenter,
          margin:const EdgeInsets.only(bottom: (30)),
          child: SvgPicture.asset(AppImages.depositsLogo,package: 'deposits_oneclick_checkout')
    );
  }
//----------------------------------------------
}