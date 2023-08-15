import 'package:food_express/model/response_model.dart';
import 'package:get/get.dart';
import 'package:food_express/data/repo/auth_repo.dart';
import '../model/auth_model.dart';

class AuthController extends GetxController {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registerUser(AuthModel user) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registerUser(user.toMap());
    late ResponseModel responseModel;
    if (response.statusCode! == 200) {
      responseModel = ResponseModel(true, response.body['_id']);
      authRepo.saveFcmToken(user.fcmToken!);
    } else if (response.statusCode == 409) {
      responseModel = ResponseModel(false, response.body['message']);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> loginUser(AuthModel user) async {
    _isLoading = true;
    update();
    Response response = await authRepo.loginUser(user.toMap());
    late ResponseModel responseModel;
    if (response.statusCode! == 200) {
      responseModel = ResponseModel(true, response.body['token']);
      authRepo.saveUserToken(response.body['token']);
      authRepo.saveFcmToken(user.fcmToken!);
      authRepo.saveId(response.body['userId']);
    } else if (response.statusCode == 401) {
      responseModel = ResponseModel(false, response.body['message']);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  bool isUserLoggedIn() {
    return authRepo.isUserLoggedIn();
  }

  void logoutUser() {
    authRepo.logoutUser();
  }
}
