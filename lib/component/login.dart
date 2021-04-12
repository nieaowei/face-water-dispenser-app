

import 'package:flutter/cupertino.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(
        children: [
          Flexible(child: CupertinoTextField(
            placeholder: "账号",
          )),
          Flexible(child: CupertinoTextField(
            placeholder: "密码",
          ))
        ],
      )
    );
  }
}