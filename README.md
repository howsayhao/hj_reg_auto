# Register Slave (RegSlv) RTL Module Automation Tool Parser

RegSlv的解析器(Parser)部分作为整个自动化工具的前端，以命令行形式使用，支持生成Excel格式的寄存器说明模板，并可根据该样式的寄存器说明解析并生成SystemRDL代码，用于交给后端生成器(Generator)部分生成RTL(Verilog/SystemVerilog)代码、寄存器说明文档、UVM RAL模型和C头文件等。

## Commands and Options

- `-h,--help`

    显示帮助信息。

- `-v, --version`

    显示`regslv`版本信息。

- `excel_template`

    子命令，用于生成寄存器`Excel(.xlsx)`模板，命令选项如下。

    `-d,--dir [directory]`

    指定生成模板的目录位置，默认为当前目录。

    `-n,--name [name]`

    指定生成模板的文件名，若有重名则自动补数字区分，默认为`template.xlsx`。

    `-rnum [number]`

    指定生成模板中包含的寄存器个数，默认为`1`。

    `-rname [TEM1 TEM2 ...]`

    指定生成模板中寄存器的名称，默认为`TEM`，且名称（Name）和简写（Abbreviation）相同。

    > 默认每个寄存器的位宽为`32`，此时地址会自行从`0x0`递增分配。

    `-l,--language [cn | en]`

    指定生成模板的语言格式：`cn`/`en`，默认为`cn`。

- `parse_excel`

- `parse_rdl`

- 

- `generate`

    子命令，用于生成RTL Module，HTML Docs，UVM RAL，C Headers，命令选项如下。

    `-f,--file file_1 [file_2 file_3 ...]`

    指定读入的`Excel(.xlsx)`或`SystemRDL(.rdl)`文件，支持同时读入多个文件，支持混合读取，若其中任一文件不存在则会报错。

    `-l,--list list_file`

    指定一个`list`文本文件，其中存放所有需要读入的文件路径，若`list`文件或其中写入的任一文件名不存在则会报错。

    > `-f,--file`和`-l,--list`选项必须使用一个但不允许同时使用，当同时使用时会报警告且忽略`-l,--list`选项

    `-gdir,--gen_dir [dir]`

    指定生成文件的存放目录，若该目录不存在则会报错，若不指定参数则默认为当前目录。

    `-grtl,--gen_rtl`

    显式指定该选项则会生成RTL Module代码。

    `-ghtml,--gen_html`

    显式指定该选项则会生成HTML形式的寄存器说明文档。

    `-gral,--gen_ral`

    显式指定该选项则会生成UVM RAL验证模型。

    `-gch,--gen_cheader`

    显式指定该选项则会生成寄存器C头文件。

    `-gall,--gen_all`

    显式指定该选项则会生成以上所有文件，包括RTL Module、HTML Docs、UVM RAL、C Headers。


## 使用说明

## 命令行示例

- Generate the Excel template:

    ```bash
    python cmd.py excel_template -n test --rnum 3 --rname tem1 tem2 tem3
    ```

- Parse Excel files and generate SystemRDL file:

    ```bash
    python cmd.py parse_excel -f test.xlsx -g
    ```

## TO BE DONE
