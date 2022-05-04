//third party libs
export 'dart:async';
export 'dart:convert';
export 'package:get/get.dart';
export 'package:flutter/services.dart';
export 'package:get_storage/get_storage.dart';
export 'package:flutter/material.dart';
export 'package:flutter_spinkit/flutter_spinkit.dart';
export 'package:flutter_svg/flutter_svg.dart';
export 'package:url_launcher/url_launcher.dart';
export 'package:uuid/uuid.dart';
//app commons
//storage
export 'package:deposits_oneclick_checkout/app/common/storage/storage.dart';
//utils folder
export 'package:deposits_oneclick_checkout/app/common/utils/utils.dart';
export 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';
export 'package:deposits_oneclick_checkout/app/common/utils/validators.dart';
export 'package:deposits_oneclick_checkout/app/common/utils/payment_card.dart';
export 'package:deposits_oneclick_checkout/app/common/utils/number_formatter.dart';
export 'package:deposits_oneclick_checkout/app/common/utils/card_input_formatter.dart';
export 'package:deposits_oneclick_checkout/app/common/utils/extensions.dart';
//global
export 'package:deposits_oneclick_checkout/app/common/global/deposits_oneclick_checkout_controller.dart';
//services
export 'package:deposits_oneclick_checkout/app/services/fingerprintjs.dart';
export 'package:deposits_oneclick_checkout/app/services/dio_client.dart';
export 'package:deposits_oneclick_checkout/app/services/logging.dart';
//values
export 'package:deposits_oneclick_checkout/app/common/values/app_colors.dart';
export 'package:deposits_oneclick_checkout/app/common/values/strings.dart';
export 'package:deposits_oneclick_checkout/app/common/values/dimens.dart';
export 'package:deposits_oneclick_checkout/app/common/values/app_spacing.dart';
export 'package:deposits_oneclick_checkout/app/common/values/app_text_style.dart';
export 'package:deposits_oneclick_checkout/app/common/values/theme.dart';
export 'package:deposits_oneclick_checkout/app/common/values/constants.dart';
export 'package:deposits_oneclick_checkout/app/common/values/app_images.dart';
//model
export 'package:deposits_oneclick_checkout/app/model/charge_funds_source/charge_funds_response.dart';
export 'package:deposits_oneclick_checkout/app/model/mailing_address/create_address_response.dart';
export 'package:deposits_oneclick_checkout/app/model/mailing_address/get_address_response.dart';
export 'package:deposits_oneclick_checkout/app/model/mailing_address/delete_address_response.dart';
export 'package:deposits_oneclick_checkout/app/model/mailing_address/get_single_address_response.dart';
export 'package:deposits_oneclick_checkout/app/model/mailing_address/set_default_address_response.dart';
export 'package:deposits_oneclick_checkout/app/model/mailing_address/update_address_response.dart';
export 'package:deposits_oneclick_checkout/app/model/resend_otp/resend_otp.dart';
export 'package:deposits_oneclick_checkout/app/model/verify_user/verify_user_response.dart';
export 'package:deposits_oneclick_checkout/app/model/linked/linked_response.dart';
export 'package:deposits_oneclick_checkout/app/model/tokenize_card/tokenise_card.dart';
export 'package:deposits_oneclick_checkout/app/model/add_bank/add_bank_response.dart';
export 'package:deposits_oneclick_checkout/app/model/charge_funds_source/delete_funds_response.dart';
export 'package:deposits_oneclick_checkout/app/model/get_funding_source/get_funding_response.dart';

export 'package:deposits_oneclick_checkout/app/model/get_funding_source/meta_data_json.dart';
export 'package:deposits_oneclick_checkout/app/model/get_funding_source/issuer.dart';
export 'package:deposits_oneclick_checkout/app/model/get_funding_source/bank_account.dart';
export 'package:deposits_oneclick_checkout/app/model/get_funding_source/card.dart';


//app modules
//pay with deposit button
export 'package:deposits_oneclick_checkout/app/modules/deposits_oneclick_checkout_button.dart';
//payment successful
export 'package:deposits_oneclick_checkout/app/modules/successful/successful.dart';
//login
export 'package:deposits_oneclick_checkout/app/modules/login/login.dart';
export 'package:deposits_oneclick_checkout/app/modules/login/login_controller.dart';
export 'package:deposits_oneclick_checkout/app/modules/login/login_binding.dart';
//confirm otp
export 'package:deposits_oneclick_checkout/app/modules/confirm_otp/confirm_otp.dart';
export 'package:deposits_oneclick_checkout/app/modules/confirm_otp/confirm_otp_controller.dart';
export 'package:deposits_oneclick_checkout/app/modules/confirm_otp/confirm_otp_binding.dart';
//pay with bank card
export 'package:deposits_oneclick_checkout/app/modules/pay_with_bank_card/pay_with_bank_card.dart';
export 'package:deposits_oneclick_checkout/app/modules/pay_with_bank_card/pay_with_bank_card_controller.dart';
export 'package:deposits_oneclick_checkout/app/modules/pay_with_bank_card/pay_with_bank_card_binding.dart';
//pay with card
export 'package:deposits_oneclick_checkout/app/modules/pay_with_card/pay_with_card.dart';
export 'package:deposits_oneclick_checkout/app/modules/pay_with_card/pay_with_card_controller.dart';
export 'package:deposits_oneclick_checkout/app/modules/pay_with_card/pay_with_card_binding.dart';
//manage deposit id
export 'package:deposits_oneclick_checkout/app/modules/manage_deposit_id/manage_deposit_id.dart';
export 'package:deposits_oneclick_checkout/app/modules/manage_deposit_id/manage_deposit_id_controller.dart';
export 'package:deposits_oneclick_checkout/app/modules/manage_deposit_id/manage_deposit_id_binding.dart';
// profile
export 'package:deposits_oneclick_checkout/app/modules/user_profile/profile/profile.dart';
export 'package:deposits_oneclick_checkout/app/modules/user_profile/profile/profile_controller.dart';
export 'package:deposits_oneclick_checkout/app/modules/user_profile/profile/profile_binding.dart';
//edit profile
export 'package:deposits_oneclick_checkout/app/modules/user_profile/edit_profile/edit_profile.dart';
export 'package:deposits_oneclick_checkout/app/modules/user_profile/edit_profile/edit_profile_controller.dart';
export 'package:deposits_oneclick_checkout/app/modules/user_profile/edit_profile/edit_profile_binding.dart';
//address
export 'package:deposits_oneclick_checkout/app/modules/address/address/address.dart';
export 'package:deposits_oneclick_checkout/app/modules/address/address/address_binding.dart';
export 'package:deposits_oneclick_checkout/app/modules/address/address/address_controller.dart';
//add bank
export 'package:deposits_oneclick_checkout/app/modules/payment/add_bank/add_bank.dart';
export 'package:deposits_oneclick_checkout/app/modules/payment/add_bank/add_bank_controller.dart';
export 'package:deposits_oneclick_checkout/app/modules/payment/add_bank/add_bank_binding.dart';
//add address
export 'package:deposits_oneclick_checkout/app/modules/address/add_address/add_address.dart';
export 'package:deposits_oneclick_checkout/app/modules/address/add_address/add_address_controller.dart';
export 'package:deposits_oneclick_checkout/app/modules/address/add_address/add_address_binding.dart';
//edit address
export 'package:deposits_oneclick_checkout/app/modules/address/edit_address/edit_address.dart';
export 'package:deposits_oneclick_checkout/app/modules/address/edit_address/edit_address_controller.dart';
export 'package:deposits_oneclick_checkout/app/modules/address/edit_address/edit_address_binding.dart';
//payment
export 'package:deposits_oneclick_checkout/app/modules/payment/payment/payment.dart';
export 'package:deposits_oneclick_checkout/app/modules/payment/payment/payment_controller.dart';
export 'package:deposits_oneclick_checkout/app/modules/payment/payment/payment_binding.dart';
//success
export 'package:deposits_oneclick_checkout/app/modules/successful/successful.dart';
export 'package:deposits_oneclick_checkout/app/modules/successful/successful_controller.dart';
//add new card
export 'package:deposits_oneclick_checkout/app/modules/payment/add_new_card/add_new_card.dart';
export 'package:deposits_oneclick_checkout/app/modules/payment/add_new_card/add_new_card_controller.dart';
export 'package:deposits_oneclick_checkout/app/modules/payment/add_new_card/add_new_card_binding.dart';
//google places
export 'package:deposits_oneclick_checkout/app/modules/google_search/place_service.dart';
export 'package:deposits_oneclick_checkout/app/modules/google_search/address_search.dart';

//linked
export 'package:deposits_oneclick_checkout/app/modules/linked/linked/linked.dart';
export 'package:deposits_oneclick_checkout/app/modules/linked/linked/linked_controller.dart';
export 'package:deposits_oneclick_checkout/app/modules/linked/linked/linked_binding.dart';
//linked details
export 'package:deposits_oneclick_checkout/app/modules/linked/linked_details/linked_details.dart';
export 'package:deposits_oneclick_checkout/app/modules/linked/linked_details/linked_details_controller.dart';
export 'package:deposits_oneclick_checkout/app/modules/linked/linked_details/linked_details_binding.dart';
//custom widgets
export 'package:deposits_oneclick_checkout/app/widgets/custom_elevated_button.dart';
export 'package:deposits_oneclick_checkout/app/widgets/custom_rich_text_widget.dart';
export 'package:deposits_oneclick_checkout/app/widgets/custom_text_field_widget.dart';
export 'package:deposits_oneclick_checkout/app/widgets/custom_inkwell_widget.dart';
export 'package:deposits_oneclick_checkout/app/widgets/custom_back_button.dart';
export 'package:deposits_oneclick_checkout/app/widgets/custom_close_button.dart';
export 'package:deposits_oneclick_checkout/app/widgets/custom_appbar_widget.dart';
export 'package:deposits_oneclick_checkout/app/widgets/custom_text.dart';
export 'package:deposits_oneclick_checkout/app/widgets/custom_text_button.dart';
export 'package:deposits_oneclick_checkout/app/widgets/custom_row_text_widget.dart';
export 'package:deposits_oneclick_checkout/app/widgets/custom_dropdown_textfield.dart';
export 'package:deposits_oneclick_checkout/app/widgets/custom_horizontal_line.dart';
export 'package:deposits_oneclick_checkout/app/widgets/custom_text_tag.dart';
export 'package:deposits_oneclick_checkout/app/widgets/custom_listtile_widget.dart';
export 'package:deposits_oneclick_checkout/app/widgets/custom_image_loader.dart';
export 'package:deposits_oneclick_checkout/app/widgets/custom_svg_image_loader.dart';
export 'package:deposits_oneclick_checkout/app/widgets/custom_internet_retry.dart';
export 'package:deposits_oneclick_checkout/app/widgets/custom_country_state_picker.dart';
