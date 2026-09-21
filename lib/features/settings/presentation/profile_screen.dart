import 'package:flutter/material.dart';
import 'package:tensio/core/design/tensio_colors.dart';
import 'package:tensio/core/widgets/surface_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context)=>SafeArea(child:ListView(
    padding:const EdgeInsets.fromLTRB(20,20,20,120),
    children:[
      Text('Profil & Ayarlar',style:Theme.of(context).textTheme.headlineMedium),
      const SizedBox(height:20),
      const SurfaceCard(child:Row(children:[
        CircleAvatar(radius:26,backgroundColor:TensioColors.surfaceStrong,child:Icon(Icons.person_rounded)),
        SizedBox(width:14),
        Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Text('Tensio Kullanıcısı',style:TextStyle(fontSize:17,fontWeight:FontWeight.w700)),
          SizedBox(height:3),
          Text('Verilerin öncelikle cihazında.',style:TextStyle(color:TensioColors.textSecondary)),
        ])),
      ])),
      const SizedBox(height:12),
      const SurfaceCard(padding:EdgeInsets.zero,child:Column(children:[
        _Row(icon:Icons.language_rounded,title:'Dil'),
        Divider(height:1),
        _Row(icon:Icons.notifications_none_rounded,title:'Hatırlatıcılar'),
        Divider(height:1),
        _Row(icon:Icons.medication_outlined,title:'İlaç Takibi'),
        Divider(height:1),
        _Row(icon:Icons.favorite_outline_rounded,title:'Sağlık Entegrasyonları'),
        Divider(height:1),
        _Row(icon:Icons.lock_outline_rounded,title:'Gizlilik & Veriler'),
        Divider(height:1),
        _Row(icon:Icons.palette_outlined,title:'Görünüm'),
      ])),
    ],
  ));
}
class _Row extends StatelessWidget{
  const _Row({required this.icon,required this.title});
  final IconData icon; final String title;
  @override
  Widget build(BuildContext context)=>ListTile(
    leading:Icon(icon,color:TensioColors.textSecondary),
    title:Text(title),
    trailing:const Icon(Icons.chevron_right_rounded,color:TensioColors.textMuted),
  );
}
