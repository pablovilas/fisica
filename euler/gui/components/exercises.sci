function updateLstExercises()
    lst = findobj('tag','exercises_list');
    
    index = lst.value;
    if (index > 0) then
        populateParameters(exercises(index)(3), []);
        executeButton = findobj('tag', 'execute_button');
        executeButton.callback = exercises(index)(2);
    end
endfunction

function names=getExercisesNames(exercises)
    n = size(exercises);
    for i = 1:n
        names(i) = exercises(i)(1);
    end
endfunction

function lstExercises(window, exercises)
    // Crear la lista de ejercicios
    
    f_margin_x = margin_x;
    f_margin_y = margin_y + 400;
    f_width = frame_w;
    f_height = frame_h - 400;
    
    frameExercises = uicontrol("parent", window, "relief","groove", ...
    "style","frame", "units","pixels", ...
    "position",[ f_margin_x f_margin_y f_width f_height], ...
    "horizontalalignment","center", "background",[1 1 1], ...
    "tag","exercises_control");
    
    t_margin_x = margin_x + ((f_width / 2) - 50);
    t_margin_y = margin_y + 540;
    t_width = 100;
    t_height = 20;
    
    frameExercisesTitle = uicontrol("parent", window, "style","text", ...
    "string","Ejercicios", "units","pixels", ...
    "position",[t_margin_x t_margin_y t_width t_height], ...
    "fontname",defaultfont, "fontunits","points", ...
    "fontsize",14, "horizontalalignment","center", ...
    "background",[1 1 1], "tag","exercises_frame_control");
    
    exercisesName = getExercisesNames(exercises);
    
    lst = uicontrol("parent", frameExercises, "style","listbox", ...
    "position", [ margin_x  margin_y 260 110], ...
    "string", exercisesName, ...
    "callback", "updateLstExercises", ...
    "tag", "exercises_list");
    if length(exercisesName) > 0 then
        lst.value = 1;
    end
endfunction

