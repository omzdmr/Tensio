import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tensio/core/design/tensio_colors.dart';
import 'package:tensio/core/widgets/surface_card.dart';

class NewMeasurementScreen extends StatefulWidget {
  const NewMeasurementScreen({super.key});
  @override
  State<NewMeasurementScreen> createState() => _NewMeasurementScreenState();
}

class _NewMeasurementScreenState extends State<NewMeasurementScreen> {
  final systolic=TextEditingController(text:'120');
  final diastolic=TextEditingController(text:'80');
  final pulse=TextEditingController(text:'72');
  final note=TextEditingController();

  @override
  void dispose(){systolic.dispose();diastolic.dispose();pulse.dispose();note.dispose();super.dispose();}

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Yeni Ölçüm'), backgroundColor: Colors.transparent),
      body: SafeArea(
        top:false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20,12,20,32),
          children:[
            const SurfaceCard(
              padding: EdgeInsets.symmetric(horizontal:16,vertical:14),
              child: Row(children:[
                Icon(Icons.calendar_today_outlined,size:19),
                SizedBox(width:10),
                Expanded(child:Text('Bugün')),
                Text('08:30',style:TextStyle(color:TensioColors.textSecondary,fontWeight:FontWeight.w600)),
              ]),
            ),
            const SizedBox(height:16),
            Row(children:[
              Expanded(child:_VitalInput(label:'Sistolik',unit:'mmHg',controller:systolic,tint:TensioColors.coral)),
              const SizedBox(width:8),
              Expanded(child:_VitalInput(label:'Diyastolik',unit:'mmHg',controller:diastolic,tint:TensioColors.blue)),
              const SizedBox(width:8),
              Expanded(child:_VitalInput(label:'Nabız',unit:'bpm',controller:pulse,tint:TensioColors.violet)),
            ]),
            const SizedBox(height:16),
            const SurfaceCard(
              child: Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
                Text('Ölçüm bağlamı',style:TextStyle(fontSize:17,fontWeight:FontWeight.w700)),
                SizedBox(height:12),
                Wrap(spacing:8,runSpacing:8,children:[
                  _ContextChip(label:'Sol kol',selected:true),
                  _ContextChip(label:'Otururken',selected:true),
                  _ContextChip(label:'İlaç öncesi',selected:false),
                  _ContextChip(label:'Sabah',selected:true),
                ]),
              ]),
            ),
            const SizedBox(height:16),
            TextField(controller:note,maxLines:3,decoration:const InputDecoration(labelText:'Not (isteğe bağlı)',hintText:'Örn. 5 dakika dinlendikten sonra')),
            const SizedBox(height:24),
            FilledButton(
              style:FilledButton.styleFrom(backgroundColor:TensioColors.coral,foregroundColor:TensioColors.background,minimumSize:const Size.fromHeight(56),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(18))),
              onPressed:(){HapticFeedback.mediumImpact();Navigator.of(context).pop();},
              child:const Text('Ölçümü Kaydet',style:TextStyle(fontSize:16,fontWeight:FontWeight.w800)),
            ),
            const SizedBox(height:12),
            const Text('Foundation prototipi: kalıcı veritabanı bir sonraki çekirdek dilimde bağlanacak.',textAlign:TextAlign.center,style:TextStyle(color:TensioColors.textMuted,fontSize:12)),
          ],
        ),
      ),
    );
  }
}

class _VitalInput extends StatelessWidget {
  const _VitalInput({required this.label,required this.unit,required this.controller,required this.tint});
  final String label,unit; final TextEditingController controller; final Color tint;
  @override
  Widget build(BuildContext context)=>SurfaceCard(
    padding:const EdgeInsets.fromLTRB(10,14,10,12),
    child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Text(label,style:const TextStyle(color:TensioColors.textSecondary,fontSize:12)),
      const SizedBox(height:8),
      TextField(
        controller:controller,keyboardType:TextInputType.number,inputFormatters:[FilteringTextInputFormatter.digitsOnly],textAlign:TextAlign.center,
        style:TextStyle(color:tint,fontSize:27,fontWeight:FontWeight.w800),
        decoration:const InputDecoration(isDense:true,filled:false,border:InputBorder.none,enabledBorder:InputBorder.none,focusedBorder:InputBorder.none,contentPadding:EdgeInsets.zero),
      ),
      const SizedBox(height:4),
      Center(child:Text(unit,style:const TextStyle(color:TensioColors.textMuted,fontSize:11))),
    ]),
  );
}

class _ContextChip extends StatelessWidget {
  const _ContextChip({required this.label,required this.selected});
  final String label; final bool selected;
  @override
  Widget build(BuildContext context)=>Container(
    padding:const EdgeInsets.symmetric(horizontal:11,vertical:8),
    decoration:BoxDecoration(
      color:selected ? TensioColors.coral.withOpacity(.12) : TensioColors.surfaceRaised,
      borderRadius:BorderRadius.circular(999),
      border:Border.all(color:selected ? TensioColors.coral : TensioColors.outline),
    ),
    child:Text(label,style:TextStyle(color:selected ? TensioColors.coralSoft:TensioColors.textSecondary,fontWeight:FontWeight.w600,fontSize:12)),
  );
}
