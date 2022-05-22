import 'package:chat_app/widgets/btn_azul.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/labels_widget.dart';
import 'package:chat_app/widgets/logo_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Logo(title: 'Messenger'),
                _Form(),
                Labels(
                  route: 'register',
                  subtitle: 'Crear una ahora',
                  title: 'No tienes una cuenta?',
                ),
                Text('Terminos y condiciones de uso'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _FormState();
  }
}

class _FormState extends StatelessWidget {
  const _FormState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          CustomInput(
            controller: emailController,
            icon: const Icon(Icons.email_outlined),
            placeHolder: 'Correo',
            keyboardType: TextInputType.emailAddress,
          ),
          CustomInput(
            controller: passwordController,
            icon: const Icon(Icons.password_outlined),
            placeHolder: 'Contrasena',
            keyboardType: TextInputType.text,
            isPassword: true,
          ),
          BotonAzulWidget(
            texto: 'Ingrese',
            onPressed: () {
              print(emailController.text);
              print(passwordController.text);
            },
            colors: Colors.blue,
          ),
        ],
      ),
    );
  }
}
