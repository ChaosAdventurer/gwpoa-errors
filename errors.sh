#!/bin/bash
# to quickly pull useful error data of of the GW POA logs that otherwise gets too unweildly.
# created by Andy Konecny, 2013-05-24, last updated 2015-03-24
#
# Intended to be run from/in the same directory as the log files
#
# Pulls all errors, filtering out the ones we know about for seperate handling with notes. 
# Make sure to see errors/errors.txt for any remaining not yet tracked ones. 
# Basically created to track problems as encountered at my clients. 
# for error details see https://www.novell.com/documentation/nwec/?page=/documentation/nwec/nwec/data/hvutyoos.html
# 
# Naming format of the logs are MMDDpoa.### with the ### starting at 001 and incrementing up.
# Future possibles would be to extract errors from just the last X days
#

#LOG="031?poa.0??"

if [ $# -eq 0 ]; then
  LOG="*poa.currentlog"
else   
  if [ $1 = all ]; then
    LOG="????poa.???"
  else
    LOG="*poa.currentlog"
  fi
fi  
if [ ! -d "errors" ]; then  
  mkdir errors
fi
echo "Checking $LOG for errors. See files in the errors folder."
grep -i error $LOG >errors/raw.txt
grep -v 8F07 errors/raw.txt |grep -v 8101 |grep -v 8F17 |grep -v C006 |grep -v D019 |grep -v D07D |grep -v D103 |grep -v D113 |grep -v D11B |grep -v D12A|grep -v E521|grep -v 8911|grep -v D01B >errors/errors.txt
#
echo "Error 8F07  appears to indicate 'lost' clients (powered off?)" >errors/err_8F07.txt
grep 8F07 errors/raw.txt >>errors/err_8F07.txt
if [ $? -eq 1 ]; then
  rm errors/err_8F07.txt
fi
echo "Error 8101  Memory error: frequent occurance indicate more RAM suggested" >errors/err_8101.txt
grep 8101 errors/raw.txt >>errors/err_8101.txt
if [ $? -eq 1 ]; then
  rm errors/err_8101.txt
fi
echo "Error 8F17  Document conversion fail, either corrupt or unsupported format" >errors/err_8F17.txt
grep 8F17 errors/raw.txt >>errors/err_8F17.txt
if [ $? -eq 1 ]; then
  rm errors/err_8F17.txt
fi
echo "Error C006  Record, key, or key reference not found" >errors/err_C006.txt
grep C006 errors/raw.txt >>errors/err_C006.txt
if [ $? -eq 1 ]; then
  rm errors/err_C006.txt
fi
echo "Error D019  Password incorrect" >errors/err_D019.txt
grep D019 errors/raw.txt >>errors/err_D019.txt
if [ $? -eq 1 ]; then
  rm errors/err_D019.txt
fi
echo "Error D07D  blocking SPAM" >errors/err_D07D.txt
grep D07D errors/raw.txt >>errors/err_D07D.txt
if [ $? -eq 1 ]; then
  rm errors/err_D07D.txt
fi
echo "Error D103  Post Office not found." >errors/err_D103.txt
grep D103 errors/raw.txt >>errors/err_D103.txt
if [ $? -eq 1 ]; then
  rm errors/err_D103.txt
fi
echo "Error D11B  Too many items in mailbox" >errors/err_D11B.txt
grep D11B errors/raw.txt >>errors/err_D11B.txt
if [ $? -eq 1 ]; then
  rm errors/err_D11B.txt
fi
echo "Error D113  Open database maximum exceeded / Domain not found" >errors/err_D113.txt
grep D113 errors/raw.txt >>errors/err_D113.txt
if [ $? -eq 1 ]; then
  rm errors/err_D113.txt
fi
echo "Error D12A  Name too long   gwcheck user contents user-db-only, resfldr" >errors/err_D12A.txt
grep D12A errors/raw.txt >>errors/err_D12A.txt
if [ $? -eq 1 ]; then
  rm errors/err_D12A.txt
fi
echo "Error E521  Invalid Library ID  end user search opps. See TID 10023743" >errors/err_E521.txt
grep E521 errors/raw.txt >>errors/err_E521.txt
if [ $? -eq 1 ]; then
  rm errors/err_E521.txt
fi
echo "Error 8911  write on TPC/IP connection. Sadly a common GMS SOAP issue" >errors/err_8911.txt
grep 8911 errors/raw.txt >>errors/err_8911.txt
if [ $? -eq 1 ]; then
  rm errors/err_8911.txt
fi
echo "Error D01B  streaming an attachment. related to Retain and other SOAP access. See bug 916172" >errors/err_D01B.txt
echo "Fixed in GW2012/2014 builds 119346 and up (2012.4/2014.2)"  >>errors/err_D01B.txt
echo "http://support.gwava.com/kb/?View=entry&EntryID=2435"  >>errors/err_D01B.txt
grep 8911 errors/raw.txt >>errors/err_D01B.txt
if [ $? -eq 1 ]; then
  rm errors/err_D01B.txt
fi

 
