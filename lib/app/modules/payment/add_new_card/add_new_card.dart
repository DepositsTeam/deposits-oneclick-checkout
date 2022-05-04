import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class AddNewCard extends StatefulWidget {
  const AddNewCard({Key? key}) : super(key: key);

  @override
  _AddNewCardState createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
  AddNewCardController controller = Get.put(AddNewCardController());

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
          title: Strings.addACard,
          textSize: (Dimens.fontSize16),
          onBackPress: () {
            Navigator.pop(context);
          },
        ),
        body: GetBuilder<AddNewCardController>(
            builder: (controller) => addNewCardBody()),
      ),
    );
  }

//--------------------------------------------------------
  Widget addNewCardBody() {
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
                          creditDebitInput(),
                          expiryCvcInput(),
                          zipCodeInput(),
                          saveCardInfo(),
                        ])),
                    // bottom content
                    Column(
                      children: [addCardButton(), depositsLogo()],
                    )
                  ]))));
        }));
  }

//--------------------------------------------------------
  Widget firstNameInput() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: (5)),
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
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp('[\\.|\\,]')),
            ],
            onSaved: (String? value) {
              controller.userFirstName.value = value!;
            },
            validator: (value) => Validators.validateEmpty(value),
            hintText: Strings.enterFirstName,
            textInputAction: TextInputAction.next,
          ),
        ]));
  }

//--------------------------------------------------------
  Widget lastNameInput() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: (5)),
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
            hintText: Strings.enterLastName,
            textInputAction: TextInputAction.next,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp('[\\.|\\,]')),
            ],
            onSaved: (String? value) {
              controller.paymentCard.name =
                  controller.userFirstName.value + " " + value!;
            },
          ),
        ]));
  }

//--------------------------------------------------------
  Widget creditDebitInput() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: (5)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CustomText(
              text: Strings.creditCard,
              font: (Dimens.fontSize14),
              fntweight: FontWeight.w400),
          verticalSpaceTiny,
          CustomTextFieldWidget(
            controller: controller.cardNumberController,
            keyboardType: TextInputType.number,
            addHint: true,
            validator: (value) => CardUtils.validateCardNum(value),
            hintText: Strings.enterCreditCard,
            onSaved: (String? value) {
             // print('onSaved = $value');
              controller.paymentCard.number =
                  CardUtils.getCleanedNumber(value!);
            },
            textInputAction: TextInputAction.next,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(19),
              CardNumberInputFormatter()
            ],
            prefixIcon: CardUtils.getCardIcon(controller.paymentCard
                .type), //SvgPicture.asset(AppImages.creditCard,package: 'deposits_oneclick_checkout'),
            suffix: SvgPicture.asset(AppImages.scanCard,
                package: 'deposits_oneclick_checkout'),
          ),
        ]));
  }

//--------------------------------------------------------
  Widget expiryCvcInput() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: (5)),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                    text: Strings.expiryDate,
                    font: (Dimens.fontSize14),
                    fntweight: FontWeight.w400),
                verticalSpaceTiny,
                CustomTextFieldWidget(
                  controller: controller.expiryDateController,
                  keyboardType: TextInputType.number,
                  addHint: true,
                  validator: (value) => CardUtils.validateDate(value),
                  hintText: Strings.mmyy,
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    List<int> expiryDate = CardUtils.getExpiryDate(value!);
                    controller.paymentCard.month = expiryDate[0];
                    controller.paymentCard.year = expiryDate[1];
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                    CardMonthInputFormatter()
                  ],
                ),
              ],
            )),
            horizontalSpaceSmall,
            horizontalSpaceTiny,
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                    text: Strings.cvc,
                    font: (Dimens.fontSize14),
                    fntweight: FontWeight.w400),
                verticalSpaceTiny,
                CustomTextFieldWidget(
                  controller: controller.cvcController,
                  keyboardType: TextInputType.number,
                  addHint: true,
                  validator: (value) => CardUtils.validateCVV(value),
                  hintText: Strings.cvc,
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    controller.paymentCard.cvv = int.parse(value!);
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                ),
              ],
            )),
          ],
        ));
  }

//--------------------------------------------------------
  Widget zipCodeInput() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: (5)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CustomText(
              text: Strings.zipCode,
              font: (Dimens.fontSize14),
              fntweight: FontWeight.w400),
          verticalSpaceTiny,
          CustomTextFieldWidget(
            controller: controller.zipController,
            keyboardType: TextInputType.text,
            addHint: true,
            validator: (value) => Validators.validateEmpty(value),
            hintText: Strings.zipCode,
            inputFormatters: [
               LengthLimitingTextInputFormatter(9),
              FilteringTextInputFormatter.digitsOnly,
            ],
            textInputAction: TextInputAction.send,
          ),
        ]));
  }

//--------------------------------------------------------
  Widget saveCardInfo() {
    return Container(
      color: AppColors.saveInfoContainerColor,
      height: (35),
      margin: const EdgeInsets.symmetric(vertical: (5)),
      padding: const EdgeInsets.symmetric(vertical: (5), horizontal: (5)),
      child: Row(
        children: [
          SvgPicture.asset(
            AppImages.iconInfo,
            package: 'deposits_oneclick_checkout',
            width: (15),
            height: (15),
          ),
          horizontalSpaceSmall,
          const CustomText(
            text: Strings.saveCardLater,
            font: (Dimens.fontSize14),
            fntweight: FontWeight.w400,
          )
        ],
      ),
    );
  }

//--------------------------------------------------------
  Widget addCardButton() {
    return Obx(() => Container(
        margin: const EdgeInsets.symmetric(vertical: (8)),
        child: CustomElevatedButton(
          onPressed: () =>
              controller.addNewCard(context),
          minWidth: Get.width,
          title: Strings.addCard,
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
          margin: const EdgeInsets.only(bottom: (10)),
          child: SvgPicture.asset(AppImages.depositsLogo,
              package: 'deposits_oneclick_checkout')),
    );
  }
//--------------------------------------------------------
//--------------------------------------------------------
//--------------------------------------------------------
//--------------------------------------------------------
//--------------------------------------------------------
//--------------------------------------------------------
}
