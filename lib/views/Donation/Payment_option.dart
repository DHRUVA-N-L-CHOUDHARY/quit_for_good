import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quit_for_good/controllers/donation_controller.dart';
import 'package:quit_for_good/models/Donation_payment_model.dart';
import 'package:quit_for_good/utils/Colors.dart';
import 'package:quit_for_good/utils/String.dart';
import 'package:quit_for_good/widgets/custom_app_bar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentOption extends StatefulWidget {
  final String nameoftitle;
  final String phonenumb;
  final double orderval;
  final String desc;
  const PaymentOption(
      {super.key,
      required this.nameoftitle,
      required this.phonenumb,
      required this.orderval,
      required this.desc});

  @override
  State<PaymentOption> createState() => _PaymentOptionState();
}

class _PaymentOptionState extends State<PaymentOption> {
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

  void _handlePaymentSucess(PaymentSuccessResponse response) async {
    DonationPaymentController controller = DonationPaymentController();
    DonationPaymentModel model = DonationPaymentModel(
        ngoname: widget.nameoftitle,
        typeofpayment: "online",
        amttrfs: widget.orderval.toString(),
        time: DateTime.now().toString(),
        totalamttrs: widget.orderval.toString(),
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
    var name = widget.nameoftitle;
    var phonenumber = widget.phonenumb;
    var options = {
      'key': 'rzp_test_FBmQayuj43JfRI',
      'amount': widget.orderval * 100.0,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Quit for Good", act: true,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
                "\"Every cigarette you don't smoke is a victory. Celebrate every small step!\"",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontStyle: FontStyle.italic),
              ),
              Image.asset(donatengo,),
            Column(
              children: [
                paythrgh("Pay Via QR Code", () {}),
            paythrgh("Pay Online", () {
              payonline();
            })
            ],
            ),
          ],
        ),
      ),
    );
  }

  Widget paythrgh(String inptxt, Function press) {
    return InkWell(
      onTap: press as void Function(),
      child: Card(
        child: Container(
           decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: kPrimaryColor),
          width: 200.w,
          child: Padding(
            padding: const EdgeInsets.all(8.0).w,
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
      ),
    );
  }
}
