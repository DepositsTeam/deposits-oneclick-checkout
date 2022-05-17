import 'package:flutter/cupertino.dart';
import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class Payments extends StatefulWidget {
  const Payments({Key? key}) : super(key: key);

  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments>with WidgetsBindingObserver  {
  PaymentsController controller = Get.put(PaymentsController());

 @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    controller.fetchfundingSources(context);
    }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      controller.fetchfundingSources(context);
    }
}

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Utils.loader();
      }
       if (controller.isError.value) {
        return CustomNoInternetRetry(message: controller.errorMessage.value, onPressed: () { controller.fetchfundingSources(context); }, title: Strings.error,);
      }
      return paymentContent();
    });
  }

//---------------------------------------------------
  Widget paymentContent() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: (18)),
      children: [
        verticalSpaceSmall,
        const CustomText(
          text: Strings.cards,
          font: (Dimens.fontSize16),
          fntweight: FontWeight.w600,
        ),
        verticalSpaceTiny,
        allCards(),
        addCardButton(),
        verticalSpaceMedium,
        const CustomText(
          text: Strings.banks,
          font: (Dimens.fontSize16),
          fntweight: FontWeight.w600,
        ),
        verticalSpaceTiny,
        allBanks(),
        addBankButton(),
        verticalSpaceMedium
      ],
    );
  }

//---------------------------------------------------
  Widget allCards() {
    return ListView.separated(
        shrinkWrap: true,
        itemCount: controller.allCards.length,
        // padding: const EdgeInsets.symmetric(vertical: (10)),
        separatorBuilder: (_, i) => const SizedBox(height: 20),
        itemBuilder: (_, i) => GetBuilder<PaymentsController>(
              builder: (controller) => RadioListTile<int>(
                  value: i,
                  dense: true,
                  groupValue: controller.choice,
                  onChanged: (value) {
                    controller.updateChoice(value!);
                  },
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                  secondary: InkWell(
                      onTap: () {
                        removeCard(
                            cardNumber: controller
                                .allCards[i].metaDataJson!.maskedCardNumber!,
                            onpress: () => {
                                  Navigator.pop(context),
                                  controller.removeCard(context,
                                      controller.allCards[i].id.toString())
                                });
                      },
                      child: const Icon(
                        Icons.close,
                        size: 24,
                      )),
                  activeColor: AppColors.activButtonColor(),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Utils.getCardImage(controller
                          .allCards[i].metaDataJson!.issuer!.isEmpty?'Not Available': controller
                                  .allCards[i].metaDataJson!.issuer![0].brand!),
                      horizontalSpaceSmall,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.allCards[i].metaDataJson!.issuer!.isEmpty?"": controller.allCards[i].metaDataJson!
                                        .issuer![0].brand!  
                            +" *" +
                                controller
                                    .allCards[i].metaDataJson!.expiration!,
                            style: const TextStyle(
                                color: AppColors.black,
                                fontSize: Dimens.fontSize14,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            "Expires " +
                                controller.allCards[i].metaDataJson!.expiration!
                                    .substring(0, 2) +
                                "/" +
                                controller.allCards[i].metaDataJson!.expiration!
                                    .substring(controller.allCards[i]
                                            .metaDataJson!.expiration!.length -
                                        2),
                            style: const TextStyle(
                              color: Colors.black45,
                              fontSize: Dimens.fontSize12,
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
            ));
  }

//----------------------------------------------
  void removeCard({String? cardNumber, VoidCallback? onpress}) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('Delete card'),
            content:
                Text('Do you want to delete the card ending with $cardNumber'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context); //close Dialog
                  },
                  child: const Text('Cancel')),
              TextButton(
                onPressed: onpress,
                child: const Text('Yes'),
              )
            ],
          );
        });
  }

//---------------------------------------------------
  void removeBank({String? bankName, VoidCallback? onpress}) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('Delete Bank'),
            content:
                Text('Do you want to delete $bankName from your bank list'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context); //close Dialog
                  },
                  child: const Text('Cancel')),
              TextButton(
                onPressed: onpress,
                child: const Text('Yes'),
              )
            ],
          );
        });
  }

//---------------------------------------------------
  Widget addCardButton() {
    return CustomElevatedButton(
      onPressed: () => controller.addNewCard(context),
      minWidth: Get.width,
      addBorder: true,
      title: Strings.addNewCard,
      textColor: AppColors.borderButtonColor(),
      buttonColor: AppColors.white,
    );
  }

//---------------------------------------------------
  Widget addBankButton() {
    return Obx(() => CustomElevatedButton(
          onPressed: () =>
              controller.addNewBank(context),
          minWidth: Get.width,
          addBorder: true,
          isBusy: controller.isAddBank.value,
          title: Strings.addNewBank,
          loaderColor: AppColors.activButtonColor(),
          textColor: AppColors.borderButtonColor(),
          buttonColor: AppColors.white,
        ));
  }

//---------------------------------------------------
  Widget allBanks() {
    return controller.allBankAccounts.isEmpty
        ? Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            alignment: Alignment.topCenter,
            child: const CustomText(
              text:
                  'You have not added any banks yet.Click the button below to add a new bank.',
              font: Dimens.fontSize14,
              fntweight: FontWeight.w400,
            ),
          )
        : ListView.separated(
            shrinkWrap: true,
            itemCount: controller.allBankAccounts.length,
            // padding: const EdgeInsets.symmetric(vertical: (10)),
            separatorBuilder: (_, i) => const SizedBox(height: 20),
            itemBuilder: (_, i) => GetBuilder<PaymentsController>(
                  builder: (controller) => RadioListTile<int>(
                      value: i,
                      dense: true,
                      groupValue: controller.bankChoice,
                      onChanged: (value) {
                        controller.updateBankChoice(value!);
                      },
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                      secondary: InkWell(
                          onTap: () {
                            removeBank(
                                bankName: controller.allBankAccounts[i].bank,
                                onpress: () => {
                                      Navigator.pop(context),
                                      controller.removeBank(
                                          context,
                                          controller.allBankAccounts[i].id
                                              .toString())
                                    });
                          },
                          child: const Icon(
                            Icons.close,
                            size: 24,
                          )),
                      activeColor: AppColors.activButtonColor(),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            maxRadius: 20,
                            backgroundColor: Colors.blueGrey.shade100,
                            child: CustomText(
                                text: Utils.getInitials(
                                    controller.allBankAccounts[i].bank!),
                                fntweight: FontWeight.bold,
                                txtColor: Colors.blueGrey.shade800,
                                font: 10),
                          ),
                          horizontalSpaceSmall,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.allBankAccounts[i].bank!,
                                style: const TextStyle(
                                    color: AppColors.black,
                                    fontSize: Dimens.fontSize14,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              CustomText(
                                text: "Checking account- *****" +
                                    controller.allBankAccounts[i].accountNumber!
                                        .substring(controller.allBankAccounts[i]
                                                .accountNumber!.length -
                                            6),
                                txtColor: Colors.black45,
                                font: Dimens.fontSize12,
                                ellipsis: TextOverflow.fade,
                              ),
                            ],
                          ),
                        ],
                      )),
                ));
  }

//---------------------------------------------------
//---------------------------------------------------
//---------------------------------------------------
//---------------------------------------------------
//---------------------------------------------------
//---------------------------------------------------
}
