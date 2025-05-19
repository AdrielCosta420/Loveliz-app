import 'package:flutter/material.dart';
import 'package:loveliz_app/src/common/widgets/loading_widget.dart';
import 'package:loveliz_app/src/modules/auth/controllers/auth_controller.dart';

import '../../../common/widgets/text_form_field_widget.dart';
import '../../../injectable.dart';
import '../uc/login_uc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = injector.get<AuthController>();
  final login = injector.get<LoginUc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 24.0),
        child: ListenableBuilder(
          listenable: controller,
          builder: (context, _) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.30,
                      child: Image.asset('assets/images/loveliz-bg.png'),
                    ),
                  ),
                  Text(
                    'Olá, seja bem-vindo(a) de volta!',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    'E-mail',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                  ),
                  TextFormFieldWidget(
                    hintText: 'Insira seu e-mail',
                    onChanged: controller.credentials.setEmail,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Senha',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                  ),
                  TextFormFieldWidget(
                    hintText: 'Insira sua senha',
                    // obscureText: true,
                    onChanged: controller.credentials.setPassword,
                  ),
                  const SizedBox(height: 16),
                  controller.isLoading
                      ? const LoadingWidget()
                      : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            login();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            textStyle: const TextStyle(fontSize: 18),
                          ),
                          child: const Text('Entrar'),
                        ),
                      ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
