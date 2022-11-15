import 'package:flutter/material.dart';
import 'package:mkk/config/theme/elements/theme_data.dart';
import 'package:lottie/lottie.dart';
import 'package:mkk/core/utils/constants.dart';

class AppSplashPage extends StatefulWidget {
  const AppSplashPage({Key? key}) : super(key: key);

  @override
  State<AppSplashPage> createState() => _AppSplashPageState();
}

class _AppSplashPageState extends State<AppSplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.of(context).primaryButtonColor,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: MyTheme.of(context).primaryButtonColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lottie/main_white.json',
            animate: true,
            repeat: true,
          ),
          const SizedBox(height: kBasePadding),
        ],
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:mkk/config/theme/elements/theme_data.dart';

// import '../../core/utils/constants.dart';

// class AppSplashPage extends StatelessWidget {
//   const AppSplashPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: MyTheme.of(context).primaryButtonColor,
//       appBar: AppBar(
//         toolbarHeight: 0,
//         elevation: 0,
//         backgroundColor: MyTheme.of(context).primaryButtonColor,
//       ),
//       body: Center(
//         child: FittedBox(
//           child: Column(
//             children: [
//               SizedBox(
//                 width: 220,
//                 height: 262,
//                 child: SvgPicture.asset(
//                   'assets/images/logo.svg',
//                   width: 220,
//                   height: 262,
//                 ),
//               ),
//               const SizedBox(height: kBasePadding * 2)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
