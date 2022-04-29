import 'package:flutter/material.dart';
import 'package:mini_project/helpers/providers/form_manager.dart';
import 'package:mini_project/helpers/validator.dart';
import 'package:provider/provider.dart';

class TextInput extends StatefulWidget {
  IconData? prefixIcon;
  IconData? suffixIcon;
  String? placeholder;
  String label;
  String name;
  bool obscureText;
  void Function(TextEditingController tec)? onSuffixIconPress;
  String? Function(String? val)? validator;

  TextInput({
    Key? key,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPress,
    this.placeholder,
    required this.label,
    this.validator,
    required this.name,
    this.obscureText = false,
  }) : super(key: key);

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (context.read<FormManager>().getValueForField(widget.name) != null) {}
    print("test");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0.5,
                color: context.read<FormManager>().getErrorMessageForField(widget.name) != null
                    ? Colors.red
                    : Colors.blue,
              ),
            ),
            // color: Colors.red,
          ),
          child: Row(
            children: [
              widget.prefixIcon != null
                  ? Icon(widget.prefixIcon, size: 24)
                  : const SizedBox.shrink(),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                child: TextFormField(
                  controller: textEditingController,
                  obscureText: widget.obscureText,
                  onChanged: (value) =>
                      context.read<FormManager>().setValueForField(widget.name, value),
                  decoration: InputDecoration(
                    hintText: widget.placeholder,
                    border: InputBorder.none,
                    errorStyle: const TextStyle(height: 0, color: Colors.transparent),
                  ),
                  onSaved: (String? value) =>
                      context.read<FormManager>().setValueForField(widget.name, value),
                  validator:
                      context.read<FormManager>().wrapValidator(widget.name, widget.validator),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              widget.suffixIcon != null
                  ? IconButton(
                      onPressed: widget.onSuffixIconPress == null
                          ? null
                          : () => widget.onSuffixIconPress!(textEditingController),
                      icon: Icon(widget.suffixIcon, size: 24))
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        context.read<FormManager>().getErrorMessageForField(widget.name) != null
            ? Text(context.read<FormManager>().getErrorMessageForField(widget.name)!,
                style: const TextStyle(color: Colors.redAccent))
            : const SizedBox.shrink()
      ],
    );
  }
}
