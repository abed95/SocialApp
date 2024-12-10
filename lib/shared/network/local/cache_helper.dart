import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialapp/models/user_model/user_model.dart';

class CacheHelper {
  static UserModel? userModel= null;
  static late SharedPreferences sharedPreference;
  static init() async {
    sharedPreference = await SharedPreferences.getInstance();
  }

  //one time object
  static dynamic getData({required String key}){
    return sharedPreference.get(key);
  }

  // Save data to shared
  static Future<bool?> saveData({
    required String key,
    required dynamic value,
}) async{
    if(value is String) return await sharedPreference.setString(key, value);
    if(value is int) return await sharedPreference.setInt(key, value);
    if(value is bool) return await sharedPreference.setBool(key, value);

    return await sharedPreference.setDouble(key, value);
  }

  //Delete Data from shared
  static Future<bool> removeData({required String key})async{
    return await sharedPreference.remove(key);
}
//Save object of user data as a string in shared
  static Future<void> saveUserData(UserModel? user) async {
    final prefs = await SharedPreferences.getInstance();
    String? userData = jsonEncode(user!.toMap()); // Convert to JSON
    await prefs.setString('user_data', userData);
  }

  static bool isLogin() => sharedPreference.containsKey('user_data') ?? false;

  static Future<UserModel?> getUserDataNew() async {
    final prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user_data');
    print('getUserData: CacheHelper $userData');
    if (userData != null) {
      try{
        Map<String?, dynamic> userMap = jsonDecode(userData); // Deserialize JSON
        userModel = UserModel.fromJson(userMap);
        return userModel;
      }catch(e){
        return null;
      }
    }
    return null;
  }

  //Get user Data
  static Future<UserModel?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user_data');
    print('getUserData: CacheHelper $userData');
    if (userData != null) {
      Map<String?, dynamic> userMap = jsonDecode(userData); // Deserialize JSON
      return UserModel.fromJson(userMap);
    }
    return null;
  }

  // Update User data in shared
 static Future<void> updateUserData({String? name, String? email, String? phone}) async {
    // Step 1: Retrieve the current LoginModel from SharedPreferences
    UserModel? currentUser = await getUserData();
    if (currentUser != null) {
      // Step 2: Update the fields if new values are provided
      currentUser.name = name ?? currentUser.name;
      currentUser.email = email ?? currentUser.email;
      currentUser.phone = phone ?? currentUser.phone;

      // Step 3: Save the updated model back to SharedPreferences
      await saveUserData(currentUser);
    }
  }

  // Remove User Data from SharedPreferences
  static Future<void> deleteUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_data'); // Removes the 'user_data' entry
  }

}
