import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../AppTheme.dart';
import '../SizeConfig.dart';

class HomeSectionItem extends StatelessWidget {
  final String itemImageURL;
  final String itemText;
  final Function onItemClicked;
  HomeSectionItem({this.itemImageURL, this.itemText, this.onItemClicked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: InkWell(
        onTap: onItemClicked,
        child: Container(
          height: MediaQuery.of(context).size.width * 0.3, //90.0,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
              border: Border.all(
                color: AppTheme.appBackgroundColor,
              ),
              color: AppTheme.appBackgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ImageIcon(
                AssetImage(itemImageURL),
                color: AppTheme.textOrangeColor,
                size: 9 * SizeConfig.imageSizeMultiplier,
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: AutoSizeText(
                  itemText,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: AppTheme.subTitleTheme,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
