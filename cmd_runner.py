import argparse
import os
import sys
from multiprocessing import Process

import utils.message as message
from generators.chdr.export import export_chdr
from generators.html.export import export_html
from generators.pdf.export import export_org, export_pdf
from generators.preprocess import preprocess
from generators.rtl.export import export_rtl
from generators.uvm.export import export_uvm
from parsers.parse import parse
from templates.gen_temp import gen_excel_template, gen_rdl_template

__version__ = "0.3.0"
__man_file__ = "hrda_reference_manual.pdf"

class CommandRunner:
    """
    Provide command-line argument parse and execution functionality

    Subcommands
    ------------
    `template` : generate Excel worksheet or SystemRDL templates
    `parse` : parse register description in Excel (.xlsx)/SystemRDL (.rdl)/IP-XACT (.xml) format
    `generate` : generate RTL modules, documentations, UVM RAL model and C header files
    """
    def build_parser(self):
        """
        Build argument parser
        """
        parser = argparse.ArgumentParser(prog="hrda",
                                         description="HJ-micro Register Design Automation (HRDA) Tool. "
                                                     "See reference manual in {}".format(os.path.join(os.path.dirname(__file__),__man_file__)))
        parser.add_argument("-v", "--version", action="version", version="%(prog)s {}".format(__version__))
        subparsers = parser.add_subparsers(title="subcommand",
                                           description="support for generating templates, "
                                                       "parsing Excel/SystemRDL specifications, "
                                                       "and generating RTL, UVM RAL model, documentations "
                                                       "and C header files",
                                           help="see more details in the reference manual: {}".format(os.path.join(os.path.dirname(__file__),__man_file__)))

        # Subcommand: template
        parser_template = subparsers.add_parser("template",
                                                help="generate an Excel worksheet or SystemRDL template")
        parser_template.add_argument("-rdl",
                                     action="store_true",
                                     help="to generate SystemRDL template")
        parser_template.add_argument("-excel",
                                     action="store_true",
                                     help="to generate Excel worksheet template")
        parser_template.add_argument("-d", "--dir",
                                     default=".",
                                     help="directory for the generated template "
                                          "(default: %(default)s)")
        parser_template.add_argument("-n", "--name",
                                     default="template",
                                     help="generated template name "
                                          "(default: %(default)s)")
        parser_template.add_argument("-rnum",
                                     default=1,
                                     type=int,
                                     help="number of registers to be generated "
                                          "in the Excel template (default: %(default)s)")
        parser_template.add_argument("-rname",
                                     default=["TEM1"],
                                     nargs="+",
                                     help="abbreviations of every generated registers "
                                          "in the Excel template. (default: %(default)s)")
        parser_template.add_argument("-l", "--language",
                                           default="cn",
                                           choices=["cn", "en"],
                                           help="language of the generated Excel template "
                                                "(default: %(default)s)")
        parser_template.set_defaults(func=self._template)

        # Subcommand: parse
        parser_parse = subparsers.add_parser("parse",
                                             help="parse and compile register "
                                                  "specifications in Excel/SystemRDL/IP-XACT format")
        parser_parse.add_argument("-f", "--file",
                                  nargs="+",
                                  help="Excel/SystemRDL files to parse (must provide the entire path)")
        parser_parse.add_argument("-l", "--list",
                                  help="a list including paths and names of all files "
                                       "(useful for large number of files)")
        parser_parse.add_argument("-grdl", "--gen_rdl",
                                  action="store_true",
                                  help="generate SystemRDL(.rdl) file based on all input Excel(.xlsx) specifications")
        parser_parse.add_argument("-m", "--module",
                                  default="top_map",
                                  help="used under the situation where all input files are Excel worksheets, "
                                       "which specifies a top addrmap instance name"
                                       "for all input Excel(.xlsx) files (default:%(default)s)")
        parser_parse.add_argument("-gdir", "--gen_dir",
                                  default=".",
                                  help="used under the situation where -grdl/--gen_rdl is set, "
                                       "which specifies the SystemRDL file directory (default:%(default)s)")
        parser_parse.set_defaults(func=self._parse)

        # Subcommand: generate
        parser_generate = subparsers.add_parser("generate",
                                                help="generate RTL, documentations, UVM RAL model and C header files")
        parser_generate.add_argument("-f", "--file",
                                     nargs="+",
                                     help="RDL or Excel (or mixed) files to parse (must provide the entire path)")
        parser_generate.add_argument("-l", "--list",
                                     help="a list including paths and names of all files "
                                          "(useful for large number of files)")
        parser_generate.add_argument("-m", "--module",
                                     default="top_map",
                                     help="if all input files are Excel worksheets, "
                                          "this option specifies extra top RDL file name "
                                          "for all input Excel(.xlsx) files (default:%(default)s)")
        parser_generate.add_argument("-gdir", "--gen_dir",
                                     default=".",
                                     help="directory to save generated files (default:%(default)s)")
        parser_generate.add_argument("-grtl", "--gen_rtl",
                                     action="store_true",
                                     help="generate synthesizable RTL code")
        parser_generate.add_argument("-ghtml", "--gen_html",
                                     action="store_true",
                                     help="generate HTML-format register documentations")
        parser_generate.add_argument("-gorg", "--gen_org",
                                     action="store_true",
                                     help="generate an org mode documentation")
        parser_generate.add_argument("-gpdf", "--gen_pdf",
                                     action="store_true",
                                     help="generate a pdf documentation")
        parser_generate.add_argument("-gral", "--gen_ral",
                                     action="store_true",
                                     help="generate UVM RAL model")
        parser_generate.add_argument("--filter",
                                     nargs="+",
                                     help="filter some instances in UVM simulation "
                                          "(support wildcard character)")
        parser_generate.add_argument("-gch", "--gen_chdr",
                                     action="store_true",
                                     help="generate C headers")
        parser_generate.add_argument("-gall", "--gen_all",
                                     action="store_true",
                                     help="generate all related files")
        parser_generate.add_argument("-q", "--quiet",
                                     action="store_true",
                                     help="turn off debug-level message display on terminal")
        parser_generate.set_defaults(func=self._generate)

        return parser

    @staticmethod
    def _template(args):
        """
        Execution of subcommand `template`.
        This method checks the legality of parameters and pass them down

        Parameter
        ---------
        `args.excel` : whether to generate Excel worksheet template
        `args.rdl` : whether to generate SystemRDL template
        `args.dir` : generation directory
        `args.name` : the generated template Excel worksheet name
        `args.rnum` : `int`, the regsiter number to be generated
        `args.rname` : `list`, register names to be generated
        `args.language` : Excel template language, Chinese/English
        """
        if (not args.excel) and (not args.rdl):
            message.error("no template type (Excel worksheet or SystemRDL) is specified, "
                          "please use -excel or -rdl option")
            sys.exit(1)
        if not os.path.exists(args.dir):
            message.error("directory does not exists!")
            sys.exit(1)

        if args.excel:
            print(args.excel)
            if args.name.endswith(".xls"):
                message.info("file suffix .xls is replaced by .xlsx")
                args.name += "x"
            elif not args.name.endswith(".xlsx"):
                args.name += ".xlsx"

            reg_names = args.rname
            if args.rnum > len(reg_names):
                append_name = reg_names[-1]
                for _ in range(len(reg_names), args.rnum):
                    reg_names.append(append_name)
            gen_excel_template(args.dir, args.name, args.rnum, reg_names, args.language)

        if args.rdl:
            if not args.name.endswith(".rdl"):
                args.name += ".rdl"
            if args.rname or args.rnum or args.language:
                message.info("-rname/-rnum/-l/--language options are not supported to "
                             "generate an SystemRDL template now (only for Excel worksheets)")
            gen_rdl_template(args.dir, args.name)

    @staticmethod
    def _parse(args):
        """
        Execution of subcommand `parse`.
        This method passes the `args` parameter down

        Parameter
        ---------
        `args.file` : `list`, all files waiting for parse
        `args.list` : `str`, the file list text file
        `args.gen_rdl` : `bool`, specifies whether to convert Excel worksheets to SystemRDL files
        `args.module` : top-level addrmap name in generated SystemRDL when all input are Excel files
        `args.gen_dir` : generation directory
        """
        parse(args.file,
              args.list,
              args.gen_dir,
              to_generate_rdl=args.gen_rdl,
              excel_top=args.module)

    @staticmethod
    def _generate(args):
        """
        Execution of subcommand `generate`.
        This method passes the `args` parameter down

        Parameter
        ---------
        `args.file` : `list`, all files to be parsed
        `args.list` : `str`, the file list text file
        `args.module` : top-level addrmap name and the `regmst` name in the `reg_tree` when all input are Excel files
        `args.gen_dir` : generation directory
        `args.gen_rtl` : `bool`, whether to generate RTL modules
        `args.gen_html` : `bool`, whether to generate HTML documentations
        `args.gen_org` : `bool`, whether to generate org mode documentations
        `args.gen_pdf` : `bool`, whether to generate PDF documentations
        `args.gen_ral` : `bool`, whether to generate the UVM RAL model (.sv)
        `args.gen_chdr` : `bool`, whether to generate C header files
        """
        root = parse(args.file,
                     args.list,
                     args.gen_dir,
                     to_generate_rdl=True,
                     excel_top=args.module)

        if not os.path.exists(args.gen_dir):
            message.error("-gdir/--gen_dir option assigns an invalid directory %s" % (args.gen_dir))
            sys.exit(1)

        preprocess(root, filter=args.filter, quiet=args.quiet)

        proc_list = []

        if args.gen_all or args.gen_rtl:
            proc_list.append(Process(target=export_rtl, name="gen_rtl", args=(root, args.gen_dir)))
        if args.gen_all or args.gen_html:
            proc_list.append(Process(target=export_html, name="gen_html", args=(root, args.gen_dir)))
        if args.gen_org:
            proc_list.append(Process(target=export_org, name="gen_org", args=(root, args.gen_dir)))
        if args.gen_all or args.gen_pdf:
            proc_list.append(Process(target=export_pdf, name="gen_pdf", args=(root, args.gen_dir)))
        if args.gen_all or args.gen_ral:
            proc_list.append(Process(target=export_uvm, name="gen_ral", args=(root, args.gen_dir)))
        if args.gen_all or args.gen_chdr:
            proc_list.append(Process(target=export_chdr, name="gen_chdr", args=(root, args.gen_dir)))

        for proc in proc_list:
            proc.start()
        for proc in proc_list:
            proc.join()

    def run(self):
        parser = self.build_parser()
        args = parser.parse_args()

        if len(sys.argv) <= 1:
            message.error("no command is specified, use -h/--help option to get instruction")
            sys.exit(1)

        args.func(args)
