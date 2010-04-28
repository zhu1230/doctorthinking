# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
Keshi.create(:title=>"心脏内科",:reserve=>"内科")
Keshi.create(:title=>"肾内科",:reserve=>"内科")
Keshi.create(:title=>"消化内科",:reserve=>"内科")
Keshi.create(:title=>"肿瘤内科",:reserve=>"内科")
Keshi.create(:title=>"呼吸内科",:reserve=>"内科")
Keshi.create(:title=>"血液科",:reserve=>"内科")
Keshi.create(:title=>"神经内科",:reserve=>"内科")
Keshi.create(:title=>"内分泌科",:reserve=>"内科")

Keshi.create(:title=>"骨科",:reserve=>"外科")
Keshi.create(:title=>"普通外科",:reserve=>"外科")
Keshi.create(:title=>"心胸外科",:reserve=>"外科")
Keshi.create(:title=>"神经外科",:reserve=>"外科")
Keshi.create(:title=>"泌尿外科",:reserve=>"外科")


Keshi.create(:title=>"检验科",:reserve=>"医技科室")
Keshi.create(:title=>"病理科",:reserve=>"医技科室")
Keshi.create(:title=>"影像科",:reserve=>"医技科室")
Keshi.create(:title=>"超声诊断科",:reserve=>"医技科室")
Keshi.create(:title=>"核医学科",:reserve=>"医技科室")
Keshi.create(:title=>"放疗科",:reserve=>"医技科室")
Keshi.create(:title=>"超声诊断科",:reserve=>"医技科室")
Keshi.create(:title=>"核医学科",:reserve=>"医技科室")

Keshi.create(:title=>"妇产科",:reserve=>"专科")
Keshi.create(:title=>"儿科",:reserve=>"专科")
Keshi.create(:title=>"急诊科",:reserve=>"专科")
Keshi.create(:title=>"眼科",:reserve=>"专科")
Keshi.create(:title=>"耳鼻喉科",:reserve=>"专科")
Keshi.create(:title=>"口腔科",:reserve=>"专科")
Keshi.create(:title=>"皮肤科",:reserve=>"专科")
Keshi.create(:title=>"烧伤整形科",:reserve=>"专科")
Keshi.create(:title=>"麻醉科",:reserve=>"专科")


# Catelog.create(:title=>"消化内科",:information=>"简介....",:keshi_id=>1)
# Catelog.create(:title=>"",:information=>"简介2....",:keshi_id=>1)
# Catelog.create(:title=>"",:information=>"简介2-1....",:keshi_id=>2)
# Catelog.create(:title=>"分类2",:information=>"简介2-2....",:keshi_id=>2)
Role.create(:rolename=>"admin")
Role.create(:rolename=>"master")
Role.create(:rolename=>"user")

FuzhuType.create(:title=>"影像科",:parent_id=>0) do |f|
f.childs << FuzhuType.new(:title=>"X线")
f.childs << FuzhuType.new(:title=>"CT")
f.childs << FuzhuType.new(:title=>"MRI")
f.childs << FuzhuType.new(:title=>"DSA－数字减影血管造影")
f.childs << FuzhuType.new(:title=>"PET-CT")
f.childs << FuzhuType.new(:title=>"其他")
end
FuzhuType.create(:title=>"超声诊断科",:parent_id=>0) do |f|
f.childs << FuzhuType.new(:title=>"腹部超声")
f.childs << FuzhuType.new(:title=>"血管超声")
f.childs << FuzhuType.new(:title=>"心脏超声")
f.childs << FuzhuType.new(:title=>"介入超声")
f.childs << FuzhuType.new(:title=>"其他")
end
FuzhuType.create(:title=>"检验科",:parent_id=>0) do |f|
f.childs << FuzhuType.new(:title=>"生化项目")
f.childs << FuzhuType.new(:title=>"免疫项目")
f.childs << FuzhuType.new(:title=>"临检项目")
f.childs << FuzhuType.new(:title=>"其他")
end

ForumTopic.create(:title=>"临床经验交流",:user_id=>1,:description=>"分享您在临床中的诊疗疾病的经验，治疗方法心得等等与临床相关的")
ForumTopic.create(:title=>"药物使用交流",:user_id=>1,:description=>"药物比较，药物使用，合理用药等")
ForumTopic.create(:title=>"医学检查技术",:user_id=>1,:description=>"分享您在临床中的各种操作技术，检查技术")
ForumTopic.create(:title=>"科研思想，方法交流",:user_id=>1,:description=>"前沿的科研技术，选题，方向，方法，实验，结果等等")
ForumTopic.create(:title=>"医疗杂谈",:user_id=>1,:description=>"医疗新观点，求助等等。")

Theme.create(:name=>"doctor")
