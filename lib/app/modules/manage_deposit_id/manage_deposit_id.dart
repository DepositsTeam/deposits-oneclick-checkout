import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class ManageDepositID extends StatefulWidget {
  
  const ManageDepositID({Key? key }) : super(key: key);

  @override
  _ManageDepositIDState createState() => _ManageDepositIDState();
}

class _ManageDepositIDState extends State<ManageDepositID> {
  ManageDepositIdController controller = Get.put(ManageDepositIdController());
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<ManageDepositIdController>(
        builder: (controller){
          return DefaultTabController(
              length:  4,
              initialIndex: 0,
              child: Scaffold(
              key: controller.globalKey,
              backgroundColor : AppColors.white,
              appBar:
               CustomAppbarWidget(
              centerTitle: true,
              addBackButton: true,
              backgroundColor: AppColors.white,
              backbuttonColor: AppColors.black,
              textColor: AppColors.black,
              title: Strings.manageDepositId,
              textSize: (Dimens.fontSize16),
              onBackPress: () {
                 Navigator.pop(context);
              },
              bottom: TabBar(
              labelColor: AppColors.activButtonColor(),
              unselectedLabelColor: const Color(0xFF5F6B7A),
              indicatorColor: AppColors.activButtonColor(),
              tabs:const [
                Tab(text: Strings.payment,),
                Tab(text: Strings.linked),
                Tab(text: Strings.address),
                Tab(text: Strings.profile),
              ],
          ),
            ),
            body:const TabBarView(
              children: [
                Payments(),
                Linked(),
                Address(),
                Profile()
              ],
              ),
            ),
          );
        },
    );
  }
}