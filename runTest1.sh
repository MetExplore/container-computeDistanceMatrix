#!/bin/bash
#
#Script used to perform unitary tests on pathway enrichment tool
#
#Author: M. Chazalviel & E. CAMENEN
#
#Copyright: PhenoMeNal/INRA Toulouse 2018

#Settings files
OUTFILE1="temp/matrix.txt"
OUTFILE2="temp/reactionsPAth.txt"

SBML="data/recon2.v03_ext_noCompartment_noTransport.xml"
AAM="data/recon2.v03_ext_noCompartment_noTransport_C-AAM-weights.tab"
FINGERPRINT="data/fingerprintHE.txt"

testFileExist(){
    [ ! -f $OUTFILE1 ] && {
        echo "$OUTFILE1 does not exist"
        BOOLEAN_ERR="true"
    }
    [ ! -f $OUTFILE2 ] && {
        echo "$OUTFILE2 does not exist"
        BOOLEAN_ERR="true"
    }
}

########### MAIN ###########

START_TIME=$(date -u -d $(date +"%H:%M:%S") +"%s")
printf "Tests in progress, could take an second...\n"
java -jar fingerprintSubnetwork.jar -algo ShortestAsUndirected -network ${SBML}  -fingerprint ${FINGERPRINT} -atommapping ${AAM} -matrixresult ${OUTFILE1} -reactionresult ${OUTFILE2}

testFileExist

rm -r temp/
getElapsedTime ${START_TIME}
[[ ${BOOLEAN_ERR} ]] || exit 1
exit 0