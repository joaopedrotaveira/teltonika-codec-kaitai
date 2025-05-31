meta:
  id: teltonika_codec
  endian: be
  file-extension: telcodec

seq:
  - id: preamble
    contents: [0x00, 0x00, 0x00, 0x00]
  - id: data_field_length
    type: u4
  - id: codec_id
    type: u1
    valid:
      any-of: [0x08, 0x8E, 0x10, 0x0C, 0x0D, 0x0E]
  - id: number_of_data_1
    type: u1
  - id: avl_data
    type:
        switch-on: codec_id
        cases:
            0x08: avl_data_codec_8
            0x8E: avl_data_codec_8e
            0x10: avl_data_codec_16
    repeat: expr
    repeat-expr: number_of_data_1

  - id: number_of_data_2
    type: u1
  - id: crc_16
    type: u4

types:
  avl_data_codec_8:
    seq:
      - id: timestamp
        type: u8
      - id: priority
        type: u1
        enum: priority
      - id: gps_element
        type: gps_element
      - id: io_element
        type: io_element_8
  avl_data_codec_8e:
    seq:
      - id: timestamp
        type: u8
      - id: priority
        type: u1
        enum: priority
      - id: gps_element
        type: gps_element
      - id: io_element
        type: io_element_8e
  avl_data_codec_16:
    seq:
      - id: timestamp
        type: u8
      - id: priority
        type: u1
        enum: priority
      - id: gps_element
        type: gps_element
      - id: io_element
        type: io_element_16
  gps_element:
    seq:
      - id: longitude
        type: s4
      - id: latitude
        type: s4
      - id: altitude
        type: u2
      - id: angle
        type: u2
      - id: satelites
        type: u1
      - id: speed
        type: u2
  io_element_8:
    seq:
      - id: event_io_id
        type: u1
      - id: n_of_total_io
        type: u1

      - id: n_of_one_byte_io
        type: u1
      - id: one_byte_pairs
        type: io_one_byte
        repeat: expr
        repeat-expr: n_of_one_byte_io

      - id: n_of_two_byte_io
        type: u1
      - id: two_byte_pairs
        type: io_two_byte
        repeat: expr
        repeat-expr: n_of_two_byte_io

      - id: n_of_four_byte_io
        type: u1
      - id: four_byte_pairs
        type: io_four_byte
        repeat: expr
        repeat-expr: n_of_four_byte_io

      - id: n_of_eight_byte_io
        type: u1
      - id: eight_byte_pairs
        type: io_eight_byte
        repeat: expr
        repeat-expr: n_of_eight_byte_io

  io_element_8e:
    seq:
      - id: event_io_id
        type: u2
      - id: n_of_total_io
        type: u2

      - id: n_of_one_byte_io
        type: u2
      - id: one_byte_pairs
        type: io_one_byte2
        repeat: expr
        repeat-expr: n_of_one_byte_io

      - id: n_of_two_byte_io
        type: u2
      - id: two_byte_pairs
        type: io_two_byte2
        repeat: expr
        repeat-expr: n_of_two_byte_io

      - id: n_of_four_byte_io
        type: u2
      - id: four_byte_pairs
        type: io_four_byte2
        repeat: expr
        repeat-expr: n_of_four_byte_io

      - id: n_of_eight_byte_io
        type: u2
      - id: eight_byte_pairs
        type: io_eight_byte2
        repeat: expr
        repeat-expr: n_of_eight_byte_io

      - id: n_of_x_byte_io
        type: u2
      - id: x_byte_pairs
        type: io_x_byte2
        repeat: expr
        repeat-expr: n_of_x_byte_io

  io_element_16:
    seq:
      - id: event_io_id
        type: u2
      - id: generation_type
        type: u1
        enum: generation_type
      - id: n_of_total_io
        type: u1

      - id: n_of_one_byte_io
        type: u1
      - id: one_byte_pairs
        type: io_one_byte2
        repeat: expr
        repeat-expr: n_of_one_byte_io

      - id: n_of_two_byte_io
        type: u1
      - id: two_byte_pairs
        type: io_two_byte2
        repeat: expr
        repeat-expr: n_of_two_byte_io

      - id: n_of_four_byte_io
        type: u1
      - id: four_byte_pairs
        type: io_four_byte2
        repeat: expr
        repeat-expr: n_of_four_byte_io

      - id: n_of_eight_byte_io
        type: u1
      - id: eight_byte_pairs
        type: io_eight_byte2
        repeat: expr
        repeat-expr: n_of_eight_byte_io

  io_one_byte:
    seq:
      - id: id
        type: u1
      - id: value
        type: u1
  io_two_byte:
    seq:
      - id: id
        type: u1
      - id: value
        type: u2
  io_four_byte:
    seq:
      - id: id
        type: u1
      - id: value
        type: u4
  io_eight_byte:
    seq:
      - id: id
        type: u1
      - id: value
        type: u8

  io_one_byte2:
    seq:
      - id: id
        type: u2
      - id: value
        type: u1
  io_two_byte2:
    seq:
      - id: id
        type: u2
      - id: value
        type: u2
  io_four_byte2:
    seq:
      - id: id
        type: u2
      - id: value
        type: u4
  io_eight_byte2:
    seq:
      - id: id
        type: u2
      - id: value
        type: u8
  io_x_byte2:
    seq:
      - id: id
        type: u2
      - id: length
        type: u2
      - id: value
        size: length

enums:
  priority:
    0: low
    1: high
    2: panic

  generation_type:
    0: on_exit
    1: on_entrance
    2: on_both
    3: reserved
    4: hysteresis
    5: on_change
    6: eventual
    7: periodical
