#!/bin/bash

printf "\n"
cat <<EOF



EOF

# Create a new screen session
echo -e "\n📟 Resuming Pipe Point Status"
    cd ~/pipe-node
    while true; do
        echo '📊 Node Status:'
        ./pop --status
        echo ''
        echo '🏆 Check Points:'
        ./pop --points
        echo ''
        echo '⏰ Check Active Time:'
        ./pop --stats
        echo '🔄 Updating in 10 seconds...'
        sleep 10
    done
