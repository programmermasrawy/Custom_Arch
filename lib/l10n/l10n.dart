// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  String translate(String key) {
    switch (key) {
      case 'invalid_code':
        return l10n.invalid_code;
      case 'invalid_password':
        return l10n.invalid_password;
      case 'invalid_building_number':
        return l10n.invalid_building_number;
      case 'invalid_full_name':
        return l10n.invalid_full_name;
      case 'invalid_phone_number':
        return l10n.invalid_phone_number;
      case 'invalid_national_id':
        return l10n.invalid_national_id;
      case 'invalid_passport':
        return l10n.invalid_passport;
      case 'invalid_street_name':
        return l10n.invalid_street_name;
      case 'please_enter_at_least_one_code':
        return l10n.please_enter_at_least_one_code;
      case 'please_complete_voucher':
        return l10n.please_complete_voucher;
      case 'please_choose_gift':
        return l10n.please_choose_gift;

      // case 'invalid_email':
      //   return l10n.invalid_email;
      // case 'invalid_name':
      //   return l10n.invalid_name;
      // case 'invalid_phone_number':
      //   return l10n.invalid_phone_number;
      // case 'invalid_address':
      //   return l10n.invalid_address;
      // case 'invalid_review_text':
      //   return l10n.invalid_review_text;
      // case 'invalid_coupon_parameter':
      //   return l10n.invalid_coupon_parameter;
      // case 'invalid_cvv':
      //   return l10n.invalid_cvv;
      // case 'invalid_body_text':
      //   return l10n.invalid_body_text;
      // case 'invalid_subject_text':
      //   return l10n.invalid_subject_text;
      // case 'invalid_verification_code':
      //   return l10n.invalid_verification_code;
      // case 'invalid_national_id':
      //   return l10n.invalid_national_id;
      // case 'invalid_phone_number':
      //   return l10n.invalid_phone_number;
    }
    return key;
  }
}
