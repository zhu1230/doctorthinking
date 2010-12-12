	function get_local_time_for_date(time) {
  system_date = new Date(time);
  user_date = new Date();
  delta_minutes = Math.floor((user_date - system_date) / (60 * 1000));
  if (Math.abs(delta_minutes) <= (8*7*24*60)) { // eight weeks... I'm lazy to count days for longer than that
    distance = distance_of_time_in_words(delta_minutes);
    if (delta_minutes < 0) {
      return distance + ' 以后';
    } else {
      return distance + ' 前';
    }
  } else {
    return 'on ' + system_date.toLocaleDateString();
  }
}
function distance_of_time_in_words(minutes) {
  if (minutes.isNaN) return "";
  minutes = Math.abs(minutes);
  if (minutes < 1) return ('不到一分钟');
  if (minutes < 50) return (minutes + ' 分' + (minutes == 1 ? '' : ''));
  if (minutes < 90) return ('大约一小时');
  if (minutes < 1080) return (Math.round(minutes / 60) + ' 小时');
  if (minutes < 1440) return ('一天');
  if (minutes < 2880) return ('大约一天');
  else return (Math.round(minutes / 1440) + ' 天')
}