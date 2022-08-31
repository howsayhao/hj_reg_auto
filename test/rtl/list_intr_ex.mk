$(call declare-mod,intr_ex)
$(call add,rtl,intr_ex, \
    $(INTR_EX_DIR)/rtl/regslv_intr_ex.v)

$(call add,mod,intr_ex,hrda)