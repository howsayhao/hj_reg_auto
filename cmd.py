import argparse
import os
import sys
from generators.rtl.export import export_rtl

import utils.message as message
from generators.html.export import export_html
from generators.uvm.export import export_uvm
from parsers.excel.gen_temp import generate_excel
from parsers.parse import parse

__version__ = "0.1.0"

class CommandRunner:
    """
    提供命令行解析和执行功能

    Sub-commands
    ------------
    `excel_template` : 生成寄存器Excel模板
    `parse` : 对Excel(.xlsx)或SystemRDL(.rdl)形式的寄存器说明进行解析, 并支持混合输入
    `generate` : 后端Generator生成RTL Module, HTML Docs, UVM RAL Model, C Headers
    """
    def build_parser(self):
        """
        构建命令行解析器
        """
        parser = argparse.ArgumentParser(prog="rda",
                                         description="Register Design Automation (RDA) Tool")
        parser.add_argument("-v", "--version", action="version", version="%(prog)s {}".format(__version__))
        subparsers = parser.add_subparsers(title="sub-commands",
                                           description="support for generating excel templates, "
                                                       "parsing Excel/SystemRDL specifications, "
                                                       "and generating RTL, UVM RAL, HTML docs "
                                                       "and C header files",
                                           help="see more details in the documentaion")

        # 子命令：生成寄存器Excel模板
        parser_excel_template = subparsers.add_parser("excel_template",
                                                      help="generate an Excel template "
                                                           "for register description")
        parser_excel_template.add_argument("-d", "--dir",
                                           default=".",
                                           help="directory for the generated template "
                                                "(default: %(default)s)")
        parser_excel_template.add_argument("-n", "--name",
                                           default="template.xlsx",
                                           help="generated template name "
                                                "(default: %(default)s)")
        parser_excel_template.add_argument("-rnum",
                                           default=1,
                                           type=int,
                                           help="number of registers to be generated "
                                                "in the Excel template (default: %(default)s)")
        parser_excel_template.add_argument("-rname",
                                           default=["TEM1"],
                                           nargs="+",
                                           help="abbreviations of every generated registers "
                                                "in the Excel template. (default: %(default)s)")
        parser_excel_template.add_argument("-l", "--language",
                                           default="cn",
                                           choices=["cn", "en"],
                                           help="language of the generated template "
                                                "(default: %(default)s)")
        parser_excel_template.set_defaults(func=self._generate_excel)

        # 子命令: 解析Excel或SystemRDL形式的寄存器描述
        parser_parse = subparsers.add_parser("parse",
                                             help="parse and check register "
                                                  "specifications in Excel/SystemRDL format")
        parser_parse.add_argument("-f", "--file",
                                  nargs="+",
                                  help="Excel/SystemRDL files to parse (must provide the entire path)")
        parser_parse.add_argument("-l", "--list",
                                  help="a list including paths and names of all files "
                                       "(useful for large number of files)")
        parser_parse.add_argument("-g", "--generate",
                                  action="store_true",
                                  help="generate SystemRDL(.rdl) file based on all input Excel(.xlsx) specifications")
        parser_parse.add_argument("-m", "--module",
                                  default="excel_extra_top",
                                  help="if all input files are Excel worksheets, "
                                       "this option specifies extra top RDL file name "
                                       "for all input Excel(.xlsx) files (default:%(default)s)")
        parser_parse.add_argument("-gdir", "--gen_dir",
                                  default=".",
                                  help="if -g/--generate is set to generate RDL files, "
                                       "this option specifies the RDL file directory (default:%(default)s)")
        parser_parse.set_defaults(func=self._parse)

        # 子命令: 后端Generator生成RTL, HTML Docs, UVM RAL, C Headers
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

    @staticmethod
    def _parse(args):
        """
        子命令`parse`的执行函数, 作为Wrapper向下传递参数

        Parameter
        ---------
        `args.file` : `list`类型, 需要解析所有Excel/SystemRDL文件名
        `args.list` : 存放所有需要解析的Excel文件名的list文本文件名
        `args.generate` : `bool`类型, 是否将输入的Excel生成对应的SystemRDL文件
        `args.aggregate` : `bool`类型, 是否把所有输入最终整合到一个SystemRDL文件中
        `args.module` : 本次解析的模块名, 也作为生成的SystemRDL中顶层addrmap的类型名
        `args.gen_dir` : 生成的SystemRDL的目录位置
        """
        parse(args.file,
              args.list,
              args.gen_dir,
              excel_top_name=args.module,
              to_generate_rdl=args.generate)

    @staticmethod
    def _generate(args):
        """
        """
        root = parse(args.file,
                     args.list,
                     args.gen_dir,
                     to_generate_rdl=True,
                     excel_top_name="excel_extra_top")

        if not os.path.exists(args.gen_dir):
            message.error("-gd/--gen_dir option assigns an invalid directory %s" % (args.gen_dir))
            sys.exit(1)

        if args.gen_all or args.gen_rtl:
            export_rtl(root, args.gen_dir)
        if args.gen_all or args.gen_html:
            export_html(root, args.gen_dir)
        if args.gen_all or args.gen_ral:
            export_uvm(root, args.gen_dir)
        if args.gen_all or args.gen_cheader:
            pass

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
