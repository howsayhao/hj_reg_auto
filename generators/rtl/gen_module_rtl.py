import sys

from .rtl_type import *
from .gen_field_rtl import *


# get port rtl
def get_ext_port(ext_list):
    ext_port_rtl = ''
    for ext_module in ext_list:
        module_name = ext_module.module_name
        ext_port_rtl += '\t// ports of %s\n'%(module_name)
        if(ext_module.cdc):
            ext_port_rtl += '\t%s_clk               ,\n'%(module_name)
            ext_port_rtl += '\t%s_rstn              ,\n'%(module_name)
        ext_port_rtl += '\t%s_req_vld           ,\n'%(module_name)
        ext_port_rtl += '\t%s_ack_vld           ,\n'%(module_name)
        ext_port_rtl += '\t%s_wr_en             ,\n'%(module_name)
        ext_port_rtl += '\t%s_rd_en             ,\n'%(module_name)
        ext_port_rtl += '\t%s_addr              ,\n'%(module_name)
        ext_port_rtl += '\t%s_wr_data           ,\n'%(module_name)
        ext_port_rtl += '\t%s_rd_data           ,\n'%(module_name)
    return ext_port_rtl

def get_regfile_port(reg_list, cdc):
    regfile_port_rtl = ''
    regfile_port_rtl += '\t// ports of internal regfile\n'
    if(cdc):
        regfile_port_rtl += '\tregfile_clk          ,\n'
        regfile_port_rtl += '\tregfile_rstn         ,\n'
    for reg in reg_list:
        if(reg.alias is True or (reg.shared is True and reg.first_shared is False)):
            pass
        else:
            for field in reg.children:
                field_name = '_'.join(field.hierachy[:-1]).replace('][','_').replace('[','').replace(']','') + '__%s'%(field.hierachy[-1])
                regfile_port_rtl += '\t// ports of %s\n'%(field.hierachy)
                regfile_port_rtl += '\t%s__next_value        ,\n'%(field_name)
                regfile_port_rtl += '\t%s__pulse             ,\n'%(field_name) if (field.hw != "`HW_RO") else ''
                regfile_port_rtl += '\t%s__curr_value        ,\n'%(field_name)
                regfile_port_rtl += '\t%s__swmod_out         ,\n'%(field_name) if field.swmod else ''
                regfile_port_rtl += '\t%s__swacc_out         ,\n'%(field_name) if field.swacc else ''
    return regfile_port_rtl

def get_regslv_port(master):
    regslv_port_rtl = ''
    if(master):
        regslv_port_rtl += '\tPCLK                    ,\n'
        regslv_port_rtl += '\tPRESETn                 ,\n'
        regslv_port_rtl += '\tPSEL                    ,\n'
        regslv_port_rtl += '\tPENABLE                 ,\n'
        regslv_port_rtl += '\tPREADY                  ,\n'
        regslv_port_rtl += '\tPSLVERR                 ,\n'
        regslv_port_rtl += '\tPWRITE                  ,\n'
        regslv_port_rtl += '\tPADDR                   ,\n'
        regslv_port_rtl += '\tPWDATA                  ,\n'
        regslv_port_rtl += '\tPRDATA                  ,\n'
        regslv_port_rtl += '\tclear                   ,\n'
        regslv_port_rtl += '\tinterrupt               ,\n'
        regslv_port_rtl += '\tglobal_sync_reset_out    \n'
    else:
        regslv_port_rtl += '\tfsm_clk                 ,\n'
        regslv_port_rtl += '\tfsm_rstn                ,\n'
        regslv_port_rtl += '\treq_vld                 ,\n'
        regslv_port_rtl += '\tack_vld                 ,\n'
        regslv_port_rtl += '\twr_en                   ,\n'
        regslv_port_rtl += '\trd_en                   ,\n'
        regslv_port_rtl += '\taddr                    ,\n'
        regslv_port_rtl += '\twr_data                 ,\n'
        regslv_port_rtl += '\trd_data                 ,\n'
        regslv_port_rtl += '\tglobal_sync_reset_in    ,\n'
        regslv_port_rtl += '\tglobal_sync_reset_out    \n'
    return regslv_port_rtl


# get port define rtl
def get_regslv_define(master):
    regslv_define_rtl = ''
    regslv_define_rtl += '\t// regslv domain fsm_clk\n'
    if(master):
        regslv_define_rtl += '\tinput                         PCLK                    ;\n'
        regslv_define_rtl += '\tinput                         PRESETn                 ;\n'
        regslv_define_rtl += '\tinput                         PSEL                    ;\n'
        regslv_define_rtl += '\tinput                         PENABLE                 ;\n'
        regslv_define_rtl += '\toutput                        PREADY                  ;\n'
        regslv_define_rtl += '\toutput                        PSLVERR                 ;\n'
        regslv_define_rtl += '\tinput                         PWRITE                  ;\n'
        regslv_define_rtl += '\tinput     [ADDR_WIDTH-1:0]    PADDR                   ;\n'
        regslv_define_rtl += '\tinput     [DATA_WIDTH-1:0]    PWDATA                  ;\n'
        regslv_define_rtl += '\toutput    [DATA_WIDTH-1:0]    PRDATA                  ;\n'
        regslv_define_rtl += '\tinput                         clear                   ;\n'
        regslv_define_rtl += '\toutput                        interrupt               ;\n'
        regslv_define_rtl += '\toutput                        global_sync_reset_out   ;\n'
        regslv_define_rtl += '\twire                          fsm_clk = PCLK          ;\n'
        regslv_define_rtl += '\twire                          fsm_rstn = PRESETn      ;\n'
    else:
        regslv_define_rtl += '\tinput                         fsm_clk                 ;\n'
        regslv_define_rtl += '\tinput                         fsm_rstn                ;\n'
        regslv_define_rtl += '\tinput                         req_vld                 ;\n'
        regslv_define_rtl += '\toutput                        ack_vld                 ;\n'
        regslv_define_rtl += '\tinput                         wr_en                   ;\n'
        regslv_define_rtl += '\tinput                         rd_en                   ;\n'
        regslv_define_rtl += '\tinput     [ADDR_WIDTH-1:0]    addr                    ;\n'
        regslv_define_rtl += '\tinput     [DATA_WIDTH-1:0]    wr_data                 ;\n'
        regslv_define_rtl += '\toutput    [DATA_WIDTH-1:0]    rd_data                 ;\n'
        regslv_define_rtl += '\tinput                         global_sync_reset_in    ;\n'
        regslv_define_rtl += '\toutput                        global_sync_reset_out   ;\n'
    return regslv_define_rtl

def get_ext_define(ext_list):
    ext_define_rtl = ''
    for ext_module in ext_list:
        module_name = ext_module.module_name
        ext_define_rtl += '\t// ports define of %s\n'%(module_name)
        if(ext_module.cdc):
            ext_define_rtl += '\tinput              %s_clk               ;\n'%(module_name)
            ext_define_rtl += '\tinput              %s_rstn              ;\n'%(module_name)
        ext_define_rtl += '\toutput             %s_req_vld           ;\n'%(module_name)
        ext_define_rtl += '\tinput              %s_ack_vld           ;\n'%(module_name)
        ext_define_rtl += '\toutput             %s_wr_en             ;\n'%(module_name)
        ext_define_rtl += '\toutput             %s_rd_en             ;\n'%(module_name)
        ext_define_rtl += '\toutput [%d-1:0]    %s_addr              ;\n'%(ext_module.ADDR_WIDTH, module_name)
        ext_define_rtl += '\toutput [%d-1:0]    %s_wr_data           ;\n'%(ext_module.DATA_WIDTH, module_name)
        ext_define_rtl += '\tinput  [%d-1:0]    %s_rd_data           ;\n'%(ext_module.DATA_WIDTH, module_name)
    return ext_define_rtl

def get_regfile_define(reg_list, cdc):
    regfile_define_rtl = ''
    regfile_define_rtl += '\t//ports define of internal regfile\n'
    if(cdc):
        regfile_define_rtl += '\tinput regfile_clk          ;\n'
        regfile_define_rtl += '\tinput regfile_rstn         ;\n'
    else:
        regfile_define_rtl += '\twire regfile_clk   = fsm_clk   ;\n'
        regfile_define_rtl += '\twire regfile_rstn  = fsm_rstn  ;\n'
    for reg in reg_list:
        if(reg.alias is True or (reg.shared is True and reg.first_shared is False)):
            pass
        else:
            for field in reg.children:
                field_name = '_'.join(field.hierachy[:-1]).replace('][','_').replace('[','').replace(']','') + '__%s'%(field.hierachy[-1])
                regfile_define_rtl += '\t// ports of %s\n'%(field.hierachy)
                regfile_define_rtl += '\tinput  [%d-1:0]    %s__next_value        ;\n'%(field.fieldwidth, field_name)
                regfile_define_rtl += '\tinput              %s__pulse             ;\n'%(field_name) if (field.hw != "`HW_RO") else ''
                regfile_define_rtl += '\toutput [%d-1:0]    %s__curr_value        ;\n'%(field.fieldwidth, field_name)
                regfile_define_rtl += '\toutput             %s__swmod_out         ;\n'%(field_name) if field.swmod else ''
                regfile_define_rtl += '\toutput             %s__swacc_out         ;\n'%(field_name) if field.swacc else ''
    return regfile_define_rtl


# get wire define rtl
def get_fsm_wire():
    fsm_wire_rtl = ''
    fsm_wire_rtl += '\t// declare the handshake signal for fsm\n'
    fsm_wire_rtl += '\twire                   slv__fsm__ack_vld		;\n'
    fsm_wire_rtl += '\twire                   fsm__slv__req_vld		;\n'
    fsm_wire_rtl += '\t// signal for fsm\n'
    fsm_wire_rtl += '\twire 						fsm__slv__wr_en		;\n'
    fsm_wire_rtl += '\twire 						fsm__slv__rd_en		;\n'
    fsm_wire_rtl += '\twire [ADDR_WIDTH-1:0] 		fsm__slv__addr		;\n'
    fsm_wire_rtl += '\twire [DATA_WIDTH-1:0] 		fsm__slv__wr_data	;\n'
    fsm_wire_rtl += '\twire [DATA_WIDTH-1:0]  		slv__fsm__rd_data	;\n'
    fsm_wire_rtl += '\t// fsm state indicator \n'
    fsm_wire_rtl += '\twire				   		cs_is_idle			;\n'
    return fsm_wire_rtl

def get_decoder_wire():
    decoder_wire_rtl = ''
    decoder_wire_rtl += '\n\t// signal for decoder\n'
    decoder_wire_rtl += '\t// signal for global decoder @regslv domain\n'
    decoder_wire_rtl += '\tlogic [64-1:0] 			global_address	;\n'
    decoder_wire_rtl += '\tlogic [EXT_NUM-1:0] 	ext_sel			;\n'
    decoder_wire_rtl += '\tlogic 					int_selected	;\n'
    decoder_wire_rtl += '\tlogic 					ext_selected	;\n'
    decoder_wire_rtl += '\tlogic 					none_selected	;\n'
    decoder_wire_rtl += '\t// signal for internal decoder @regfile domain\n'
    decoder_wire_rtl += '\tlogic [REG_NUM-1:0] 	reg_sel			;\n'
    decoder_wire_rtl += '\tlogic 					dummy_reg		;\n'
    return decoder_wire_rtl

def get_splitmux_wire():
    splitmux_wire_rtl = ''
    splitmux_wire_rtl += '\n\t// signal for regfile split mux\n'
    splitmux_wire_rtl += '\tlogic [REG_NUM-1:0] [DATA_WIDTH-1:0] regfile_reg_rd_data_in;\n'

    splitmux_wire_rtl += '\n\t// signal for external split mux\n'
    splitmux_wire_rtl += '\twire [EXT_NUM-1:0]                     ext_req_vld_fsm      ;\n'
    splitmux_wire_rtl += '\twire [EXT_NUM-1:0]                     ext_ack_vld_fsm      ;\n'
    splitmux_wire_rtl += '\twire [EXT_NUM-1:0]                     ext_ack_fsm		    ;\n'
    splitmux_wire_rtl += '\twire                                   ext_wr_en_fsm        ;\n'
    splitmux_wire_rtl += '\twire                                   ext_rd_en_fsm        ;\n'
    splitmux_wire_rtl += '\twire [ADDR_WIDTH-1:0]                  ext_addr_fsm         ;\n'
    splitmux_wire_rtl += '\twire [DATA_WIDTH-1:0]                  ext_wr_data_fsm      ;\n'
    splitmux_wire_rtl += '\twire [EXT_NUM-1:0] [DATA_WIDTH-1:0]    ext_rd_data_fsm      ;\n'
    splitmux_wire_rtl += '\twire [DATA_WIDTH-1:0] 				   ext_rd_data_vld_fsm	;\n'
    splitmux_wire_rtl += '\twire                                   ext_reg_ack_vld_fsm  ;\n'
    return splitmux_wire_rtl

def get_regfile_wire(cdc):
    regfile_wire_rtl = ''
    regfile_wire_rtl += '\n\t// regfile signal in regslv domain\n'
    regfile_wire_rtl += '\twire [EXT_NUM-1:0]                     regfile_req_vld_fsm      ;\n'
    regfile_wire_rtl += '\twire                                   regfile_ack_vld_fsm      ;\n'
    regfile_wire_rtl += '\twire                                   regfile_wr_en_fsm        ;\n'
    regfile_wire_rtl += '\twire                                   regfile_rd_en_fsm        ;\n'
    regfile_wire_rtl += '\twire [ADDR_WIDTH-1:0]                  regfile_addr_fsm         ;\n'
    regfile_wire_rtl += '\twire [DATA_WIDTH-1:0]                  regfile_wr_data_fsm      ;\n'
    regfile_wire_rtl += '\twire [DATA_WIDTH-1:0]                  regfile_rd_data_fsm      ;\n'

    regfile_wire_rtl += '\n\t// regfile signal in regfile domain\n'
    regfile_wire_rtl += '\twire [REG_NUM-1:0] wr_sel;\n'
    regfile_wire_rtl += '\twire [REG_NUM-1:0] rd_sel;\n'
    regfile_wire_rtl += '\twire [EXT_NUM-1:0]                     regfile_req_vld      ;\n'
    regfile_wire_rtl += '\twire                                   regfile_ack_vld      ;\n'
    regfile_wire_rtl += '\twire                                   regfile_wr_en        ;\n'
    regfile_wire_rtl += '\twire                                   regfile_rd_en        ;\n'
    regfile_wire_rtl += '\twire [ADDR_WIDTH-1:0]                  regfile_addr         ;\n'
    regfile_wire_rtl += '\twire [DATA_WIDTH-1:0]                  regfile_wr_data      ;\n'
    regfile_wire_rtl += '\twire [DATA_WIDTH-1:0]                  regfile_rd_data      ;\n'
    if(cdc):
        regfile_wire_rtl += '\n\t// regfile signal to handle cdc\n'
        regfile_wire_rtl += '\tlogic [99-1:0] regfile_value_out_fsm;\n'
        regfile_wire_rtl += '\tlogic [99-1:0] regfile_value_out;\n'
        regfile_wire_rtl += '\tlogic [33-1:0] regfile_value_in_fsm;\n'
        regfile_wire_rtl += '\tlogic [33-1:0] regfile_value_in;\n'
        regfile_wire_rtl += '\t// the pulse to deliver the value\n'
        regfile_wire_rtl += '\tlogic regfile_req_vld_fsm_ff;\n'
        regfile_wire_rtl += '\tlogic regfile_sel_pulse;\n'
        regfile_wire_rtl += '\tlogic regfile_ack_vld_ff;\n'
        regfile_wire_rtl += '\tlogic regfile_ack_pulse;\n'

    return regfile_wire_rtl

def get_internal_reg_wire(int_reg_list):
    reg_wire_rtl = ''
    for reg in int_reg_list:
        reg_name = '_'.join(reg.hierachy[:]).replace('][','_').replace('[','').replace(']','')
        reg_wire_rtl += '\tlogic [%d:0] %s_wr_data'%(reg.regwidth-1,reg_name) + ';\n'
        reg_wire_rtl += '\tlogic %s_wr_en'%(reg_name) + ';\n'
        reg_wire_rtl += '\tlogic %s_rd_en'%(reg_name) + ';\n'
    return reg_wire_rtl

def get_snaped_reg_wire(snaped_reg_list):
    snaped_reg_wire_rtl = ''
    for reg in snaped_reg_list:
        reg_name = '_'.join(reg.hierachy[:]).replace('][','_').replace('[','').replace(']','')
        snaped_reg_wire_rtl += '\tlogic [%d:0] %s_wr_data'%(reg.regwidth-1,reg_name) + ';\n'
        snaped_reg_wire_rtl += '\tlogic [%d:0] %s_snapshot_wr_data'%(reg.regwidth-1,reg_name) + ';\n'
        snaped_reg_wire_rtl += '\tlogic [%d:0] %s_snapshot_reg_rd_data'%(reg.regwidth-1,reg_name) + ';\n'
        snaped_reg_wire_rtl += '\tlogic %s_wr_en'%(reg_name) + ';\n'
        snaped_reg_wire_rtl += '\tlogic %s_snapshot_wr_en'%(reg_name) + ';\n'
        snaped_reg_wire_rtl += '\tlogic %s_rd_en'%(reg_name) + ';\n'
        snaped_reg_wire_rtl += '\tlogic %s_snapshot_rd_en'%(reg_name) + ';\n'
    return snaped_reg_wire_rtl

def get_external_wire(ext_list):
    ext_wire_rtl = ''
    for ext_module in ext_list:
        module_name = ext_module.module_name
        ext_wire_rtl += '\t// %s signal in regslv domain\n'%(module_name)
        ext_wire_rtl += '\twire               %s_req_vld_fsm   ;\n'%(module_name)
        ext_wire_rtl += '\twire               %s_ack_vld_fsm   ;\n'%(module_name)
        ext_wire_rtl += '\twire               %s_wr_en_fsm     ;\n'%(module_name)
        ext_wire_rtl += '\twire               %s_rd_en_fsm     ;\n'%(module_name)
        ext_wire_rtl += '\twire [%d-1:0]      %s_addr_fsm      ;\n'%(ext_module.ADDR_WIDTH, module_name)
        ext_wire_rtl += '\twire [%d-1:0]      %s_wr_data_fsm   ;\n'%(ext_module.DATA_WIDTH, module_name)
        ext_wire_rtl += '\twire [%d-1:0]      %s_rd_data_fsm   ;\n'%(ext_module.DATA_WIDTH, module_name)
        ext_wire_rtl += '\t// %s signal in ext_mem1 domain\n'%(module_name)
        ext_wire_rtl += '\twire               %s_req_vld   ;\n'%(module_name)
        ext_wire_rtl += '\twire               %s_ack_vld   ;\n'%(module_name)
        ext_wire_rtl += '\twire               %s_wr_en     ;\n'%(module_name)
        ext_wire_rtl += '\twire               %s_rd_en     ;\n'%(module_name)
        ext_wire_rtl += '\twire [%d-1:0]      %s_addr      ;\n'%(ext_module.ADDR_WIDTH, module_name)
        ext_wire_rtl += '\twire [%d-1:0]      %s_wr_data   ;\n'%(ext_module.DATA_WIDTH, module_name)
        ext_wire_rtl += '\twire [%d-1:0]      %s_rd_data   ;\n'%(ext_module.DATA_WIDTH, module_name)

        if(ext_module.cdc):
            ext_wire_rtl += '\t// %s signal to handle cdc\n'%(module_name)
            ext_wire_rtl += '\tlogic [%d-1:0] %s_value_out_fsm;\n'%(ext_module.DATA_WIDTH + ext_module.ADDR_WIDTH + 3 , module_name)
            ext_wire_rtl += '\tlogic [%d-1:0] %s_value_out    ;\n'%(ext_module.DATA_WIDTH + ext_module.ADDR_WIDTH + 3 , module_name)
            ext_wire_rtl += '\tlogic [%d-1:0] %s_value_in_fsm ;\n'%(ext_module.DATA_WIDTH + 1 , module_name)
            ext_wire_rtl += '\tlogic [%d-1:0] %s_value_in     ;\n'%(ext_module.DATA_WIDTH + 1 , module_name)

            ext_wire_rtl += '\t// the pulse to deliver the %s value\n'%(module_name)
            ext_wire_rtl += '\tlogic          %s_req_vld_fsm_ff   ;\n'%(module_name)
            ext_wire_rtl += '\tlogic          %s_sel_pulse        ;\n'%(module_name)
            ext_wire_rtl += '\tlogic          %s_ack_vld_ff       ;\n'%(module_name)
            ext_wire_rtl += '\tlogic          %s_ack_pulse        ;\n'%(module_name)

        if(isinstance(ext_module, Memory)):
            ext_wire_rtl +=  '\t// %s snapshot signal in regslv domain\n'%(module_name)
            ext_wire_rtl +=  '\twire            %s_snapshot_wr_en_fsm     ;\n'%(module_name)
            ext_wire_rtl +=  '\twire            %s_snapshot_rd_en_fsm     ;\n'%(module_name)
            ext_wire_rtl +=  '\twire [64-1:0]   %s_snapshot_addr_fsm      ;\n'%(module_name)
            ext_wire_rtl +=  '\twire [32-1:0]   %s_snapshot_wr_data_fsm   ;\n'%(module_name)
            ext_wire_rtl +=  '\twire [32-1:0]   %s_snapshot_rd_data_fsm   ;\n'%(module_name)
            ext_wire_rtl +=  '\twire            %s_snapshot_req_vld_fsm   ;\n'%(module_name)
            ext_wire_rtl +=  '\twire            %s_snapshot_ack_vld_fsm   ;\n'%(module_name)

    return ext_wire_rtl


# get wire connection rtl
def get_ext_connect(ext_list):
    ext_connect_rtl = ''
    ext_connect_rtl += '\tassign ext_wr_en_fsm   = fsm__slv__wr_en      ;\n'
    ext_connect_rtl += '\tassign ext_rd_en_fsm   = fsm__slv__rd_en      ;\n'
    ext_connect_rtl += '\tassign ext_addr_fsm    = fsm__slv__addr       ;\n'
    ext_connect_rtl += '\tassign ext_wr_data_fsm = fsm__slv__wr_data    ;\n'
    for ext_module in ext_list:
        module_name = ext_module.module_name
        id = ext_module.id
        if(isinstance(ext_module, Memory)):
            ext_connect_rtl += '\t// wire connection of %s\n'%(module_name)
            ext_connect_rtl += '\tassign %s_snapshot_req_vld_fsm   =   ext_req_vld_fsm[%d]         ;\n'%(module_name, id)
            ext_connect_rtl += '\tassign ext_ack_vld_fsm[%d]       =   %s_snapshot_ack_vld_fsm     ;\n'%(id, module_name)
            ext_connect_rtl += '\tassign %s_snapshot_wr_en_fsm     =   ext_wr_en_fsm               ;\n'%(module_name)
            ext_connect_rtl += '\tassign %s_snapshot_rd_en_fsm     =   ext_rd_en_fsm               ;\n'%(module_name)
            ext_connect_rtl += '\tassign %s_snapshot_addr_fsm      =   ext_addr_fsm                ;\n'%(module_name)
            ext_connect_rtl += '\tassign %s_snapshot_wr_data_fsm   =   ext_wr_data_fsm             ;\n'%(module_name)
            ext_connect_rtl += '\tassign ext_rd_data_fsm[%d]       =   %s_snapshot_rd_data_fsm     ;\n'%(id, module_name)
        else:
            ext_connect_rtl += '\t// wire connection of %s\n'%(module_name)
            ext_connect_rtl += '\tassign %s_req_vld_fsm            =   ext_req_vld_fsm[%d]         ;\n'%(module_name, id)
            ext_connect_rtl += '\tassign ext_ack_vld_fsm[%d]       =   %s_ack_vld_fsm              ;\n'%(id, module_name)
            ext_connect_rtl += '\tassign %s_wr_en_fsm              =   ext_wr_en_fsm               ;\n'%(module_name)
            ext_connect_rtl += '\tassign %s_rd_en_fsm              =   ext_rd_en_fsm               ;\n'%(module_name)
            ext_connect_rtl += '\tassign %s_addr_fsm               =   ext_addr_fsm                ;\n'%(module_name)
            ext_connect_rtl += '\tassign %s_wr_data_fsm            =   ext_wr_data_fsm             ;\n'%(module_name)
            ext_connect_rtl += '\tassign ext_rd_data_fsm[%d]       =   %s_rd_data_fsm              ;\n'%(id, module_name)

        ext_connect_rtl += '\tassign ext_req_vld_fsm[%d]       =   ext_sel[%d] & fsm__slv__req_vld ;\n'%(id, id)
        ext_connect_rtl += '\tassign ext_ack_fsm[%d]           =   ext_sel[%d] & ext_ack_vld_fsm   ;\n'%(id, id)
        return ext_connect_rtl


# get decoder rtl
def get_decoder(int_addr_list, ext_addr_list, master):
    decoder_rtl = ''
    decoder_rtl = '\t// global fsm_decoder @regslv domain\n'
    if(master):
        decoder_rtl += '\tassign global_address   = cs_is_idle ? PADDR : fsm__slv__addr;\n'
    else:
        decoder_rtl += '\tassign global_address   = cs_is_idle ? addr : fsm__slv__addr;\n'
    decoder_rtl += '\tassign ext_selected     = | ext_sel;\n'
    decoder_rtl += '\talways_comb begin\n'
    decoder_rtl += '\t\t\tint_selected = 1\'b0;\n'
    decoder_rtl += '\t\t\text_sel = {EXT_NUM{1\'b0}};\n'
    decoder_rtl += '\t\t\tnone_selected = 1\'b0;\n'
    decoder_rtl += '\t\tunique casez (global_address)\n'

    int_reg_list = []
    if(len(int_addr_list) > 0):
        for addr in int_addr_list:
            for reg in addr.registers:
                reg.hierachy_name = '_'.join(reg.hierachy[:]).replace('][','_').replace('[','').replace(']','')
                addr.register_names.append('`' + reg.hierachy_name)
                reg_addr = '64\'h' + get_hex(reg.addr)
                int_reg_list.append(reg_addr)
        decoder_rtl += '\t\t\t' + ','.join(int_reg_list) + ':' + 'int_selected = 1\'b1;//\n'

    if(len(ext_addr_list) > 0):
        for addr in ext_addr_list:
            for reg in addr.registers:
                reg.hierachy_name = '_'.join(reg.hierachy[:]).replace('][','_').replace('[','').replace(']','')
                addr.register_names.append('`' + reg.hierachy_name)
                if(isinstance(reg.addr,str)):
                    reg_addr = reg.addr
                else:
                    reg_addr = '64\'h' + get_hex(reg.addr)
                addr.addr_str.append(reg_addr)
            # set multi addr to one ext_module
            decoder_rtl += '\t\t\t' + ','.join(addr.addr_str) + ':' + 'ext_sel[%s] = 1\'b1;//external module %s\n'%(ext_addr_list.index(addr),addr.registers[0].external_top.obj)

    decoder_rtl += '\t\t\tdefault: none_selected = 1\'b1;\n'
    decoder_rtl += '\t\tendcase\n'
    decoder_rtl += '\tend\n'

    decoder_rtl += '\t// internal regfile decoder @regfile domain\n'
    decoder_rtl += '\talways_comb begin\n'
    decoder_rtl += '\t\t\treg_sel = {REG_NUM{1\'b0}};\n'
    decoder_rtl += '\t\t\tdummy_reg = 1\'b0;\n'
    decoder_rtl += '\t\tunique casez (regfile_addr)\n'
    if(len(int_addr_list) > 0):
        for addr in int_addr_list:
            for reg in addr.registers:
                reg.hierachy_name = '_'.join(reg.hierachy[:]).replace('][','_').replace('[','').replace(']','')
                addr.register_names.append('`' + reg.hierachy_name)
                reg_addr = '64\'h' + get_hex(reg.addr)
            decoder_rtl += '\t\t\t' + reg_addr + ':' + 'reg_sel[%s] = 1\'b1;//%s\n'%(reg.id,reg.hierachy[:])
    decoder_rtl += '\t\t\tdefault: dummy_reg = 1\'b1;\n'
    decoder_rtl += '\t\tendcase\n'
    decoder_rtl += '\tend\n'
    return decoder_rtl


# get fsm instance rtl
def get_fsm_ins(module_name, master):
    fsm_rtl = ''
    if(master is False):
        fsm_rtl +=              '\tslv_fsm #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))\n' + \
                                '\t\tslv_fsm_%s (\n'%(module_name) + \
                                '\t\t.clk(fsm_clk), .rstn(fsm_rstn), .mst__fsm__req_vld(req_vld), .mst__fsm__wr_en(wr_en), .mst__fsm__rd_en(rd_en), .mst__fsm__addr(addr), .mst__fsm__wr_data(wr_data),\n' + \
                                '\t\t.slv__fsm__rd_data(slv__fsm__rd_data), .slv__fsm__ack_vld(slv__fsm__ack_vld), .fsm__slv__req_vld(fsm__slv__req_vld),\n' + \
                                '\t\t.fsm__slv__wr_en(fsm__slv__wr_en), .fsm__slv__rd_en(fsm__slv__rd_en), .fsm__slv__addr(fsm__slv__addr), .fsm__slv__wr_data(fsm__slv__wr_data),\n' + \
                                '\t\t.fsm__mst__rd_data(rd_data), .fsm__mst__ack_vld(ack_vld),\n' + \
                                '\t\t.external_reg_selected(ext_selected),\n' + \
                                '\t\t.cs_is_idle(cs_is_idle),' + \
                                '\t\t.mst__fsm__sync_reset(global_sync_reset_in),\n' + \
                                '\t\t.fsm__slv__sync_reset(global_sync_reset_out)\n' + '\t);\n'
    else:
        fsm_rtl +=              '\tmst_fsm #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))\n' + \
                                '\t\tmst_fsm_%s (\n'%(module_name) + \
                                '\t\t.PCLK(PCLK), .PRESETn(PRESETn), .fsm__slv__req_vld(fsm__slv__req_vld),\n' + \
                                '\t\t.PADDR(PADDR), .PWRITE(PWRITE), .PSEL(PSEL), .PENABLE(PENABLE),\n' + \
                                '\t\t.PWDATA(PWDATA), .PRDATA(PRDATA), .PREADY(PREADY), .PSLVERR(PSLVERR),\n' + \
                                '\t\t.slv__fsm__rd_data(slv__fsm__rd_data), .slv__fsm__ack_vld(slv__fsm__ack_vld),\n' + \
                                '\t\t.fsm__slv__wr_en(fsm__slv__wr_en), .fsm__slv__rd_en(fsm__slv__rd_en), .fsm__slv__addr(fsm__slv__addr), .fsm__slv__wr_data(fsm__slv__wr_data),\n' + \
                                '\t\t.external_reg_selected(ext_selected),\n' + \
                                '\t\t.cs_is_idle(cs_is_idle),' + \
                                '\t\t.fsm__slv__sync_reset(global_sync_reset_out),\n' + \
                                '\t\t.clear(clear), .interrupt(interrupt)\n' + \
                                '\t\t);\n'
    return fsm_rtl


# get split_mux_ins rtl
def get_split_mux_ins(M,N,reg_mux_size,skip_reg_mux_dff_0,skip_reg_mux_dff_1,ext_mux_size,skip_ext_mux_dff_0,skip_ext_mux_dff_1):
    split_mux_rtl = ''
    skip_reg_dff_0 = 1 if(skip_reg_mux_dff_0) else 0
    skip_reg_dff_1 = 1 if(skip_reg_mux_dff_1) else 0
    skip_ext_dff_0 = 1 if(skip_ext_mux_dff_0) else 0
    skip_ext_dff_1 = 1 if(skip_ext_mux_dff_1) else 0
    if(N > 0):
        split_mux_rtl += '\t// regfile mux @regfile domain\n'
        split_mux_rtl += '\tsplit_mux_2d #(.WIDTH(DATA_WIDTH), .CNT(N+1), .GROUP_SIZE(%d), .SKIP_DFF_0(%d), .SKIP_DFF_1(%d)) rd_split_mux\n'%(reg_mux_size,skip_reg_dff_0,skip_reg_dff_1)
        split_mux_rtl += '\t(.clk(regfile_clk), .rst_n(regfile_rstn),\n'
        split_mux_rtl += '\t.din({regfile_reg_rd_data_in,{DATA_WIDTH{1\'b0}}}), .sel({rd_sel, dummy_reg}),\n'
        split_mux_rtl += '\t.dout(regfile_rd_data), .dout_vld(regfile_ack_vld)\n'
        split_mux_rtl += '\t);\n'
    if(M > 0):
        split_mux_rtl += '\t// external mux @regslv domain\n'
        split_mux_rtl += '\tsplit_mux_2d #(.WIDTH(DATA_WIDTH), .CNT(M), .GROUP_SIZE(%d), .SKIP_DFF_0(%d), .SKIP_DFF_1(%d)) ext_rd_split_mux\n'%(ext_mux_size,skip_ext_dff_0,skip_ext_dff_1)
        split_mux_rtl += '\t(.clk(fsm_clk), .rst_n(fsm_rstn),\n'
        split_mux_rtl += '\t.din(ext_rd_data_fsm), .sel(ext_ack_fsm),\n'
        split_mux_rtl += '\t.dout(ext_rd_data_vld_fsm), .dout_vld(ext_reg_ack_vld_fsm)\n'
        split_mux_rtl += '\t);\n'

    return split_mux_rtl

def get_ultimate_mux(M,N):
    ultimate_mux_rtl = ''
    # get output select
    ultimate_mux_rtl += '\t// select which to read out and transfer the corresponding vld signal @regslv domain\n'
    if(M > 0 and N > 0):
        ultimate_mux_rtl += '\tassign slv__fsm__rd_data = regfile_ack_vld_fsm ? regfile_rd_data_fsm : (ext_reg_ack_vld_fsm ? ext_rd_data_vld_fsm : 0);\n'
        ultimate_mux_rtl += '\tassign slv__fsm__ack_vld = regfile_ack_vld_fsm | ext_reg_ack_vld_fsm;\n'
    elif(M == 0 and N > 0):
        ultimate_mux_rtl += '\tassign slv__fsm__rd_data = regfile_ack_vld_fsm ? regfile_rd_data_fsm : 0;\n'
        ultimate_mux_rtl += '\tassign slv__fsm__ack_vld = regfile_ack_vld_fsm;\n'
    elif(M > 0 and N == 0):
        ultimate_mux_rtl += '\tassign slv__fsm__rd_data = none_selected ? {DATA_WIDTH{1\'b0}} : (ext_reg_ack_vld_fsm ? ext_rd_data_vld_fsm : 0);\n'
        ultimate_mux_rtl += '\tassign slv__fsm__ack_vld = none_selected | ext_reg_ack_vld_fsm;\n'
    else:
        try:
            sys.exit(1)
        except:
            print('NO internal or external regs found!')

    return ultimate_mux_rtl


# get cdc handling logic rtl
def get_mem_cdc_rtl(ext_list):
    mem_cdc_rtl = ''
    for ext_module in ext_list:
        module_name = ext_module.module_name
        if(isinstance(ext_module, Memory) and ext_module.cdc):
            mem_cdc_rtl += '\tassign %s_value_out_fsm = {%s_req_vld_fsm, %s_wr_en_fsm, %s_rd_en_fsm, %s_wr_data_fsm, %s_addr_fsm};\n'%(module_name, module_name, module_name, module_name, module_name, module_name)
            mem_cdc_rtl += '\tassign {%s_req_vld, %s_wr_en, %s_rd_en, %s_wr_data, %s_addr} =  %s_value_out;\n'%(module_name, module_name, module_name, module_name, module_name, module_name)

            mem_cdc_rtl += '\n\tassign {%s_ack_vld_fsm, %s_rd_data_fsm} =  %s_value_in_fsm;\n'%(module_name, module_name, module_name)
            mem_cdc_rtl += '\tassign %s_value_in = {%s_ack_vld, %s_rd_data};\n'%(module_name, module_name, module_name)

            mem_cdc_rtl += '\n\t// create the pulse to deliver the value\n'
            mem_cdc_rtl += '\talways_ff@(posedge fsm_clk or negedge fsm_rstn)begin\n'
            mem_cdc_rtl += '\t\tif(fsm_rstn)\n'
            mem_cdc_rtl += '\t\t\t%s_req_vld_fsm_ff = 1\'b0;\n'%(module_name)
            mem_cdc_rtl += '\t\telse\n'
            mem_cdc_rtl += '\t\t\t%s_req_vld_fsm_ff = %s_req_vld_fsm;\n'%(module_name, module_name)
            mem_cdc_rtl += '\tend\n'

            mem_cdc_rtl += '\n\tassign mem_sel_pulse = ~%s_req_vld_fsm_ff & %s_req_vld_fsm;\n'%(module_name, module_name)

            mem_cdc_rtl += '\n\talways_ff@(posedge %s_clk or negedge %s_rstn)begin\n'%(module_name, module_name)
            mem_cdc_rtl += '\t\tif(%s_rstn)\n'%(module_name)
            mem_cdc_rtl += '\t\t\t%s_ack_vld_ff = 1\'b0;\n'%(module_name)
            mem_cdc_rtl += '\t\telse\n'
            mem_cdc_rtl += '\t\t\t%s_ack_vld_ff = %s_ack_vld;\n'%(module_name, module_name)
            mem_cdc_rtl += '\tend\n'

            mem_cdc_rtl += '\n\tassign mem_ack_pulse = ~%s_ack_vld_ff & %s_ack_vld;\n'%(module_name, module_name)
            mem_cdc_rtl += '\n' + value_transmitter_ins(ext_module)
        else:
            mem_cdc_rtl += '\tassign %s_req_vld       = %s_req_vld_fsm    ;\n'%(module_name, module_name)
            mem_cdc_rtl += '\tassign %s_ack_vld_fsm   = %s_ack_vld        ;\n'%(module_name, module_name)
            mem_cdc_rtl += '\tassign %s_wr_en         = %s_wr_en_fsm      ;\n'%(module_name, module_name)
            mem_cdc_rtl += '\tassign %s_rd_en         = %s_rd_en_fsm      ;\n'%(module_name, module_name)
            mem_cdc_rtl += '\tassign %s_addr          = %s_addr_fsm       ;\n'%(module_name, module_name)
            mem_cdc_rtl += '\tassign %s_wr_data       = %s_wr_data_fsm    ;\n'%(module_name, module_name)
            mem_cdc_rtl += '\tassign %s_rd_data_fsm   = %s_rd_data        ;\n'%(module_name, module_name)

    return mem_cdc_rtl

def get_regfile_cdc(cdc):
    regfile_cdc_rtl = ''
    module_name = 'regfile'

    regfile_cdc_rtl += '\tassign %s_req_vld_fsm = fsm__slv__req_vld & int_selected;\n'%(module_name)
    regfile_cdc_rtl += '\tassign %s_wr_en_fsm = fsm__slv__wr_en & int_selected;\n'%(module_name)
    regfile_cdc_rtl += '\tassign %s_rd_en_fsm = fsm__slv__rd_en & int_selected;\n'%(module_name)
    regfile_cdc_rtl += '\tassign %s_wr_data_fsm = int_selected ? fsm__slv__wr_data : 0;\n'%(module_name)
    regfile_cdc_rtl += '\tassign %s_addr_fsm = int_selected ? fsm__slv__addr : 0;\n'%(module_name)

    if(cdc):
        regfile_cdc_rtl += '\n\tassign %s_value_out_fsm = {%s_req_vld_fsm, %s_wr_en_fsm, %s_rd_en_fsm, %s_wr_data_fsm, %s_addr_fsm};\n'%(module_name, module_name, module_name, module_name, module_name, module_name)
        regfile_cdc_rtl += '\tassign {%s_req_vld, %s_wr_en, %s_rd_en, %s_wr_data, %s_addr} =  %s_value_out;\n'%(module_name, module_name, module_name, module_name, module_name, module_name)

        regfile_cdc_rtl += '\n\tassign {%s_ack_vld_fsm, %s_rd_data_fsm} =  %s_value_in_fsm;\n'%(module_name, module_name, module_name)
        regfile_cdc_rtl += '\tassign %s_value_in = {%s_ack_vld, %s_rd_data};\n'%(module_name, module_name, module_name)

        regfile_cdc_rtl += '\n\t// create the pulse to deliver the value\n'
        regfile_cdc_rtl += '\talways_ff@(posedge fsm_clk or negedge fsm_rstn)begin\n'
        regfile_cdc_rtl += '\t\tif(fsm_rstn)\n'
        regfile_cdc_rtl += '\t\t\t%s_req_vld_fsm_ff = 1\'b0;\n'%(module_name)
        regfile_cdc_rtl += '\t\telse\n'
        regfile_cdc_rtl += '\t\t\t%s_req_vld_fsm_ff = %s_req_vld_fsm;\n'%(module_name, module_name)
        regfile_cdc_rtl += '\tend\n'

        regfile_cdc_rtl += '\n\tassign mem_sel_pulse = ~%s_req_vld_fsm_ff & %s_req_vld_fsm;\n'%(module_name, module_name)

        regfile_cdc_rtl += '\n\talways_ff@(posedge %s_clk or negedge %s_rstn)begin\n'%(module_name, module_name)
        regfile_cdc_rtl += '\t\tif(%s_rstn)\n'%(module_name)
        regfile_cdc_rtl += '\t\t\t%s_ack_vld_ff = 1\'b0;\n'%(module_name)
        regfile_cdc_rtl += '\t\telse\n'
        regfile_cdc_rtl += '\t\t\t%s_ack_vld_ff = %s_ack_vld;\n'%(module_name, module_name)
        regfile_cdc_rtl += '\tend\n'

        regfile_cdc_rtl += '\n\tassign mem_ack_pulse = ~%s_ack_vld_ff & %s_ack_vld;\n'%(module_name, module_name)

        int_regfile = Regfile('internal_regfile')
        int_regfile.module_name = 'regfile'
        int_regfile.DATA_WIDTH = 32
        int_regfile.ADDR_WIDTH = 64
        regfile_cdc_rtl += '\n' + value_transmitter_ins(int_regfile)
    else:
        regfile_cdc_rtl += '\tassign %s_req_vld       = %s_req_vld_fsm    ;\n'%(module_name, module_name)
        regfile_cdc_rtl += '\tassign %s_ack_vld_fsm   = %s_ack_vld        ;\n'%(module_name, module_name)
        regfile_cdc_rtl += '\tassign %s_wr_en         = %s_wr_en_fsm      ;\n'%(module_name, module_name)
        regfile_cdc_rtl += '\tassign %s_rd_en         = %s_rd_en_fsm      ;\n'%(module_name, module_name)
        regfile_cdc_rtl += '\tassign %s_addr          = %s_addr_fsm       ;\n'%(module_name, module_name)
        regfile_cdc_rtl += '\tassign %s_wr_data       = %s_wr_data_fsm    ;\n'%(module_name, module_name)
        regfile_cdc_rtl += '\tassign %s_rd_data_fsm   = %s_rd_data        ;\n'%(module_name, module_name)

    return regfile_cdc_rtl

def value_transmitter_ins(module):
    module_name = module.module_name
    trans_length = module.DATA_WIDTH + module.ADDR_WIDTH + 3
    recei_length = module.DATA_WIDTH + 1

    trans_ins_rtl = ''
    trans_ins_rtl += '\t// fsm to %s\n'%(module_name)
    trans_ins_rtl += '\tvalue_transmitter\n'
    trans_ins_rtl += '\t\t#(.WIDTH(%d))\n'%(trans_length)
    trans_ins_rtl += '\t\t%s_value_transmitter\n'%(module_name)
    trans_ins_rtl += '\t\t(\n'
    trans_ins_rtl += '\t\t.clk_a                                  (fsm_clk)                   ,\n'
    trans_ins_rtl += '\t\t.rst_a_n                                (fsm_rstn)                  ,\n'
    trans_ins_rtl += '\t\t.pulse_in                               (%s_sel_pulse)             ,\n'%(module_name)
    trans_ins_rtl += '\t\t.value_in                               (%s_value_out_fsm)   ,\n'%(module_name)
    trans_ins_rtl += '\t\t.clk_b                                  (%s_clk)             ,\n'%(module_name)
    trans_ins_rtl += '\t\t.rst_b_n                                (%s_rstn)            ,\n'%(module_name)
    trans_ins_rtl += '\t\t.value_out_ack                          (%s_ack_vld)         ,\n'%(module_name)
    trans_ins_rtl += '\t\t.pulse_out                              ()                          ,\n'
    trans_ins_rtl += '\t\t.value_out                              (%s_value_out)\n'%(module_name)
    trans_ins_rtl += '\t);\n'

    trans_ins_rtl += '\n\tvalue_transmitter\n'
    trans_ins_rtl += '\t\t#(.WIDTH(%d))\n'%(recei_length)
    trans_ins_rtl += '\t\t%s_value_receiver\n'%(module_name)
    trans_ins_rtl += '\t\t(\n'
    trans_ins_rtl += '\t\t.clk_a                                  (%s_clk)                         ,\n'%(module_name)
    trans_ins_rtl += '\t\t.rst_a_n                                (%s_rstn)                        ,\n'%(module_name)
    trans_ins_rtl += '\t\t.pulse_in                               (%s_ack_pulse)                         ,\n'%(module_name)
    trans_ins_rtl += '\t\t.value_in                               (%s_value_in)                    ,\n'%(module_name)
    trans_ins_rtl += '\t\t.clk_b                                  (fsm_clk)                               ,\n'
    trans_ins_rtl += '\t\t.rst_b_n                                (fsm_rstn)                              ,\n'
    trans_ins_rtl += '\t\t.value_out_ack                          (%s_ack_vld_fsm)                 ,\n'%(module_name)
    trans_ins_rtl += '\t\t.pulse_out                              ()                                      ,\n'
    trans_ins_rtl += '\t\t.value_out                              (%s_value_in_fsm)\n'%(module_name)
    trans_ins_rtl += '\t);\n'

    return trans_ins_rtl


# internal reg ins rtl
def get_reg_rtl(reg_list, rsvdset):
    reg_rtl = ''
    for reg in reg_list:
        addr = '64\'h' + get_hex(reg.addr)
        offset = '64\'h' + '64\'h' + get_hex(reg.offset)
        reg_name = '_'.join(reg.hierachy[:]).replace('][','_').replace('[','').replace(']','')
        reg_rtl += '\t//' + 'REG INSTANT'.center(100,"=") + '//\n'
        reg_rtl += '\t//' + ('REG NAME: %s'%(reg_name)) + '//\n'
        reg_rtl += '\t//' + ('REG HIERARCHY: %s'%(reg.hierachy)) + '//\n'
        reg_rtl += '\t//' + ('REG ABSOLUTE_ADDR:%s'%(addr)) + '//\n'
        reg_rtl += '\t//' + ('REG OFFSET_ADDR:%s'%(offset)) + '//\n'
        reg_rtl += '\tlogic [%d:0] %s_o'%(reg.regwidth-1,reg_name) + ';\n'
        reg_rtl += '\tassign %s_wr_data = wr_sel[%d] ? regfile_wr_data : 0;\n'%(reg_name,reg.id)
        reg_rtl += '\tassign %s_wr_en = wr_sel[%d];\n'%(reg_name,reg.id)
        reg_rtl += '\tassign %s_rd_en = rd_sel[%d];\n'%(reg_name,reg.id)
        # get field instantion
        # for regs which are snapshoted it will implement while snap_reg won't
        if(reg.snap_origin is None):
            reg_rtl += gen_field_rtl(reg)
            reg_rtl += ''
            rsv_value = hex(int('1'*reg.regwidth,2)) if(rsvdset) else '0x0'
            reg_rtl += '\talways_comb begin\n'
            reg_rtl += '\t%s_o[%d:0] = %d\'h%s;\n'%(reg_name,reg.regwidth-1,reg.regwidth,rsv_value[2:])
            reg_rtl += gen_reg_port(reg)
            reg_rtl += '\tend\n'
        reg_rtl += '\tassign regfile_reg_rd_data_in[%d] = %s_o;\n'%(reg.id,reg_name)

    return reg_rtl


# snapshot reg ins rtl
def get_snapped_reg_rtl(snapped_reg_list, rsvdset):
    snapped_reg_rtl = ''
    for reg in snapped_reg_list:
        # for regs which are snapshoted, additional logic would be generated
        addr = '64\'h' + get_hex(reg.addr)
        offset = '64\'h' + '64\'h' + get_hex(reg.offset)
        rtl_reg_name = '_'.join(reg.hierachy[:]).replace('][','_').replace('[','').replace(']','')
        snapped_reg_rtl += '\t//' + 'REG INSTANT'.center(100,"=") + '//\n'
        snapped_reg_rtl += '\t//' + ('REG NAME: %s'%(rtl_reg_name)) + '//\n'
        snapped_reg_rtl += '\t//' + ('REG HIERARCHY: %s'%(reg.hierachy)) + '//\n'
        snapped_reg_rtl += '\t//' + ('REG ABSOLUTE_ADDR:%s'%(addr)) + '//\n'
        snapped_reg_rtl += '\t//' + ('REG OFFSET_ADDR:%s'%(offset)) + '//\n'
        snapped_reg_rtl += '\tlogic [%d:0] %s_o'%(reg.regwidth-1,rtl_reg_name) + ';\n'
        snapped_reg_rtl += '\tassign %s_wr_data = %s_snapshot_wr_data;\n'%(rtl_reg_name, rtl_reg_name)
        snapped_reg_rtl += '\tassign %s_wr_en = %s_snapshot_wr_en;\n'%(rtl_reg_name,rtl_reg_name)
        snapped_reg_rtl += '\tassign %s_rd_en = %s_snapshot_rd_en;\n'%(rtl_reg_name,rtl_reg_name)
        snapped_reg_rtl += gen_field_rtl(reg)
        rsv_value = hex(int('1'*reg.regwidth,2)) if(rsvdset) else '0x0'
        snapped_reg_rtl += '\talways_comb begin\n'
        snapped_reg_rtl += '\t\t%s_o[%d:0] = %d\'h%s;\n'%(rtl_reg_name,reg.regwidth-1,reg.regwidth,rsv_value[2:])
        snapped_reg_rtl += gen_reg_port(reg)
        snapped_reg_rtl += '\tend\n'
        snapped_reg_rtl += '\tassign %s_snapshot_reg_rd_data = %s_o;\n'%(rtl_reg_name,rtl_reg_name)
        snapped_reg_rtl += '\t//snapshot_reg instance\n'
        snapped_reg_rtl += snapshot_reg_ins(reg)

    return snapped_reg_rtl

def snapshot_reg_ins(reg):
    ins_str = ''
    reg_name = '_'.join(reg.hierachy[:]).replace('][','_').replace('[','').replace(']','')
    snap_reg_wr_en = []
    snap_reg_rd_en = []
    snap_reg_wr_data = []
    snap_reg_rd_data = []
    for snap_reg in reg.snap_reg:
        snap_reg_name = '_'.join(snap_reg.hierachy[:]).replace('][','_').replace('[','').replace(']','')
        snap_reg_wr_en.append('%s_wr_en'%(snap_reg_name))
        snap_reg_rd_en.append('%s_rd_en'%(snap_reg_name))
        snap_reg_wr_data.append('%s_wr_data'%(snap_reg_name))
        snap_reg_rd_data.append('%s_o'%(snap_reg_name))

    snap_reg_wr_en.reverse()
    snap_reg_rd_en.reverse()
    snap_reg_wr_data.reverse()
    snap_reg_rd_data.reverse()

    ins_str = ''
    ins_str +=  '\tsnapshot_reg\n' + \
                '\t\t#(.DATA_WIDTH(%d), .REG_WIDTH(%d))\n'%(32, reg.regwidth) + \
                '\t%s_snapshot_reg\n'%(reg_name) + \
                '\t\t(\n' + \
                '\t\t.clk                     (regfile_clk)                               ,\n' + \
                '\t\t.rst_n                   (regfile_rstn)                              ,\n' + \
                '\t\t.snap_wr_en              ({%s})                              ,\n'%(','.join(snap_reg_wr_en)) + \
                '\t\t.snap_rd_en              ({%s})                              ,\n'%(','.join(snap_reg_rd_en)) + \
                '\t\t.snap_wr_data            ({%s})                              ,\n'%(','.join(snap_reg_wr_data)) + \
                '\t\t.snap_rd_data            ({%s})                              ,\n'%(','.join(snap_reg_rd_data)) + \
                '\t\t.reg_wr_en               (%s_snapshot_wr_en)                 ,\n'%(reg_name) + \
                '\t\t.reg_rd_en               (%s_snapshot_rd_en)                 ,\n'%(reg_name) + \
                '\t\t.reg_wr_data             (%s_snapshot_wr_data)               ,\n'%(reg_name) + \
                '\t\t.reg_rd_data             (%s_snapshot_reg_rd_data)           \n'%(reg_name) + \
                '\t);\n'
    return ins_str

def gen_reg_port(reg:RTL_NODE):
    reg_port_str = ''
    reg_name = '_'.join(reg.hierachy[:]).replace('][','_').replace('[','').replace(']','')
    # if the reg is alias or share
    if(reg.alias or (reg.shared and len(reg.alias_reg) == 0)):
        field_bin = reg.origin_reg.children
    else:
        field_bin = reg.children
    # traverse the original reg's field bin
    for field in field_bin:
        if(field.sw == "`SW_RW" or field.sw == "`SW_RO" or field.sw == "`SW_RW1" ):
            rtl_field_name = '_'.join(field.hierachy[:-1]).replace('][','_').replace('[','').replace(']','') + '__%s'%(field.hierachy[-1])
            reg_port_str += '\t\t%s_o[%d:%d] = %s__curr_value;\n'%(reg_name,field.msb,field.lsb,rtl_field_name)
    return reg_port_str


# snapshot mem ins rtl
def snapshot_mem_ins(ext_list):
    snapshot_str = ''
    for module in ext_list:
        if(isinstance(module, Memory)):
            memory = module
            mem_name = '_'.join(memory.hierachy[:]).replace('][','_').replace('[','').replace(']','')
            snapshot_str = ''
            snapshot_str +=  '\tsnapshot_reg_mem\n' + \
                        '\t\t#(.DATA_WIDTH(%d), .MEM_WIDTH(%d), .SUB(%d),'%(32, memory.memwidth, memory.addr_sub) + \
                        '\t.ADDR_WIDTH(64), .VALID_WIDTH(%s), .ENTRY_WIDTH(%s))\n'%(memory.valid_width, memory.entry_width) + \
                        '\t%s_snapshot_reg_mem\n'%(mem_name) + \
                        '\t\t(\n' + \
                        '\t\t.clk                     (fsm_clk)                               ,\n' + \
                        '\t\t.rst_n                   (fsm_rstn)                              ,\n' + \
                        '\t\t.addr                    (%s_snapshot_addr_fsm)                  ,\n'%(mem_name) + \
                        '\t\t.wr_en                   (%s_snapshot_wr_en_fsm)                 ,\n'%(mem_name) + \
                        '\t\t.rd_en                   (%s_snapshot_rd_en_fsm)                 ,\n'%(mem_name) + \
                        '\t\t.wr_data                 (%s_snapshot_wr_data_fsm)               ,\n'%(mem_name) + \
                        '\t\t.rd_data                 (%s_snapshot_rd_data_fsm)               ,\n'%(mem_name) + \
                        '\t\t.req_vld                 (%s_snapshot_req_vld_fsm)               ,\n'%(mem_name) + \
                        '\t\t.ack_vld                 (%s_snapshot_ack_vld_fsm)               ,\n'%(mem_name) + \
                        '\t\t.entry_write_protect_en  (1\'b0)                             ,\n' + \
                        '\t\t.entry_vld               (1\'b1)                             ,\n' + \
                        '\t\t.entry_vld_nxt           ()                                  ,\n' + \
                        '\t\t.mem_addr                (%s_addr_fsm)                           ,\n'%(mem_name) + \
                        '\t\t.mem_wr_en               (%s_wr_en_fsm)                          ,\n'%(mem_name) + \
                        '\t\t.mem_rd_en               (%s_rd_en_fsm)                          ,\n'%(mem_name) + \
                        '\t\t.mem_wr_data             (%s_wr_data_fsm)                        ,\n'%(mem_name) + \
                        '\t\t.mem_rd_data             (%s_rd_data_fsm)                        ,\n'%(mem_name) + \
                        '\t\t.mem_req_vld             (%s_req_vld_fsm)                        ,\n'%(mem_name) + \
                        '\t\t.mem_ack_vld             (%s_ack_vld_fsm)                        \n'%(mem_name) + \
                        '\t);\n'

    return snapshot_str


# convert addr or reset value from int(decimal) to str(hex)
def get_hex(dec_d:int) -> str:
    if(dec_d is None):
        return '0'
    hex_d = str(hex(dec_d)[2:])
    return hex_d