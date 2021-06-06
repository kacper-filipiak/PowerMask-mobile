
class DoubleWrapper{ 
	double value;
	DoubleWrapper(this.value);
  }
class TimeChart extends StatelessWidget {
  const TimeChart({
    Key? key,
    required this.timeList,
    required double width,
    required double pointWidth,
    int height = 50,
    Color mainColor = Colors.orangeAccent,
    Color secondColor = Colors.white10,
  }) : _width = width, _pointWidth = pointWidth, _height = height, _mainColor = mainColor, _secondColor = secondColor, super(key: key);

  final List<DateTime> timeList;
  final double _width;
  final double _pointWidth;
  final _height;
  final Color _mainColor;
  final Color _secondColor;

  
  double datePlacement(DateTime date, DoubleWrapper nextOffset){
	int diffDate = date.millisecondsSinceEpoch - timeList.first.millisecondsSinceEpoch;
	int scale = timeList.last.millisecondsSinceEpoch - timeList.first.millisecondsSinceEpoch;

	if(_width - timeList.length * _pointWidth > 0){
		double res = (diffDate / scale) * (_width - timeList.length * _pointWidth) - nextOffset.value; 
		nextOffset.value = res;
		return res;
	} else{
		double res =  (diffDate / scale) * (_width) - nextOffset.value;
		nextOffset.value = res;
		return res;
	}
  }
  @override
  Widget build(BuildContext context) {
	  print(timeList.length);
	  DoubleWrapper nextOffset = new DoubleWrapper(0);

    return Container(
		    	width: _width,
	        	height: _height,
			child: ListView.builder( 
				scrollDirection: Axis.horizontal,
				itemCount: timeList.length,
				itemBuilder: (BuildContext context, int index) {
					print(index);
					return new Row(
						children: [
					      	Container(width: datePlacement(timeList[index], nextOffset),
								decoration: BoxDecoration(
										gradient: LinearGradient(
												begin: Alignment.centerLeft,
												end: Alignment.centerRight,
												stops:[0.1, 0.5, 0.9,],
												colors: [ _mainColor, _secondColor, _mainColor],
												)
										),
								),
					      	Container(
								width: _pointWidth.toDouble(), 
								height: _height, 
								child: Center(
										child: Text(timeList[index].toString())), 
								color: _mainColor),	
					      ]);
					    }
					  ),
					);
  }
}

