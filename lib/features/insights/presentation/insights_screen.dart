import 'package:flutter/material.dart';
import 'package:tensio/core/design/tensio_colors.dart';
import 'package:tensio/core/widgets/surface_card.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});
  @override
  Widget build(BuildContext context)=>SafeArea(child:ListView(
    padding:const EdgeInsets.fromLTRB(20,20,20,120),
    children:[
      Text('Analiz',style:Theme.of(context).textTheme.headlineMedium),
      const SizedBox(height:6),
      const Text('Trendler, karşılaştırmalar ve anlaşılır özetler.',style:TextStyle(color:TensioColors.textSecondary)),
      const SizedBox(height:20),
      const Row(children:[
        Expanded(child:_Metric(title:'Ölçüm',value:'42',detail:'Bu ay')),
        SizedBox(width:10),
        Expanded(child:_Metric(title:'Ortalama',value:'125/80',detail:'mmHg')),
      ]),
      const SizedBox(height:10),
      const SurfaceCard(child:SizedBox(height:180,child:Center(child:Text('Gelişmiş trend grafiği alanı',style:TextStyle(color:TensioColors.textMuted))))),
    ],
  ));
}
class _Metric extends StatelessWidget{
  const _Metric({required this.title,required this.value,required this.detail});
  final String title,value,detail;
  @override
  Widget build(BuildContext context)=>SurfaceCard(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    Text(title,style:const TextStyle(color:TensioColors.textSecondary)),
    const SizedBox(height:8),
    Text(value,style:const TextStyle(fontSize:24,fontWeight:FontWeight.w800)),
    const SizedBox(height:3),
    Text(detail,style:const TextStyle(color:TensioColors.textMuted)),
  ]));
}
