
import 'package:casino/global_widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/constants/colors.dart';
import 'controller.dart';
class UserLogin extends GetView<UserLoginController> {
  const UserLogin({super.key});
  Widget spacer(){
    return const SizedBox(height: 20,);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserLoginController>(
      builder: (context) {
        return Scaffold(
          body:    SafeArea(
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: CasinoColors.secondary,
                  child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 60,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                // gradient: LinearGradient(colors: [
                                //   Color.fromARGB(255, 25, 23, 23),
                                //   Color.fromARGB(255, 54, 53, 53),
                                //   Color.fromARGB(255, 25, 23, 23),
                                // ])
                              ),
                              child: const Center(
                                child: Text("Login User", style: TextStyle(color: CasinoColors.primary, fontSize: 20, fontWeight: FontWeight.bold),),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 400,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/background.jpg',),
                                  fit: BoxFit.fill
                                )
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: CasinoColors.primary,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(223, 218, 122, 0.2),
                                          blurRadius: 20.0,
                                          offset: Offset(0, 10)
                                        )
                                      ]
                                    ),
                                    child: Container(
                                          height: 50,
                                          padding: const EdgeInsets.all(4.0),
                                          child:  TextField(
                                            controller: controller.userId,
                                           // keyboardType: TextInputType.phone,
                                            cursorColor: Colors.black,
                                            style: const TextStyle(color: CasinoColors.secondary,fontWeight: FontWeight.bold),
                                            // inputFormatters:[
                                            //   LengthLimitingTextInputFormatter(10),
                                            // ],
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Enter user id",
                                              hintStyle: TextStyle(color: CasinoColors.secondary,fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ),
                                  ),
                                  const SizedBox(height: 40,),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: CasinoColors.primary,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(223, 218, 122, 0.2),
                                          blurRadius: 20.0,
                                          offset: Offset(0, 10)
                                        )
                                      ]
                                    ),
                                    child: Container(
                                          height: 50,
                                          padding: const EdgeInsets.all(4.0),
                                          child:  TextField(
                                            controller: controller.password,
                                           // keyboardType: TextInputType.phone,
                                            cursorColor: Colors.black,
                                            style: const TextStyle(color: CasinoColors.secondary,fontWeight: FontWeight.bold),
                                            // inputFormatters:[
                                            //   LengthLimitingTextInputFormatter(10),
                                            // ],
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Enter password",
                                              hintStyle: TextStyle(color: CasinoColors.secondary,fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ),
                                  ),
                                  const SizedBox(height: 40,),
 
                                  CasinoButton(
                                    height: 50,
                                    width: 200,
                                    title: 'Login',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    onTap: controller.getUserLogin,
                
                                  ),
                                  
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                ),
              ],
            ),
          )      );
      }
    );
  }
}