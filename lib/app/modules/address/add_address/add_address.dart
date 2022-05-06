import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key,}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  AddAddressController controller = Get.put(AddAddressController());

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
          title: Strings.addMailingAddress,
          textSize: (Dimens.fontSize16),
          onBackPress: () {
            Navigator.pop(context);
          },
        ),
        body: GetBuilder<AddAddressController>(
            builder: (controller) => addAddressBody()),
      ),
    );
  }

//--------------------------------------------------------
  Widget addAddressBody() {
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
                          streetAddressInput(),
                          zipCodeInput(),
                          verticalSpaceSmall,
                          CountryStateCityPicker(
                            country: controller.country,
                            state: controller.state,
                            city: controller.city,
                            countryValidator: (value) =>
                                Validators.validateEmpty(value),
                            stateValidator: (value) =>
                                Validators.validateEmpty(value),
                            cityValidator: (value) =>
                                Validators.validateEmpty(value),
                          ),
                          verticalSpaceSmall,
                        ])),
                    // bottom content
                    Column(
                      children: [addAddressButton(), depositsLogo()],
                    )
                  ]))));
        }));
  }

//--------------------------------------------------------
  Widget streetAddressInput() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: (15)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CustomText(
              text: Strings.streetAddress,
              font: (Dimens.fontSize14),
              fntweight: FontWeight.w400),
          verticalSpaceTiny,
          CustomTextFieldWidget(
            controller: controller.streetAddressController,
            keyboardType: TextInputType.name,
            addHint: true,
            validator: (value) => Validators.validateEmpty(value),
            hintText: Strings.enterStreetAddress,
            textInputAction: TextInputAction.next,
            onTap: ()async{
              // generate a new token here
                final sessionToken =const Uuid().v4();
                final Suggestion? result = await showSearch(
                  context: context,
                  delegate: AddressSearch(sessionToken),
                );
                // This will change the text displayed in the TextField
                if (result != null) {
                  final placeDetails = await PlaceApiProvider(sessionToken)
                      .getPlaceDetailFromId(result.placeId);
                  setState(() {
                    controller.streetAddressController.text ='${placeDetails.streetNumber??''} ${placeDetails.street??''}';//placeDetails.street??
                    controller.city.text = '${placeDetails.city!.replaceAll('County', '').replaceAll('Country', '')} ';
                    controller.zipCodeController.text = placeDetails.zipCode??'';
                    controller.state.text = placeDetails.state??'';
                    controller.country.text = placeDetails.country??'';
                  });
                }
            },
          ),
        ]));
  }

//--------------------------------------------------------
  Widget zipCodeInput() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: (10)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CustomText(
              text: Strings.zipCode,
              font: (Dimens.fontSize14),
              fntweight: FontWeight.w400),
          verticalSpaceTiny,
          CustomTextFieldWidget(
            controller: controller.zipCodeController,
            keyboardType: TextInputType.text,
            addHint: true,
            validator: (value) => Validators.validateEmpty(value),
            hintText: Strings.enterZipCode,
            inputFormatters: [
              LengthLimitingTextInputFormatter(9),
              FilteringTextInputFormatter.digitsOnly,
            ],
            textInputAction: TextInputAction.send,
          ),
        ]));
  }

//--------------------------------------------------------
 Widget addAddressBody2(){
   return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: (15)),
          child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                  child:
                      Column(mainAxisSize: MainAxisSize.max, children: [
                        //top content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                            ])),
                            // bottom content
                        Column(
                          children: [

                          ],
                        )
                      ]))));
    });
 }
//--------------------------------------------------------
//--------------------------------------------------------
//--------------------------------------------------------
//--------------------------------------------------------
//--------------------------------------------------------
  Widget addAddressButton() {
    return Obx(() => Container(
        margin: const EdgeInsets.symmetric(vertical: (20)),
        child: CustomElevatedButton(
          onPressed: () =>
              controller.addAddress(context),
          minWidth: Get.width,
          title: Strings.addAddress,
          isBusy: controller.isLoading.value,
          textStyle: TextStyle(
              color: controller.validateInput()
                  ? AppColors.black
                  : AppColors.white),
          buttonColor: controller.validateInput()
              ? AppColors.activButtonColor()
              : AppColors.inActivButtonColor(),
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

//--------------------------------------------------------

//--------------------------------------------------------

//--------------------------------------------------------
}
