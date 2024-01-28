// Copyright (c) 2023 Beijing Institute of Open Source Chip
// i2s is licensed under Mulan PSL v2.
// You can use this software according to the terms and conditions of the Mulan PSL v2.
// You may obtain a copy of Mulan PSL v2 at:
//             http://license.coscl.org.cn/MulanPSL2
// THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
// EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
// MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
// See the Mulan PSL v2 for more details.

`include "i2s_define.sv"

module i2s_clkgen (
    input  logic                      clk_i,
    input  logic                      rst_n_i,
    input  logic                      en_i,
    input  logic [`I2S_DIV_WIDTH-1:0] div_i,
    output logic                      sclk_o,
    output logic                      ws_o
);

endmodule
