import 'dart:io';
import 'package:path/path.dart' as pat;
import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class Linked extends StatefulWidget {
  final Widget? initialScreen;
  const Linked({Key? key, this.initialScreen}) : super(key: key);

  @override
  _LinkedState createState() => _LinkedState();
}

class _LinkedState extends State<Linked> with WidgetsBindingObserver  {
  LinkedController controller = Get.put(LinkedController());

 @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    controller.fetchLinked(context);
    }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      controller.fetchLinked(context);
    }
}

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Utils.loader();
      }
      if (controller.isError.value) {
        return CustomNoInternetRetry(message: controller.errorMessage.value, onPressed: () { controller.fetchLinked(context); }, title: Strings.error,);
      }
      return linkedBody();
    });
  }

//----------------------------------------------
  Widget linkedBody() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: (18)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //top content
          Column(
            children: [
              verticalSpaceSmall,
              verticalSpaceTiny,
              linkDesc(),
              allLiknedStuff(),
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

//----------------------------------------------
  Widget linkDesc() {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.symmetric(vertical: (15)),
      child: const CustomText(
        txtAlign: TextAlign.center,
        text: Strings.linkedDesc,
        font: (Dimens.fontSize14),
        fntweight: FontWeight.w400,
      ),
    );
  }

//----------------------------------------------
  Widget allLiknedStuff() {
    return ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: (10)),
        itemCount: controller.allAccounts.length,
        separatorBuilder: (_, i) => const SizedBox(height: 0),
        itemBuilder: (_, i) {
          var link =  controller.allAccounts[i];
          var file =  File(link.logo!);
          var extenion = pat.extension(file.path);
          return CustomListTileWidget(
              title: link.name!.toTitleCase(),
              onTap: () {
                Utils.navigationPush(
                    context,
                    LinkedDetails(
                        linkedItem: link,
                        initialScreen: widget.initialScreen));
              },
              subTitle: '',
              leading: CircleAvatar(
                  backgroundColor: AppColors.white,
                  child: extenion == '.svg'? SvgImageLoader(
                    link.logo!,
                    height: 50,
                    width: 40,
                    fit: BoxFit.contain,
                  ):ImageLoader(
                    controller.allAccounts[i].logo!,
                    height: 50,
                    width: 40,
                    fit: BoxFit.contain,
                  )),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    text: 'Has ' +
                        link.access! +
                        ' of 4 access',
                    font: Dimens.fontSize14,
                  ),
                  const Icon(Icons.arrow_forward_ios_sharp)
                ],
              ),
            );
        });
  }

//----------------------------------------------
//----------------------------------------------
  Widget depositsLogo() {
    return Container(
        alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.only(bottom: (30)),
        child: SvgPicture.asset(AppImages.depositsLogo,
            package: 'deposits_oneclick_checkout'));
  }
//----------------------------------------------
}
