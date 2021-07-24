import 'package:confectionery_storie/app/modules/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'login_store.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({this.title = "Login"}) : super();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginStore> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
          child: Stack(
            children: [
              // Align(
              //   alignment: Alignment(0, 0.52),
              //   child: Container(
              //     width: 230,
              //     height: 44,
              //     child: Stack(
              //       children: [
              //         Align(
              //           alignment: Alignment(0, 0),
              //           child: FFButtonWidget(
              //             onPressed: () async {
              //               await Navigator.pushAndRemoveUntil(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) => HomeWidget(),
              //                 ),
              //                     (r) => false,
              //               );
              //             },
              //             text: 'Sign in with Google',
              //             icon: Icon(
              //               Icons.add,
              //               color: Colors.transparent,
              //               size: 20,
              //             ),
              //             options: FFButtonOptions(
              //               width: 230,
              //               height: 44,
              //               color: Colors.white,
              //               textStyle: GoogleFonts.getFont(
              //                 'Roboto',
              //                 color: Color(0xFF606060),
              //                 fontSize: 17,
              //               ),
              //               elevation: 4,
              //               borderSide: BorderSide(
              //                 color: Colors.transparent,
              //                 width: 0,
              //               ),
              //               borderRadius: 12,
              //             ),
              //           ),
              //         ),
              //         Align(
              //           alignment: Alignment(-0.83, 0),
              //           child: Container(
              //             width: 22,
              //             height: 22,
              //             clipBehavior: Clip.antiAlias,
              //             decoration: BoxDecoration(
              //               shape: BoxShape.circle,
              //             ),
              //             child: Image.network(
              //               'https://i0.wp.com/nanophorm.com/wp-content/uploads/2018/04/google-logo-icon-PNG-Transparent-Background.png?w=1000&ssl=1',
              //               fit: BoxFit.contain,
              //             ),
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // Align(
              //   alignment: Alignment(0, 0.84),
              //   child: FFButtonWidget(
              //     onPressed: () async {
              //       await Navigator.pushAndRemoveUntil(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => HomeWidget(),
              //         ),
              //             (r) => false,
              //       );
              //     },
              //     text: 'Sign in with Apple',
              //     icon: FaIcon(
              //       FontAwesomeIcons.apple,
              //       size: 20,
              //     ),
              //     options: FFButtonOptions(
              //       width: 230,
              //       height: 44,
              //       color: Colors.white,
              //       textStyle: GoogleFonts.getFont(
              //         'Roboto',
              //         color: Colors.black,
              //         fontSize: 17,
              //       ),
              //       elevation: 4,
              //       borderSide: BorderSide(
              //         color: Colors.transparent,
              //         width: 0,
              //       ),
              //       borderRadius: 12,
              //     ),
              //   ),
              // ),
              // Align(
              //   alignment: Alignment(0, 0.67),
              //   child: Container(
              //     width: 230,
              //     height: 44,
              //     child: Stack(
              //       children: [
              //         Align(
              //           alignment: Alignment(0, 0),
              //           child: FFButtonWidget(
              //             onPressed: () async {
              //               await Navigator.pushAndRemoveUntil(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) => HomeWidget(),
              //                 ),
              //                     (r) => false,
              //               );
              //             },
              //             text: 'Login with Facebook',
              //             icon: Icon(
              //               Icons.add,
              //               color: Colors.transparent,
              //               size: 20,
              //             ),
              //             options: FFButtonOptions(
              //               width: 230,
              //               height: 44,
              //               color: Colors.white,
              //               textStyle: GoogleFonts.getFont(
              //                 'Roboto',
              //                 color: Color(0xFF1877F2),
              //                 fontWeight: FontWeight.w500,
              //                 fontSize: 17,
              //               ),
              //               elevation: 4,
              //               borderSide: BorderSide(
              //                 color: Colors.transparent,
              //                 width: 0,
              //               ),
              //               borderRadius: 12,
              //             ),
              //           ),
              //         ),
              //         Align(
              //           alignment: Alignment(-0.83, 0),
              //           child: Container(
              //             width: 22,
              //             height: 22,
              //             clipBehavior: Clip.antiAlias,
              //             decoration: BoxDecoration(
              //               shape: BoxShape.circle,
              //             ),
              //             child: Image.network(
              //               'https://facebookbrand.com/wp-content/uploads/2019/04/f_logo_RGB-Hex-Blue_512.png?w=512&h=512',
              //               fit: BoxFit.contain,
              //             ),
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // Align(
              //   alignment: Alignment(0, -0.38),
              //   child: Container(
              //     width: 120,
              //     height: 120,
              //     clipBehavior: Clip.antiAlias,
              //     decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //     ),
              //     child: Image.network(
              //       'https://picsum.photos/seed/864/600',
              //     ),
              //   ),
              // ),
              // Align(
              //   alignment: Alignment(0, 0.15),
              //   child: Text(
              //     'Minha Confeitaria',
              //     textAlign: TextAlign.center,
              //     style: FlutterFlowTheme.title1.override(
              //       fontFamily: 'Open Sans',
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              // Align(
              //   alignment: Alignment(0, 0.24),
              //   child: Text(
              //     'Seu novo modo de organizar e vender em sua loja',
              //     textAlign: TextAlign.start,
              //     style: FlutterFlowTheme.bodyText1.override(
              //       fontFamily: 'Open Sans',
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}