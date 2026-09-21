import 'package:flutter/material.dart';
import 'package:tensio/core/design/tensio_colors.dart';
import 'package:tensio/core/widgets/surface_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const data=[('Bugün • 08:30','120 / 80','72 bpm'),('Dün • 21:15','135 / 85','78 bpm'),('Dün • 08:20','118 / 76','70 bpm')];
    return SafeArea(child:ListView(
      padding:const EdgeInsets.fromLTRB(20,20,20,120),
      children:[
        Text('Geçmiş',style:Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height:6),
        const Text('Liste, takvim ve filtreler tek yerde.',style:TextStyle(color:TensioColors.textSecondary)),
        const SizedBox(height:20),
        for(final item in data)...[
          SurfaceCard(child:Row(children:[
            Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
              Text(item.$1,style:const TextStyle(color:TensioColors.textSecondary)),
              const SizedBox(height:6),
              Text(item.$2,style:const TextStyle(fontSize:24,fontWeight:FontWeight.w800)),
            ])),
            Text(item.$3,style:const TextStyle(color:TensioColors.textSecondary)),
          ])),
          const SizedBox(height:10),
        ],
      ],
    ));
  }
}
