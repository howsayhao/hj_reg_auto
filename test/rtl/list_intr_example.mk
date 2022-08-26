$(call declare-mod,intr_example)
$(call add,rtl,intr_example, \
    $(INTR_EXAMPLE_DIR)/rtl/regslv_intr_example.v)

$(call add,mod,intr_example,hrda)