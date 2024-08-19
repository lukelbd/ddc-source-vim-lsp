Vim-lsp completion
==================

This plugin uses [vim-lsp](https://github.com/prabirshrestha/vim-lsp) to provide insert and command-mode
popup completion with lsp identifiers (requires [denops.vim](https://github.com/vim-denops/denops.vim) and [ddc.vim](https://github.com/Shougo/ddc.vim)).

To configure add the following to your `~/.vimrc`:

```vim
call ddc#custom#patch_global('sources', ['vim-lsp'])
call ddc#custom#patch_global('sourceOptions', {'vim-lsp': {'matchers': ['matcher_head'], 'mark': 'lsp'}})
```

Installation
============

Install with your favorite [plugin manager](https://vi.stackexchange.com/q/388/8084).
I highly recommend the [vim-plug](https://github.com/junegunn/vim-plug) manager.
To install with vim-plug, add

```
Plug 'lukelbd/ddc-source-vim-lsp'
```
to your `~/.vimrc`.
