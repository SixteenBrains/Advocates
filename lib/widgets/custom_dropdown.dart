import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final Function(String? value) onChanged;
  final String labelText;
  final String? selectedValue;
  final List<String> dropDownOptions;

  const CustomDropDown({
    Key? key,
    required this.onChanged,
    required this.selectedValue,
    required this.dropDownOptions,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final leftPadding =
    //     selectedValue?.length != null ? selectedValue!.length * 6.0 : 12;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SizedBox(
            height: 72.0,
            width: double.infinity,
            child: Card(
              elevation: 0.5,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade400, width: 0.5),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: const InputDecoration.collapsed(
                        hintText: 'NONE',
                      ),
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      isEmpty: selectedValue == '',
                      child: Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                            alignment: Alignment.center,
                            // value: _currentSelectedValue,
                            value: selectedValue,
                            dropdownColor: Colors.white,
                            icon: const SizedBox.shrink(),
                            //  const Icon(
                            //   Icons.arrow_drop_down,
                            //   color: Colors.white,
                            // ),
                            isDense: true,
                            onChanged: onChanged,

                            items: dropDownOptions.map((String value) {
                              return DropdownMenuItem<String>(
                                // alignment: Alignment.center,
                                value: value,
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Chip(
            backgroundColor: Colors.white,
            label: Text(
              labelText,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
