#! /bin/bash
IMAGE_ID="fd85h99uh6sdg7gck9cg"  # Replace with the actual image_id
SSH_KEY_PATH="../infrastructure/05-infra/.secrets/reddit-app/id_rsa.pub"  # Replace with the actual path to the SSH key

yc compute instance create --name=reddit-app --zone=ru-central1-a --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 --create-boot-disk image-id="$IMAGE_ID" --ssh-key "$SSH_KEY_PATH"
