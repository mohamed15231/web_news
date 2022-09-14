import 'package:shared_preferences/shared_preferences.dart';

class SaveData{
  static SharedPreferences? sharedPreferences;

  static Future init()async{
    sharedPreferences=await SharedPreferences.getInstance();
  }
  static void setData({
    required String key,
    required bool value,
})async{
       await sharedPreferences?.setBool(key,value);

  }

  static bool? getData({
    required String key,
}){
    return sharedPreferences?.getBool(key);
  }

}