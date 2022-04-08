# Register Design Automation Tool (RDA Tool)

RDA Tool是基于Python的命令行工具，分前端（front-end）与后端（back-end）两部分。前端包含模板生成（Template Generation）和解析器（Parser）功能，前者支持生成既定样式的Excel Worksheet（.xlsx格式）类型寄存器说明模板，后者能够解析输入的Excel Worksheet或SystemRDL描述，进行语法和规则检查。后端包含生成器（Generator）功能，支持生成寄存器RTL (Verilog/SystemVerilog) Modules、HTML形式的寄存器文档、UVM RAL模型和C header files等。

## 命令选项与参数

- `-h,--help`

    显示帮助信息。

    ![ ](docs/pics/1.png)

- `-v, --version`

    显示`RDA Tool`版本信息。

- `excel_template`

    子命令，适用于简单功能的寄存器模块，用于生成寄存器`Excel Worksheet (.xlsx)`模板，有以下命令选项。

    `-h, --help`

    显示该子命令的帮助信息。

    ![ ](docs/pics/2.png)

    `-d,--dir [DIR]`

    指定生成模板的目录位置，默认为当前目录。

    `-n,--name [NAME]`

    指定生成模板的文件名，若有重名则自动补数字区分，默认为`template.xlsx`。

    `-rnum [RNUM]`

    指定生成模板中包含的寄存器个数，默认为`1`。

    `-rname [TEM1 TEM2 ...]`

    指定生成模板中寄存器的名称，默认为 `TEM` ，默认名称（Name）和简写（Abbreviation）相同。

    `-l, --language [cn | en]`

    指定生成模板的语言格式：`cn/en`，默认为`cn`。

- `parse`

    子命令，对输入的Excel(.xlsx)/SystemRDL(.rdl)进行语法和规则检查，并解析为`systemrdl-compiler`中定义的可遍历层级模型（hierarchical model），有以下命令选项。

    `-h, --help`

    显示该子命令的帮助信息。

    ![ ](docs/pics/3.png)

    `-f, --file [FILE1 FILE2 ...]`

    指定输入的Excel(.xlsx)/SystemRDL(.rdl)文件名，支持同时读入多个文件，支持混合读取，若其中任一文件不存在则会报错。

    `-l, --list [LIST_FILE]`

    指定一个`LIST_FILE`文本文件，其中存放所有需要读入的文件路径，Parser会逐行按顺序读取并解析文件，若`LIST_FILE`文件或其中写入的任一文件名不存在则会报错。

    > `-f, --file`和`-l, --list`选项必须使用一个但不允许同时使用，当同时使用时会报警告且忽略`-l,--list`选项

    `-g, --generate`

    显式指定该选项则会对输入的所有Excel (.xlsx)文件解析并一一对应地转换生成SystemRDL (.rdl)文件，并且一个Excel Worksheet对应一个单独的addrmap。当输入全部为Excel (.xlsx)文件时，Parser还会额外生成一个包含顶层`addrmap`的SystemRDL (.rdl)文件，这个顶层`addrmap`会例化所有的子`addrmap`。

    若不使用该选项，则Parser只会进行检查和解析工作，不会额外生成文件。

    `-m, --module [MODULE_NAME]`

    当使用`-g, --generate`选项时，可同时使用该选项指定生成的顶层`addrmap`名称和顶层RDL文件名，方便后续分析和进一步修改。

    `-gdir, --gen_dir [GEN_DIR]`

    当使用`-g, --generate`选项时，该选项指定生成文件的目录，默认为当前目录。

- `generate`

    子命令，用于生成RTL Module，HTML Docs，UVM RAL，C Header Files，有以下命令选项。

    `-h, --help`

    显示该子命令的帮助信息。

    ![ ](docs/pics/4.png)

    `-f, --file [FILE1 FILE2 ...]`

    指定读入的Excel (.xlsx)或SystemRDL (.rdl)文件，支持同时读入多个文件，支持混合读取，若其中任一文件不存在则会报错。

    `-l, --list [LIST_FILE]`

    指定一个`LIST_FILE`文本文件，其中存放所有需要读入的文件路径，Parser会逐行按顺序读取并解析文件，若`LIST_FILE`文件或其中写入的任一文件名不存在则会报错。

    > `-f, --file`和`-l, --list`选项必须使用一个但不允许同时使用，当同时使用时会报警告且忽略`-l,--list`选项

    `-gdir, --gen_dir [dir]`

    指定生成文件的存放目录，若该目录不存在则会报错，若不指定参数则默认为当前目录。

    `-grtl, --gen_rtl`

    显式指定该选项则会生成RTL Module代码。

    `-ghtml, --gen_html`

    显式指定该选项则会生成HTML形式的寄存器说明文档。

    `-gral, --gen_ral`

    显式指定该选项则会生成UVM RAL验证模型。

    `-gch,--gen_cheader`

    显式指定该选项则会生成寄存器C头文件。

    `-gall,--gen_all`

    显式指定该选项则会生成以上所有文件。

## 使用说明

## 示例

> 使用时请将目录切换到到工具的源代码目录下。

- 生成Excel格式的寄存器模板：

    ```bash
    python cmd.py excel_template -n test --rnum 3 --rname tem1 tem2 tem3
    ```

- 解析Excel格式的寄存器说明并生成对应的RDL文件：

    ```bash
    python cmd.py parse -f test1.xlsx test2.xlsx -g -gdir ../test -m test_top

    python cmd.py parse -l test.list -g -gdir ../test -m test_top
    ```

- 使用Generator生成模块代码

    ```bash
    python cmd.py generate -f test1.xlsx test2.xlsx test3.rdl -gdir ../test -grtl -ghtml -gral -gch

    python cmd.py generate -l test.list -gdir ../test -gall
    ```

## 环境与依赖

- 可运行的OS: Windows/Linux

- Python: Version 3.5+

  - systemrdl-compiler  <https://github.com/SystemRDL/systemrdl-compiler>

  - PeakRDL-html  <https://github.com/SystemRDL/PeakRDL-html>

  - PeakRDL-uvm  <https://github.com/SystemRDL/PeakRDL-uvm>

> 后续会将依赖的开源Python库集成到工具里

## TO BE DONE
