# Building the example firmware for targets
We are using the (CW303 XMEGA)[https://rtfm.newae.com/Targets/CW303%20XMEGA/] target.

1. Install the AVR compiler with `sudo apt install gcc-avr avr-libc`
2. Clone the chipwhisperer repo, and navigate to one of the example firmwares in `hardware/victims/firmware`
3. run `make PLATFORM=CW303 CRYPTO_TARGET=AVRCRYPTOLIB`
4. The `upload_cw_firmware.py` script can then be used to upload the firmware through the chipwhisperer.