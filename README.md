# ripple-docker
Docker Repo for [ripple](https://ripple.com/).

## Usage Instructions

**Mandatory Requirement**: Must use a local mount volume and config file.

Example:

```
udo docker run --name=ripple-docker --rm -it -p 127.0.0.1:3888:3888 -p51235:51235 \
-v/ /path/to/local/ripple/dir/db:/var/lib/rippled/db \
-v /path/to/local/ripple/dir/etc:/opt/ripple/etc \
-v /path/to/local/ripple/dir/log:/var/log/rippled/ kp666/ripple-docker:latest

```

**Config file is read from**: `/etc/opt/ripple/rippled.cfg`, i.e., `/path/to/local/ripple/dir/etc/rippled.cfg`

##Storing of Data

You can store data within `/var/lib/rippled/db`, ie `/path/to/local/ripple/dir/db` or change in rippled.cfg.

