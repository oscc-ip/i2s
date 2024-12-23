// Copyright (c) 2023-2024 Miao Yuchi <miaoyuchi@ict.ac.cn>
// i2s is licensed under Mulan PSL v2.
// You can use this software according to the terms and conditions of the Mulan PSL v2.
// You may obtain a copy of Mulan PSL v2 at:
//             http://license.coscl.org.cn/MulanPSL2
// THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
// EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
// MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
// See the Mulan PSL v2 for more details.

`ifndef INC_I2S_DEF_SV
`define INC_I2S_DEF_SV

// sync design
// audio and apb4 clk: 12.288M(mclk)
// div only support 256, 384, 512, 768, 1024
// clk gen: gen the ws(mclk/div) -> sck(mclk/div*2*(16/32))
// or sck(mclk/sckdiv) -> ws(mclk/sckdiv/2*(16/32))
// sckdiv: div / (2*16/32)
/* register mapping
 * I2S_CTRL:
 * BITS:   | 31:26 | 25:21 | 20:16 | 15:14 | 13:12 | 11:10 | 9:8 | 7  | 6   | 5   | 4   | 3   | 2    | 1    | 0  |
 * FIELDS: | RES   | RXTH  | TXTH  | DTL   | CHL   | CHM   | FMT | WM | LSB | POL | LSR | CLR | RXIE | TXIE | EN |
 * PERMS:  | NONE  | RW    | RW    | RW    | RW    | RW    | RW  | RW | RW  | RW  | RW  | RW  | RW   | RW   | RW |
 * ---------------------------------------------------------------------------------------------------------------
 * I2S_DIV:
 * BITS:   | 31:16 | 15:0   |
 * FIELDS: | RES   | SCKDIV |
 * PERMS:  | NONE  | RW     |
 * ---------------------------------------------------------------------------------------------------------------
 * I2S_TXR:
 * BITS:   | 31:0   |
 * FIELDS: | TXDATA |
 * PERMS:  | WO     |
 * ---------------------------------------------------------------------------------------------------------------
 * I2S_RXR:
 * BITS:   | 31:0   |
 * FIELDS: | RXDATA |
 * PERMS:  | RO     |
 * ---------------------------------------------------------------------------------------------------------------
 * I2S_STAT:
 * BITS:   | 31:6 | 5   | 4    | 3    | 2    | 1    | 0    |
 * FIELDS: | RES  | CHD | RETY | TFUL | BUSY | RXIF | TXIF |
 * PERMS:  | NONE | RO  | RO   | RO   | RO   | RC   | RC   |
 * ---------------------------------------------------------------------------------------------------------------
*/

// verilog_format: off
`define I2S_CTRL 4'b0000 // BASEADDR + 0x00
`define I2S_DIV  4'b0001 // BASEADDR + 0x04
`define I2S_TXR  4'b0010 // BASEADDR + 0x08
`define I2S_RXR  4'b0011 // BASEADDR + 0x0C
`define I2S_STAT 4'b0100 // BASEADDR + 0x10

`define I2S_CTRL_ADDR {26'b00, `I2S_CTRL, 2'b00}
`define I2S_DIV_ADDR  {26'b00, `I2S_DIV , 2'b00}
`define I2S_TXR_ADDR  {26'b00, `I2S_TXR , 2'b00}
`define I2S_RXR_ADDR  {26'b00, `I2S_RXR , 2'b00}
`define I2S_STAT_ADDR {26'b00, `I2S_STAT, 2'b00}

`define I2S_DATA_WIDTH     32
`define I2S_DATA_BIT_WIDTH $clog2(`I2S_DATA_WIDTH)

`define I2S_CTRL_WIDTH 26
`define I2S_DIV_WIDTH  16
`define I2S_TXR_WIDTH  `I2S_DATA_WIDTH
`define I2S_RXR_WIDTH  `I2S_DATA_WIDTH
`define I2S_STAT_WIDTH 6

`define I2S_WM_NORM 1'b0
`define I2S_WM_TEST 1'b1

`define I2S_FMT_I2S  2'b00
`define I2S_FMT_MSB  2'b01 // NOTE: no support now
`define I2S_FMT_LSB  2'b10 // NOTE: no support now
`define I2S_FMT_NONE 2'b11

`define I2S_CHM_STERO 2'b00
`define I2S_CHM_LEFT  2'b01
`define I2S_CHM_RIGHT 2'b10
`define I2S_CHM_NONE  2'b11

`define I2S_DAT_8_BITS  2'b00
`define I2S_DAT_16_BITS 2'b01
`define I2S_DAT_24_BITS 2'b10
`define I2S_DAT_32_BITS 2'b11

`define I2S_FSM_IDLE 1'b0
`define I2S_FSM_BUSY 1'b1
// verilog_format: on

interface i2s_if ();
  logic mclk_o;
  logic sck_o;
  logic sck_i;
  logic sck_en_o;
  logic ws_o;
  logic ws_i;
  logic ws_en_o;
  logic sd_o;
  logic sd_i;
  logic irq_o;

  modport dut(
      output mclk_o,
      output sck_o,
      input sck_i,
      output sck_en_o,
      output ws_o,
      input ws_i,
      output ws_en_o,
      output sd_o,
      input sd_i,
      output irq_o
  );

  modport tb(
      input mclk_o,
      input sck_o,
      output sck_i,
      input sck_en_o,
      input ws_o,
      output ws_i,
      input ws_en_o,
      input sd_o,
      output sd_i,
      input irq_o
  );
endinterface
`endif
