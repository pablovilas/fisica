// Importar las funciones de GUI.
getd('gui');

// Constantes globales

// Gravedad de la tierra
g = 9.8  // m/s^2
// Radio de la tierra
r = 6.37E6;

// Funciones utiles

function rad=toRad(degrees)
    rad = degrees * %pi / 180;
endfunction

function []=plotEarth()
    // Centro de la cfa
    x0 = 0;
    y0 = 0;
    // Angulo
    degrees = [0:10:360];
    radians = toRad(degrees);
    // x 
    x = x0 + r * cos(radians);
    // y 
    y = y0 + r * sin(radians);
    // Grafica cfa tierra
    plot2d(x, y, style=color("green"), axesflag=5);
endfunction

// Nombre: Ejercicio 1, Callback: ejercicio1, Parametros: "theta" "v0"
exercise1 = list("Ejercicio 1", "ejercicio1", ["theta" "vo"]);
exercise2 = list("Ejercicio 2", "ejercicio2", ["theta2" "vo2"]);

exercises = list(exercise1, exercise2);

// Interface GUI
startGUI(exercises);

// Ejercicio 1

function ax=ax1(i)
    ax=0;
endfunction

function ay=ay1(i)
    ay=-g;
endfunction

function [vectorX, vectorY]=ballPosition(funAx, funAy, vx0, vy0, x0, y0, dt)
    i = 1
    x(1) = x0;
    y(1) = y0;
    vx(1) = vx0;
    vy(1) = vy0;
    
    while y(i) >= 0
        ax(i)   = funAx(i);
        ay(i)   = funAy(i);
        vx(i+1) = vx(i) + ax(i) * dt;
        vy(i+1) = vy(i) + ay(i) * dt;
        x(i+1)  = x(i) + vx(i) * dt;
        y(i+1)  = y(i) + vy(i) * dt;
        i= i+1;
    end
    
    vectorX = x;
    vectorY = y;    
endfunction

function ejercicio1()    
    thetaTxt = findobj('tag','theta');
    voTxt = findobj('tag', 'vo');
    
    theta = evstr(thetaTxt.string);
    vo = evstr(voTxt.string);
    
    vox = vo * cos(toRad(theta));
    voy = vo * sin(toRad(theta));
    xo = 0;
    yo = 1;
    dt = 0.001;

    [x, y] = ballPosition(ax1, ay1, vox, voy, xo, yo, dt);
    
    // Redraw window
    drawlater();
    plotter = gca();
    plotter.title.font_size = 5;
    plotter.axes_bounds = [1/3,0,2/3,1];
    //plotter.auto_clear = 'on';
    xtitle('Ejercicio 1 (Velocidad inicial: ' + string(vo) + ', Angulo: ' + string(theta) + ')') ;
    plot2d(x, y, style=color("red"), frameflag=6);
	drawnow();
endfunction
