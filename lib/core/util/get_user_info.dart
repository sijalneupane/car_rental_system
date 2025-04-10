import 'package:shared_preferences/shared_preferences.dart';

class  GetUserInfo {
  static Future<String?> getUserId() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    String? userId=prefs.getString("userId");
    if(userId!=null){
      return userId ;
    }else{
      return null;
    }
  }
}