for i in `seq 1 72`
do
	sed '/^@.*/d;/^\r/d' "$i.txt" > "tmp.txt"
	mv "tmp.txt" "$i.txt"
done
