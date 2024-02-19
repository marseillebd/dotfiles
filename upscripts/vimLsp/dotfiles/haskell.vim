if executable('haskell-language-server-wrapper')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'haskell-language-server-wrapper',
        \ 'cmd': {server_info->['haskell-language-server-wrapper', '--lsp']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(
        \     lsp#utils#find_nearest_parent_file_directory(
        \         lsp#utils#get_buffer_path(),
        \         ['.cabal', 'stack.yaml', 'cabal.project', 'package.yaml', 'hie.yaml', '.git'],
        \     ))},
        \ 'whitelist': ['haskell', 'lhaskell'],
        \ })
endif
