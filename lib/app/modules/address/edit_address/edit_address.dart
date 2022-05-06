import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';
class EditAddress extends StatefulWidget {
  final Datum? userAddress;
  const EditAddress({Key? key, this.userAddress})
      : super(key: key);

  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  EditAddressController controller = Get.put(EditAddressController());

  @override
  void initState() {
    super.initState();
    controller.streetAddressController.text = widget.userAddress!.address??'';
    controller.zipCodeController.text = widget.userAddress!.zip??'';
    controller.country.text = widget.userAddress!.country??"";
    controller.state.text = widget.userAddress!.state??'';
    controller.city.text = widget.userAddress!.city??'';
    controller.streetAddressController.addListener(() {
      if (mounted) setState(() {});
    });
    controller.zipCodeController.addListener(() {
      if (mounted) setState(() {});
    });
    controller.country.addListener(() {
      if (mounted) setState(() {});
    });
    controller.state.addListener(() {
      if (mounted) setState(() {});
    });
    controller.city.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: CustomAppbarWidget(
            centerTitle: true,
            addBackButton: true,
            backgroundColor: AppColors.white,
            backbuttonColor: AppColors.black,
            textColor: AppColors.black,
            title: Strings.editAddress,
            textSize: (Dimens.fontSize16),
            onBackPress: () {
              Navigator.pop(context);
            },
          ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return Utils.loader();
            }
            return GetBuilder<EditAddressController>(
                builder: (controller) => editAddressBody());
          }),
        ));
  }

//----------------------------------------------
  Widget editAddressBody() {
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
                      children: [checkDefault(), payButton(), depositsLogo()],
                    )
                  ]))));
        }));
  }

//----------------------------------------------
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
                    controller.streetAddressController.text = '${placeDetails.streetNumber??''} ${placeDetails.street??''}';//placeDetails.street??
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

//----------------------------------------------
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

//----------------------------------------------
  Widget payButton() {
    return Container(
        margin: const EdgeInsets.only(top: 0, bottom: 20),
        child: Row(
          children: [
            Expanded(
                child: CustomElevatedButton(
              onPressed: () => controller.editAddress(context,
                  widget.userAddress!.id.toString()),
              minWidth: Get.width,
              title: Strings.saveChanges,
              textStyle: TextStyle(
                  color: controller.validateInput()
                      ? AppColors.black
                      : AppColors.white),
              buttonColor: controller.validateInput()
                  ? AppColors.activButtonColor()
                  : AppColors.inActivButtonColor(),
            )),
            horizontalSpaceSmall,
            horizontalSpaceTiny,
            Expanded(
                child: CustomElevatedButton(
              onPressed: () => controller.deleteAddress(context,
                   widget.userAddress!.id.toString()),
              minWidth: Get.width,
              title: Strings.delete,
              textStyle: const TextStyle(color: AppColors.white),
              buttonColor: const Color(0xFFD62F4B),
            ))
          ],
        ));
  }

//----------------------------------------------
  Widget checkDefault() {
    return CheckboxListTile(
      value: controller.isDefaultAddressSet.value,
      activeColor: AppColors.activButtonColor(),
      checkColor: AppColors.white,
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      title: const CustomText(
        text: 'Make default address',
        font: Dimens.fontSize14,
        fntweight: FontWeight.w400,
        txtColor: AppColors.doveGray,
      ),
      onChanged: (value) {
        controller.toggleDefaultAddress(value!);
      },
    );
  }

//----------------------------------------------
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
//----------------------------------------------
}
