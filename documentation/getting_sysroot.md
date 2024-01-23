# Obtaining Sysroot
1. In WSL download the rootfs from the [website](http://www.pynq.io/board), and move it to the current directory.
2. Run the following commands. You may need to adjust the path to the rootfs.
```sh
mkdir pynq_sysroot
cd pynq_sysroot
mkdir usr lib opt
tar -xf ../jammy.arm.3.0.1.gz usr lib opt
chmod a+w -R ./
```