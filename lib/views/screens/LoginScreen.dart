import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:winninbets/constants/colors.dart';
import 'package:winninbets/controller/AuthController.dart';
import 'package:winninbets/models/AuthToken.dart';
import 'package:winninbets/models/UserLogin.dart';
import 'package:winninbets/views/components/ButtonRounded.dart';
import 'package:winninbets/views/components/InputBox.dart';
import 'package:winninbets/views/components/InputLabel.dart';
import 'package:winninbets/views/components/LinkLabel.dart';
import 'package:winninbets/views/screens/RegisterScreen.dart';
import 'package:http/http.dart' as http;

import 'HomeScreen.dart';

class LoginScreen extends StatelessWidget {

  var _email, _password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
                child: Center(
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
              Container(
                  padding: EdgeInsets.all(50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  fontSize: 26,
                                  color: clrPrimary,
                                  fontFamily: 'Visby CF',
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w700
                              ),
                              children: <TextSpan>[
                                TextSpan(text: 'Hello,\n'),
                                TextSpan(text: 'login to proceed')
                              ]
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10,),
                            InputLabel(labelText: "Enter your email address here"),
                            SizedBox(height: 7,),
                            InputBox(changed: (text){
                                _email = text.toString();
                            }, icon: "assets/icons/ic_user.svg",hint: "example@email.com", secureText:false),
                            SizedBox(height: 20,),
                            InputLabel(labelText: "Enter your password",),
                            SizedBox(height: 7,),
                            InputBox(changed: (text){
                                _password = text.toString();
                            }, icon:"assets/icons/ic_lock.svg",hint:"Password", secureText:true),
                            SizedBox(height: 10,),
                            LinkLabel(labelText: "Forgot password ?"),
                            Center(
                              child: ButtonRounded(text: "Login", onTap: () async{
                                var userToLogin = new UserLogin(_email, _password);
                                var loginResponse = await http.post('http://192.168.43.69:8000/api/users/login/', body: json.encode(userToLogin));
                                if(loginResponse.statusCode == 200) {
                                  var authToken = new AuthToken.fromJson(json.decode(loginResponse.body));

//                                  await fss.write(key: 'token', value: authToken.token);
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context){
                                      return HomeScreen();
                                    }
                                  ));
                                }

                              },),
                            ),
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Expanded(
                                    child: Text("Don't yet have an account ?", style: TextStyle(
                                      fontWeight: FontWeight.w700
                                    ),),
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: LinkLabel(labelText: "Register here", press: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return RegisterScreen();
                                        }
                                      ));
                                    }),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}

