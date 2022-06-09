import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

PayWithDepositsController controller = Get.put(PayWithDepositsController());
PaymentsController payController = Get.put(PaymentsController());

//initial function to call the deposit buttom
void depositsCheckout(
  BuildContext context,
  ButtonConfig buttonConfig, {
  required String userEmail,
  required String apiKey,
  required bool envMode,
  ValueChanged<ChargeFundResponse>? chargeFundsResponse,
}) async {
  GetStorage.init();
  await dotenv.load(
      fileName:
          'packages/deposits_oneclick_checkout/lib/app/common/assets/.env');
  FingerPrintJs().init();
  Storage.removeValue(Constants.customColor);
  Storage.saveValue(Constants.customColor, buttonConfig.buttonColor);
  showModalBottomSheet(
      context: context,
      elevation: 4,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return PayButtonSheet(
          buttonConfig: buttonConfig,
          userEmail: userEmail,
          subClientApiKey: apiKey,
          envMode: envMode,
          chargeFundsResponse: chargeFundsResponse,
        );
      }).whenComplete(() {
    chargeFundsResponse!(controller.finalChargeFundResponse);
  });
}

class PayButtonSheet extends StatefulWidget {
  final ButtonConfig buttonConfig;
  final String userEmail;
  final String subClientApiKey;
  final bool envMode;
  final ValueChanged<ChargeFundResponse>? chargeFundsResponse;
  const PayButtonSheet(
      {Key? key,
      required this.buttonConfig,
      required this.userEmail,
      required this.subClientApiKey,
      required this.envMode,
      this.chargeFundsResponse})
      : super(key: key);

  @override
  State<PayButtonSheet> createState() => _PayButtonSheetState();
}

class _PayButtonSheetState extends State<PayButtonSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            const EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PayWithDepositsButton(
              buttonConfig: widget.buttonConfig,
              userEmail: widget.userEmail,
              subClientApiKey: widget.subClientApiKey,
              envMode: widget.envMode,
              chargFundsResponse: widget.chargeFundsResponse,
            ),
            if (Storage.hasData(Constants.isCardAdded)) ...[
              controller.isLoading.isFalse
                  ? Obx(
                      () => Container(
                        margin: const EdgeInsets.only(top: (10)),
                        child: CustomRowTextWidget(
                          title: payController.isPayWithCard.isTrue
                              ? Strings.payWith +
                                  Storage.getValue(Constants.cardNumber)
                              : Strings.payWith +
                                  Storage.getValue(Constants.accountNumber),
                          titleStyle: const TextStyle(color: AppColors.black),
                          titleOnTap: () {},
                          subtitle: Strings.edit,
                          subtitleStyle:
                              TextStyle(color: Utils.hexToInt(
                                  widget.buttonConfig.buttonColor)),
                          subTitleOnTap: () {
                            Storage.saveValue(Constants.customColor,
                                widget.buttonConfig.buttonColor);
                            Navigator.pop(context);
                            //Navigator.of(context, rootNavigator: true).pop();
                            Utils.navigationPush(
                              context,
                              const ManageDepositID()
                            );
                          },
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
            verticalSpaceMedium,
            SvgPicture.asset(AppImages.depositsLogo,
                package: 'deposits_oneclick_checkout'),
            verticalSpaceMedium,
          ],
        ));
  }
}

//pay with deposits button
class PayWithDepositsButton extends StatefulWidget {
  final ButtonConfig buttonConfig;
  final String userEmail;
  final String subClientApiKey;
  final bool envMode;
  final ValueChanged<ChargeFundResponse>? chargFundsResponse;

  const PayWithDepositsButton(
      {Key? key,
      required this.buttonConfig,
      required this.userEmail,
      required this.subClientApiKey,
      required this.envMode,
      this.chargFundsResponse});
  @override
  _PayWithDepositsButtonState createState() => _PayWithDepositsButtonState();
}

class _PayWithDepositsButtonState extends State<PayWithDepositsButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            Storage.removeValue(Constants.amountToProcess);
            Storage.removeValue(Constants.userEmail);
            Storage.removeValue(Constants.subClientApiKey);
            Storage.removeValue(Constants.envMode);
            Storage.saveValue(Constants.amountToProcess,
                widget.buttonConfig.amount.toStringAsFixed(2));
            Storage.saveValue(Constants.envMode, widget.envMode);
            Storage.saveValue(Constants.userEmail, widget.userEmail);
            Storage.saveValue(
                Constants.subClientApiKey, widget.subClientApiKey);
            if (Storage.hasData(Constants.isCardAdded)) {
              payController.isPayWithCard.isTrue
                  ? controller.payWithCard(context, widget.chargFundsResponse)
                  : controller.payWithBank(context, widget.chargFundsResponse);
            } else {
              Navigator.pop(context);
              Utils.navigationPush(context, const Login());
            }
          });
        },
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          minimumSize: MaterialStateProperty.resolveWith<Size>(
            (states) => Size(
              widget.buttonConfig.minWidth,
              widget.buttonConfig.height,
            ),
          ),
          shape: widget.buttonConfig.addBorder
              ? MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
                  (states) => RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                    side: BorderSide(
                      //Color(int.parse("0xFF${widget.buttonConfig.buttonColor}"))
                      color: Utils.hexToInt(widget.buttonConfig.buttonColor) ==
                              AppColors.activButtonColor()
                          ? Colors.white
                          : widget.buttonConfig.buttonBorderColor!,
                      width: 2,
                    ),
                  ),
                )
              : MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
                  (states) => RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.transparent;
              }

              return null;
            },
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                // return Color(int.parse("0xFF${widget.buttonConfig.buttonColor}")).withOpacity(.50);
                return Utils.hexToInt(widget.buttonConfig.buttonColor)
                    .withOpacity(.50);
              }
              return !controller.isLoading.value
                  ? Utils.hexToInt(widget.buttonConfig.buttonColor)
                  : Utils.hexToInt(widget.buttonConfig.buttonColor)
                      .withOpacity(0.6);
              // ?  Color(int.parse("0xFF${widget.buttonConfig.buttonColor}"))
              // :  Color(int.parse("0xFF${widget.buttonConfig.buttonColor}")).withOpacity(0.6);
            },
          ),
        ),
        child: Obx(
          () => controller.isLoading.isTrue
              ? SpinKitFadingCircle(
                  color: Utils.hexToInt(widget.buttonConfig
                      .loaderColor), //Color(int.parse("0xFF${widget.buttonConfig.loaderColor}")),
                  size: 20,
                )
              : widget.buttonConfig.titleWidget ??
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Pay \$" +
                            widget.buttonConfig.amount.toStringAsFixed(2) +
                            " USD",
                        style: widget.buttonConfig.textStyle ??
                            AppTextStyle.boldStyle.copyWith(
                                fontSize: Dimens.fontSize14,
                                color: Utils.hexToInt(widget.buttonConfig
                                    .textColor) //Color(int.parse("0xFF${widget.buttonConfig.textColor}"))
                                ),
                      ),
                    ],
                  ),
        ));
  }
}

class ButtonConfig {
  final double amount;
  final TextStyle? textStyle;
  final double height, minWidth;
  final Widget? titleWidget;
  final Color? buttonBorderColor;
  final String buttonColor, textColor, loaderColor;
  final bool addBorder;

  const ButtonConfig({
    required this.amount,
    this.textStyle,
    this.height = 55,
    this.minWidth = 100,
    required this.buttonColor,
    this.buttonBorderColor,
    this.textColor = '000000',
    this.loaderColor = 'FFFFFF',
    this.titleWidget,
    this.addBorder = false,
  });
}
