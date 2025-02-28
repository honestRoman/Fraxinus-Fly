import '../../commons/all.dart';

class CommonButton extends StatelessWidget {
  final String? btnName;
  final Color? btnColor;
  final Color? textColor;
  final Color? borderColor;
  final void Function()? onTap;
  const CommonButton({super.key, this.btnName, this.onTap, this.btnColor, this.textColor, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: btnColor ?? Colors.blue,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor ?? Colors.transparent)
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              btnName ?? "",
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontFamily: FontFamily.medium,
                fontSize: FontSize.s16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
