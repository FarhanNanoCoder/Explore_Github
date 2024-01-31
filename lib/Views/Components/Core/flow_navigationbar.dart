
import 'package:explore_github/Utilities/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FlowNavigationBar extends StatefulWidget{
  List<IconData> icons =[];
  Color? circleColor = AppColors().primaryColor,
      backgroundColor = AppColors().white,
      iconColor = AppColors().primaryColor,
      activeIconColor=AppColors().white;
  double? height = 56,iconSize=24;
  int? initialIndex = 0;
  int? length = 0;
  final Function (int position) onIndexChangedListener;

  FlowNavigationBar({required this.icons, this.circleColor, this.backgroundColor,
      this.iconColor, this.activeIconColor, this.height, this.iconSize,this.initialIndex,
  required this.onIndexChangedListener}){

    circleColor = circleColor ?? AppColors().primaryColor;
    backgroundColor = backgroundColor ?? AppColors().white;
    iconColor = iconColor ?? AppColors().primaryColor;
    activeIconColor = activeIconColor ?? AppColors().white;
    height = height ?? 56;
    iconSize = iconSize ?? 24;
    initialIndex = initialIndex ?? 0;
    length = icons.length;

  }


  @override
  _FlowNavigationBarState createState() => _FlowNavigationBarState();
}

class _FlowNavigationBarState extends State<FlowNavigationBar> {
  @override
  Widget build(BuildContext context) {
    int currentIndex =widget.initialIndex??0;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: widget.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            left: MediaQuery.of(context).size.width*((currentIndex)/widget.icons.length),
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: Container(
              width: MediaQuery.of(context).size.width*(1/widget.icons.length),
              height: widget.height,
              child: Center(
                child: Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: widget.circleColor,
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: widget.icons.map((e) => SizedBox(
              width: MediaQuery.of(context).size.width*(1/widget.icons.length),
              height: widget.height,
              child: Center(
                child: IconButton(
                  onPressed: (){
                    setState(() {
                      currentIndex = widget.icons.indexOf(e);
                      widget.onIndexChangedListener(currentIndex);
                    });
                  },
                  icon: Icon(e,),
                  iconSize: widget.iconSize,
                  color: currentIndex == widget.icons.indexOf(e)?
                  widget.activeIconColor:widget.iconColor,
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}