# **HJ-micro Register Design Automation Tool (HRDA Tool)**

## **1. 简介**

HRDA Tool是基于Python构建的命令行形式的寄存器自动化工具，分前端（front-end）与后端（back-end）两部分。前端包含模板生成（Template Generation）和解析器（Parser）功能，前者支持生成既定样式的Excel Worksheet（.xlsx格式）类型寄存器说明模板，后者能够解析输入的Excel Worksheet或SystemRDL描述，进行语法和规则检查。后端包含生成器（Generator）功能，支持生成寄存器RTL (Verilog/SystemVerilog) Modules、HTML形式的寄存器文档、UVM RAL模型和C header files等。

## **2. 功能描述**

该工具的整体实现流程如下图所示。

![ ](docs/pics/tool%20flow.png)

### **2.1 寄存器Excel模板生成（template generator）**

Excel模板的基础格式如下两张图所示。

![ ](docs/pics/temp_cn.png)

![ ](docs/pics/temp_en.png)

上图给出的是单个寄存器的规格定义，设计者可以参照模板编辑和扩展，在一张Worksheet里排列若干张寄存器规格定义的表单，每张表之间需要隔出空行。

使用Excel Worksheet定义的寄存器各元素如下：

- 寄存器名称：和SystemRDL中的`name`属性一致，用于在生成寄存器说明文档时辅助理解用。

- 地址偏移：每一张Excel Worksheet都会被映射到SystemRDL中的`addrmap`，拥有一个单独的基地址。因此，设计者填入的地址偏移值是基于当前Worksheet基地址的，建议从`0X0`开始编址。

- 寄存器位宽：目前仅支持`32 bit`或`64 bit`（但是对于`32 bit`数据位宽的上层总线如APB，`64 bit`寄存器访问的snapshot功能还在实现中）。

- 寄存器简写：对应到生成RTL的Module名。

- 寄存器功能描述：和SystemRDL中的`desc`属性一致，用于在生成寄存器说明文档时辅助理解用。

- 域定义

  - 比特位：用`xx:xx`形式表示域在寄存器中的位置。

  - 域名称：对应到生成RTL的Field Module名，也和SystemRDL中的`name`属性一致。

  - 域描述：和SystemRDL中的`desc`属性一致，用于在生成寄存器说明文档时辅助理解用。

  - 读属性：和SystemRDL中的`onread`属性一致，支持`R`，`RCLR`，`RSET`。

  - 写属性：和SystemRDL中的`onwrite`属性一致，支持`W`，`WOC`，`WOS`，`WOT`，`WZC`，`WZS`，`WZT`。

  - 复位值

  - 同步复位信号：除默认有的全局异步复位以外，每个域都支持设计单独的、一个或多个同步复位信号。

### **2.2 Excel解析器（Excel Parser）**

Excel解析器会完成两部分工作，其一是检查设计者输入的所有Excel文件，并对基础格式和其他寄存器设计规则进行检查，其二是将解析后的寄存器描述转换为SystemRDL代码，既作为源文件向后面的 `SystemRDL Compiler`递交，也可以让设计者添加SystemRDL支持的更复杂特性。

Excel解析器会执行以下检查：

- **BASIC_FORMAT :** 以正则表达式方式约束的基础格式，包括表格项是否齐全，位置是否正确，特定的单元格内容等。

  1. 基地址必须为 `hex`并以 `0X(x)`作前缀

  2. 地址偏移必须为 `hex`并以 `0X(x)`作前缀

  3. 寄存器位宽只能为 `32 bit`或 `64 bit`

  4. 域的读写属性是被支持的

  5. 域的比特位范围为 `xx:xx`格式

  6. 复位值为 `hex`并以 `0X(x)`作前缀

  7. 域的同步复位信号，若没有则为 `None`，也可有一个或多个，多个的情况以 `,`分隔

- **REG_NAME :** 在同一张Excel工作表中描述的寄存器名字和简写不允许重复。

- **REG_ADDR :** 对寄存器地址偏移分配的合法性。

  1. 按寄存器字节长度的整数倍进行地址对齐（在SystemRDL中称为 `regalign`方式）

  2. 在同一张Excel工作表中不允许地址重叠

- **FIELD_DEFINITION :** 域定义部分的合法性。

  1. 定义多个域时的比特位序自高向低排列

  2. 每个域的比特位范围按 `[high_bit]:[low_bit]`排布

  3. 域比特位无重叠（3.1），无遗漏（3.2）

  4. 复位值合法, 不能超过该域能表示的最大值

  5. 除保留域 `Reserved`以外域名称无重复

  6. 保留域 `Reserved`的同步复位信号只能为 `None`

  7. 同一个域的同步复位信号不能重复

解析过程中，若以上所述的任一规则不被满足，Excel解析器都会报错并提示错误信息和出错位置。

### **2.3 SystemRDL编译器（SystemRDL Compiler）**

SystemRDL的解析依赖于一个开源的github项目 `SystemRDL Compiler`，项目地址见3.1节。它能够将SystemRDL 2.0 Spec定义的RDL输入进行解析、编译和语法检查，生成可遍历的树状寄存器模型，基本工作流程如下图所示。

![ ](docs/pics/systemrdl-compiler.png)

下面是一个简单的SystemRDL代码示例：

```systemrdl
reg my_reg_t {
    field {} f1;
    field {} f2;
};

addrmap top {
    my_reg_t A[4];
    my_reg_t B;
};
```

编译后的寄存器模型如下图所示。

![ ](docs/pics/rdlcompiler_ex1.png)

或者另一种 `Node`形式的模型。

![ ](docs/pics/rdlcompiler_ex2.png)

这个模型是连接工具前端（front-end）与后端（back-end）的桥梁，前端的解析最终会生成这个模型，而后端的一切都是基于这个模型的输入。

> 关于这个模型的详细说明，参见SystemRDL Compiler Documentation : [https://systemrdl-compiler.readthedocs.io/en/stable/index.html](https://systemrdl-compiler.readthedocs.io/en/stable/index.html)

### **2.4 RTL生成器（RTL Generator）**

参见HRDA Tool说明文档。

### **2.5 HTML生成器（HTML Exporter）**

HTML的导出依赖于github上开源的项目 `PeakRDL-html`，项目地址见3.1节。一个简单的导出HTML的例子如下图所示。

![ ](docs/pics/html_ex1.png)

### **2.6 UVM RAL生成器（UVM Exporter）**

UVM寄存器模型的导出依赖于github上开源的项目 `PeakRDL-uvm`，项目地址见3.1节。

### **2.7 C头文件生成器（C Header Generator）（TBD）**

## **3. 使用说明**

### **3.1 环境与依赖**

- 可运行的OS: Windows/Linux

- Python: Version 3.7+

  - systemrdl-compiler  [https://github.com/SystemRDL/systemrdl-compiler](https://github.com/SystemRDL/systemrdl-compiler)

  - PeakRDL-html  [https://github.com/SystemRDL/PeakRDL-html](https://github.com/SystemRDL/PeakRDL-html)

  - PeakRDL-uvm  [https://github.com/SystemRDL/PeakRDL-uvm](https://github.com/SystemRDL/PeakRDL-uvm)

### **3.2 命令选项与参数**

- `-h,--help`

  显示帮助信息。

  ![ ](docs/pics/1.png)
- `-v, --version`

  显示 `RDA Tool`版本信息。
- `template`

  子命令，适用于简单功能的寄存器模块，用于生成寄存器 `Excel Worksheet (.xlsx)`模板，有以下命令选项。

  `-h, --help`

  显示该子命令的帮助信息。

  ![ ](docs/pics/2.png)

  `-d,--dir [DIR]`

  指定生成模板的目录位置，默认为当前目录。

  `-n,--name [NAME]`

  指定生成模板的文件名，若有重名则自动补数字区分，默认为 `template.xlsx`。

  `-rnum [RNUM]`

  指定生成模板中包含的寄存器个数，默认为 `1`。

  `-rname [TEM1 TEM2 ...]`

  指定生成模板中寄存器的名称，默认为 `TEM` ，默认名称（Name）和简写（Abbreviation）相同。

  `-l, --language [cn | en]`

  指定生成模板的语言格式：`cn/en`，默认为 `cn`。

- `parse`

  子命令，对输入的Excel(.xlsx)/SystemRDL(.rdl)进行语法和规则检查，并解析为 `systemrdl-compiler`中定义的可遍历层级模型（hierarchical model），有以下命令选项。

  `-h, --help`

  显示该子命令的帮助信息。

  ![ ](docs/pics/3.png)

  `-f, --file [FILE1 FILE2 ...]`

  指定输入的Excel(.xlsx)/SystemRDL(.rdl)文件名，支持同时读入多个文件，支持混合读取，若其中任一文件不存在则会报错。

  `-l, --list [LIST_FILE]`

  指定一个 `LIST_FILE`文本文件，其中存放所有需要读入的文件路径，Parser会逐行按顺序读取并解析文件，若 `LIST_FILE`文件或其中写入的任一文件名不存在则会报错。

  > `-f, --file`和 `-l, --list`选项必须使用一个但不允许同时使用，当同时使用时会报警告且忽略 `-l,--list`选项
  >

  `-g, --generate`

  显式指定该选项则会对输入的所有Excel (.xlsx)文件解析并一一对应地转换生成SystemRDL (.rdl)文件，并且一个Excel Worksheet对应一个单独的addrmap。当输入全部为Excel (.xlsx)文件时，Parser还会额外生成一个包含顶层 `addrmap`的SystemRDL (.rdl)文件，这个顶层 `addrmap`会例化所有的子 `addrmap`。

  若不使用该选项，则Parser只会进行检查和解析工作，不会额外生成文件。

  `-m, --module [MODULE_NAME]`

  当使用 `-g, --generate`选项时，可同时使用该选项指定生成的顶层 `addrmap`名称和顶层RDL文件名，方便后续分析和进一步修改。

  `-gdir, --gen_dir [GEN_DIR]`

  当使用 `-g, --generate`选项时，该选项指定生成文件的目录，默认为当前目录。

- `generate`

  子命令，用于生成RTL Module，HTML Docs，UVM RAL，C Header Files，有以下命令选项。

  `-h, --help`

  显示该子命令的帮助信息。

  ![ ](docs/pics/4.png)

  `-f, --file [FILE1 FILE2 ...]`

  指定读入的Excel (.xlsx)或SystemRDL (.rdl)文件，支持同时读入多个文件，支持混合读取，若其中任一文件不存在则会报错。

  `-l, --list [LIST_FILE]`

  指定一个 `LIST_FILE`文本文件，其中存放所有需要读入的文件路径，Parser会逐行按顺序读取并解析文件，若 `LIST_FILE`文件或其中写入的任一文件名不存在则会报错。

  > `-f, --file`和 `-l, --list`选项必须使用一个但不允许同时使用，当同时使用时会报警告且忽略 `-l,--list`选项
  >

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

### **3.3 示例**

> 使用时请将目录切换到到工具的源代码目录下，或者将可执行文件`hrda`加入到`PATH`中，或者使用`module`工具进行配置。

- 生成Excel格式的寄存器模板：

  ```bash
  mkdir test
  hrda template -n test.xlsx -rnum 3 -rname tem1 tem2 tem3
  ```

- 解析Excel格式的寄存器说明并生成对应的RDL文件：

  ```bash
  hrda parse -f test/test.xlsx -g -gdir ./test -m test_top
  # another method: edit and save a list file
  hrda parse -l test.list -g -gdir ./test -m test_top
  ```

- 使用Generator生成模块代码

  ```bash
  hrda generate -f test.xlsx -gdir ./test -grtl -ghtml -gral -gch
  # another method: edit and save a list file
  hrda generate -l test.list -gdir ./test -gall
  ```

> 若执行`hrda`失败，请检查`hrda`是否在`PATH`中，以及3.1节提到的Python版本和依赖是否满足。
