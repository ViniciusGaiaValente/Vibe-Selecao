import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesController {

  static checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  static getCpf() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cpf = prefs.getString("cpf");
    return cpf;
  }

  static setCpf([String cpf]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('cpf', cpf)
        .then((res) {
      return res;
    }).catchError((err) {
      return err;
    });
  }

  static getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    return token;
  }

  static setToken([String token]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token)
        .then((res) {
          return res;
        })
        .catchError((err) {
          return err;
        });
  }

  static getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String list = prefs.getString("list");
    return list;
  }

  static setList([String list]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('list', list)
      .then((res) {
        return res;
      })
      .catchError((err) {
        return err;
      });
  }
}