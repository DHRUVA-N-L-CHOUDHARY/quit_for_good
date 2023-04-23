import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quit_for_good/widgets/Custom_button.dart';
import 'package:quit_for_good/models/ngo_model.dart';
import 'package:quit_for_good/utils/Colors.dart';
import 'package:quit_for_good/utils/String.dart';
import 'package:quit_for_good/views/Donation/Payment_option.dart';
import 'package:quit_for_good/widgets/custom_app_bar.dart';

class DonateToSocialCommunites extends StatefulWidget {
  const DonateToSocialCommunites({super.key});

  @override
  State<DonateToSocialCommunites> createState() =>
      _DonateToSocialCommunitesState();
}

class _DonateToSocialCommunitesState extends State<DonateToSocialCommunites> {
  Future<List<NgodetailsModel>> getStarted_readData() async {
    List<NgodetailsModel> productList = [];
    print("sdjkfhldskfhd");
    await FirebaseFirestore.instance
        .collection("ngos")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((product) {
        var _product = product.data();
        print(_product);
        productList.add(NgodetailsModel.fromJson(_product));
      });
    });
    print(productList);
    return productList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Quit for Good",
      ),
      body: ListView(
        children: [
          Image.asset(donatengo),
          Center(
              child: Text(
            "Donate to NGO or Social Communities",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          )),
          SizedBox(
            height: 20.h,
          ),
          FutureBuilder<List<NgodetailsModel>>(
              future: getStarted_readData(),
              builder: (context, snapshot) {
                print(snapshot.data);
                if (snapshot.hasData) {
                  List<NgodetailsModel> productList = snapshot.data ?? [];
                  print(productList);
                  return Container(
                    height: (productList.length * 70).h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: productList.length,
                      itemBuilder: ((context, index) {
                        return dontaecard(
                            productList[index].name.toString(),
                            productList[index].description.toString(),
                            100,
                            "9353478558",
                            "");
                      }),
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
          // dontaecard("NGO 1", "ABCD", 100, "9353478558", ""),
        ],
      ),
    );
  }

  Widget dontaecard(String nameoftitle, String description, double ordervalue,
      String phonenumb, String desc) {
    return Container(
      width: 360.w,
      child: ListTile(
        subtitle: Text(description),
        title: Text(nameoftitle),
        trailing: Custombutton(
            customwidth: 100.w,
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
            text: "Pay",
            inputcolor: kPrimaryColor,
            press: () {
              Get.to(() => PaymentOption(
                    desc: desc,
                    nameoftitle: nameoftitle,
                    orderval: ordervalue,
                    phonenumb: phonenumb,
                  ));
            }),
      ),
    );
  }
}
