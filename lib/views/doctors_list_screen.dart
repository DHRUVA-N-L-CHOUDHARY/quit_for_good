import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quit_for_good/models/Doctor_details_model.dart';
import 'package:quit_for_good/widgets/custom_doctor_card.dart';

class DoctorsListScreen extends StatefulWidget {
  const DoctorsListScreen({super.key});

  @override
  State<DoctorsListScreen> createState() => _DoctorsListScreenState();
}

class _DoctorsListScreenState extends State<DoctorsListScreen> {
  Future<List<DoctorDetailsModel>> readCartData1() async {
    List<DoctorDetailsModel> productList = [];
    await FirebaseFirestore.instance
        .collection("doctors")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((product) {
        var _product = product.data();
        print(_product);
        productList.add(DoctorDetailsModel.fromJson(_product));
      });
    });
    print("pdhfdlkfdsjf");
    print(productList[0]);
    return productList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.only(
                right: 20.0, left: 20.0, bottom: 10.0, top: 10.0),
            width: MediaQuery.of(context).size.width - 10,
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder<List<DoctorDetailsModel>>(
                future: readCartData1(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<DoctorDetailsModel> productList = snapshot.data ?? [];
                    print(productList);
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 1,
                      ),
                      itemCount: productList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return DoctorCard(
                          imgPath: productList[index].img ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCLU17In7zzDrseM4vWUoAlSgi-82B6pO9hg&usqp=CAU",
                          name: productList[index].name ?? "John",
                          description: productList[index].descri ??
                              "Special of Pyshcartrics",
                        );
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                })));
  }
}
