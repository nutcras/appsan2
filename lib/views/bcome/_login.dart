import 'package:creative/configs/config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/api.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool hidepassword = true;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkToken1();
  }

  checkToken1() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') != null) {
      headers?['Authorization'] = "bearer ${prefs.getString('token')}";
      Navigator.pushNamedAndRemoveUntil(
          context, "/MainPage", (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AppMentor'),
          backgroundColor: const Color.fromARGB(255, 160, 42, 207),
        ),
        backgroundColor: Colors.purple.shade50,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(13),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(children: [
                    const SizedBox(
                      height: 30,
                    ),
                    // Icon(Icons.wheelchair_pickup, size: 50),
                    const Text(
                      'Login Account',
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'appication for mentor',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Form(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 250.0,
                              width: 380.0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 25.0,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(25.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      TextField(
                                        controller: username,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 17),
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.purple.shade100,
                                            labelText: 'username',
                                            hintText: 'ชื่อผู้ใช้',
                                            hintStyle: const TextStyle(
                                                color: Colors.purple),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.purple,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50)),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide(
                                                            color: Colors
                                                                .purple,
                                                            width: 2.5),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                100))),
                                            prefixIcon: const Icon(
                                              Icons.account_circle,
                                              size: 30,
                                              color: Colors.purple,
                                            )),
                                      ),
                                      const SizedBox(height: 20),
                                      TextField(
                                          controller: password,
                                          obscureText: hidepassword,
                                          // ignore: prefer_const_constructors
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.purple.shade100,
                                              labelText: 'password',
                                              hintText: 'รหัสผ่าน',
                                              hintStyle: const TextStyle(
                                                  color: Colors.purple),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.purple),
                                                      borderRadius: BorderRadius
                                                          .all(Radius
                                                              .circular(50))),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.purple,
                                                    width: 2.5),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(100)),
                                              ),
                                              prefixIcon: const Icon(
                                                Icons.lock,
                                                size: 30,
                                                color: Colors.purple,
                                              ),
                                              suffixIcon: IconButton(
                                                  onPressed: (() {
                                                    setState(() {
                                                      hidepassword =
                                                          !hidepassword;
                                                    });
                                                  }),
                                                  icon: Icon(
                                                    hidepassword
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                    size: 30,
                                                    color: Colors.purple,
                                                  )))),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          const Text(
                                            'Foeget Password ?',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () async {
                        await checkLogin(username.text, password.text, context);
                        // Navigator.pushNamedAndRemoveUntil(context,
                        //     "/Page1", (Route<dynamic> route) => false);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        primary: Colors.purple,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'or',
                      style: TextStyle(color: Colors.purple),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/PageOne");
                        // Navigator.pushNamed(context, "/PageOne");
                      },
                      child: const Text('Register',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        primary: Colors.purple,
                      ),
                    )
                  ])),
            ),
          ),
        ));
  }
}
