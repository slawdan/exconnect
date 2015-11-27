exconnect
===========

A SSH auxiliary script for login to server.

 - quick connect server by tag
 - send password automaticly
 - login to the tunnel/fort/jump server.
 - `zssh` will be used if detected, or else will fallback to `ssh`

This project has two script, use `connect` to connect remote server by tag and send password, and use `tunnel` if you need login to a tunnel server first.

## Usage

### Dependencies

`expect` installed. You can use brew:

```
brew install expect
```

### Quick Start

 1. Download and unzip.
 2. `./connect` (or `./tunnel`) to auto initialize config file(s).
 3. Change the config file(s) (aka. `connect.servers`) as you wish.
 4. `./connect foo` to connect the server with tag `foo`.

### Basic Usage

Simply `./connect` with no param will give you a hint as below:

    Using file ./connect.servers for server matching.
    Usage:
        connect [$server|$server_postfix|$server_tag]
    ============= Servers ============
    User@Server:Pass#Tags#
    -------------------------
    example_user1@example.com:***#foo#
    example_user2@192.168.1.1#foo#bar#
    example_user3@192.168.1.2

It will show you where the config file is, the command usage, and also, servers defined in your config file `connect.servers`.

> Server password will be masked.

Then, use host address or tag, e.g. `connect .com` or `connect foo` to connect the first server.
The tag matching is exactly, but host address matching is backward, e.g. `2` or `1.2` matches `example_user3@192.168.1.2`

More examples:

To connect `example_user1@example.com`:

```
./connect com 
./connect ple.com
./connect example.com
./connect foo
```
> You can use partial address

To connect `example_user2@192.168.1.1`:

```
./connect 1
./connect .1
./connect 1.1
./connect 192.168.1.1
./connect bar
```
Note that `./connect foo` will match the first server.

Also remember, config your servers into `connect.servers`.

### Basic Config Format

The per line format of `connect.servers` as belows, which is also commented in the auto intialized config:

```
User@Server:Password#Tags#
```

Note that `Password` and `Tags` are optional, you can omit them. When `Password` is omitted, the `./connect` script will try to use other authenticate methods, such as `PubKey`.

`Tags` could be multiple, be formated as `#tag1#tag2#...#tagN#`, any tag is matched seperately.

### Servers behind Tunnel Server or Barrier Server

With servers behind a tunnel server, you should use the second script `./tunnel`, which provide a common way to auto login to the tunnel and then do a server ip/tag matching as `./connect` does.

`./tunnel` can handle the tunnel login situation like this:

    Last login: Fri Nov 27 15:01:20 2015 from 192.168.1.2
    Welcome to Sky-IDC, This is tunnel server 10.1.1.1.
    Please contact foo@bar.com if something occur!
    server ip ( 'q' to exit ):10.1.2.3
    Last login: Fri Nov 27 15:01:41 2015 from 192.168.1.2
    [bee@10.1.2.3 ~]$

### Tunnel Login Usage

Also `./tunnel` with no param will give you a hint as below:

    Using file ./tunnel.tunnels for tunnels matching.
    Using file ./tunnel.servers for server matching.
    2015-11-27 15:28:36
    Today is a gift. That's why it is called the present.
    =====================================================
    This script accept 0 to 2 params. If you omit the $server, it will use the first server in servers list. If you omit the $tunnel_alias, it will try to use the predefined alias in servers list if not empty, then try the first tunnel in tunnels list
    Examples:
      tunnel [$server|$tag]
      tunnel $tunnel_alias [$server|$tag]
      tunnel
    ========== Tunnels =========
    Alias:User@Tunnel:Password
    ------------------
    #Line format:
    #Alias:User@Server[:Password]
    tunnel1:user1@example_tunnel1.foo.com:password
    tunnel2:user2@example_tunnel2.foo.com
    
    ========== Servers =========
    Server:Tunnel#Tag#
    ------------------
    #Line format:
    #Server[:Tunnel_Alias][#Tag1#...#TagN#]
    server1.com:tunnel1#svr1#svr2#
    10.1.1.5:tunnel1#svr3#

It's very like `./connect`'s hint, but as it shows, `./tunnel` use one more config file, and also the servers config is slightly different.

First of all, you should config your tunnel server login with an alias in `tunnel.tunnels` file. Then edit the `tunnel.servers` config use the tunnel alias.

As the auto intialized configs, simply typing one of belows:

```
./tunnel server1.com
./tunnel com
./tunnel svr1
./tunnel svr2
```

the script will use tunnel1 ( which is defined to use `user1@example_tunnel1.foo.com` and password `password` ) to login to the tunnel server first. If successed, `server1.com` will be automaticly filled in and finally connect.

### Tunnel Config Format

The line format of `tunnel.tunnels` is:

```
Alias:User@Tunnel:Password
```

which `Password` is optional. And format of `tunnel.servers` is:

```
Server:Tunnel#Tags#
```

which `Tags` is optional.

### Quick Force Quit

When connected, you can use `!!!` (invisible in term) to quick quit from server.

This is simply done by sending `exit\n` looply, so it will take no effect when you in some text editors like vim.

There is also a side-effect, which `!` or `!!` will be invisible in term before your subsequent input.

Enjoy.

## Author

Slawdan <schludern@gmail.com>

