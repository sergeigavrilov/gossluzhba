#!/bin/bash
curdate() {
    date +%Y%m%d-%H%M%S
}

# path to the JMeter BIN directory
jmDir=~/jmeter/bin
# path to directory 
resDir=testdata
# Desired transfer protocol (http or https)
protocol=https
# address of the tested host
host=gossluzhba.gov.ru
# active port on the tested host
port=443
# how many test iterations should be performed. 
#Set -1 for forever loop and kill the test with shutdown command
LoopCnt=1
# Number of the threads to run
ThreadsCnt=1
# seconds, Time to start the entire threads
RampUp=1
# Index of the desired article in the list
newsIndex=25


# Name of the file with desired test case to run
filename=getNews

if [[ ! -e $resDir ]]; then 
    mkdir $resDir
fi

echo "Run $filename script for $ThreadsCnt threads"

${jmDir}/jmeter -j $resDir/${filename}-${ThreadsCnt}_$(curdate).log \
    -t ${filename}.jmx -n -JRampUp=$RampUp -JThreadsCnt=$ThreadsCnt -Jprotocol=$protocol \
    -JLoopCnt=$LoopCnt -Jhost=$host -Jport=$port -Jresdir=$resDir -JnewsIndex=$newsIndex
