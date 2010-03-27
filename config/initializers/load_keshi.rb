$ccc=[]
Keshi.find(:all).each{|k|$ccc << [k.title,k.id]}
$zhicheng={1=>"初级",2=>"中级",3=>"高级"}
