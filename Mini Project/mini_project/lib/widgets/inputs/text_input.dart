import 'package:flutter/material.dart';
import 'package:mini_project/helpers/providers/form_manager.dart';
import 'package:provider/provider.dart';

class TextInput extends StatefulWidget {
  IconData? prefixIcon;
  IconData? suffixIcon;
  String? placeholder;
  String? label;
  String name;
  bool obscureText;
  void Function(TextEditingController tec)? onSuffixIconPress;
  String? Function(String? val)? validator;
  late bool expands;
  late int? minLines;
  late int? maxLines;
  late TextStyle? style;
  late TextStyle? hintStyle;

  TextInput({
    Key? key,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPress,
    this.placeholder,
    this.label,
    this.validator,
    required this.name,
    this.obscureText = false,
    this.expands = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.style,
    this.hintStyle,
  }) : super(key: key);

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (context.read<FormManager>().getValueForField(widget.name) != null) {}
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null ? Text(widget.label!) : const SizedBox.shrink(),
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
                  expands: widget.expands,
                  minLines: widget.minLines,
                  maxLines: widget.maxLines,
                  controller: textEditingController,
                  obscureText: widget.obscureText,
                  onChanged: (value) =>
                      context.read<FormManager>().setValueForField(widget.name, value),
                  decoration: InputDecoration(
                    hintText: widget.placeholder,
                    border: InputBorder.none,
                    errorStyle: const TextStyle(height: 0, color: Colors.transparent),
                    hintStyle: widget.hintStyle,
                  ),
                  style: widget.style,
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
