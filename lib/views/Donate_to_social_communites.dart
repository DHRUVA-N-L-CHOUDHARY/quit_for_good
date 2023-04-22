import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quit_for_good/Custom_button.dart';
import 'package:quit_for_good/views/Chat_screen.dart';
import 'package:quit_for_good/widgets/components/custom_app_bar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class DonateToSocialCommunites extends StatefulWidget {
  const DonateToSocialCommunites({super.key});

  @override
  State<DonateToSocialCommunites> createState() => _DonateToSocialCommunitesState();
}

class _DonateToSocialCommunitesState extends State<DonateToSocialCommunites> {
   final _razorpay = Razorpay();


 void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSucess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

   void _handlePaymentSucess(PaymentSuccessResponse response) async {
    
  }

  void _handlePaymentError(PaymentFailureResponse response) {
   
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Quit for Good",),
      body: ListView(
        children: [
          Center(child: Text("Donate to NGO or Social Communities", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),)),
          SizedBox(
            height: 20.h,
          ),
          dontaecard("NGO 1", "ABCD", 100, "9353478558",""
          ),
          // dontaecard("NGO 1", "ABCD"),
          // dontaecard("NGO 1", "ABCD"),

        ],
      ),
    );
  }

  Widget dontaecard(String nameoftitle, String description, double ordervalue, String phonenumb, desc) {
    return Container(
      width: 360.w,
      child: ListTile(
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
          press: (){
             var name = nameoftitle;
                var phonenumber = phonenumb;
                 const ordervalu = "$ordervalue";
                 name = nameoftitle;
                 const description =  desc;
             var options = {
                  'key': 'rzp_test_FBmQayuj43JfRI',
                  'amount': ordervalu *100.0,
                  'name': name,
                  'description': description,
                  'prefill': {
                    'contact': phonenumber,
                    'email': 'lci2021014@iiitl.ac.in'
                  }
                };
                 try {
                  _razorpay.open(options);
                } catch (e) {
                  debugPrint(e.toString());
                }
          },
        ),
      ),
    );
  }
}
