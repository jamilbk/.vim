if has("gui_running")
  if has("gui_macvim")
    set guifont=Monaco:h14
  elseif has("gui_gtk3")
    set guifont=Fira\ Mono\ 11
  endif
else
  set guifont=Monospace:h12
endif
