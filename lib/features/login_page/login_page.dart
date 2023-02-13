import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/component/app_elevated_button.dart';
import 'package:project/component/app_text_form_field.dart';
import 'package:project/core/style/colors.dart';
import 'package:project/core/style/resource.dart';
import 'package:project/core/style/text_style.dart';
import 'package:project/core/style/transaction.dart';
import 'package:project/core/utils/toast_message.dart';
import 'package:project/features/login_page/component/background_image.dart';
// import 'package:project/features/login_page/component/login_form.dart';
import 'package:project/features/login_page/cubit/login_cubit.dart';
part 'component/login_form.dart';
part 'component/fogot_form.dart';
// class LoginPage extends StatelessWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocProvider(
            create: (context) => LoginCubit(),
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state.message != "") {
                  errorToast(msg: state.message);
                } else {}
              },
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      R.ASSETS_PNG_LOGO_PNG,
                      fit: BoxFit.contain,
                      width: 250,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    if (state.gotoFogot)
                      buildFogotForm(context, state, emailCtrl)
                    else
                      buildLoginForm(context, state, emailCtrl, passwordCtrl)
                  ],
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
