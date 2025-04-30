import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class CustomDropdownSearch<T> extends StatelessWidget {
  final FutureOr<List<T>> Function(String, LoadProps?)? items;
  final T? selectedItem;
  final String Function(T)? itemAsString;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final IconData? dropdownIcon;
  final bool Function(T, String)? filterFn;
  final bool Function(T, T)? compareFn;
  final Widget? suffixWidget;
  final bool? showSearchBox;
  final bool? enabled;
  const CustomDropdownSearch({
    super.key,
    required this.items,
    this.selectedItem,
    this.itemAsString,
    this.onChanged,
    this.validator,
    this.dropdownIcon,
    this.filterFn,
    this.compareFn,
    this.suffixWidget,
    this.showSearchBox,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 43,
      child: DropdownSearch<T>(
        enabled: enabled ?? true,
        items: items,
        selectedItem: selectedItem,
        itemAsString: itemAsString,
        onChanged: onChanged,
        validator: validator,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        filterFn: filterFn,
        suffixProps: DropdownSuffixProps(
          dropdownButtonProps: DropdownButtonProps(
            // color: Colors.red,
            iconClosed: Icon(
              Icons.keyboard_arrow_down,
              color:
                  enabled == true
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
            ),
            iconOpened: Icon(
              Icons.keyboard_arrow_up,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        compareFn: compareFn,
        decoratorProps: DropDownDecoratorProps(
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            filled: true,
            isDense: true,
            contentPadding: const EdgeInsets.only(
              top: 12,
              bottom: 8,
              left: 16,
              right: 16,
            ),
            fillColor:
                Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xff313131)
                    : const Color(0xffFAFAFC),

            hintText: 'Selecione...',
            hintStyle: const TextStyle(
              color: Color(0xffB2BCC9),
              fontWeight: FontWeight.w400,
              fontSize: 15.5,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xffF04D00), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFA6767A), width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xffF04D00), width: 1),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1, color: Color(0xffF4F4F6)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1, color: Color(0xffF4F4F6)),
            ),
          ),
        ),
        popupProps: PopupProps.modalBottomSheet(
          emptyBuilder:
              (context, searchEntry) =>
                  const Center(child: Text('Nenhum item encontrado.')),
          // menuProps: MenuProps(
          //   borderRadius: BorderRadius.circular(12),
          // ),
          //
          showSearchBox: showSearchBox ?? false,
          searchFieldProps: const TextFieldProps(
            padding: EdgeInsets.all(8),
            decoration: InputDecoration(
              labelText: 'Pesquisar',
              prefixIcon: Icon(Icons.search),
              border: UnderlineInputBorder(),
            ),
          ),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.25,
          ),
          modalBottomSheetProps: const ModalBottomSheetProps(
            useSafeArea: true,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
