# Author:           Twisted World, JasonP, Volterra
# Web-page:         https://github.com/volterra4/synologyshareautomount
# Original idea:    https://forum.synology.com/enu/viewtopic.php?f=36&t=142308
if [ "$#" -ne 6 ]; then
    echo "Usage: ./mountshare.sh <url> <sharename> <password> <hostname> <try_delay> <max_try _number>"
    echo "---"
    echo "<url> is the url towards which the wget command is executed"
    echo "<sharename> is the name of the encrypted share to be mounted"
    echo "<password> is the password used to decrypt the password coming from the web server"
    echo "<hostname> must be either an ip or an hostname used to check internet connection availability through a ping"
    echo "<try_delay> is the wait period (in seconds) between adjacent tries"
    echo "<max_try_number> specifies the maximum number of tries before giving up"
else

    ((delay = $5)) # Delay between each try
    ((count = $6)) # Maximum number of tries

    echo "["$(date)"] - Started automatic share mounter"
    echo "["$(date)"] - Time delay between each try "$delay" seconds"
    echo "["$(date)"] - Maximum number of tries "$count""
    while [[ $count -ne 0 ]] ; do
        sleep $delay
        ping -c 1 $4 > /dev/null #Check internet availability
        rc=$?
        if [[ $rc -eq 0 ]] ; then
            echo "["$(date)"] - Internet available"
            cryptpass=$(wget -nv -O -q - $1?$2)
            if [[ $? -eq 0 ]]; then
                password=$(echo "$cryptpass" | openssl enc -aes-256-cbc -a -d -salt -pass pass:$3)
                echo "["$(date)"] - Mounting the encrypted share: "$2""
                result=$(synoshare --enc_mount $2 $password)
                if [[ $? -eq 0 ]]; then
                     password=""
                     echo "["$(date)"] - Mount succesfull! "
                     ((count=1))
                else
                     echo "["$(date)"] - Problems during mount: "$result
                fi
            fi
        fi
        ((count = count - 1))
    done
fi
