class Alert{

  Alert(this._id,this._date,this._time,this._type, {id,date,time,type});

  final _id,_date,_time,_type;

  getId() => _id;
  getDate()=> _date;
  getTime()=> _time;
  getType() => _type;


}