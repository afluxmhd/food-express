import 'package:flutter/material.dart';
import 'package:food_express/data/repo/promo_code_repo.dart';
import 'package:food_express/model/promo_code_model.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';

class PromoCodeController extends GetxController {
  final PromoCodeRepo promoCodeRepo;
  PromoCodeController({required this.promoCodeRepo});

  List<PromoCodeModel> _promocodeList = [];
  List<PromoCodeModel> get promocodeList => _promocodeList;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _isPromoCodeActive = false;
  bool get isPromoCodeActive => _isLoading;

  double _discountPercentage = 0.0;
  double get discountPercentage => _discountPercentage;

  double _discountValue = 0.0;
  double get discountValue => _discountValue;

  Future getPromoCodeList() async {
    _isLoading = true;
    update();
    Response response = await promoCodeRepo.getPromocodesList();
    if (response.statusCode == 200) {
      _promocodeList = [];
      for (dynamic json in response.body) {
        _promocodeList.add(PromoCodeModel.fromMap(json));
      }
    }
    _isLoading = false;
    update();
  }

  void applyPromoCode(String code) {
    for (PromoCodeModel promoCode in _promocodeList) {
      if (promoCode.code == code) {
        if (_isPromoCodeActive) {
          if (promoCode.isApplied == true) {
            promoCode.isApplied = false;
            _isPromoCodeActive = false;
            _discountPercentage = 0;
            update();
          } else {
            Get.snackbar("Promo Code", "You can only use one promo code at a time",
                backgroundColor: AppColors.mainColor, colorText: Colors.white);
          }
        } else {
          _isPromoCodeActive = true;
          promoCode.isApplied = true;
          _discountPercentage = promoCode.discountPercentage.toDouble();
          Get.snackbar("Promo Code", "Code applied successfully", backgroundColor: AppColors.mainColor, colorText: Colors.white);
          update();
        }
        update();
      }
    }
  }

  double getSelectedPromoDiscount(double subTotal) {
    double discountValue = 0;
    discountValue = subTotal * _discountPercentage / 100.00;
    _discountValue = discountValue;
    update();
    print('Discount Value: $discountValue');
    return discountValue;
  }
}
