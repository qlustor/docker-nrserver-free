[![](https://images.microbadger.com/badges/version/qlustor/nrserver-free.svg)](https://microbadger.com/images/qlustor/nrserver-free "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/qlustor/nrserver-free.svg)](https://microbadger.com/images/qlustor/nrserver-free "Get your own image badge on microbadger.com")

# NeoRouter Free server, docked...

![](http://www.neorouter.com/img/screenshots/Windows/Client/Client8.png)

I've wanted to dockerize my NeoRouter server for a while now but it has been a bit challenging to do, but after some head-bashing this is the result of that success. The largest challenges were insuring that unique encryption keys were generated upon initial run as well as service recovery worked should the nrserver fail within the container.

This docker is NOT fully functional after initial run and YOU MUST CONNECT TO THE CONTAINER AND nrsetup! unless you have an existing nr setup in which case you can copy your configuration into the folder you connect to the docker's volume (/usr/local/ZebraNetworkSystems/NeoRouter within the container). The volume is mandatory and persists all of your configuration.

# Running
    docker run -d -p 32976:32976 -v /my/local/directory:/usr/local/ZebraNetworkSystems/NeoRouter --name nrserver-free qlustor/nrserver-free

# Configuring
Connect to the container with:

    docker exec -ti nrserver-free sh

If you DO NOT wish to be part of neorouter's cloud console and can resolve you nrserver's address another way, simply add your first adminsitrator's account with:

```
# nrserver -adduser adminusername adminuserspassword admin
NeoRouter Free [Version 2.3.1.4360]
Copyright (C) 2017 NeoRouter Inc.

*** Please run this command as root ***

SUCCEEDED
```

Otherwise just run through the nrsetup wizard:

```
# nrsetup
NeoRouter Server Install Wizard
Copyright (C) 2017 NeoRouter Inc.

*** Please run this command as root ***

Step 1 - Setup NeoRouter Domain:
    NeoRouter domain name uniquely identifies your NeoRouter server, and is required to login NeoRouter client.
    Do you already have a NeoRouter domain(y/n): y
    Please enter domain info.
    Enter domain name: domain
    Enter domain password:
    Domain setup succeeded.

Step 2 - Setup Administrator Account:
    NeoRouter can defer authentication to the operating system. If your OS user account has a non-empty password, you can use the same username/password to login NeoRouter and can skip this step.
    Do you want to create an administrator account? (y/n): y
    Enter username: admin
    Enter password:
    Enter password again:
    Administrator account setup succeeded.

Step 3 - Setup Port Forward as necessary:
    NeoRouter server listens at port 32976. Please make sure it can receive incoming connections from Internet. If NeoRouter server is behind a NAT, please setup port forward. You can use http://www.neorouter.com/checkport.php to verify the settings.

NeoRouter Server Setup succeeded.
    You can make additional configuration changes using Configuration Explorer or nrserver CLI.
    You can find more information in User's Manual (http://www.neorouter.com/Documents.html).
```

Then sign in using your client. Enjoy!

## Reference
[http://download.neorouter.com/Documents/nr_howitworks_en.pdf](http://download.neorouter.com/Documents/nr_howitworks_en.pdf "NoeRouter - How it Works")
[http://download.neorouter.com/Documents/nr_usermanual_24en.pdf](http://download.neorouter.com/Documents/nr_usermanual_24en.pdf "NeoRouter - User Manual")

## Bonus

# Connect to an existing container.
    docker exec -ti nrserver-free sh

# Remove exited containers.
    docker ps -a | grep 'Exited' | awk '{print $1}' | xargs docker rm

# Remove intermediary and unused images.
    docker rmi $(docker images -aq -f "dangling=true")
