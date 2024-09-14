import 'package:character/models/character.dart';
import 'package:character/shared/styled_text.dart';
import 'package:character/theme.dart';
import 'package:flutter/material.dart';

class StatsTable extends StatefulWidget {
  const StatsTable(this.character,{super.key});
  
  final Character character;

  @override
  State<StatsTable> createState() => _StatsTableState();
}

class _StatsTableState extends State<StatsTable> {
  double turns = 0.0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        Container(
          color: AppColors.secondaryColor,
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              AnimatedRotation(
                turns: turns,
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  Icons.star,
                  color: widget.character.points>0 ? Colors.yellow : Colors.grey,
                ),
              ),
              const SizedBox(width: 20,),
              const StyledText('Stat points available:'),
              const Expanded(child: SizedBox(width: 20,)),
              StyledHeading(widget.character.points.toString()),
            ],
          ),
        ),
        Table(
          children: widget.character.statsAsFormattedList.map((stat){
            return TableRow(
              decoration: BoxDecoration(
                color: AppColors.secondaryColor.withOpacity(0.5),
                
              ),
              children: [
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: StyledHeading(stat['title']!),
                  )),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: StyledHeading(stat['value']!),
                  )),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: IconButton(
                    onPressed: (){
                      setState(() {
                        widget.character.increaseStat(stat['title']!);
                        turns+=0.5;
                      });
                    }, 
                    icon: Icon(Icons.arrow_upward,
                    color: AppColors.textColor,
                    )
                  )
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: IconButton(
                    onPressed: (){
                      setState(() {
                        widget.character.decreaseStat(stat['title']!);
                        turns-=0.5;
                      });
                    }, 
                    icon: Icon(Icons.arrow_downward,
                    color: AppColors.textColor,
                    )
                  )
                ),
              ]
            );
          }).toList(),
        ),
      ],),
    );
  }
}