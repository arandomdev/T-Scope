# PYNQ Setup
We are using PYNQ-Z1 from digilent

## SD Card flashing
1. download the latest PYNQ-Z1 image from the [images](http://www.pynq.io/board) site. We have downloaded version 3.0.1.
2. Using a flasher like balena etcher, flash the SD card.
3. SSH into the board. The user and password is xilinx
4. run `sudo apt update` and `sudo apt upgrade`.
    * tmux can be optionally installed first to get a terminal emulator.
5. run the following,
```sh
cd ~
mkdir source
cd source
git clone https://github.com/newaetech/chipwhisperer
cd chipwhisperer
sudo cp hardware/50-newae.rules /etc/udev/rules.d/50-newae.rules
sudo udevadm control --reload-rules
sudo groupadd -f chipwhisperer
sudo usermod -aG chipwhisperer $USER
sudo usermod -aG plugdev $USER
sudo python -m pip install -e .
```
