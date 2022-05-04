import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

const Widget horizontalSpaceTiny = SizedBox(width: 5.0);
const Widget horizontalSpaceSmall = SizedBox(width: 10.0);
const Widget horizontalSpaceSmallX = SizedBox(width: 20.0);
const Widget horizontalSpaceMedium = SizedBox(width: 25.0);

const Widget verticalSpaceTiny = SizedBox(height: 5.0);
const Widget verticalSpaceSmall = SizedBox(height: 10.0);
const Widget verticalSpaceMedium = SizedBox(height: 25.0);
const Widget verticalSpaceLarge = SizedBox(height: 50.0);
const Widget verticalSpaceMassive = SizedBox(height: 120.0);

double screenWidth(BuildContext context) =>
    MediaQuery.of(context).size.width +
        MediaQuery.of(context).padding.left +
        MediaQuery.of(context).padding.right;

double screenHeight(BuildContext context) =>
    MediaQuery.of(context).size.height +
        MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;