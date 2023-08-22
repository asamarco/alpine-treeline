# alpine-treeline
A docker container for running TreeLine in Kasm Workspaces


## Custom workspace behvior

### Docker Run Config (JSON)
* Change the hostname
```
{
  "hostname": "treeline"
}
```

### Docker Exec Config (JSON)

* Show the home folder on the desktop and open a treeline window
```
{
  "first_launch": {
    "user": "kasm-user",
    "cmd": "bash -c '/usr/bin/desktop_ready && xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-home -s true && treeline'"
  }
}
```

* Allow passwordless sudo

```
{
 "first_launch":{
      "user":"root",
      "cmd":"echo \"kasm-user  ALL=(ALL) NOPASSWD: ALL\" >> /etc/sudoers'"
  }
}
```
