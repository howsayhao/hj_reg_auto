# field instantion
def gen_field_rtl(register):
    fstr = ''
    # if the register is alias reg or shared reg(not the first), its field will not be instanced
    if(register.alias is True or (register.shared is True and register.first_shared is False)):
        return fstr

    if(register.external is True):
        return fstr
    # if the register have alias/shared reg
    if(len(register.alias_reg)>0):
        i = 0
        sw_wr_str_list = []
        sw_rd_str_list = []
        register_name = '_'.join(register.hierachy[:]).replace('][','_').replace('[','').replace(']','')

        sw_wr_str_list.append('wr_sel_ff[%d]'%register.id)
        sw_rd_str_list.append('rd_sel_ff[%d]'%register.id)

        for r_obj in register.alias_reg:
            sw_wr_str_list.append('wr_sel_ff[%d]'%r_obj.id)
            sw_rd_str_list.append('rd_sel_ff[%d]'%r_obj.id)


        for f_obj in register.children:
            alias_num = len(register.alias_reg)

            sw_wr_data_str_list= []
            sw_wr_data_str_list.append(register_name + '_wr_data' + '[%d:%d]'%(f_obj.msb,f_obj.lsb))

            sw_type = []
            sw_type.append(f_obj.sw)
            sw_onread_type = []
            sw_onread_type.append(f_obj.onread)
            sw_onwrite_type = []
            sw_onwrite_type.append(f_obj.onwrite)
            swmod = []
            swmod.append(int(f_obj.swmod))
            swacc = []
            swacc.append(int(f_obj.swacc))
            pulse = []
            pulse.append(int(f_obj.singlepulse))
            sync_reset = []
            sync_reset += f_obj.syncresetsignal

            # collect the alias register's corresponding fields information
            for alias in register.alias_reg:
                alias_reg_name = '_'.join(r_obj.hierachy[:]).replace('][','_').replace('[','').replace(']','')
                sw_wr_data_str_list.append(alias_reg_name + '_wr_data' + '[%d:%d]'%(f_obj.msb,f_obj.lsb))

                sw_type.append(alias.children[i].sw)
                sw_onread_type.append(alias.children[i].onread)
                sw_onwrite_type.append(alias.children[i].onwrite)
                swmod.append(int(alias.children[i].swmod))
                swacc.append(int(alias.children[i].swacc))
                pulse.append(int(alias.children[i].singlepulse))
                sync_reset += alias.children[i].syncresetsignal
            # after collecting the information starting instantiate
            fstr += 'field\n'
            fstr += '\t//' + 'PARAMETER INSTANTIATE'.center(50,"*") + '//\n'
            fstr += '\t#( '
            fstr += '\n\t.F_WIDTH(%s),'%(f_obj.fieldwidth)
            fstr += '\n\t.SRST_CNT(%s),'%(len(sync_reset)) if(sync_reset) else ''
            fstr += '\n\t.ARST_VALUE(%s),'%(f_obj.reset)
            # fstr += '\n\t.SRST_VALUE(%s),'%('')
            # fstr += '\n\t.USE_EXT_ASYNC_VALUE(%s),'%('')
            # fstr += '\n\t.USE_EXT_SYNC_VALUE(%s),'%('')
            fstr += '\n\t.ALIAS_NUM(%s),'%(alias_num + 1)
            fstr += '\n\t.SW_TYPE({%s}),'%(','.join(sw_type))
            fstr += '\n\t.SW_ONREAD_TYPE({%s}),'%(','.join(sw_onread_type))
            fstr += '\n\t.SW_ONWRITE_TYPE({%s}),'%(','.join(sw_onwrite_type))
            fstr += '\n\t.SWMOD({%s}),'%(''.join(str(swmod)).replace('[','').replace(']','')) if f_obj.swmod else ''
            fstr += '\n\t.SWACC({%s}),'%(''.join(str(swacc)).replace('[','').replace(']','')) if f_obj.swacc else ''
            fstr += '\n\t.PULSE({%s}),'%(''.join(str(pulse)).replace('[','').replace(']','')) if f_obj.singlepulse else ''
            fstr += '\n\t.HW_TYPE(%s),'%(f_obj.hw)
            fstr += '\n\t.PRECEDENCE(%s)'%('`' + f_obj.precedence.upper())
            # fstr = fstr[0:-1]
            fstr += '\n\t)\n'
            f_obj_name = '_'.join(f_obj.hierachy[:-1]).replace('][','_').replace('[','').replace(']','') + '__%s'%(f_obj.hierachy[-1])


            sw_wr_data_str = ','.join(sw_wr_data_str_list)
            sw_wr_str = ','.join(sw_wr_str_list)
            sw_rd_str = ','.join(sw_rd_str_list)

            fstr += 'x__%s\n'%(f_obj_name)
            fstr += '\t//' + 'PORT INSTANTIATE'.center(50,"*") + '//\n'
            fstr += '\t('
            fstr += '\n\t.clk(clk),'
            fstr += '\n\t.rst_n(%s),'%(f_obj.resetsignal)
            fstr += '\n\t.sync_rst({%s}),'%(','.join(sync_reset)) if sync_reset else '\n\t.sync_rst(1\'b0),'
            # fstr += '\n\t.ext_async_reset_value(%s),'%('')
            # fstr += '\n\t.ext_sync_reset_value(%s),'%('')
            fstr += '\n\t.sw_wr_data({%s}),'%(sw_wr_data_str)
            fstr += '\n\t.sw_rd({%s}),'%(sw_rd_str)
            fstr += '\n\t.sw_wr({%s}),'%(sw_wr_str)
            fstr += '\n\t.write_protect_en(1\'b0),'
            fstr += '\n\t.sw_type_alter_signal(1\'b0),'
            fstr += '\n\t.swmod_out(%s__swmod_out),'%(f_obj_name) if f_obj.swmod else '\n\t.swmod_out(),'
            fstr += '\n\t.swacc_out(%s__swacc_out)'%(f_obj_name) if f_obj.swacc else '\n\t.swacc_out(),'
            fstr += '\n\t.hw_value(%s__next_value),'%(f_obj_name) if(f_obj.hw != "`HW_RO") else '\n\t.hw_value(%s\'b0),'%(f_obj.fieldwidth)
            fstr += '\n\t.hw_pulse(%s__pulse),'%(f_obj_name) if(f_obj.hw != "`HW_RO") else '\n\t.hw_pulse(1\'b0),'
            fstr += '\n\t.field_value(%s__curr_value)'%(f_obj_name)
            fstr += '\n\t);\n'

    # normal register's field
    else:
        for f_obj in register.children:
            fstr += 'field\n'
            fstr += '\t//' + 'PARAMETER INSTANTIATE'.center(50,"*") + '//\n'
            fstr += '\t#( '
            fstr += '\n\t.F_WIDTH(%s),'%(f_obj.fieldwidth)
            fstr += '\n\t.SRST_CNT(%s),'%(len(f_obj.syncresetsignal)) if(f_obj.syncresetsignal) else ''
            # fstr += '\n\t.SRST_WIDTH(%s),'%(1)
            fstr += '\n\t.ARST_VALUE(%s),'%(f_obj.reset)
            # fstr += '\n\t.SRST_VALUE(%s),'%('')
            # fstr += '\n\t.USE_EXT_ASYNC_VALUE(%s),'%('')
            # fstr += '\n\t.USE_EXT_SYNC_VALUE(%s),'%('')
            fstr += '\n\t.SW_TYPE({%s}),'%(f_obj.sw)
            fstr += '\n\t.SW_ONREAD_TYPE({%s}),'%(f_obj.onread)
            fstr += '\n\t.SW_ONWRITE_TYPE({%s}),'%(f_obj.onwrite)
            fstr += '\n\t.SWMOD({%s}),'%(int(f_obj.swmod)) if f_obj.swmod else ''
            fstr += '\n\t.SWACC({%s}),'%(int(f_obj.swacc)) if f_obj.swacc else ''
            fstr += '\n\t.PULSE({%s}),'%(int(f_obj.singlepulse)) if f_obj.singlepulse else ''
            fstr += '\n\t.HW_TYPE(%s),'%(f_obj.hw)
            fstr += '\n\t.PRECEDENCE(%s)'%('`' + f_obj.precedence.upper())
            # fstr = fstr[0:-1]
            fstr += '\n\t)\n'

            f_obj_name = '_'.join(f_obj.hierachy[:-1]).replace('][','_').replace('[','').replace(']','') + '__%s'%(f_obj.hierachy[-1])
            r_obj_name = '_'.join(register.hierachy[:]).replace('][','_').replace('[','').replace(']','')

            fstr += 'x__%s\n'%(f_obj_name)
            fstr += '\t//' + 'PORT INSTANTIATE'.center(50,"*") + '//\n'
            fstr += '\t('
            fstr += '\n\t.clk(clk),'
            fstr += '\n\t.rst_n(%s),'%(f_obj.resetsignal)
            fstr += '\n\t.sync_rst({%s}),'%(','.join(f_obj.syncresetsignal)) if f_obj.syncresetsignal else '\n\t.sync_rst(1\'b0),'
            # fstr += '\n\t.ext_async_reset_value(%s),'%('')
            # fstr += '\n\t.ext_sync_reset_value(%s),'%('')
            fstr += '\n\t.sw_wr_data(%s_wr_data[%d:%d]),'%(r_obj_name,f_obj.msb,f_obj.lsb)
            fstr += '\n\t.sw_rd(rd_sel_ff[%s]),'%(register.id)
            fstr += '\n\t.sw_wr(wr_sel_ff[%s]),'%(register.id)
            fstr += '\n\t.write_protect_en(1\'b0),'
            fstr += '\n\t.sw_type_alter_signal(1\'b0),'
            # fstr += '\n\t.write_protect_en(%s),'%(register.id)
            fstr += '\n\t.swmod_out(%s__swmod_out),'%(f_obj_name) if f_obj.swmod else '\n\t.swmod_out(),'
            fstr += '\n\t.swacc_out(%s__swacc_out),'%(f_obj_name) if f_obj.swacc else '\n\t.swacc_out(),'
            fstr += '\n\t.hw_value(%s__next_value),'%(f_obj_name) if(f_obj.hw != "`HW_RO") else '\n\t.hw_value(%s\'b0),'%(f_obj.fieldwidth)
            fstr += '\n\t.hw_pulse(%s__pulse),'%(f_obj_name) if(f_obj.hw != "`HW_RO") else '\n\t.hw_pulse(1\'b0),'
            fstr += '\n\t.field_value(%s__curr_value)'%(f_obj_name)
            fstr += '\n\t);\n'

    return fstr