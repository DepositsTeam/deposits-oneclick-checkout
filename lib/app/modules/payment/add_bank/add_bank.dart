import 'dart:io';
import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AddBank extends StatefulWidget {
  final String? pageTitle;
  const AddBank({Key? key, this.pageTitle}) : super(key: key);

  @override
  State<AddBank> createState() => _AddBankState();
}

class _AddBankState extends State<AddBank> with WidgetsBindingObserver {
  AddBankController controller = Get.put(AddBankController());

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    controller.addBank(context);
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      controller.addBank(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbarWidget(
        centerTitle: true,
        addBackButton: true,
        backgroundColor: AppColors.white,
        backbuttonColor: AppColors.black,
        textColor: AppColors.black,
        title: widget.pageTitle,
        textSize: (Dimens.fontSize16),
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      body: Obx(() => controller.isLoading.value
          ? Container(
              child: Utils.loader(),
            )
          : WebView(
              initialUrl: controller.checkOutUrl.value,
              javascriptMode: JavascriptMode.unrestricted,
            )),
    );
  }
}
