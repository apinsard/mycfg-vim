# -*- coding: utf-8 -*-
import os
import re

import neovim

data_dir = os.path.join(
    os.path.dirname(os.path.abspath(__file__)),
    '..', '..', 'data', 'python_imports')

single_import_re = re.compile((
    r'(from\s+(?P<from>[a-z0-9_.]+)\s+)?import\s+(?P<import>[a-z0-9_.]+)'
    r'(\s+as\s+(?P<as>[a-z0-9_]+))?'), re.I)


@neovim.plugin
class PythonImports:

    def __init__(self, vim):
        self.vim = vim

    @neovim.command('SaveImports', range='')
    def save_imports(self, rng):
        buf = self.vim.current.buffer
        import_line = ' '.join(buf.range(*rng)).strip()
        try:
            data = self._parse_import_line(import_line)
        except ValueError as e:
            self.error(e)
            return
        import_name = data['as'] or data['import']
        data_line = self._build_import_line(**data) + '\n'
        filename = os.path.join(data_dir, import_name[0], import_name)
        if os.path.exists(filename):
            with open(filename) as f:
                lines = f.readlines()
            try:
                i = lines.index(data_line)
            except ValueError:
                pass
            else:
                del lines[i]
        else:
            os.makedirs(os.path.dirname(filename))
            lines = []
        lines.insert(0, data_line)
        with open(filename, 'w') as f:
            f.write(''.join(lines))
        self.message("import line saved")

    def _build_import_line(self, **kwargs):
        pattern = 'import {import}'
        if kwargs.get('from'):
            pattern = 'from {from} ' + pattern
        if kwargs.get('as'):
            pattern += ' as {as}'
        return pattern.format(**kwargs)

    def _parse_import_line(self, import_line):
        match = single_import_re.match(import_line)
        if not match:
            raise ValueError("Range doesn't match an import statement")
        return match.groupdict()

    def error(self, msg):
        self.vim.err_write(str(msg) + '\n')

    def message(self, msg):
        self.vim.out_write(str(msg) + '\n')
