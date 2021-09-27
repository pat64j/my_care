
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_care/src/repos/user_repo.dart';
import 'package:my_care/src/validations/signup_validation.dart';


final signUpValidationProvider = ChangeNotifierProvider<SignUpValidation>(
        (ref) => SignUpValidation()
);

final userRepoProvider = ChangeNotifierProvider<UserRepository>((ref){
  return UserRepository.instance();
});