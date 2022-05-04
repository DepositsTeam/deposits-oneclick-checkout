import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class PayWithBankCard extends StatefulWidget {
 const PayWithBankCard({Key? key}) : super(key: key);

  @override
  _PayWithBankCardState createState() => _PayWithBankCardState();
}

class _PayWithBankCardState extends State<PayWithBankCard> {
  PayWithBankCardController controller = Get.put(PayWithBankCardController());


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: AppColors.white,
          key: controller.globalKey,
          appBar: CustomAppbarWidget(
            centerTitle: true,
            addBackButton: true,
            backgroundColor: AppColors.white,
            backbuttonColor: AppColors.black,
            textColor: AppColors.black,
            title: 'Pay \$ '+Storage.getValue(Constants.amountToProcess)+' USD',
            textSize: (Dimens.fontSize16),
            onBackPress: () {
              Navigator.pop(context);
            },
          ),
          body: payWithBankCardBody(),
    );
  }
//--------------------------------------------------------
  Widget payWithBankCardBody(){
    return Padding(
      padding:
        const  EdgeInsets.symmetric(horizontal: (20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //top content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [payWithBankDesc(),payDesc(), useBankButton(),
            separator(),
            payWithCard()],
          ),

          //bottom content
          Column(
            children: [depositsLogo()],
          )
        ],
      )
    );
  }
//--------------------------------------------------------
  Widget payDesc() {
    return Container(
      alignment: Alignment.topCenter,
      margin:const EdgeInsets.symmetric(vertical: (15)),
      child:const CustomText(
        txtAlign: TextAlign.center,
        text: Strings.payWithBankDesc,
        font: (Dimens.fontSize14),
        fntweight: FontWeight.w400,
      ),
    );
  }
//--------------------------------------------------------
  Widget depositsLogo() {
    return Container(
          alignment: Alignment.bottomCenter,
          margin:const EdgeInsets.only(bottom: (30)),
          child: SvgPicture.asset(AppImages.depositsLogo,package: 'deposits_oneclick_checkout',)
    );
  }
//--------------------------------------------------------
  Widget useBankButton() {
    return CustomElevatedButton(
            onPressed: () => controller.payWithBank(context),
            minWidth: Get.width,
            addBorder: true,
            title: Strings.useBankLogin,
            isBusy: controller.isLoading.value,
            textColor: AppColors.borderButtonColor,
            buttonColor: AppColors.white,
            loaderColor: AppColors.borderButtonColor,
         );
  }
//--------------------------------------------------------
  Widget payWithBankDesc() {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.only(top: (15)),
      child: const CustomText(
        txtAlign: TextAlign.center,
        text: Strings.payWithBank,
        font: (Dimens.fontSize20),
        fntweight: FontWeight.w700,
      ),
    );
  }
//-------------------------------------------------------=
  Widget separator(){
    return Container(
      margin:const EdgeInsets.symmetric(vertical: (20)),
      child: const HorizontalOrLine(height: 10,label: Strings.or),
    );
  }
//--------------------------------------------------------
  Widget payWithCard(){
    return CustomListTileWidget(
      title: Strings.payWithCard, 
      onTap: ()=>controller.payWithCard(context),
      subTitle: '',
      trailing: const Icon(Icons.arrow_forward_ios_sharp,color: AppColors.borderColor,),
      contentPadding: const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),
      leading: SvgPicture.asset(AppImages.card,package: 'deposits_oneclick_checkout'),
      );
  }
//--------------------------------------------------------
}