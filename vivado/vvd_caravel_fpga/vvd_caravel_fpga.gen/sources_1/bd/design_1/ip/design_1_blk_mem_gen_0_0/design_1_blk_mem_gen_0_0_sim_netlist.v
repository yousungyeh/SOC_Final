// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.1 (lin64) Build 3526262 Mon Apr 18 15:47:01 MDT 2022
// Date        : Mon Jan 22 06:18:14 2024
// Host        : ubuntu2004 running 64-bit Ubuntu 20.04.4 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/ubuntu/SOC_Final/vivado/vvd_caravel_fpga/vvd_caravel_fpga.gen/sources_1/bd/design_1/ip/design_1_blk_mem_gen_0_0/design_1_blk_mem_gen_0_0_sim_netlist.v
// Design      : design_1_blk_mem_gen_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_blk_mem_gen_0_0,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.1" *) 
(* NotValidForBitStream *)
module design_1_blk_mem_gen_0_0
   (clka,
    rsta,
    ena,
    wea,
    addra,
    dina,
    douta,
    clkb,
    rstb,
    enb,
    web,
    addrb,
    dinb,
    doutb,
    rsta_busy,
    rstb_busy);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE BRAM_CTRL, READ_WRITE_MODE READ_WRITE, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA RST" *) input rsta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [3:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [31:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE BRAM_CTRL, READ_WRITE_MODE READ_WRITE, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB RST" *) input rstb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB WE" *) input [3:0]web;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [31:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DIN" *) input [31:0]dinb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [31:0]doutb;
  output rsta_busy;
  output rstb_busy;

  wire [31:0]addra;
  wire [31:0]addrb;
  wire clka;
  wire clkb;
  wire [31:0]dina;
  wire [31:0]dinb;
  wire [31:0]douta;
  wire [31:0]doutb;
  wire ena;
  wire enb;
  wire rsta;
  wire rsta_busy;
  wire rstb;
  wire rstb_busy;
  wire [3:0]wea;
  wire [3:0]web;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [31:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "32" *) 
  (* C_ADDRB_WIDTH = "32" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "8" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "2" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "1" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "1" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     10.7492 mW" *) 
  (* C_FAMILY = "zynq" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "1" *) 
  (* C_HAS_RSTB = "1" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "NONE" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "2" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "2048" *) 
  (* C_READ_DEPTH_B = "2048" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "1" *) 
  (* C_USE_BYTE_WEA = "1" *) 
  (* C_USE_BYTE_WEB = "1" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "4" *) 
  (* C_WEB_WIDTH = "4" *) 
  (* C_WRITE_DEPTH_A = "2048" *) 
  (* C_WRITE_DEPTH_B = "2048" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  design_1_blk_mem_gen_0_0_blk_mem_gen_v8_4_5 U0
       (.addra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,addra[12:2],1'b0,1'b0}),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,addrb[12:2],1'b0,1'b0}),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb(dinb),
        .douta(douta),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(enb),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[31:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(rsta),
        .rsta_busy(rsta_busy),
        .rstb(rstb),
        .rstb_busy(rstb_busy),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[31:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(web));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2022.1"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
RgPKnWr9n0dGgttm3akiFhAlfB96usOQYxnEmPhGyTGg1AbizYAjGPWLXBWl50n/d0IA71ci4aJB
wt6mtfyNADm3ZReK7D3mKu037BOgxryoEwwf1kiC6q/PllxsdAgEMfQrfHJ3E2AzSpdYjoxVYito
y0JW6CUDcWvWa4WV0EA=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
M0l6KpOGH3jL8eRt3NCD7e2USYnkg5H9GAnE1PKmnjiouFN3Y8kjWA2PZDAQLm9UW+TsC1HeVlzO
WjNCHkjR/6ubCsIcWfpPZWdIuAenlsyq8Y9l6b8vMj8JSbDEOiFF/GHSbKsn22MJdDJKEhHFK6GV
s8gR2vywRFwG69gIRE4qGhVB+WIg8GJrDpDMYH6lCjMkTrjXuKDUcNlJN3NPLuhJ7tsditwf1pr5
moJRmGpJnip/rGm0g4o4A6ev4CtePjoao8C1wFtzHkERX9oenhh7cGjDMejU5IrLv8NxFnLj1FpB
9MuF1beTU20NI5oAn6zLiLiOtXjf0ghU3AN4DA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
hAsrUfp6Qgjm8yBjNYTEtQmVQmMxzL8TE/3oiQSxSI3+yEkXAbQCXkT9mo+LCdv+fGECOB0istHd
eLtbsiYbxjxNxYkXiUrRE5O+aSxynIray+uF9DJigTEUZu8JJXUbzxK4DDUu1Lm9tpGps4+Prz1m
0gkj13RT/Y/418s2VTw=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
BP/54Wm/GJmb1jy0bxWJJX4aiKyiWPVh4X3VL30BQrmX4PlEsNKzBJH3Qu8IIYERfnFP0ifAgboa
vypMQ5Ed0BrMePGkWIgT6I8hxJCMFpHdkSK7m1giSKyZzFfTOrVqoNFXE+qdzLfY1J5hBWCvouYo
jllavK4N3gF9FLScH2AUWYVMcVth2QPaTAU2NLnAUNH8kgtBjBfc8/KbPPTznD1QNVqvFstzcbTA
hGQ1ETVPvINQ0KqxxAG5PRhtQD4+pC+hr/Tvk+RSvGyBOfy9zE86OXkJiYs9dSFhNiMFmCPL9DBO
se4OxNNC0/7aBtb1mkSEA9YFDYEb9jS7Jasy2A==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
SnzT9DVH3xlEN8nrr2YrlvTO5qj7L22d7WaBcuKyTaiHoIwwFHrC4HQbfs0TAwkdWcOgmJoATPSF
F6qm0KiddbrlERF3MfKUldeGBJtqLdX+zGw7+3JD7S+HB9dIMOFOHy+IiCZp1/Pz8epKpi238cel
rcVoJQKz406wmXDvOo8KsT+XhRLs9BVCrBErPGGXKYDk6NXAp0duOgQE9DbslzMU83M/kUC7uERV
tQW02240peKQFp2elEZC7Tetvgp0TaFTtJiKN45REi8GQUCKGa85JjNIk1qb/+k95TIIP1xrHirc
6iX7qbwnPetv8TVu2NjkZ0WDEK5RXdOXcxBwHA==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_07", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
erkR82V0jX8ytva+9MzEs0c75Z7j7TsgxWRLNAUfbbU28i+U9YzuZlSfYU75M0f9jx1gvxtBrfKv
cNHVdkR+i5zfHDZsDwfMEEBhs8wzDCKqe+eex6BBEvlIOesCPXrr2RozQgaQ1PBh/os2Arfu+873
BjsVxFJkbhpzIqlddOo/XZV9Yi+eih7A7pXXEBR6IL7Poo4Ka49MiVQU0xJrDTm+ddOuMPDRRD7g
dsxS/uzdcBcO2myV6g/7YH/C2Ce9s6+UywJN/0JeXSqwA7bsBqqnfFicVAT0lckLopMLiuzK7dsN
EwhFeqoetciFrDIj9+o0xDMWBZhgNP1u68vURA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
R+BI65BKLT0I9hEtsxGnDyM5XY9gzULeTPOSDXvd3KWOzZJAx6C0xlbyZcFZhAEG/QIK2yd0wAi6
IUWxyF/sx3HsqKjhVi5KxnpuXDBOZVoj811O7JukedFVmDW7OHGtBkuiJ5X5irw7mfsEKRQmF/1i
V6lj9HYHZEjxtDeZjACsLY4y1QxWalSKT4HIMOHznBLL8dLbGMlS+ZmFuFn0gcwZavVl7gTkTtkf
W0gn01A9ru7NKsf+iLX0kj4dgItPu9N2g02M1vWQ9UUQEVvfV7lUc7GY1suibrD8aEkhH9S7lZ7n
bFsT4qxyvzg8ML6v4g4v7N6VuyhEtgFgNd725Q==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
jNUVKiwH68vHsU54idgvKwaVJcoxTUuxfgrQpbpmM/IpesWA3wHsGzYClwAxkKzw3KRnFyQqTWcZ
yj1EQ2CMBxlJ0kyNbZW8OK8pXzeigToZ0U6Aq3Gy+j7wBbhe83wE1Ygn82sK8dHTEulvaRLn/c5r
ispy1s7jMKIvYNzoUuZrgyBQyfaYmdqUia8XlQjFd+VwzhTXKwzvmaqHWyaHjfBKeCooO7+oUxMG
OJg83W54EVe9ronFQ8Wr9EOL8ia7qelCAgyQe/bC0HHCoMAm8apI7sX23iMR/wMiPP5V2bQzycy+
rBX/+SWkqSeIE1FLm+muFPvrE7iLwJaW8d1fzdFFjAZ5aIXArbWNfwbK8S0TczXc9lEzmpb69rwA
UJIrs4alo81qGQ32UFhjuMQjX75O9Od1HWHDj5PFaT/Ja5Ly+bK8Cc3gfO6dCE81m7d+B2JBZ/Hl
tBA19QuOAYwT2EIPOdpaVtCULb33cWODWu3qQFhZMmDzKTb3kwpcr0LL

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
MnzcA2swaxH1LRacKDou0ZmiiMRETbWIdHgeBgyQz7ILronsXLoB/C20WuFNGEVSiL2/51EZ6MXZ
vMHI8fFcMQCJcuTBDBibUMKv6bXI9s8fTbtrBZppbF/R1icG5JYhqmX4aRnv4W/dxJRjI2L35nLN
Y48E9OfgfkD1sr+IRwx8WEKFmUhuk8dLe0VOK7ywe3XEcneYvrz+HhPj16bGmNfMwNnDgZ3gKKZD
hRnys+jzvAX3HyISrErWXhMKrhWMxXeTNFJCqNQ0LWAVHQYwyKnF5xVpyXSuGNSIrva+QXqOrZBG
3VNLirNVtMRiKLfwZeMaqvswkqBDAa53utlAAA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
d0xXkKtsKM8GvXhDZr16p1+oE3uBtD04BJ76eGGIEj/CFECfHVy9qsJ43oSKjas0+AJr4GFFnVb6
X7gJV6MmX/OboC9ier5joUCGz0mxVzkRZK9a+LPEDcg0K6+cLE36kr+FfxW9Uk2816EHBCMCf5mK
A4eAhSmAb5Nq74F/q0quiG416npbny7faiQ+xmPDfYYiM3UuMKaD4iE8ODlz1w5xThPllWESf3LZ
NTkw6fozyTqZ47vvE21O3dgIGAY1v+C6BwlCK24VwPJa1xs9csY+qTk31j5jjAc1ExlB6QF7t9UH
lk70qdNPWxT87OH7kFT8UvPO1D6BTC3/WkDZfA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
LYhdzKTvo93uJrAaiP5OfCDuOnu2BSvPnxlv6I7h2n1+xHtj34LNNKzWEgOg9dUV9cYDaHYUjjEt
DKdWcz6mZ61d5qyxAhpv67fc90v7JVgtOAcT94/Yb+AuLxXFcGA6Gic7uoJtUgz6JmTnb22Dxdjc
KuIewDj4IOTfP8XGXKTaF+cNp0CFrQgTAcVSQFyLFxr0I/9h3S+GZLecA7ntEeHEOfCJzPvy0ddi
7MCdQWECLb+fXC0IAn8V95TumcpINiRAX1BHi9IGJ4QoMrb3jOCrPkFhDMTJj2aiImUWdi/l/0QE
d7wcXlgIEYVeoKYUOJ4mqy+zZPUbLNeOPADUDQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 59888)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
