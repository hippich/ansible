
### Prepare the server

Create a user account for Ansible to do its thing through:

```
useradd deploy
passwd deploy
mkdir /home/deploy
```

Authorize your ssh key if you want passwordless ssh login:

```
mkdir /home/deploy/.ssh
chmod 700 /home/deploy/.ssh
nano /home/deploy/.ssh/authorized_keys
chmod 400 /home/deploy/.ssh/authorized_keys
chown deploy:deploy /home/deploy -R
echo 'deploy ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/deploy
```
