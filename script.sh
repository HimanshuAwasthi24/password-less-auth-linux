#!/bin/bash
ssh-keygen -t rsa -m PEM
ls -lah ~/.ssh
cat ~/.ssh/id_rsa.pub
cat ~/.ssh/id_rsa.pub | ssh -i ~/path/to/your/key.pem ubuntu@your-ec2-public-dns "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
ssh -i ~/path/to/your/key.pem ubuntu@your-ec2-public-dns "cat ~/.ssh/authorized_keys"
ssh ubuntu@your-ec2-public-dns
