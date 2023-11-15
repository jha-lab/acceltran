module PatchifyImage
(
    clk,
    reset, 
    en, 
    output_taken,
    state,
    image_cache, 
    all_patches,
);


parameter CHANNEL_SIZE = 8;  
parameter NUM_CHANNELS = 3; // i.e. RGB
parameter PIXEL_WIDTH = CHANNEL_SIZE * NUM_CHANNELS; 

parameter IMG_WIDTH = 64;
parameter IMG_HEIGHT = 64;
parameter PATCH_SIZE = 16;
parameter PATCHES_IN_ROW = IMG_WIDTH/PATCH_SIZE;

parameter TOTAL_NUM_PATCHES = (IMG_WIDTH/PATCH_SIZE) * (IMG_HEIGHT/PATCH_SIZE);
parameter PATCH_VECTOR_SIZE = PATCH_SIZE*PATCH_SIZE; 

input clk, reset;
input en;
input output_taken;

input [PIXEL_WIDTH-1:0] image_cache [IMG_WIDTH-1:0][IMG_HEIGHT-1:0];

output logic [1:0] state;

// output 1D vector for each patch
output logic [PIXEL_WIDTH-1:0] all_patches [TOTAL_NUM_PATCHES-1:0][PATCH_VECTOR_SIZE-1:0];


logic [PIXEL_WIDTH-1:0] reg_all_patches [TOTAL_NUM_PATCHES-1:0][PATCH_VECTOR_SIZE-1:0];
logic done;



always_ff @(posedge clk) begin
	if (reset) begin
		state <= 2'b00;
	end
	else begin
		if (state == 2'b00 && en) begin
			state <= 2'b01;
		end
		if (state == 2'b01 && done) begin
			state <= 2'b10;
		end
		if (state == 2'b10 && output_taken) begin
			state <= 2'b00;
		end
	end
end



/*
PATCHIFICATION EXAMPLE:

    [ ] = 16x16 patch

    [A][B][C][D]
    [E][F][*][H] < patch_row_index
    [I][J][K][L]
    [M][N][O][P]
            ^
    patch_col_index


    patch_index = * = G
    --------------------------------------------
    For a given patch:

    [ 1, 2, 3, ...15, 16  ]
    [ 17, 18,  ...31, 32  ] < position_row_index
    [ ....................]
    [ 241, 242, ...*, 256 ]
                  ^
            position_col_index
    

    position_index = * = 255
*/

int i, j;
int patch_row_index, patch_col_index, patch_index;
int position_row_index, position_col_index, position_index;
always_comb begin
	if (state == 2'b01) begin
		for (i = 0; i < IMAGE_WIDTH; i++) begin
            patch_row_index = i/PATCH_SIZE * PATCHES_IN_ROW;
            position_row_index = i%PATCH_SIZE * PATCH_SIZE;
			for (j = 0; j < IMAGE_HEIGHT; j++) begin
                patch_col_index = j/PATCH_SIZE;
                position_col_index = j%PATCH_SIZE;

                patch_index = patch_row_index + patch_col_index;
                position_index = position_row_index + position_col_index;

                // assign image pixel value to 1D vector position in corresponding patch
				reg_all_patches[patch_index][position_index] = image_cache[i][j];
			end
		end	
	end
end


int l,m;
always_ff @(posedge clk) begin
	if (reset || (state == 2'b10 && output_taken)) begin
		for (l = 0; l < TOTAL_NUM_PATCHES; l++) begin
			for (m = 0; m < PATCH_VECTOR_SIZE; m++) begin
				all_patches[l][m] <= 0;
			end
		end	
	end
	else if (state == 2'b01 && done) begin
		all_patches <= reg_all_patches;
	end
end


always_comb begin
	if (state == 2'b01) begin
		done = 1;
	end
	else begin
		done = 0;
	end
end


endmodule
