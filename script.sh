#!/bin/bash

# Step 1: Prompt the user for the private key PEM file path
read -p "Enter the path to your PEM file (e.g., ~/path/to/key.pem): " PEM_FILE

# Step 2: Prompt the user for the destination machine's public IP address (IPv4)
read -p "Enter the IPv4 address of the destination machine (e.g., 54.123.45.67): " DEST_IP

# Step 3: Prompt the user for the SSH username on the destination machine (default 'ubuntu' for EC2)
read -p "Enter the SSH username on the destination machine (default is 'ubuntu'): " SSH_USER
SSH_USER=${SSH_USER:-ubuntu}  # Default to 'ubuntu' if the user didn't provide a username

# Step 4: Generate SSH key pair (RSA format, PEM encoding)
echo "Generating SSH key pair..."
ssh-keygen -t rsa -b 2048 -m PEM -f ~/.ssh/id_rsa -N ""

# Step 5: List the files in the ~/.ssh directory to confirm the key pair was created
ls -lah ~/.ssh

# Step 6: Display the public key to be copied
cat ~/.ssh/id_rsa.pub

# Step 7: Copy the public key to the remote EC2 instance and append it to the authorized_keys file
echo "Copying the public key to the remote machine..."
cat ~/.ssh/id_rsa.pub | ssh -i "$PEM_FILE" "$SSH_USER@$DEST_IP" \
    "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"

# Step 8: Verify the remote authorized_keys file contains the new key
echo "Verifying the authorized_keys file on the remote machine..."
ssh -i "$PEM_FILE" "$SSH_USER@$DEST_IP" "cat ~/.ssh/authorized_keys"

# Step 9: Test SSH connection to EC2 instance without password
echo "Testing SSH connection to the remote machine..."
ssh "$SSH_USER@$DEST_IP"
