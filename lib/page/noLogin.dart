
import 'package:face_water_dispenser/component/login/view.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> checkLogin() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool("logined")??false;
}


Future<bool> setLoginInfo(bool logined,String token) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool ok = await prefs.setBool("logined",logined);
  if(!ok){
    return false;
  }
  ok =await prefs.setString("token", token);
  if(!ok){
    return false;
  }
  return true;
}


class NoLoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NoLoginPageState();
  }

}

class _NoLoginPageState extends State<NoLoginPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text('未登录'),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate((content, index) {
                  return LoginCom();
                }, childCount: 1))
          ],
        )
    );
  }
}