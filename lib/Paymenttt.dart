import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Mypaymnett extends StatefulWidget {
  const Mypaymnett({Key? key}) : super(key: key);

  @override
  State<Mypaymnett> createState() => _MypaymnettState();
}

class _MypaymnettState extends State<Mypaymnett> {

  Razorpay? _razorpay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(onPressed: () {
        _razorpay!.open(options);
      }, child: Text("Payment")),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(msg: " Payment Successfully");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "Payment Successfully");
  }

  Map<String, dynamic> options = {
    'key': 'rzp_test_U0E5SXISk6pySm',
    'amount': 10000000000000,
    'name': 'Acme Corp.',
    'description': 'Fine T-Shirt',
    'prefill': {
      'contact': '9824157683',
      'email': 'priyanshimulsha2510@gmail.com'
    }
  };
}

//   void openCheckout() async {
//     var options = {
//       'key': 'rzp_test_NNbwJ9tmM0fbxj',
//       'amount': 28200,
//       'name': 'Shaiq',
//       'description': 'Payment',
//       'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
//       'external': {
//         'wallets': ['paytm']
//       }
//     };
//
//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       debugPrint(e);
//     }
// }
