# Register Slave (RegSlv) RTL Module Automation Tool Parser

RegSlv的解析器(Parser)部分作为整个自动化工具的前端，以命令行形式使用，支持生成Excel格式的寄存器说明模板，并可根据该样式的寄存器说明解析并生成SystemRDL代码，用于交给后端生成器(Generator)部分生成RTL(Verilog/SystemVerilog)代码、寄存器说明文档、UVM RAL模型和C头文件等。

## 功能

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
