# 向Oracle插入100条数据
#!/bin/bash
for ((i=2;i<=100;i++)) do
su - oracle <<EON
sqlplus test6444/123456 <<EOF 
insert into test6444.student(id,name) values('${i}','zhoushuiping');
commit;
EOF
EON
done
