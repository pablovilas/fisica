function startGUI(exercisesList)
    // Crear ventana principal vacia
    global margin_x margin_y;
    global frame_w frame_h plot_w plot_h;
    global defaultfont;
    global exercises;

    frame_w = 300; 
    frame_h = 550;
    plot_w = 600; 
    plot_h = frame_h;
    margin_x = 15; 
    margin_y = 15;
    defaultfont = "arial";
    exercises = exercisesList;
    axes_w = 3 * margin_x + frame_w + plot_w;
    axes_h = 2 * margin_y + frame_h;
    window = scf(100001);
    window.background = -2;
    window.figure_position = [100 100];
    window.figure_name = gettext("Aproximacion numerica por metodo de Euler");
    window.axes_size = [axes_w axes_h];
    
    // Quito los menu por defecto de scilab
    delmenu(window.figure_id, gettext("&File"));
    delmenu(window.figure_id, gettext("&Tools"));
    delmenu(window.figure_id, gettext("&Edit"));
    delmenu(window.figure_id, gettext("&?"));
    toolbar(window.figure_id, "off");
    
    // Menues personalizados
    h1 = uimenu("parent", window, "label",gettext("Archivo"));
    h2 = uimenu("parent", window, "label",gettext("Acerca"));
    
    // Popular menu: Archivo
    uimenu("parent",h1, "label",gettext("Cerrar"), "callback", "frame=get_figure_handle(100001);delete(frame);", "tag","close_menu");
    
    // Popular menu: Acerca de
    uimenu("parent",h2, "label",gettext("Acerca de"), "callback","dlgAbout();");
    // Espero a que se dibuje la pantalla
    sleep(500);
    
    lstExercises(window, exercises);
    lstParameters(window);
endfunction
