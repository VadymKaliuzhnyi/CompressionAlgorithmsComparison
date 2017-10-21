#!/bin/bash

# 0. Method which take take test case (archiving command)
# exectes it, measure time and filesizediff, write results to file
# move file to dummy folder
process()
{
START=$(date +%s)
echo "-----  $1  ------"
$1
END=$(date +%s)
DIFF=$(( $END - $START ))
FILESIZE=$(stat -c%s "$2")
PERC=$(div $OriginalSize $FILESIZE)
echo "$1,$DIFF,$3,$4,$OriginalSize,$FILESIZE,$PERC" >> results.csv
mv $2 ./ArchivedTestData/$2
}

# 0. Method which take take test case (archiving command)
# exectes it, measure time and filesizediff, write results to file
# move file to dummy folder
process2()
{
START=$(date +%s)
echo "-----  $1  ------"
$1
END=$(date +%s)
DIFF=$(( $END - $START ))
FILESIZE=$(stat -c%s "$2")
PERC=$(div $OriginalSize $FILESIZE)
echo "$1,$DIFF,$4,$5,$OriginalSize,$FILESIZE,$PERC" >> results.csv
mv $2 ./ArchivedTestData/$3
}

# 0. Method which take variables and return result of operation
div ()  # Arguments: dividend and divisor
{
        if [ $2 -eq 0 ]; then echo division by 0; exit; fi
        local p=6                            # precision
        local c=${c:-0}                       # precision counter
        local d=.                             # decimal separator
        local r=$(($1/$2)); echo -n $r        # result of division
        local m=$(($r*$2))
        [ $c -eq 0 ] && [ $m -ne $1 ] && echo -n $d
        [ $1 -eq $m ] || [ $c -eq $p ] && return
        local e=$(($1-$m))
        let c=c+1
        div $(($e*10)) $2
}

# 1. Update the system and install required apps
sudo apt-get update
yes | sudo apt-get upgrade
yes | sudo apt-get install p7zip-full lzop liblz4-tool gzip bzip2 rar unrar-free

# 2. Clearing all possible files
echo
echo "Clearing all existing archeves in folder. Press any key to proceed."
rm results.csv
rm -r ArchivedTestData/
echo "Clearing is done. Press any key to proceed."
echo

# 3. Defining new test file
echo "Enter input file name"
read INPUTFILE
echo

# 4. Starting points
echo "Start acrhiving..."
mkdir ArchivedTestData
echo "ArchCmd,Time,AppName,Algo,OrigFS,CompressedFS,OrigFS/CompressedFS" >> results.csv
OriginalSize=$(stat -c%s "$INPUTFILE")
echo "Original file size: $OriginalSize"
echo

# 5. Processing test cases one by one
process "7z -t7z -mx=9 -mfb=273 -ms=on -mmt=on -m0=lzma2 a 7z.mx9.mfb.mntOn.msOn.lzma2 $INPUTFILE" "7z.mx9.mfb.mntOn.msOn.lzma2" "7z" "lzma2"
process "7z -t7z -mx=9 -mfb=273 -ms=on -mmt=2 -m0=lzma2 a 7z.mx9.mfb.mnt2.msOn.lzma2 $INPUTFILE" "7z.mx9.mfb.mnt2.msOn.lzma2" "7z" "lzma2"
process "7z -t7z -mx=9 -ms=on -mmt=on -m0=lzma2 a 7z.mx9.mntOn.msOn.lzma2 $INPUTFILE" "7z.mx9.mntOn.msOn.lzma2" "7z" "lzma2"
process "7z -t7z -mx=9 -ms=on -mmt=2 -m0=lzma2 a 7z.mx9.mnt2.msOn.lzma2 $INPUTFILE" "7z.mx9.mnt2.msOn.lzma2" "7z" "lzma2"
process "7z -t7z -mx=9 -mfb=273 -mmt=on -m0=lzma2 a 7z.mx9.mfb.mntOn.lzma2 $INPUTFILE" "7z.mx9.mfb.mntOn.lzma2" "7z" "lzma2"
process "7z -t7z -mx=9 -mfb=273 -mmt=2 -m0=lzma2 a 7z.mx9.mfb.mnt2.lzma2 $INPUTFILE" "7z.mx9.mfb.mnt2.lzma2" "7z" "lzma2"
process "7z -t7z -mx=9 -mmt=on -m0=lzma2 a 7z.mx9.mntOn.lzma2 $INPUTFILE" "7z.mx9.mntOn.lzma2" "7z" "lzma2"
process "7z -t7z -mx=9 -mmt=2 -m0=lzma2 a 7z.mx9.mnt2.lzma2 $INPUTFILE" "7z.mx9.mnt2.lzma2" "7z" "lzma2"

process "7z -t7z -mx=9 -mfb=273 -ms=on -mmt=on -m0=lzma a 7z.mx9.mfb.mntOn.msOn.lzma $INPUTFILE" "7z.mx9.mfb.mntOn.msOn.lzma" "7z" "lzma"
process "7z -t7z -mx=9 -mfb=273 -ms=on -mmt=2 -m0=lzma a 7z.mx9.mfb.mnt2.msOn.lzma $INPUTFILE" "7z.mx9.mfb.mnt2.msOn.lzma" "7z" "lzma"
process "7z -t7z -mx=9 -ms=on -mmt=on -m0=lzma a 7z.mx9.mntOn.msOn.lzma $INPUTFILE" "7z.mx9.mntOn.msOn.lzma" "7z" "lzma"
process "7z -t7z -mx=9 -ms=on -mmt=2 -m0=lzma a 7z.mx9.mnt2.msOn.lzma $INPUTFILE" "7z.mx9.mnt2.msOn.lzma" "7z" "lzma"
process "7z -t7z -mx=9 -mfb=273 -mmt=on -m0=lzma a 7z.mx9.mfb.mntOn.lzma $INPUTFILE" "7z.mx9.mfb.mntOn.lzma" "7z" "lzma"
process "7z -t7z -mx=9 -mfb=273 -mmt=2 -m0=lzma a 7z.mx9.mfb.mnt2.lzma $INPUTFILE" "7z.mx9.mfb.mnt2.lzma" "7z" "lzma"
process "7z -t7z -mx=9 -mmt=on -m0=lzma a 7z.mx9.mntOn.lzma $INPUTFILE" "7z.mx9.mntOn.lzma" "7z" "lzma"
process "7z -t7z -mx=9 -mmt=2 -m0=lzma a 7z.mx9.mnt2.lzma $INPUTFILE" "7z.mx9.mnt2.lzma" "7z" "lzma"

process "7z -txz -mx=9 -mfb=273 -mmt=on -m0=lzma2 a xz.mx9.mfb.mntOn.lzma2 $INPUTFILE" "xz.mx9.mfb.mntOn.lzma2" "7z (xz)" "lzma2"
process "7z -txz -mx=9 -mfb=273 -mmt=2 -m0=lzma2 a xz.mx9.mfb.mnt2.lzma2 $INPUTFILE" "xz.mx9.mfb.mnt2.lzma2" "7z (xz)" "lzma2"
process "7z -txz -mx=9 -mmt=on -m0=lzma2 a xz.mx9.mntOn.lzma2 $INPUTFILE" "xz.mx9.mntOn.lzma2" "7z (xz)" "lzma2"
process "7z -txz -mx=9 -mmt=2 -m0=lzma2 a xz.mx9.mnt2.lzma2 $INPUTFILE" "xz.mx9.mnt2.lzma2" "7z (xz)" "lzma2"

process "lz4 -9f $INPUTFILE lz4.9f" "lz4.9f" "lz4" "lz4 (LZ77 family)"

process "rar a -m5 rar.m5 $INPUTFILE" "rar.m5" "rar" "LZSS"

process "zip -9v zip.9v $INPUTFILE" "zip.9v" "zip" "Deflate"

process2 "xz -9k $INPUTFILE" "$INPUTFILE.xz" "xz.9k" "xz" "lzma2"

process2 "xz -9ke $INPUTFILE" "$INPUTFILE.xz" "xz.9ke" "xz" "lzma2"

process2 "bzip2 -9vk $INPUTFILE" "$INPUTFILE.bz2" "bz2.9vk" "bzip2" "BWT"

process2 "gzip -9k $INPUTFILE" "$INPUTFILE.gz" "gz.9k" "gzip" "Deflate"

process2 "lzop -9 -v $INPUTFILE" "$INPUTFILE.lzo" "lzo.9v" "lzop" "LZO"

