#!/usr/bin/env python3

import chipwhisperer as cw
import click


@click.command()
@click.argument("firmware", type=click.Path())
def main(firmware: str) -> None:
    if not firmware.endswith(".hex"):
        print("Expecting a .hex file")
        return

    scope = cw.scope()  # type: ignore
    cw.program_target(scope, cw.programmers.XMEGAProgrammer, firmware)  # type: ignore
    pass


if __name__ == "__main__":
    main()
