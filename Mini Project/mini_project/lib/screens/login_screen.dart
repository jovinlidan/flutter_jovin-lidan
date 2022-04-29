import 'package:flutter/material.dart';
import 'package:mini_project/helpers/providers/form_manager.dart';
import 'package:mini_project/helpers/validator.dart';
import 'package:mini_project/model/auth_model.dart';
import 'package:mini_project/services/services.dart';
import 'package:mini_project/view_models/auth_view_model.dart';
import 'package:mini_project/widgets/auth_header.dart';
import 'package:mini_project/widgets/form.dart';
import 'package:mini_project/widgets/inputs/text_input.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late final FormManager _formManager;

  bool isPasswordShow = false;

  @override
  void initState() {
    _formManager = FormManager();
    super.initState();
  }

  void clearText(TextEditingController tec, String key) {
    tec.clear();
    _formManager.setValueForField(key, '');
  }

  void onSubmit() async {
    if (_formManager.erroredFields.isEmpty) {
      final LoginInput input = LoginInput(
          email: _formManager.getValueForField('email'),
          password: _formManager.getValueForField('password'));

      final res = await Provider.of<AuthViewModel>(context, listen: false).login(input: input);
      if (res.status == ApiStatus.success && res.data?.token != null) {
        // await Provider.of<AuthViewModel>(context, listen: false)
        //     .setToken(token: res.data!.token as String);
        Navigator.pushNamed(context, '/');
      } else {
        if (res.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.message!)));
        }
      }
    }
  }

  void onNavigateRegister() {
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AuthHeader(
                title: "Masuk", desc1: "Ayo mulai kursusmu hari ini", desc2: "Masuk Sekarang"),
            const SizedBox(height: 36),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FormProvider(
                  changeNotifier: _formManager,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  builder: (state) => Column(
                    children: [
                      TextInput(
                        name: "email",
                        prefixIcon: Icons.alternate_email,
                        suffixIcon: (state.getValueForField('email') != null &&
                                state.getValueForField('email')!.isNotEmpty
                            ? Icons.close
                            : null),
                        placeholder: "Masukkan email anda",
                        label: "Email",
                        validator: (String? val) => Validator.validate(
                          val,
                          [
                            Validator.required,
                            Validator.email,
                          ],
                        ),
                        onSuffixIconPress: (tec) => clearText(tec, 'email'),
                      ),
                      const SizedBox(height: 12),
                      TextInput(
                          name: "password",
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: isPasswordShow ? Icons.visibility : Icons.visibility_off,
                          placeholder: "Masukkan kata sandi anda",
                          label: "Kata Sandi",
                          obscureText: !isPasswordShow,
                          onSuffixIconPress: (_) =>
                              setState(() => isPasswordShow = !isPasswordShow),
                          validator: (String? val) => Validator.validate(val, [Validator.min5])),
                      const SizedBox(height: 24),
                      Consumer<AuthViewModel>(
                        builder: (_, state, __) => ElevatedButton.icon(
                          icon: state.token?.status == ApiStatus.loading
                              ? Container(
                                  width: 24,
                                  height: 24,
                                  padding: const EdgeInsets.all(2.0),
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                )
                              : const SizedBox.shrink(),
                          onPressed: state.token?.status == ApiStatus.loading ? null : onSubmit,
                          label: const Text("Masuk"),
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(const Size.fromHeight(40)),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue[700]!),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextButton(
                          onPressed: onNavigateRegister,
                          child: const Text("Belum Punya Akun? Daftar"))
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
