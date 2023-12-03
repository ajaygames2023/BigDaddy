
import 'package:casino/global_widgets/buttons.dart';
import 'package:casino/global_widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/constants/colors.dart';
import 'controller.dart';
class UserLogin extends GetView<UserLoginController> {
  UserLogin({super.key});
  Widget spacer(){
    return const SizedBox(height: 20,);
  }
  @override
  final controller = Get.put(UserLoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CasinoColors.secondary,
        centerTitle: true,
        title: const CasinoText(text: 'Login User',fontSize: 20,color: CasinoColors.primary,fontWeight: FontWeight.bold,),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.jpg',),
                    fit: BoxFit.fill
                  )
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        color: CasinoColors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Form(
                        key: controller.formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.height * 0.5,
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
                                      padding: const EdgeInsets.all(4.0),
                                      child:  TextFormField(
                                        controller: controller.userId,
                                       // keyboardType: TextInputType.phone,
                                        cursorColor: Colors.black,
                                        validator: (val) => val!.length < 3 ? '' : null,
                                        style: const TextStyle(color: CasinoColors.secondary,fontWeight: FontWeight.bold),
                                        decoration: const InputDecoration(
                                          errorText: '',
                                          errorStyle: TextStyle(fontSize: 0.01),
                                          border: InputBorder.none,
                                          hintText: "Enter user id",
                                          hintStyle: TextStyle(color: CasinoColors.secondary,fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ),
                              ),
                              const SizedBox(height: 40,),
                              Container(
                                width: MediaQuery.of(context).size.height * 0.5,
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
                                child: GetBuilder<UserLoginController>(
                                  init: UserLoginController(),
                                  global: false,
                                  builder: (context) {
                                    return Container(
                                          padding: const EdgeInsets.all(4.0),
                                          child:  TextFormField(
                                            controller: controller.password,
                                           // keyboardType: TextInputType.phone,
                                            cursorColor: Colors.black,
                                            obscureText: !context.passwordVisible,
                                            style: const TextStyle(color: CasinoColors.secondary,fontWeight: FontWeight.bold),
                                            // inputFormatters:[
                                            //   LengthLimitingTextInputFormatter(10),
                                            // ],
                                            validator: (val) => val!.length < 6 ? '' : null,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              errorText: '',
                                              errorStyle: const TextStyle(fontSize: 0.01),
                                              hintText: "Enter password",
                                              hintStyle: const TextStyle(color: CasinoColors.secondary,fontWeight: FontWeight.bold),
                                              suffixIcon: IconButton(
                                                  icon: Icon(
                                                    context.passwordVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                    color: CasinoColors.secondary,
                                                    ),
                                                  onPressed: () {
                                                    context.passwordVisible = !context.passwordVisible;
                                                    context.update();
                                                  },
                                                  ),
                                            ),
                                          )
                                        );
                                  }
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
                      ),
                    ),
                  ),
                ),
                ),
            ],
          ),
        ),
      )      );
  }
}