import 'package:casino/global_widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:get_upi/get_upi.dart';

class Payment extends StatelessWidget {
  const Payment({
    this.upiAppsListAndroid,
    super.key});
  final List<UpiObject>? upiAppsListAndroid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 500,
        width: double.infinity,
        child: Column(
          children: [
            getUpiApps(),
            const SizedBox(height: 20,),
            getNetBanking(),
        ],),
      ),
    );
  }

  Widget getUpiApps() {
    return  SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 5,
         child: Padding(
           padding: EdgeInsets.all(8.0),
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
             children: [
              CasinoText(text: 'Upi Payment'),
              SizedBox(height: 20,),
               Wrap (
            children: upiAppsListAndroid!.map<Widget>((UpiObject app) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onTap: () {
                  //  openUPI(app);
                  },
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15,bottom: 5),
                        child: Image.asset(
                          app.icon,
                          repeat: ImageRepeat.noRepeat,
                          height: 30,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Text(app.name,softWrap: true,style: const TextStyle(fontSize: 12),),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
             ],
           ),
         ),
      ),
    );
  }

    Widget getNetBanking() {
    return const SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 5,
         child: Padding(
           padding: EdgeInsets.all(8.0),
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
             children: [
              CasinoText(text: 'Net Banking'),
              SizedBox(height: 20,),
             ],
           ),
         ),
      ),
    );
  }
}