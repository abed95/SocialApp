import 'package:socialapp/shared/components/components.dart';
import '../../modules/login/login_screen.dart';
import '../network/local/cache_helper.dart';

void signOut(context){
  CacheHelper.deleteUserData().then((onValue){
      navigateAndFinish(context, LoginScreen());
  });
}

void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}

bool isDark = false;
