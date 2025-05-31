#!/usr/bin/env python3
""" test parsing packet """
import sys
from teltonika_codec import TeltonikaCodec

def main():
    """main"""

    if len(sys.argv) != 2:
        print(f"usage: {sys.argv[0]} packet_data")
        sys.exit(1)

    input_packet = bytearray.fromhex(sys.argv[1].replace(" ",""))

    print(input_packet)

    packet = TeltonikaCodec.from_bytes(input_packet)

    print(packet)

if __name__ == "__main__":
    main()

