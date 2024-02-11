
import 'package:chatai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OutlinedInputTextField extends StatefulWidget {
  final IconButton floatingIcon;
  final String hintName;
  final int maxLines;
  final TextInputType textInputType;
  final Function onSaved;
  final Function validator;
  final Function onChanged;
  final int decimalPoint;
  final bool isSecure;
  final bool autoValidate;
  final TextEditingController controller;
  final isEnable;
  final TextInputAction textInputAction;
  final Function onFieldSubmitted;
  MaterialColor textColor = AppColors.colorBlack;

  OutlinedInputTextField(this.isSecure, this.controller, this.autoValidate,
      {this.floatingIcon,
      this.hintName,
      this.maxLines,
      this.textInputType,
      this.onSaved,
      this.validator,
      this.decimalPoint,
      this.onChanged,
      this.isEnable,
      this.textColor,
      this.textInputAction,
      this.onFieldSubmitted});

  @override
  _OutlinedInputTextFieldState createState() => _OutlinedInputTextFieldState();
}

class _OutlinedInputTextFieldState extends State<OutlinedInputTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        maxLines: widget.maxLines != null ? widget.maxLines : 1,
        controller: widget.controller,
        onChanged: widget.onChanged == null ? (text) {} : widget.onChanged,
        enabled: widget.isEnable,
        textCapitalization: TextCapitalization.words,
        textAlign: TextAlign.left,
        cursorColor: AppColors.colorPrimary,
        obscureText: widget.isSecure,
        decoration: InputDecoration(
          suffixIcon: widget.floatingIcon,
          contentPadding: EdgeInsets.all(8.0),
          labelText: widget.hintName,
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: AppColors.colorGrey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: AppColors.colorPrimary),
          ),
        ),
        textInputAction: widget.textInputAction,
        style: TextStyle(color: widget.textColor),
        keyboardType: widget.textInputType != null
            ? widget.textInputType
            : TextInputType.text,
        autofocus: false,
        validator: widget.validator,
        onSaved: widget.onSaved,
        onFieldSubmitted: widget.onFieldSubmitted,
      ),
    );
  }
}
