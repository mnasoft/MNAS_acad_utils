cd ../
for i in `find . -name "*.prv"`
do 
echo 'MakePrv(acad_w_path + "'$i'");'
done