"""""" Output the current syntax group
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . "> "
                   \ . "trans<" . synIDattr(synID(line("."),col("."),0),"name") . "> "
                   \ . "lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
