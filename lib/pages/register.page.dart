import 'package:chat_app/helpers/mostrar_alerta.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/services/socket_services.dart';
import 'package:chat_app/widgets/btn_azul.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/labels_widget.dart';
import 'package:chat_app/widgets/logo_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
                Logo(title: 'Crea una cuenta'),
                _Form(),
                Labels(
                  route: 'login',
                  subtitle: 'Ingresa ahora',
                  title: 'Ya tienes una cuenta?',
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
    final authServices = Provider.of<AuthServices>(context);
    final socketServices = Provider.of<SocketService>(context);
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameController = TextEditingController();
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          CustomInput(
            controller: nameController,
            icon: const Icon(Icons.person_outline),
            placeHolder: 'Nombre',
            keyboardType: TextInputType.name,
          ),
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
            onPressed: () async {
              final registerOk = await authServices.register(
                nombre: nameController.text.trim(),
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
                createdAt: DateTime.now().toString(),
                updatedAt: DateTime.now().toString(),
              );
              if (registerOk == true) {
                socketServices.connect();
                Navigator.pushReplacementNamed(context, 'usuarios');
              } else {
                mostrarAlerta(context, 'Registro incorrecto', registerOk);
              }
            },
            colors: Colors.blue,
          ),
        ],
      ),
    );
  }
}
