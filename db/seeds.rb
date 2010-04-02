# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
# Keshi.create(:title=>"aaa",:reserve=>"")
# Keshi.create(:title=>"bbb",:reserve=>"")
# Catelog.create(:title=>"分类1",:information=>"简介....",:keshi_id=>1)
# Catelog.create(:title=>"分类2",:information=>"简介2....",:keshi_id=>1)
# Catelog.create(:title=>"分类1",:information=>"简介2-1....",:keshi_id=>2)
# Catelog.create(:title=>"分类2",:information=>"简介2-2....",:keshi_id=>2)
# Role.create(:rolename=>"admin")
# Role.create(:rolename=>"user")
# 
# FuzhuType.create(:title=>"影像科",:parent_id=>0)
# FuzhuType.create(:title=>"检验科",:parent_id=>0)
# FuzhuType.create(:title=>"x线",:parent_id=>1)
# FuzhuType.create(:title=>"ct",:parent_id=>1)
# FuzhuType.create(:title=>"mri",:parent_id=>1)
# FuzhuType.create(:title=>"超声",:parent_id=>1)
# FuzhuType.create(:title=>"血常规",:parent_id=>2)
# FuzhuType.create(:title=>"尿常规",:parent_id=>2)

User.find(16).roles << Role.find(1)
