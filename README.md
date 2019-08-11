# gentoo-linux-surface

A kernel and firmware patcher for Surface devices. This patches
`sys-kernel/gentoo-sources` with patches from
[Jakeday's repository](https://github.com/jakeday/linux-surface). It is meant to
be used with *stable* `gentoo-sources`. This should probably work with any
distribution of the kernel you may use on your Gentoo install; just modify the
install script to insert the patches in the proper place in
`/etc/portage/patches/`.

Again, I am **not** the original author of the patches, these are the result of
the awesome work by Jakeday. Any request and discussion about having Linux
working on Surface devices should go
[here](https://github.com/jakeday/linux-surface).

## Kernel version

This install patches for the `4.19` version of the kernel. Tested on: `4.19.57`.

## Installation

``` shell
git clone https://github.com/Yumasi/gentoo-linux-surface.git && cd gentoo-linux-surface
./setup.sh
```

This script must be run as `root` to copy patches in the portage directory, to
rebuild the kernel, and install it. It does not support building an initramfs at
the moment.

As any scripts that runs `root` on your machine, you *should* read it and
understand what it does. Don't blindly trust me! (Even though in this case you
can.) Also, it uses verbose options as much as possible so you know what it
does.

## TODO

- Better version checks
- Firmware installation
- Initramfs generation
