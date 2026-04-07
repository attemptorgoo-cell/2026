package my_riscv_pkg;

typedef struct packed {
    logic [4:0] rs2;     
    logic [4:0] rs1;     
    logic [4:0] rd;      
    logic [3:0] alu_op;
    logic we;     //这条指令最终要不要写回
} decode_out_t;  
//不需要记录位宽，使用t.rd的方式访问

typedef struct packed {
    logic [31:0] instr;
} if_id_bus_t;  //t means type

typedef struct packed {
    logic [31:0] src1_data;
    logic [31:0] src2_data;//R_type的源寄存器中的数据
    
    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [4:0] rd;
    logic [3:0] alu_op;
    
    logic we; 
} id_ex_bus_t;  //t means type

typedef struct packed {
    

    logic [31:0] w_data;
    logic [4:0] rd; 
    logic [4:0] rs1;
    logic [4:0] rs2;

    logic we;
} ex_mem_bus_t;

typedef struct packed {
    logic [31:0] w_data;
    logic [4:0] rd; 
    logic we;
    logic [4:0] rs1;
    logic [4:0] rs2;
} mem_wb_bus_t;

typedef struct packed {
    
    logic [4:0] rd; 
    logic [31:0] w_data;
    logic we;

} wb_id_bus_t;


//数据旁路，实现“WB慢两拍”的问题,数据回传目标寄存器，和写回数据
typedef struct packed {
    logic [4:0] rd; 
    logic [31:0] w_data;
    logic we;
}  wb_ex_bus_t;

typedef struct packed {
    logic [4:0] rd; 
    logic [31:0] w_data;
    logic we;
}  mem_ex_bus_t;

endpackage