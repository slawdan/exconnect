exconnect
===========

A auxiliary script for ssh to server.

 - quick connect server by tag
 - send password automaticly
 - login to the tunnel/fort/jump server.

It has two script, use `connect` to connect remote server by tag and send password, and use `tunnel` if you need login to a tunnel server first.

## Usage

### Install

 1. Download and unzip.
 2. `./connect` (or `./tunnel`) to auto init config file.
 3. Change the config file (aka. `connect.servers`) as you wish.
 4. `./connect foo` to connect the server with tag `foo`.

### Basic Usage

Simply `./connect` with no param will give you a hint as below:

    Using file ./connect.servers for server matching.
    Usage:
        connect [$server|$server_postfix|$server_tag]
    ============= Servers ============
    User@Server:Pass#Tags#
    -------------------------
    #Line format:
    #user@host[:***[#tag1#...#tagN#]
    example_user1@example.com:***#example#
    example_user2@192.168.1.1#gateway#lgw#
    example_user3@192.168.1.2

The hint will give you where config file is, the command usage, and also, servers defined in your `connect.servers`.

> Server password will be masked.

Then, use host address or tag, eg. `connect .com` and `connect example` to connect the first server.
The tag matching is exactly, but host address matches backward, e.g. `2` matches `example_user3@192.168.1.2`

More examples:

To connect `example_user1@example.com`:

```
./connect com 
./connect ple.com
./connect example.com
./connect example
```

To connect `example_user2@192.168.1.1`:

```
./connect 1
./connect .1
./connect 192.168.1.1
./connect gateway
./connect lgw
```

```
./connect 2
./connect .2
./connect 1.2
```

Remember, put your servers to the `connect.servers`.

### Config format

The format for `connect` is `User@Server:Pass#Tags#`, and also commented in the default created config.

Note that `Pass` and `Tags` are optional, you can omitted them.

`Tags` could be multiple, represent a `#tag1#tag2#...#tagN#` format, any tag is matching seperately.

### Via A Tunnel Server

    TODO

