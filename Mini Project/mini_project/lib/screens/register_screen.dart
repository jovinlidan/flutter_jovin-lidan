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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  late final FormManager _formManager;

  bool isPasswordShow = false;
  bool isRepeatPasswordShow = false;

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
      final RegisterInput input = RegisterInput(
          email: _formManager.getValueForField('email'),
          password: _formManager.getValueForField('password'),
          firstName: _formManager.getValueForField('email'));

      final res = await Provider.of<AuthViewModel>(context, listen: false).register(input: input);
      if (res.status == ApiStatus.success && res.data?.token != null) {
        Navigator.pushNamed(context, '/');
      } else {
        if (res.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.message!)));
        }
      }
    }
  }

  void onNavigateLogin() {
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AuthHeader(
                title: "Daftar",
                desc1: "Belajar coding dengan melakukannya",
                desc2: "Daftar Sekarang"),
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
                        name: "name",
                        prefixIcon: Icons.perm_identity,
                        suffixIcon: (state.getValueForField('name') != null &&
                                state.getValueForField('name')!.isNotEmpty
                            ? Icons.close
                            : null),
                        placeholder: "Masukkan nama anda",
                        label: "Nama",
                        validator: (String? val) => Validator.validate(
                          val,
                          [
                            Validator.required,
                            Validator.min5,
                          ],
                        ),
                        onSuffixIconPress: (tec) => clearText(tec, 'name'),
                      ),
                      const SizedBox(height: 12),
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
                          validator: (String? val) {
                            if (state.getValueForField('password') !=
                                state.getValueForField('repeatPassword')) {
                              return "Kedua Password harus sama";
                            }
                            return Validator.validate(val, [Validator.min5]);
                          }),
                      const SizedBox(height: 12),
                      TextInput(
                          name: "repeatPassword",
                          prefixIcon: Icons.lock_outline,
                          suffixIcon:
                              isRepeatPasswordShow ? Icons.visibility : Icons.visibility_off,
                          placeholder: "Ulangi kata sandi anda",
                          label: "Ulang Kata Sandi",
                          obscureText: !isRepeatPasswordShow,
                          onSuffixIconPress: (_) =>
                              setState(() => isRepeatPasswordShow = !isRepeatPasswordShow),
                          validator: (String? val) {
                            if (state.getValueForField('password') !=
                                state.getValueForField('repeatPassword')) {
                              return "Kedua Password harus sama";
                            }
                            return Validator.validate(val, [Validator.min5]);
                          }),
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
                          label: const Text("Daftar"),
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(const Size.fromHeight(40)),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue[700]!),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextButton(
                          onPressed: onNavigateLogin, child: const Text("Sudah Punya Akun? Masuk"))
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
