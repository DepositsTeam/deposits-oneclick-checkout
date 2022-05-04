import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class CustomDropdownTextField<T> extends StatelessWidget {
  final String title;
  final ValueChanged<T?> onChanged;
  final FormFieldSetter<T>? onSaved;
  final List<T> dataList;
  final String Function(T data)? item;
  final double? width;
  final T? value;
  final double? textFontSize;
  final FormFieldValidator? validator;

  const CustomDropdownTextField({
    Key? key,
    required this.title,
    required this.dataList,
    required this.item,
    required this.onChanged,
    this.onSaved,
    this.validator,
    this.width,
    this.value,
    this.textFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return dataList.isNotEmpty
        ? SizedBox(
            width: width,
            child: DropdownButtonFormField<T>(
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              value: value,
              decoration: InputDecoration(
                filled: true,
                hintText: value == null ? '' : item!(value!),
                labelText: title,
                border: const OutlineInputBorder() ,
                enabledBorder: const OutlineInputBorder(
                  borderSide:  BorderSide(color: AppColors.borderColor),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide:  BorderSide(color: AppColors.borderColor),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide:  BorderSide(color: AppColors.borderColor),
                ),
                hintStyle: AppTextStyle.regularStyle.copyWith(
                  fontSize: textFontSize ?? Dimens.fontSize14,
                  color: AppColors.mineShaft,
                ),
                floatingLabelBehavior: value == null || item == null
                    ? FloatingLabelBehavior.never
                    : FloatingLabelBehavior.always,
                fillColor: Colors.white,
                contentPadding:const EdgeInsets.symmetric(horizontal: 12),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validator,
              onChanged: onChanged,
              onSaved: onSaved,
              items: dataList
                  .map<DropdownMenuItem<T>>(
                    (e) => DropdownMenuItem<T>(
                      value: e,
                      child: Text(
                        item!(e),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.regularStyle.copyWith(
                          fontSize: textFontSize ?? Dimens.fontSize14,
                          color: AppColors.mineShaft,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
        : const SizedBox.shrink();
  }
}
