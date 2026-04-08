module ram (
    input logic rst,
    input  memory_bus_t mem_ram_bus,
    output memory_bus_t ram_mem_bus
    
);

logic addr;
logic [31:0] ram [1023:0];

always_comb begin

end
endmodule