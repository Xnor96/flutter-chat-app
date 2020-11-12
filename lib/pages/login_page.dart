import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/widgets/btn_azul.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(227, 227, 227, 1), //color 
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Logo(titulo: 'S i l e n t',),
                _Form(),
                Labels(ruta: 'register', titulo: '¿No tienes cuenta?',subtitulo: 'Crea una ahora!'),
                Text('Terminos y condiciones de uso',style: TextStyle(fontWeight: FontWeight.w200))
              ],
            ),
          ),
        ),
      )
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: EdgeInsets.only(top:40),
      padding: EdgeInsets.symmetric(horizontal:50),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),

          //crear boton 
          
          BotonAzul(
            text:'Ingrese',
            onPressed:authService.autenticando ? null:()async{

              FocusScope.of(context).unfocus();

              final loginOk  = await authService.login(emailCtrl.text.trim(), passCtrl.text.trim());

              if(loginOk){
                //TO DO navegar otra pantalla
                Navigator.pushReplacementNamed(context, 'usuarios');
              }else{
                //mostrar alerta 
                mostrarAlerta(context, 'Login Incorrecto', 'Revise sus datos nuevamente');
              }

            },
          )

        ],
      ),
    );
  }
}