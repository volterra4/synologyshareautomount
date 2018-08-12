# Synology encrypted shares auto mounter
The script present in this GitHub repository is based on an original idea based on the thread at 

https://forum.synology.com/enu/viewtopic.php?f=36&t=142308

## Description
The repository provides a shell and a php scripts that can be used for automatically mounting encrypted shares on Synology NASes that are running latest version of DSM.

This methodology is based on a client-server methodology that takes advantage of a remote php script to download the decryption key if the internet IP address of the Synology lies in a set of trusted IPs.

Multi shares can be used as well.

For a complete description of the underlying problematics, please refer to the synology forum web page.

## Usage

The repository consists of two files:

+ A PHP script that needs to be placed over a remote server
+ A bash script to be placed on the Synology

For the PHP part, please refer to the Synology forum link above.

The bash script can be add to the Synology scheduler functionality and it can be triggered after the device boot.
In order to be properly executed, the following parameters need to be provided:

```bash
./mountshare.sh <url> <sharename> <password> <hostname> <try_delay> <max_try _number>
```

The shell script will contact the php script placed at the *< url >* address to mount the <sharename> shared folder. The script checks automatically the availability of the internet connection for a maximum of 
*< max_try _number >* tries, and waits *< try_delay >* seconds between consecutive tentatives. In order to check internet availability, 
a ping command is executed to check whether *< hostname >* responds or not. If yes, *< url >* will be contacted and the hashed decryption key
will be downloaded from the php script and decrypted with the *< password >* argument for mounting the encrypted share.


Additional details can be found in the .sh file.

