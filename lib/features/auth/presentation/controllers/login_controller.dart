import '../../../../utils/command.dart';
import '../../../../utils/result.dart';

class LoginController {
  LoginController() {
    signIn = Command1<void, (String, String)>(_signIn);
    googleSignIn = Command0(_googleSignIn);
  }

  late Command1 signIn;
  late Command0 googleSignIn;

  Future<Result<void>> _signIn((String, String) user) async {
    final (email, password) = user;

    if (email.isEmpty || password.isEmpty) {
      return Result.error(
        Exception('pls fill in email and password')
      );
    }

    // TODO: implement auth repo signin
    await Future.delayed(const Duration(seconds: 2));
    print('sign in {$email} : {$password}'); 

    return Result.ok(null);
  }


  Future<Result<void>> _googleSignIn() async {
    //TODO: implement google sign in

    await Future.delayed(const Duration(seconds: 2));
    print('google sign in'); 

    return Result.ok(null);
  }
}
