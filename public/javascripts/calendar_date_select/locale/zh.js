Date.weekdays = $w('周一 周二 周三 周四 周五 周六 周日');
Date.months = $w("一月 二月 三月 四月 五月 六月 七月 八月 九月 十月 十一月 十二月");

Date.first_day_of_week = 1;

_translations = {
  "OK": "确定",
  "Now": "现在",
  "Today": "今天",
  "Clear": "清除"
}
Date.prototype.getAMPM = function() { return (this.getHours() < 12) ? "上午" : "下午"; }