:: Command line test
del .\parsers\test\*.xlsx
del .\parsers\test\*.rdl

python cmd.py   % will display error message %
python cmd.py -h
python cmd.py --version

:: sub-command: excel_template
python cmd.py excel_template -d parsers\test -n test_en --rnum 4 --rname tem1 tem2 tem3 tem4 -l en
python cmd.py excel_template -d parsers\test -n test_cn --rnum 4 --rname tem1 tem2 tem3 tem4 -l cn
python cmd.py excel_template -d parsers\test -n test_cn --rnum 4 --rname tem1 tem2 tem3 tem4 -l cn % will display error info %

:: sub-command: parse_excel
python cmd.py parse_excel -f parsers\test\test_cn.xlsx -g -m test_1 --gen_dir parsers\test
python cmd.py parse_excel -l parsers\test\test_list -g -m test_1 --gen_dir parsers\test