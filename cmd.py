import argparse
import os
import utils.message as message
import sys
from excel.gen_temp import generate_excel
from excel.check import check_excel_list, check_excel_single, show_rules

class CommandRunner:
    """
    提供命令行解析和执行功能。
    
    子命令
    -----
    `excel_template` : 生成寄存器Excel模板

    `rdl_template` : 生成寄存器SystemRDL模板

    `check_excel` : 对Excel形式的寄存器说明进行规则检查

    `check_rdl` : 对SystemRDL形式的寄存器说明进行规则检查
    """
    def build_parser(self):
        """
        构建命令行解析器。
        """
        parser = argparse.ArgumentParser(prog="regslv",
                                        description="Register Slave (RegSlv) RTL Automation tool.")
        subparsers = parser.add_subparsers(title="Sub-functions",
                                        description="Generating templates, checking, generating RTL...",
                                        help="See more in the documentaion")
        # 子命令：生成寄存器Excel模板
        parser_excel_template = subparsers.add_parser("excel_template",
                                                    help="Generate an Excel template for register description.")
        parser_excel_template.add_argument("-p", "--path",
                                        default=".",
                                        help="Path for the generated template. (Default: %(default)s)")
        parser_excel_template.add_argument("-n", "--name",
                                        default="template.xlsx",
                                        help="File name for the generated template. (Default: %(default)s)")
        parser_excel_template.add_argument("--rnum",
                                        default=1,
                                        type=int,
                                        help="Number of registers generated in the Excel template. (Default: %(default)s)")
        parser_excel_template.add_argument("--rname",
                                        default="TEM1",
                                        help="Abbreviations of every generated registers "
                                        "in the Excel template. (Default: %(default)s)",
                                        metavar="TEM1[,TEM2,...]")
        parser_excel_template.add_argument("-l", "--language",
                                        default="cn",
                                        choices=["cn", "en"],
                                        help="Language for the generated template. (Default: %(default)s)")
        parser_excel_template.set_defaults(func=self._generate_excel)
        
        # 子命令：生成寄存器SystemRDL模板
        
        # 子命令：对Excel形式的寄存器说明进行规则检查
        parser_check_excel = subparsers.add_parser("check_excel",
                                                help="Rule check for register descriptions in Excel format.")
        parser_check_excel.add_argument("-f", "--file",
                                        help="Excel files to check. (must provide entire file path)")
        parser_check_excel.add_argument("-l", "--list",
                                        help="A list including paths and names of all excel files. (useful for large number of files)")
        parser_check_excel.add_argument("-s", "--show",
                                        action="store_true",
                                        help="Show rules.")                           
        parser_check_excel.set_defaults(func=self._check_excel)

        # 子命令：对SystemRDL形式的寄存器说明进行规则检查
        parser_check_excel = subparsers.add_parser("check_rdl",
                                                help="Rule check for register descriptions in SystemRDL format.")
        parser_check_excel.add_argument("-f", "--file",
                                        help="SystemRDL files to check. (must provide entire file path)")
        parser_check_excel.add_argument("-l", "--list",
                                        help="A list including paths and names of all excel files. (useful for large number of files)")                      
        parser_check_excel.set_defaults(func=self._check_rdl)

        return parser

    # 子命令执行函数
    # Wrapper
    @staticmethod
    def _generate_excel(args):
        if not os.path.exists(args.path):
            message.error("path does not exists!")
            sys.exit(1)
        if not ".xlsx" in args.name:
            args.name += ".xlsx" 

        reg_names = args.rname.split(",")
        if args.rnum > len(reg_names):
            append_name = reg_names[-1]
            for _ in range(len(reg_names), args.rnum):
                reg_names.append(append_name)
        generate_excel(args.path, args.name, args.rnum, reg_names, args.language)

    @staticmethod
    def _check_excel(args):
        if args.show:
            show_rules()
        # 单个Excel文件作为输入
        if args.file is not None:
            if args.list is not None:
                message.warning("cannot use -f(--file) and -l(--list) at the same time,"
                                "-l(--list) option will be ignored")
            if not os.path.exists(args.file):
                message.error("file does not exists!")
                sys.exit(1)
            if not os.path.splitext(args.file)[-1] == ".xlsx":
                message.error("wrong file format!")
                sys.exit(1)
            check_excel_single(args.file)
        # 多个Excel文件作为输入,文件路径放在一个list文本文件中
        elif args.list is not None:
            if not os.path.exists(args.list):
                message.error("list file does not exists!")
                sys.exit(1)
            check_excel_list(args.list)
        elif not args.show:
            message.error("one of the -f(--file) and -l(--list) options must be provided!")
            sys.exit(1)
            
 


    @staticmethod
    def _check_rdl(args):
        print(args.file, args.list)
    
    def run(self):
        parser = self.build_parser()
        args = parser.parse_args()
        args.func(args)

if __name__ == "__main__":
    runner =  CommandRunner()
    runner.run()