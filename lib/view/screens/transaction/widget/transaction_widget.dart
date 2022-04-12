
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/transaction_model.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class TransactionWidget extends StatelessWidget {
  final TransactionModel transactionModel;
  TransactionWidget({@required this.transactionModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: ColorResources.getBottomSheetColor(context),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 800 : 200], spreadRadius: 0.5, blurRadius: 0.3)],
      ),
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: ColorResources.getHomeBg(context),
                      boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 800 : 400], spreadRadius: 0.5, blurRadius: 0.3)],
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(transactionModel.createdAt)),
                    style: titilliumSemiBold.copyWith(color: ColorResources.getTextColor(context), fontSize: 14),textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(width: 10),
                Expanded(
                  child: Column( mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
                    Text(
                      '${getTranslated('order_no', context)} : #${transactionModel.id}',
                      style: titilliumBold.copyWith(color: ColorResources.getTextColor(context), fontSize: 14),
                    ),
                    Text(
                      getTranslated(transactionModel.approved == 2 ? 'denied' : transactionModel.approved == 1 ? 'approved' : 'pending', context),
                      style: titilliumBold.copyWith(
                        color: transactionModel.approved == 1 ? Colors.green : transactionModel.approved == 2 ? Colors.red : Theme.of(context).primaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ]),
                ),

                Text(
                  PriceConverter.convertPrice(context, transactionModel.amount),
                  style: titilliumBold.copyWith(color: ColorResources.getTextColor(context), fontSize: 14),
                ),

              ]
          ),
        ],
      ),
    );
  }
}
