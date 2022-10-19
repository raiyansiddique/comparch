`default_nettype none
`timescale 1ns/1ps

module led_array_driver(ena, x, cells, rows, cols);
// Module I/O and parameters
parameter N=8; // Size of Conway Cell Grid.
parameter ROWS=N;
parameter COLS=N;

// I/O declarations
input wire ena;
input wire [$clog2(N):0] x;
input wire [N*N-1:0] cells;
output logic [N-1:0] rows;
output logic [N-1:0] cols;


// You can check parameters with the $error macro within initial blocks.
initial begin
  if ((N <= 0) || (N > 8)) begin
    $error("N must be within 0 and 8.");
  end
  if (ROWS != COLS) begin
    $error("Non square led arrays are not supported. (%dx%d)", ROWS, COLS);
  end
  if (ROWS < N) begin
    $error("ROWS/COLS must be >= than the size of the Conway Grid.");
  end
end

wire [N-1:0] x_decoded;

decoder_3_to_8 COL_DECODER(ena, x[$clog2(N)-1:0], x_decoded);
always_comb begin
  cols = x_decoded;
  rows[0] = ~cells[x*ROWS];
  rows[1] = ~cells[x*ROWS + 1];
  rows[2] = ~cells[x*ROWS + 2];
  rows[3] = ~cells[x*ROWS + 3];
  rows[4] = ~cells[x*ROWS + 4];
  rows[5] = ~cells[x*ROWS + 5];
  rows[6] = ~cells[x*ROWS + 6];
  rows[7] = ~cells[x*ROWS + 7];
end
endmodule