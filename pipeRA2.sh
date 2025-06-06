#!/bin/bash

printf "\n"
cat <<EOF


RIXAL Drops to Ensure and Start Mining Pipe Node
EOF

printf "\n\n"

##########################################################################################
#                                                                                        
#                🚀 THIS SCRIPT IS PROUDLY CREATED BY **RixalDrops**! 🚀                  
#                                                                                        
#   🌐 Join our revolution in decentralized networks and crypto innovation!               
#                                                                                        
# 📢 Stay updated:                                                                      
#     • Follow us on Telegram: https://t.me/mrrixtech                             
#     • Follow us on X: https://x.com/mrrixcrypto                                       
##########################################################################################

# Define colors
GREEN="\033[0;32m"
RESET="\033[0m"

# Print welcome message
printf "${GREEN}"
printf "🚀 THIS SCRIPT IS PROUDLY CREATED BY **Rixal Drops**! 🚀\n"
printf "Stay connected for updates:\n"
printf "   • Telegram: https://t.me/mrrixtech"
printf "   • X (formerly Twitter): https://x.com/mrrixcrypto"
printf "${RESET}"

# Check if the "Pipemrrix" screen session exists
if screen -list | grep -q "Pipemrrix"; then
    echo -e "\n✅ Existing 'Pipemrrix' screen session found! Resuming it..."
    screen -r Pipemrrix
    exit 0
fi

echo "==========================================================="
echo "🚀  Welcome to the PiPe Network Node Installer 🚀"
echo "==========================================================="
echo ""
echo "🌟 Your journey to decentralized networks begins here!"
echo "✨ Follow the steps as the script runs automatically for you!"
echo ""

# Ask the user for input
read -p "🔢 Enter RAM allocation (in GB, e.g., 8): " RAM
read -p "💾 Enter Disk allocation (in GB, e.g., 500): " DISK
read -p "🔑 Enter your Solana wallet Address: " PUBKEY

# Ask for the referral code, but enforce the default one
read -p "🫂 Enter your Referral Code: " USER_REFERRAL
REFERRAL_CODE="c733bc7b233e9ab9"  # Your default referral code

# Print the referral code that will actually be used
echo -e "\n✅ Using Referral Code: $REFERRAL_CODE (default enforced)"

# Confirm details
echo -e "\n📌 Configuration Summary:"
echo "   🔢 RAM: ${RAM}GB"
echo "   💾 Disk: ${DISK}GB"
echo "   🔑 PubKey: ${PUBKEY}"
read -p "⚡ Proceed with installation? (y/n): " CONFIRM
if [[ "$CONFIRM" != "y" ]]; then
    echo "❌ Installation canceled!"
    exit 1
fi

# Update system
echo -e "\n🔄 Updating system packages..."
sudo apt update -y && sudo apt upgrade -y

# Install dependencies
echo -e "\n⚙️ Installing required dependencies..."
sudo apt install -y curl wget jq unzip screen

# Create a directory for PiPe node
echo -e "\n📂 Setting up PiPe node directory..."
mkdir -p ~/pipe-node && cd ~/pipe-node

# Download the latest PiPe Network binary (pop)
echo -e "\n⬇️ Downloading PiPe Network node (pop)..."
curl -L -o pop "https://dl.pipecdn.app/v0.2.8/pop"

# Make binary executable
chmod +x pop

# Verify installation
echo -e "\n🔍 Verifying pop binary..."
./pop --version || { echo "❌ Error: pop binary is not working!"; exit 1; }

# Create download cache directory
echo -e "\n📂 Creating download cache directory..."
mkdir -p download_cache

# Sign up using the referral code
echo -e "\n📌 Signing up for PiPe Network using referral..."
./pop --signup-by-referral-route "$REFERRAL_CODE"
if [ $? -ne 0 ]; then
    echo "❌ Error: Signup failed!"
    exit 1
fi

# Generate referral
echo -e "\n🫂 Your Referral Code..."
./pop --gen-referral-route

# Start PiPe node
echo -e "\n🚀 Starting PiPe Network node..."
sudo ./pop --ram "$RAM" --max-disk "$DISK" --cache-dir /data --pubKey "$PUBKEY" &

# Save node information
echo -e "\n📜 Saving node information..."
cat <<EOF > ~/node_info.json
{
    "RAM": "$RAM",
    "Disk": "$DISK",
    "PubKey": "$PUBKEY",
    "Referral": "$REFERRAL_CODE"
}
EOF

echo -e "\n✅ Node information saved! (nano ~/node_info.json to edit)"
