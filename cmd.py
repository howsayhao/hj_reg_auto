import argparse
import os
import sys

import utils.message as message
from generators.html.export import export_html
from generators.uvm.export import export_uvm
from parsers.excel.gen_temp import generate_excel
from parsers.parse import parse_excel, parse_rdl, show_excel_rules

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
        parser.add_argument('--version', action='version', version='%(prog)s {}'.format(__version__))
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
        parser_excel_template.add_argument("--rnum",
                                           default=1,
                                           type=int,
                                           help="number of registers to be generated in the Excel template (default: %(default)s)")
        parser_excel_template.add_argument("--rname",
                                           default=["TEM1"],
                                           nargs="+",
                                           help="abbreviations of every generated registers "
                                                "in the Excel template. (default: %(default)s)")
        parser_excel_template.add_argument("-l", "--language",
                                           default="cn",
                                           choices=["cn", "en"],
                                           help="language of the generated template. (default: %(default)s)")
        parser_excel_template.set_defaults(func=self._generate_excel)

        # 子命令: 解析Excel形式的寄存器描述
        parser_parse_excel = subparsers.add_parser("parse_excel",
                                                help="parse and check register specifications in Excel files")
        parser_parse_excel.add_argument("-f", "--file",
                                        nargs="+",
                                        help="Excel files to parse. (must provide the entire file path)")
        parser_parse_excel.add_argument("-l", "--list",
                                        help="a list file including paths and names of all Excel files "
                                             "(useful for large number of files)")
        parser_parse_excel.add_argument("-s", "--show",
                                        action="store_true",
                                        help="show parsing rules")
        parser_parse_excel.add_argument("-g", "--generate",
                                        action="store_true",
                                        help="generate SystemRDL (.rdl) module file based on Excel specifications")
        parser_parse_excel.add_argument("-m", "--module",
                                        default="unnamed",
                                        help="register module name for all input Excel files (default:%(default)s)")
        parser_parse_excel.add_argument("-gd", "--gen_dir",
                                        default=".",
                                        help="if -g/--generate is set to generate an RDL file, "
                                             "this option specifies the RDL file directory (default:%(default)s)")
        parser_parse_excel.set_defaults(func=self._parse_excel)

        # 子命令：解析SystemRDL形式的寄存器描述
        parser_parse_rdl = subparsers.add_parser("parse_rdl",
                                                 help="parse and check register specifications in SystemRDL files")
        parser_parse_rdl.add_argument("-f", "--file",
                                      nargs="+",
                                      help="SystemRDL files to parse (must provide the entire file path)")
        parser_parse_rdl.add_argument("-l", "--list",
                                      help="a list including paths and names of all SystemRDL files "
                                           "(useful for large number of files)")                      
        parser_parse_rdl.set_defaults(func=self._parse_rdl)

        # TO BE DONE: 子命令: 后端Generator生成RTL, HTML Docs, UVM RAL, C Headers
        # 支持Excel和SystemRDL混合输入
        parser_generate = subparsers.add_parser("generate",
                                                help="generate RTL, HTML Docs, UVM RAL and C Headers")
        parser_generate.add_argument("-f", "--file",
                                     nargs="+",
                                     help="RDL or Excel (or mixed) files to parse (must provide the entire file path)")
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
    def _parse_excel(args):
        """
        子命令`parse_excel`的执行函数, 作为Wrapper检查参数合法性并向下传递

        Parameter
        ---------
        `args.file` : `list`类型, 需要解析的所有Excel文件名
        `args.list` : 存放所有需要解析的Excel文件名的list文件名
        `args.show` : `bool`类型, 是否显示Excel检查规则
        `args.generate` : `bool`类型, 是否生成对应的SystemRDL文件
        `args.module` : 本次解析的模块名, 也作为生成的SystemRDL中顶层addrmap的类型名
        `args.gen_dir` : 生成的SystemRDL的目录位置
        """
        if args.show:
            show_excel_rules()
        # 单个或多个Excel文件作为输入
        if args.file is not None:
            if args.list is not None:
                message.warning("cannot use -f/--file and -l/--list options at the same time,"
                                "-l/--list option will be ignored")
            for file in args.file:
                if not os.path.exists(file):
                    message.error("input file:%s does not exists, "
                                  "maybe you need to add .xlsx suffix" %(file))
                    sys.exit(1)
                if not os.path.splitext(file)[-1] == ".xlsx":
                    message.error("wrong file format! (should be .xlsx)")
                    sys.exit(1)

            # 以list形式把一个或多个Excel文件名传进去
            parse_excel(args.file, args.generate, args.module, args.gen_dir)

        # 多个Excel文件作为输入,文件路径放在一个list文本文件中
        elif args.list is not None:
            if not os.path.exists(args.list):
                message.error("list file does not exists!")
                sys.exit(1)
            else:
                with open(args.list, "r") as f:
                    flist = []
                    lines = f.readlines()
                    for cnt, line in enumerate(lines):
                        line = line.replace("\n", "")

                        # list文件中有注释(#)或空行
                        if line == "" or line.startswith("#"):
                            continue

                        if not os.path.exists(line):
                            message.error("list file:%s line:%d input file:%s does not exists!" %(args.list, cnt, line))
                            sys.exit(1)
                        if not os.path.splitext(line)[-1] == ".xlsx":
                            message.error("wrong file format! (should be .xlsx)")
                            sys.exit(1)
                        flist.append(line)

            # 以list形式把一个或多个Excel文件名传进去
            parse_excel(flist, args.generate, args.module, args.gen_dir)
        elif not args.show:
            message.error("one of the -f/--file and -l/--list options must be provided!")
            sys.exit(1)

    @staticmethod
    def _parse_rdl(args):
        """
        子命令`parse_rdl`的执行函数, 作为Wrapper检查参数合法性并向下传递

        Parameter
        ---------
        `args.file` : `list`类型, 需要解析的所有RDL文件名
        `args.list` : 存放所有需要解析的RDL文件名的list文件名
        """
        # 单个或多个RDL文件作为输入
        if args.file is not None:
            if args.list is not None:
                message.warning("cannot use -f/--file and -l/--list options at the same time,"
                                "-l/--list option will be ignored")
            for file in args.file:
                if not os.path.exists(file):
                    message.error("input file:%s does not exists!" %(file))
                    sys.exit(1)
                if not os.path.splitext(file)[-1] == ".rdl":
                    message.error("wrong file format! (should be .rdl)")
                    sys.exit(1)

            # 以list形式把一个或多个RDL文件名传进去
            parse_rdl(args.file)

        # 多个RDL文件作为输入,文件路径放在一个list文本文件中
        elif args.list is not None:
            if not os.path.exists(args.list):
                message.error("list file does not exists!")
                sys.exit(1)
            else:
                with open(args.list, "r") as f:
                    flist = []
                    lines = f.readlines()
                    for cnt, line in enumerate(lines):
                        line = line.replace("\n", "")

                        # list文件中有注释(#)或空行
                        if line == "" or line.startswith("#"):
                            continue

                        if not os.path.exists(line):
                            message.error("list file:%s line:%d input file:%s does not exists!" %(args.list, cnt, line))
                            sys.exit(1)
                        if not os.path.splitext(line)[-1] == ".rdl":
                            message.error("wrong file format! (should be .rdl)")
                            sys.exit(1)
                        flist.append(line)

            # 以list形式把一个或多个Excel文件名传进去
            parse_rdl(flist)
        else:
            message.error("one of the -f/--file and -l/--list options must be provided!")
            sys.exit(1)

    @staticmethod
    def _generate(args):
        """
        """
        # 单个或多个Excel或者SystemRDL文件作为输入
        rdl_files, excel_files = [], []
        if args.file is not None:
            if args.list is not None:
                message.warning("cannot use -f/--file and -l/--list options at the same time,"
                                "-l/--list option will be ignored")

            for file in args.file:
                if not os.path.exists(file):
                    message.error("input file:%s does not exists!" %(file))
                    sys.exit(1)

                file_format = os.path.splitext(file)[-1]
                if file_format == ".rdl":
                    rdl_files.append(file)
                elif file_format == ".xlsx":
                    excel_files.append(file)
                else:
                    message.error("wrong file format! (should be .rdl/.xlsx)")
                    sys.exit(1)

        # 多个Excel或RDL文件作为输入, 文件路径放在一个list文本文件中
        elif args.list is not None:
            if not os.path.exists(args.list):
                message.error("list file does not exists!")
                sys.exit(1)
            else:
                with open(args.list, "r") as f:
                    lines = f.readlines()
                    for cnt, line in enumerate(lines):
                        line = line.replace("\n", "")

                        # list文件中有注释(#)或空行
                        if line == "" or line.startswith("#"):
                            continue

                        if not os.path.exists(line):
                            message.error("list file:%s line:%d input file:%s does not exists!" %(args.list, cnt, line))
                            sys.exit(1)
                        
                        file_format = os.path.splitext(line)[-1]

                        if file_format == ".rdl":
                            rdl_files.append(line)
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
        if len(excel_files) > 0:
            excel_rdl_file = parse_excel(excel_files, to_parse_rdl=False)   # 不解析生成的RDL, 后续会一并解析
            rdl_files.append(excel_rdl_file)

        root = parse_rdl(rdl_files)

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
    def _generate_rtl(args):
        """
        """
        pass

    @staticmethod
    def _generate_html(args):
        """
        """
        pass

    @staticmethod
    def _generate_ral(args):
        """
        """
        pass
    
    @staticmethod
    def _generate_cheader(args):
        """
        """
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
