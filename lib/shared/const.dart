import 'package:flutter/material.dart';

InputDecoration textDecorated(
  BuildContext context, {
  String? hint,
  String? labelText,
  Widget? suffixIcon,
  EdgeInsetsGeometry contentPadding =
      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
}) {
  return InputDecoration(
    labelText: labelText,
    hintText: hint,
    contentPadding: contentPadding,
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black54, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue.shade800, width: 1.0),
      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
    ),
    isDense: true,
    suffixIconConstraints: const BoxConstraints(
      minWidth: 2,
      minHeight: 2,
    ),
    suffixIcon: suffixIcon,
  );
}

class DropText extends StatelessWidget {
  final String? state, hint;
  final List<DropdownMenuItem<dynamic>> map;
  final Function(dynamic) onchange, onSaved;
  const DropText(
      {Key? key,
      this.hint,
      required this.state,
      required this.map,
      required this.onSaved,
      required this.onchange})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: state,
      hint: Text(hint!),
      decoration: textDecorated(
        context,
      ),
      items: map,
      onChanged: onchange,
      onSaved: onSaved,
    );
  }
}

class TextF extends StatelessWidget {
  final TextEditingController controller;
  final String? validator, hint, labelText;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

  final Function()? onEdittingComplete;
  final Function(String)? onchange;
  final bool? short, obscure;
  final Widget? suffixIcon;
  final TextInputType? keybord;

  final EdgeInsetsGeometry? contentPadding;

  const TextF(this.controller, this.validator,
      {Key? key,
      this.hint,
      this.contentPadding =
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      this.focusNode,
      this.keybord,
      this.obscure = false,
      this.onEdittingComplete,
      this.onchange,
      this.short = false,
      this.suffixIcon,
      this.textInputAction,
      this.labelText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onchange,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onEditingComplete: onEdittingComplete,
      obscureText: obscure!,
      controller: controller,
      keyboardType: keybord,
      decoration: textDecorated(
        context,
        hint: hint,
        labelText: labelText,
        contentPadding: contentPadding!,
        suffixIcon: suffixIcon,
      ),
      minLines: 1,
      maxLines: obscure! ? 1 : 3,
      validator: short!
          ? (value) =>
              value!.isEmpty || value.characters.length > 30 ? validator : null
          : (value) => value!.isEmpty || value.characters.length > 800
              ? validator
              : null,
    );
  }
}

Widget materialButton(Function() onpress, String text) {
  return MaterialButton(
      onPressed: onpress,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: Text(text,
          style: TextStyle(
              color: Colors.green.shade900,
              fontWeight: FontWeight.bold,
              fontFamily: 'Caveat-VariableFont_wght')));
}

class TextWidget extends StatelessWidget {
  final String? item, data;
  const TextWidget({Key? key, this.item, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: item,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: data,
            style: TextStyle(
              color: Colors.blue.shade800,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class CreateAlertDialog extends StatelessWidget {
  final Function() onpress;
  const CreateAlertDialog({Key? key, required this.onpress}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      foregroundColor: Colors.blue.shade800,
      child: const Icon(
        Icons.add,
      ),
      onPressed: onpress,
      mini: true,
    );
  }
}
