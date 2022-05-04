
import '../common/utils/exports.dart';

class CustomNoInternetRetry extends StatelessWidget{
  final String title;
  final String message;
  final VoidCallback onPressed;

  CustomNoInternetRetry({required this.title,required this.message,required this.onPressed});

   Widget build(BuildContext context) {
   return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(text: title, fntweight: FontWeight.bold, font: 20, txtColor: AppColors.black.withOpacity(0.9),),
              SizedBox(height: 10,),
              CustomText(text: message, fntweight: FontWeight.normal, font: 14,txtColor: AppColors.black),
              SizedBox(height: 10,),
              SizedBox(
                width: 100,
                child: CustomElevatedButton(
                  onPressed: onPressed,title: Strings.retry,))
            ],)
        );
   }
}