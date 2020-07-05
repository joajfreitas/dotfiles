# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import *
from ranger.core.loader import CommandLoader

# A simple command for demonstration purposes follows.
#------------------------------------------------------------------------------

# You can import any python module as needed.
import os, sys

import subprocess

# Any class that is a subclass of "Command" will be integrated into ranger as a
# command.  Try typing ":my_edit<ENTER>" in ranger!
class my_edit(Command):
    # The so-called doc-string of the class will be visible in the built-in
    # help that is accessible by typing "?c" inside ranger.
    """:my_edit <filename>

    A sample command for demonstration purposes that opens a file in an editor.
    """

    # The execute method is called when you run this command in ranger.
    def execute(self):
        # self.arg(1) is the first (space-separated) argument to the function.
        # This way you can write ":my_edit somefilename<ENTER>".
        if self.arg(1):
            # self.rest(1) contains self.arg(1) and everything that follows
            target_filename = self.rest(1)
        else:
            # self.fm is a ranger.core.filemanager.FileManager object and gives
            # you access to internals of ranger.
            # self.fm.thisfile is a ranger.container.file.File object and is a
            # reference to the currently selected file.
            target_filename = self.fm.thisfile.path

        # This is a generic function to print text in ranger.  
        self.fm.notify("Let's edit the file " + target_filename + "!")

        # Using bad=True in fm.notify allows you to print error messages:
        if not os.path.exists(target_filename):
            self.fm.notify("The given file does not exist!", bad=True)
            return

        # This executes a function from ranger.core.acitons, a module with a
        # variety of subroutines that can help you construct commands.
        # Check out the source, or run "pydoc ranger.core.actions" for a list.
        self.fm.edit_file(target_filename)

    # The tab method is called when you press tab, and should return a list of
    # suggestions that the user will tab through.
    def tab(self):
        # This is a generic tab-completion function that iterates through the
        # content of the current directory.
        return self._tab_directory_content()


# https://github.com/ranger/ranger/wiki/Integrating-File-Search-with-fzf
# Now, simply bind this function to a key, by adding this to your ~/.config/ranger/rc.conf: map <C-f> fzf_select
class fzf_select(Command):
    """
    :fzf_select

    Find a file using fzf.

    With a prefix argument select only directories.

    See: https://github.com/junegunn/fzf
    """
    def execute(self):
        import subprocess
        if self.quantifier:
            # match only directories
            command="find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
            -o -type d -print 2> /dev/null | sed 1d | cut -b3- | fzf +m"
        else:
            # match files and directories
            command="find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
            -o -print 2> /dev/null | sed 1d | cut -b3- | fzf +m"
        fzf = self.fm.execute_command(command, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.decode('utf-8').rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)


# fzf_locate
class fzf_locate(Command):
    """
    :fzf_locate

    Find a file using fzf.

    With a prefix argument select only directories.

    See: https://github.com/junegunn/fzf
    """
    def execute(self):
        import subprocess
        if self.quantifier:
            command="locate home media | fzf -e -i"
        else:
            command="locate home media | fzf -e -i"
        fzf = self.fm.execute_command(command, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.decode('utf-8').rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)


class fzf_bring(Command):
    """
    :fzf_bring

    Find a file using fzf and bring it to the current directory.

    See: https://github.com/junegunn/fzf
    """
    def execute(self):
        import subprocess
        import shutil
        if self.quantifier:
            # match only directories
            command="find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
            -o -type d -print 2> /dev/null | sed 1d | cut -b3- | fzf +m"
        else:
            # match files and directories
            command="find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
            -o -print 2> /dev/null | sed 1d | cut -b3- | fzf +m"
        fzf = self.fm.execute_command(command, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.decode('utf-8').rstrip('\n'))
            shutil.move(fzf_file, self.fm.thisdir.path)


class compress(Command):
    def execute(self):
        """ Compress marked files to current directory """
        cwd = self.fm.thisdir
        marked_files = cwd.get_selection()

        if not marked_files:
            return

        def refresh(_):
            cwd = self.fm.get_directory(original_path)
            cwd.load_content()

        original_path = cwd.path
        parts = self.line.split()
        au_flags = parts[1:]

        descr = "compressing files in: " + os.path.basename(parts[1])
        obj = CommandLoader(args=['apack'] + au_flags + \
                [os.path.relpath(f.path, cwd.path) for f in marked_files], descr=descr)

        obj.signal_bind('after', refresh)
        self.fm.loader.add(obj)

    def tab(self):
        """ Complete with current folder name """

        extension = ['.zip', '.tar.gz', '.rar', '.7z']
        return ['compress ' + os.path.basename(self.fm.thisdir.path) + ext for ext in extension]


class extracthere(Command):
    def execute(self):
        """ Extract copied files to current directory """
        copied_files = tuple(self.fm.copy_buffer)

        if not copied_files:
            return

        def refresh(_):
            cwd = self.fm.get_directory(original_path)
            cwd.load_content()

        one_file = copied_files[0]
        cwd = self.fm.thisdir
        original_path = cwd.path
        au_flags = ['-X', cwd.path]
        au_flags += self.line.split()[1:]
        au_flags += ['-e']

        self.fm.copy_buffer.clear()
        self.fm.cut_buffer = False
        if len(copied_files) == 1:
            descr = "extracting: " + os.path.basename(one_file.path)
        else:
            descr = "extracting files from: " + os.path.basename(one_file.dirname)
        obj = CommandLoader(args=['aunpack'] + au_flags \
                + [f.path for f in copied_files], descr=descr)

        obj.signal_bind('after', refresh)
        self.fm.loader.add(obj)


class ncdu(Command):
    """:ncdu run ncdu command on selected folder"""
    def execute(self):
        """ Run ncdu on folder """
        
        target_file = self.fm.thisfile.path
        if not os.path.isdir(target_file):
            self.fm.notify("Error: File is not a directory!")
            return

        self.fm.execute_command(f"ncdu {target_file}")

video_file_ext = [ '264', '3g2', '3gp', '3gp2', '3gpp', '3gpp2', '3mm',
        '3p2', '60d', '787', '89', 'aaf', 'aec', 'aep', 'aepx', 'aet',
        'aetx', 'ajp', 'ale', 'am', 'amc', 'amv', 'amx', 'anim',
        'aqt', 'arcut', 'arf', 'asf', 'asx', 'avb', 'avc', 'avd',
        'avi', 'avp', 'avs', 'avs', 'avv', 'axm', 'bdm', 'bdmv',
        'bdt2', 'bdt3', 'bik', 'bin', 'bix', 'bmk', 'bnp', 'box',
        'bs4', 'bsf', 'bvr', 'byu', 'camproj', 'camrec', 'camv', 'ced',
        'cel', 'cine', 'ip', 'clpi', 'cmmp', 'cmmtpl', 'cmproj',
        'cmrec', 'cpi', 'cst', 'cvc', 'cx3', 'd2v', 'd3v', 'dat',
        'dav', 'dce', 'dck', 'dcr', 'dcr', 'ddat', 'dif', 'dir',
        'divx', 'dlx', 'dmb', 'dmsd', 'dmsd3d', 'dmsm', 'dmsm3d',
        'dmss', 'dmx', 'dnc', 'dpa', 'dpg', 'dream', 'dsy', 'dv',
        'dv-avi', 'dv4', 'dvdmedia', 'dvr', 'dvr-ms', 'dvx', 'dxr',
        'dzm', 'dzp', 'dzt', 'edl', 'evo', 'eye', 'ezt', 'f4p', 'f4v',
        'fbr', 'fbr', 'fbz', 'fcp', 'fcproject', 'ffd', 'flc', 'flh',
        'fli', 'flv', 'flx', 'gfp', 'gl', 'gom', 'grasp', 'gts',
        'gvi', 'gvp', 'h264', 'hdmov', 'hkm', 'ifo', 'imovieproj',
        'imovieproject', 'ircp', 'irf', 'ism', 'ismc', 'ismv', 'iva',
        'ivf', 'ivr', 'ivs', 'izz', 'izzy', 'jss', 'jts', 'jtv',
        'k3g', 'kmv', 'ktn', 'lrec', 'lsf', 'lsx', 'm15', 'm1pg',
        'm1v', 'm21', 'm21', 'm2a', 'm2p', 'm2t', 'm2ts', 'm2v',
        'm4e', 'm4u', 'm4v', 'm75', 'mani', 'meta', 'mgv', 'mj2',
        'mjp', 'mjpg', 'mk3d', 'mkv', 'mmv', 'mnv', 'mob', 'mod',
        'modd', 'moff', 'moi', 'moov', 'mov', 'movie', 'mp21', 'mp21',
        'mp2v', 'mp4', 'mp4v', 'mpe', 'mpeg', 'mpeg1', 'mpeg4', 'mpf',
        'mpg', 'mpg2', 'mpgindex', 'mpl', 'mpl', 'mpls', 'mpsub',
        'mpv', 'mpv2', 'mqv', 'msdvd', 'mse', 'msh', 'mswmm', 'mts',
        'mtv', 'mvb', 'mvc', 'mvd', 'mve', 'mvex', 'mvp', 'mvp',
        'mvy', 'mxf', 'mxv', 'mys', 'ncor', 'nsv', 'nut', 'nuv',
        'nvc', 'ogm', 'ogv', 'ogx', 'osp', 'otrkey', 'pac', 'par',
        'pds', 'pgi', 'photoshow', 'piv', 'pjs', 'playlist', 'plproj',
        'pmf', 'pmv', 'pns', 'ppj', 'prel', 'pro', 'prproj', 'prtl',
        'psb', 'psh', 'pssd', 'pva', 'pvr', 'pxv', 'qt', 'qtch',
        'qtindex', 'qtl', 'qtm', 'qtz', 'r3d', 'rcd', 'rcproject',
        'rdb', 'rec', 'rm', 'rmd', 'rmd', 'rmp', 'rms', 'rmv', 'rmvb',
        'roq', 'rp', 'rsx', 'rts', 'rts', 'rum', 'rv', 'rvid', 'rvl',
        'sbk', 'sbt', 'scc', 'scm', 'scm', 'scn', 'screenflow', 'sec',
        'sedprj', 'seq', 'sfd', 'sfvidcap', 'siv', 'smi', 'smi',
        'smil', 'smk', 'sml', 'smv', 'spl', 'sqz', 'srt', 'ssf',
        'ssm', 'stl', 'str', 'stx', 'svi', 'swf', 'swi', 'swt',
        'tda3mt', 'tdx', 'thp', 'tivo', 'tix', 'tod', 'tp', 'tp0',
        'tpd', 'tpr', 'trp', 'ts', 'tsp', 'ttxt', 'tvs', 'usf', 'usm',
        'vc1', 'vcpf', 'vcr', 'vcv', 'vdo', 'vdr', 'vdx', 'veg','vem',
        'vep', 'vf', 'vft', 'vfw', 'vfz', 'vgz', 'vid', 'video',
        'viewlet', 'viv', 'vivo', 'vlab', 'vob', 'vp3', 'vp6', 'vp7',
        'vpj', 'vro', 'vs4', 'vse', 'vsp', 'w32', 'wcp', 'webm',
        'wlmp', 'wm', 'wmd', 'wmmp', 'wmv', 'wmx', 'wot', 'wp3',
        'wpl', 'wtv', 'wve', 'wvx', 'xej', 'xel', 'xesc', 'xfl',
        'xlmv', 'xmv', 'xvid', 'y4m', 'yog', 'yuv', 'zeg', 'zm1',
        'zm2', 'zm3', 'zmv']

class subtitle(Command):
    """:subtitle download subtitles from opensubtitle"""
    def execute(self):
        target_file = self.fm.thisfile.path
        
        is_video_file = False
        for ext in video_file_ext:
            if ext in target_file:
                is_video_file = True
                break

        if not is_video_file:
            self.fm.notify("Error: File is not a video")
            return
        
        video_file = os.path.basename(target_file)
        self.fm.execute_command(f"subify dl --notify=false '{video_file}'")

class norm(Command):
    """:Replace each underscore within the filename with a space"""
    def execute(self):
        target_file = self.fm.thisfile.path
        if not os.path.isfile(target_file) and not os.path.isdir(target_file):
            self.fm.notify("Error: Not a file!")
            return

        new_name = target_file.lower().replace(' ', '_')
        os.rename(target_file, new_name)

class norm_dir(Command):
    """:Replace each underscore within the filename with a space for each file
    in a directory"""

    def execute(self):
        target_dir = self.fm.thisfile.path

        if not os.path.isdir(target_dir):
            self.fm.notify("Error: Not a file!")
            return
        
        ls = os.listdir(target_dir)

        for f in ls:
            fs = os.path.join(target_dir, f)
            new_name = f.lower().replace(' ', '_')
            nn = os.path.join(target_dir, new_name)
            os.rename(fs, nn)

class j(Command):
    """:j
    Uses autojump to set the current directory.
    """

    def execute(self):
        directory = subprocess.check_output(["autojump", self.arg(1)])
        directory = directory.decode("utf-8", "ignore")
        directory = directory.rstrip('\n')
        self.fm.execute_console("cd " + directory)
