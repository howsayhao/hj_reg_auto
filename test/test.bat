:: command line test
del test_1.xlsx test_2.xlsx
del test_1.rdl test_2.rdl
del excel_extra_top.rdl
del uvm_test.sv
rmdir /s/q html

:: help and version info
python cmd.py -h
python cmd.py --version

:: sub-command: excel_template
python ..\cmd.py excel_template -h
python ..\cmd.py excel_template -n test_1.xlsx -rnum 4 -rname TEST_11 TEST_12 TEST_13 TEST_14
python ..\cmd.py excel_template -n test_2.xlsx -rnum 4 -rname TEST_21 TEST_22 TEST_23 TEST_24

:: sub-command: parse
python ..\cmd.py parse -f .\test_1.xlsx .\test_2.xlsx -g    % only excel files to be parsed and generated %

:: sub-command: generate
python ..\cmd.py generate -f .\test_1.xlsx .\test_2.xlsx -ghtml -gral