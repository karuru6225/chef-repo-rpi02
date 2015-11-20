mkdir tmp
cd tmp
wget ftp://ftp.arin.net/pub/stats/arin/delegated-arin-extended-latest
wget ftp://ftp.ripe.net/pub/stats/ripencc/delegated-ripencc-extended-latest
wget ftp://ftp.apnic.net/pub/stats/apnic/delegated-apnic-extended-latest
wget ftp://ftp.lacnic.net/pub/stats/lacnic/delegated-lacnic-extended-latest
wget ftp://ftp.afrinic.net/pub/stats/afrinic/delegated-afrinic-extended-latest
cd ..
cat tmp/* | grep ipv4 | grep -v '*' | sed  's/||/|00|/g' | awk -f ip.awk | sort -k 2 -n | awk -f ipmerge.awk | awk -f ipmerge.awk | awk -f ipmerge.awk | awk -f ipmerge.awk | awk -f ipmerge.awk | sort -k 1,1 -k 2n,2 -k 3n,3 -k 4n,4 -k 5n,5 | grep -v '00\|ZZ'

