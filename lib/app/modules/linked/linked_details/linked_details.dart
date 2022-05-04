import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class LinkedDetails extends StatefulWidget {
  const LinkedDetails({Key? key, required this.linkedItem,this.initialScreen }) : super(key: key);
  final Tenant? linkedItem;
  final Widget? initialScreen;

  @override
  _LinkedDetailsState createState() => _LinkedDetailsState();
}

class _LinkedDetailsState extends State<LinkedDetails> {
  LinkedDetailsController controller = Get.put(LinkedDetailsController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          backgroundColor: AppColors.white,
          appBar: CustomAppbarWidget(
            centerTitle: true,
            addBackButton: true,
            backgroundColor: AppColors.white,
            backbuttonColor: AppColors.black,
            textColor: AppColors.black,
            title: widget.linkedItem!.name!.toTitleCase(),
            textSize: (Dimens.fontSize16),
            onBackPress: () {
              Navigator.pop(context);
            },
          ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return Utils.loader();
            }
            return  linkDetailBody();
          }),
        );
  }

//--------------------------------------------------------
  Widget linkDetailBody() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: (20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //top content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpaceSmall,
              linkDesc(),
              revokeButton(),
              website(),
              haveAccess(),
              loginAccess(),
              addressAccess(),
              accountAccess(),
              paymentAccess()
            ],
          ),
          //bottom content
          Column(
            children: [depositsLogo()],
          )
        ],
      ),
    );
  }

//--------------------------------------------------------
  Widget linkDesc() {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.symmetric(vertical: (15)),
      child: CustomRichTextWidget(
        title: widget.linkedItem!.name!.toTitleCase() + " "+ Strings.brandRevokeAccress,
        subtitle: Strings.learnAboutProtection,
        subtitle2: '',
        subtitle3: '',
        onSubtitleTap2: controller.learnMore,
      ),
    );
  }

//--------------------------------------------------------
  Widget website() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: Strings.website,
            font: (Dimens.fontSize15),
            fntweight: FontWeight.w400,
            txtColor: AppColors.doveGray,
          ),
          verticalSpaceTiny,
          CustomText(
            text: widget.linkedItem?.website??'null',
            textStyle: const TextStyle(
              fontSize: (Dimens.fontSize16),
              color: AppColors.activButtonColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

//--------------------------------------------------------
  Widget haveAccess() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'What ${widget.linkedItem!.name!.toTitleCase()} have access to',
            font: (Dimens.fontSize15),
            fntweight: FontWeight.w400,
            txtColor: AppColors.doveGray,
          ),
          verticalSpaceTiny,
          CustomText(
            text: widget.linkedItem!.text!.toCapitalized(),
            font: (Dimens.fontSize14),
            fntweight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

//--------------------------------------------------------
  Widget loginAccess() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: 'Login access given on',
            font: (Dimens.fontSize15),
            fntweight: FontWeight.w400,
            txtColor: AppColors.doveGray,
          ),
          verticalSpaceTiny,
          CustomText(
            text:DateFormat('MMM dd yyyy, h:mma')
                        .format(widget.linkedItem!.createdAt!),
            font: (Dimens.fontSize14),
            fntweight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

//--------------------------------------------------------
  Widget addressAccess() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: 'Address access given on',
            font: (Dimens.fontSize15),
            fntweight: FontWeight.w400,
            txtColor: AppColors.doveGray,
          ),
          verticalSpaceTiny,
          CustomText(
            text: DateFormat('MMM dd yyyy, h:mma')
                        .format(widget.linkedItem!.createdAt!),
            font: (Dimens.fontSize14),
            fntweight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

//--------------------------------------------------------
  Widget accountAccess() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: 'Basic account info access given on',
            font: (Dimens.fontSize15),
            fntweight: FontWeight.w400,
            txtColor: AppColors.doveGray,
          ),
          verticalSpaceTiny,
          CustomText(
            text: DateFormat('MMM dd yyyy, h:mma')
                        .format(widget.linkedItem!.createdAt!),
            font: (Dimens.fontSize14),
            fntweight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

//--------------------------------------------------------
  Widget paymentAccess() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: 'Payment access given on',
            font: (Dimens.fontSize15),
            fntweight: FontWeight.w400,
            txtColor: AppColors.doveGray,
          ),
          verticalSpaceTiny,
          CustomText(
            text: DateFormat('MMM dd yyyy, h:mma')
                        .format(widget.linkedItem!.createdAt!),
            font: (Dimens.fontSize14),
            fntweight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

//--------------------------------------------------------
  void revokeAccess({VoidCallback? onpress}) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('Revoke access'),
            content:  Text(
                'Do you want to remove all access to  ${widget.linkedItem!.name} website?'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context); //close Dialog
                  },
                  child: const Text('Close')),
              TextButton(
                onPressed: onpress,
                child: const Text('Yes'),
              )
            ],
          );
        });
  }

//--------------------------------------------------------
  Widget revokeButton() {
    return CustomElevatedButton(
      onPressed: () => {
        revokeAccess(
        onpress: () => {
          Navigator.pop(context),
          controller.revokeLinkAccess(context,widget.linkedItem!.name!,widget.initialScreen!,widget.linkedItem!.userId!.toString() )
        },
      )},
      minWidth: Get.width,
      title: Strings.revokeAccress,
      textStyle: const TextStyle(
        color: AppColors.black,
      ),
      buttonColor: AppColors.activButtonColor,
    );
  }

//--------------------------------------------------------
  Widget depositsLogo() {
    return Container(
        alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.only(bottom: (30)),
        child: SvgPicture.asset(AppImages.depositsLogo,
            package: 'deposits_oneclick_checkout'));
  }
//--------------------------------------------------------
}
