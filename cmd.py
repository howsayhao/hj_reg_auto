import argparse
import os
import sys

import utils.message as message
from generators.html.export import export_html
from generators.uvm.export import export_uvm
from parsers.excel.gen_temp import generate_excel
from parsers.parse import parse_excel, parse_rdl

__version__ = "0.1.0"

class CommandRunner:
    """
    提供命令行解析和执行功能

    子命令
    -----
    `excel_template` : 生成寄存器Excel模板
    `parse_excel` : 对Excel形式的寄存器说明进行规则检查
    `parse_rdl` : 对SystemRDL形式的寄存器说明进行规则检查
    `generate` : 后端Generator生成RTL, HTML Docs, UVM RAL, C Headers
    """
    def build_parser(self):
        """
        构建命令行解析器
        """
        parser = argparse.ArgumentParser(prog="regslv",
                                         description="register slave (regslv) RTL automation tool.")
        parser.add_argument("-v", "--version", action="version", version="%(prog)s {}".format(__version__))
        subparsers = parser.add_subparsers(title="sub-commands",
                                           description="now support for generating excel templates, " 
                                                       "parsing Excel/SystemRDL specifications, "
                                                       "and generating RTL, RAL, documentation files and C header files",
                                           help="see more details in the documentaion")

        # 子命令：生成寄存器Excel模板
        parser_excel_template = subparsers.add_parser("excel_template",
                                                      help="generate an Excel template for register description")
        parser_excel_template.add_argument("-d", "--dir",
                                           default=".",
                                           help="directory for the generated template (default: %(default)s)")
        parser_excel_template.add_argument("-n", "--name",
                                           default="template.xlsx",
                                           help="generated template name (default: %(default)s)")
        parser_excel_template.add_argument("-rnum",
                                           default=1,
                                           type=int,
                                           help="number of registers to be generated in the Excel template (default: %(default)s)")
        parser_excel_template.add_argument("-rname",
                                           default=["TEM1"],
                                           nargs="+",
                                           help="abbreviations of every generated registers "
                                                "in the Excel template. (default: %(default)s)")
        parser_excel_template.add_argument("-l", "--language",
                                           default="cn",
                                           choices=["cn", "en"],
                                           help="language of the generated template. (default: %(default)s)")
        parser_excel_template.set_defaults(func=self._generate_excel)

        # 子命令: 解析Excel或SystemRDL形式的寄存器描述
        parser_parse = subparsers.add_parser("parse",
                                             help="parse and check register specifications in Excel/SystemRDL format")
        parser_parse.add_argument("-f", "--file",
                                  nargs="+",
                                  help="Excel/SystemRDL files to parse (must provide the entire path)")
        parser_parse.add_argument("-l", "--list",
                                  help="a list including paths and names of all files "
                                       "(useful for large number of files)")
        parser_parse.add_argument("-g", "--generate",
                                  action="store_true",
                                  help="generate SystemRDL(.rdl) file based on all input Excel(.xlsx) specifications")
        parser_parse.add_argument("-a", "--aggregate",
                                  action="store_true",
                                  help="if -g/--generate option is set to generate RDL files, "
                                       "this option aggregate all input Excel(.xlsx) files to one RDL file")
        parser_parse.add_argument("-m", "--module",
                                  default="unnamed",
                                  help="if -a/--aggregate option is set, "
                                       "this option specifies aggregated RDL file name for all input files (default:%(default)s)")
        parser_parse.add_argument("-gdir", "--gen_dir",
                                  default=".",
                                  help="if -g/--generate is set to generate RDL files, "
                                       "this option specifies the RDL file directory (default:%(default)s)")
        parser_parse.set_defaults(func=self._parse)

        # TO BE DONE: 子命令: 后端Generator生成RTL, HTML Docs, UVM RAL, C Headers
        # 支持Excel和SystemRDL混合输入
        parser_generate = subparsers.add_parser("generate",
                                                help="generate RTL, HTML Docs, UVM RAL and C Headers")
        parser_generate.add_argument("-f", "--file",
                                     nargs="+",
                                     help="RDL or Excel (or mixed) files to parse (must provide the entire path)")
        parser_generate.add_argument("-l", "--list",
                                     help="a list including paths and names of all files "
                                          "(useful for large number of files)")
        parser_generate.add_argument("-gdir", "--gen_dir",
                                     default=".",
                                     help="directory to save generated files (default:%(default)s)")
        parser_generate.add_argument("-grtl", "--gen_rtl",
                                     action="store_true",
                                     help="generate synthesiszable SystemVerilog RTL code")
        parser_generate.add_argument("-ghtml", "--gen_html",
                                     action="store_true",
                                     help="generate HTML-format register documentations")
        parser_generate.add_argument("-gral", "--gen_ral",
                                     action="store_true",
                                     help="generate UVM RAL model")
        parser_generate.add_argument("-gch", "--gen_cheader",
                                     action="store_true",
                                     help="generate C headers")
        parser_generate.add_argument("-gall", "--gen_all",
                                     action="store_true",
                                     help="generate all")
        parser_generate.set_defaults(func=self._generate)

        return parser

    @staticmethod
    def _generate_excel(args):
        """
        子命令`excel_template`的执行函数, 作为Wrapper检查参数合法性并向下传递

        Parameter
        ---------
        `args.dir` : 生成寄存器Excel模板的输出目录
        `args.name` : 生成寄存器Excel模板的文件名
        `args.rnum` : 生成Excel模板中寄存器的数量
        `args.rname` : 生成Excel模板中寄存器的名称`list`
        `args.language` : 生成Excel模板的语言, 支持中文/English
        """
        if not os.path.exists(args.dir):
            message.error("directory does not exists!")
            sys.exit(1)
        if not ".xlsx" in args.name:
            args.name += ".xlsx" 

        reg_names = args.rname
        if args.rnum > len(reg_names):
            append_name = reg_names[-1]
            for _ in range(len(reg_names), args.rnum):
                reg_names.append(append_name)
        generate_excel(args.dir, args.name, args.rnum, reg_names, args.language)

    def _parse(self, args):
        """
        `args.file` : `list`类型, 需要解析所有Excel/SystemRDL文件名
        `args.list` : 存放所有需要解析的Excel文件名的list文本文件名
        `args.generate` : `bool`类型, 是否将输入的Excel生成对应的SystemRDL文件
        `args.aggregate` : `bool`类型, 是否把所有输入最终整合到一个SystemRDL文件中
        `args.module` : 本次解析的模块名, 也作为生成的SystemRDL中顶层addrmap的类型名
        `args.gen_dir` : 生成的SystemRDL的目录位置
        """
        self._pre_parse(args.file,
                        args.list,
                        args.gen_dir,
                        to_generate_rdl=args.generate,
                        to_aggregate=args.aggregate,
                        to_gen_sigs=True)

    def _generate(self, args):
        """
        """
        root = self._pre_parse(args.file,
                         args.list,
                         args.gen_dir,
                         to_generate_rdl=True,
                         to_aggregate=True,
                         to_gen_sigs=True)

        if not os.path.exists(args.gen_dir):
            message.error("-gd/--gen_dir option assigns an invalid directory %s" % (args.gen_dir))
            sys.exit(1)

        if args.gen_all or args.gen_rtl:
            pass
        if args.gen_all or args.gen_html:
            export_html(root, args.gen_dir)
        if args.gen_all or args.gen_ral:
            export_uvm(root, args.gen_dir)
        if args.gen_all or args.gen_cheader:
            pass

    @staticmethod
    def _pre_parse(original_files:list, list_file:str, gen_dir:str, **parse_ops):
        """
        
        """
        # 单个或多个Excel或者SystemRDL文件作为输入
        original_rdl_files, excel_files = [], []
        if original_files is not None:
            if list_file is not None:
                message.warning("cannot use -f/--file and -l/--list options at the same time,"
                                "-l/--list option will be ignored")
            for file in original_files:
                    if not os.path.exists(file):
                        message.error("input file: %s does not exists!" %(file))
                        sys.exit(1)

                    file_format = os.path.splitext(file)[-1]
                    if file_format == ".rdl":
                        original_rdl_files.append(file)
                    elif file_format == ".xlsx":
                        excel_files.append(file)
                    else:
                        message.error("wrong file format! (should be .rdl/.xlsx)")
                        sys.exit(1)

        # 多个Excel或RDL文件作为输入, 文件路径放在一个list文本文件中
        elif list_file is not None:
            if not os.path.exists(list_file):
                message.error("list file does not exists!")
                sys.exit(1)
            else:
                with open(list_file, "r") as f:
                    lines = f.readlines()
                    for cnt, line in enumerate(lines):
                        line = line.replace("\n", "").replace("\r", "")

                        # list文件中有注释(#)或空行
                        if line == "" or line.startswith("#"):
                            continue

                        if not os.path.exists(line):
                            message.error("list file: %s line: %d input file: %s does not exists!" %(list_file, cnt, line))
                            sys.exit(1)

                        file_format = os.path.splitext(line)[-1]

                        if file_format == ".rdl":
                            original_rdl_files.append(line)
                        elif file_format == ".xlsx":
                            excel_files.append(line)
                        else:
                            message.error("wrong file format! (should be .rdl/.xlsx)")
                            sys.exit(1)

        else:
            message.error("one of the -f/--file and -l/--list options must be provided!")
            sys.exit(1)

        # 先解析Excel生成中间RDL代码,
        # 再合并其他输入的RDL代码一起输入systemrdl-compiler编译生成寄存器模型
        # TO BE FIXED: 按命令行输入的文件顺序进行解析
        # TO BE FIXED: 复位信号的问题
        # TO BE FIXED: 当好几个Excel文件输入并转成RDL后, 只有一个addrmap能被识别为root
        # TO BE FIXED: aggregation如何使用
        # 每个excel文件生成的addrmap都单独generate一个regslv moodule?
        # 可能的解决方案: reset signal的定义放到每张addrmap scope里面去, 并用自定义的property来引用signal
        excel_rdl_files = parse_excel(excel_files,
                                      parse_ops.get("agg_module", "aggregated_excel_parsed"),
                                      gen_dir,
                                      generate_rdl=parse_ops.get("to_generate_rdl", False),
                                      gen_aggregation=parse_ops.get("to_aggregate", False),
                                      gen_rst_sigs=(original_rdl_files==[] and parse_ops.get("to_gen_sigs", False)))

        if excel_rdl_files is None:
            if parse_ops.get("to_generate_rdl", False):
                message.warning("input files do not include Excel(.xlsx) files")
            all_files = original_rdl_files
        else:
            if parse_ops.get("to_aggregate", False):
                all_files = [excel_rdl_files] + original_rdl_files
            else:
                all_files = excel_rdl_files + original_rdl_files

        return parse_rdl(all_files)

    def run(self):
        parser = self.build_parser()
        args = parser.parse_args()

        if len(sys.argv) <= 1:
            message.error("no command is specified, use -h/--help option to get instruction")
            sys.exit(1)

        args.func(args)

if __name__ == "__main__":
    runner =  CommandRunner()
    runner.run()
