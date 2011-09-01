echo 'Section "sh[xp]"' >sh[xp].txt

assa=`find . -name "*.sh[xp]"`
for i in $assa
do
  dn=`dirname $i`

  echo "  SetOutPath \$INSTDIR/$dn"
  echo "  File $i"
done >>sh[xp].txt

echo 'SectionEnd' >>sh[xp].txt

for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
do
  sed -i "s/\//\\\/" sh[xp].txt
done


echo 'Section "un.sh[xp]"' >un.sh[xp].txt

for i in $assa; do  echo "  Delete \$INSTDIR/$i"; done >>un.sh[xp].txt
for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
do
  sed -i "s/\//\\\/" un.sh[xp].txt
done

echo 'SectionEnd' >>un.sh[xp].txt
