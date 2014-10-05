function dlgAbout()
	msg = msprintf(gettext("Resolucion de ejercicios de fisica. Gracias a Openeering Team y M. Venturin por los ejemplos de GUI \nAutor: Pablo Vilas"));
	messagebox(msg, gettext("Acerca de"), "info", "modal");
endfunction
