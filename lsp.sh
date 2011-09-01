assa=`find . -name "*.lsp"`
for i in $assa; do  echo "  File -r $i"; done >lsp.txt
for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
do
  sed -i "s/\//\\\/" lsp.txt
done

for i in $assa; do  echo "  Delete \$INSTDIR/$i"; done >un.lsp.txt
for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
do
  sed -i "s/\//\\\/" un.lsp.txt
done
