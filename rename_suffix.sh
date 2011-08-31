suffix=$1
new_suffix=$2
#suffix="SLD"
#new_suffix="sld"

assa=`find . -name "*.${suffix}"`
for i in $assa
do 
echo git mv $i ${i}1
echo git mv ${i}1 ${i}2
done >plot.log

sed -i "s/[.]${suffix}2/.${new_suffix}/" plot.log