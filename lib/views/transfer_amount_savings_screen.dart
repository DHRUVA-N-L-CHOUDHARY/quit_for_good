import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quit_for_good/controllers/donation_controller.dart';
import 'package:quit_for_good/controllers/savings_payment_controller.dart';
import 'package:quit_for_good/models/Donation_payment_model.dart';
import 'package:quit_for_good/models/Savings_payment_model.dart';
import 'package:quit_for_good/utils/Colors.dart';
import 'package:quit_for_good/utils/String.dart';
import 'package:quit_for_good/widgets/custom_input_field.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class TransferAmountSavingsScreen extends StatefulWidget {
  final String nameoftitle;
  final String phonenumb;
  final double orderval;
  final String desc;
  const TransferAmountSavingsScreen(
      {super.key,
      required this.nameoftitle,
      required this.phonenumb,
      required this.orderval,
      required this.desc});

  @override
  State<TransferAmountSavingsScreen> createState() =>
      _TransferAmountSavingsScreenState();
}

class _TransferAmountSavingsScreenState
    extends State<TransferAmountSavingsScreen> {
  TextEditingController _controller = TextEditingController();
   final GlobalKey<FormState> detailskey = GlobalKey<FormState>();

  void clear() {
    _controller.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  final _razorpay = Razorpay();
  String getCustomUniqueId() {
    const String pushChars =
        '-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz';
    int lastPushTime = 0;
    List lastRandChars = [];
    int now = DateTime.now().millisecondsSinceEpoch;
    bool duplicateTime = (now == lastPushTime);
    lastPushTime = now;
    List timeStampChars = List<String>.filled(8, '0');
    for (int i = 7; i >= 0; i--) {
      timeStampChars[i] = pushChars[now % 64];
      now = (now / 64).floor();
    }
    if (now != 0) {
      print("Id should be unique");
    }
    String uniqueId = timeStampChars.join('');
    if (!duplicateTime) {
      for (int i = 0; i < 12; i++) {
        lastRandChars.add((Random().nextDouble() * 64).floor());
      }
    } else {
      int i = 0;
      for (int i = 11; i >= 0 && lastRandChars[i] == 63; i--) {
        lastRandChars[i] = 0;
      }
      lastRandChars[i]++;
    }
    for (int i = 0; i < 8; i++) {
      uniqueId += pushChars[lastRandChars[i]];
    }
    return uniqueId;
  }

  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSucess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }
  double valp = 0.0;
  void _handlePaymentSucess(PaymentSuccessResponse response) async {
    SavingsPaymentController controller = SavingsPaymentController();
    SavingsPaymentModel model = SavingsPaymentModel(
        amttrfs: widget.orderval.toString(),
        time: DateTime.now().toString(),
        totalamttrs: valp.toString(),
        trsid: getCustomUniqueId());
    await controller.addUserInfo(model);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("");
  }

  void payonline() {
    if(detailskey.currentState!.validate())
    {
    var name = widget.nameoftitle;
    var phonenumber = widget.phonenumb;
    final double valq = 10;
    var options = {
      'key': 'rzp_test_FBmQayuj43JfRI',
      'amount': valq * 100.0,
      'name': name,
      'description': widget.desc,
      'prefill': {'contact': phonenumber, 'email': 'lci2021014@iiitl.ac.in'}
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
    }
    else{
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: detailskey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(savings),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
              child: TextFormField(
                initialValue: widget.orderval.toString(),
                onSaved: (value) {
                  valp = double.parse(value ?? "0.0");
                },
                validator: (value) {
                  if(value == null)
                  {
                    return "Enter Valid Value";
                  }
                  else{
                    return null;
                  }
                },
                style: TextStyle(fontStyle: FontStyle.italic),
                decoration: InputDecoration(
                  prefix: Container(width: 5.h,),
                  labelText: "Enter the amount you would like to save",
                  labelStyle: TextStyle(fontStyle: FontStyle.italic, color: kPrimaryColor),
                  hintText: "Enter the amount",
                  hintStyle: TextStyle(fontStyle: FontStyle.italic, color: kPrimaryColor),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor)
                  )
                ),
              ),
              // CustomInputField(
              //     controller: _controller,
              //     textInputType: TextInputType.number,
              //     hintText: "Enter the amount you would like to Save"),
            ),
            paythrgh("Pay Online", () {
               clear();
                    FocusManager.instance.primaryFocus?.unfocus();
              payonline();
            }),
          ],
        ),
      ),
    );
  }

  Widget paythrgh(String inptxt, Function press) {
    return InkWell(
      onTap: press as void Function(),
      child: Container(
         decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: kPrimaryColor),
        width: 200.w,
        child: Padding(
          padding: const EdgeInsets.all(15.0).h,
          child: Text(
            inptxt,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: kContrColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
