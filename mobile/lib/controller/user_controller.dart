import 'package:food_express/data/repo/user_repo.dart';
import 'package:food_express/model/user_model.dart';
import 'package:get/get.dart';
import '../model/response_model.dart';

class UserController extends GetxController {
  final UserRepo userRepo;
  UserController({required this.userRepo});

  bool _isloading = false;
  bool get isloading => _isloading;

  late UserModel _userModel;
  UserModel get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {
    _isloading = true;
    update();
    String userId = userRepo.getUserId();
    Response response = await userRepo.getUserInfo(userId);
    print(userId);
    late ResponseModel responseModel;
    print('Testing: ${response.body}');
    if (response.statusCode == 200) {
      _userModel = UserModel.fromMap(response.body);
      responseModel = ResponseModel(true, 'Succesfully');
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isloading = false;
    update();
    return responseModel;
  }
}
