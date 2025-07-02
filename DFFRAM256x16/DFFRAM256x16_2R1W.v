/*
 * DFFRAM.v
 *
 * * A 256x32 DFFRAM (1 Kbytes)
 *
 * This is free software: you can redistribute it and/or modify
 * it under the terms of the Apache License, Version 2.0 (the "License").
 *
 * DFFRAM is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * Apache License, Version 2.0 for more details.
 *
 * You should have received a copy of the Apache License, Version 2.0
 * along with DFFRAM. If not, see <https://www.apache.org/licenses/LICENSE-2.0>.
 *
 * For further information, please visit .
 *
 */

`timescale 1ns/1ps

`default_nettype        none

module DFFRAM256x16_2R1W  (
	input   wire            CLK,  
    input   wire [1:0]      WE0,  
    input                   EN0,  
    input                   EN1,  
    input   wire [7:0]      A0,   
    input   wire [7:0]      A1,   
    input   wire [15:0]     Di0,  
    output  wire [15:0]     Do0,
    output  wire [15:0]     Do1
);

    DFFRAM_2R1W  #( .USE_LATCH(1), .WSIZE(2), .BANKS(16) ) RAM (
	    .CLK(CLK),  
        .WE0(WE0),  
        .EN0(EN0),  
        .EN1(EN1),  
        .A0(A0),   
        .A1(A1),   
        .Di0(Di0),  
        .Do0(Do0),
        .Do1(Do1)
    );

endmodule
