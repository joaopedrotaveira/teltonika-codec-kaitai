meta:
  id: teltonika_tcp
  endian: be
  file-extension: teltcp
  imports:
    - teltonika_codec_packet

types:
  imei_req:
    seq:
      - id: len_imei
        type: u2
      - id: imei
        size: len_imei
  imei_ack:
    seq:
      - id: ack
        type: u1
        enum: imei_ack

  avl_packet:
    seq:
      - id: avl_data
        type: teltonika_codec_packet

  avl_packet_ack:
    seq:
      - id: elements_received
        type: u2

enums:
  imei_ack:
    0x01: accepted
    0x00: denied
