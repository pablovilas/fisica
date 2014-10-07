// Importar las funciones de GUI.
getd('gui');

// Constantes globales
global g r mt G;

// Gravedad de la tierra (m/s^2)
g = 9.8
// Radio de la tierra (m)
r = 6.37E6;
// Masa de la tierra (kg)
mt = 5.972E24;
// Constante de gravitacion universal
G = 6.67384E-11

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
exercise2 = list("Ejercicio 2", "ejercicio2", ["vo"]);
exercise4 = list("Ejercicio 4", "ejercicio4", []);
exercise7 = list("Ejercicio 7", "ejercicio7", ["v1" "v2" "v3" "v4"]);

exercises = list(exercise1, exercise2, exercise4, exercise7);

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

// Callback de ejercicios

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

function ejercicio2()
    voTxt = findobj('tag', 'vo');
    vo = evstr(voTxt.string);
    maxPos = 0 ;
    angle = 0;
    
    for i = 40:0.5:50
        vox = vo * cos(toRad(i));
        voy = vo * sin(toRad(i));
        xo = 0;
        yo = 1;
        dt = 0.001;
        [x, y] = ballPosition(ax1, ay1, vox, voy, xo, yo, dt);
        
        if maxPos < x($) then
            maxPos = x($);
            angle = i;
        end
    end
    
    messagebox('El angulo con mayor alcance es :' + string(angle));
endfunction


function ax=ax4(i, k, m, vx, vy)
    ax = (-k/m) * (sqrt(vx(i)^2 + vy(i)^2) * vx(i));
endfunction

function ay=ay4(i, k, m, vx, vy)
    ay = (-k/m) * (sqrt((vx(i)^2) + (vy(i)^2)) * vy(i)) - g;
endfunction

function [vectorX, vectorY]=ballPositionWithFriction(funAx, funAy, vx0, vy0, x0, y0, dt, k, m)
    i = 1
    x(1) = x0;
    y(1) = y0;
    vx(1) = vx0;
    vy(1) = vy0;
    
    while y(i) >= 0
        ax(i)   = funAx(i, k, m, vx, vy);
        ay(i)   = funAy(i, k, m, vx, vy);
        vx(i+1) = vx(i) + ax(i) * dt;
        vy(i+1) = vy(i) + ay(i) * dt;
        x(i+1)  = x(i) + vx(i) * dt;
        y(i+1)  = y(i) + vy(i) * dt;
        
        i= i+1;
    end
    
    vectorX = x;
    vectorY = y;    
endfunction

function ejercicio4()
    m = 0.45 // kg
    r = 0.11 // m
    vo = 30 // m/s
    p = 1.2 // kg/m^3
    theta = toRad(45) // rad
    k = (1/2) * p * %pi * r ^ 2;

    vox = vo * cos(theta);
    voy = vo * sin(theta);
    xo = 0;
    yo = 0;
    dt = 0.001;
    
    [x, y] = ballPositionWithFriction(ax4, ay4, vox, voy, xo, yo, dt, k, m);
    [x2, y2] = ballPosition(ax1, ay1, vox, voy, xo, yo, dt);
    
    // Redraw window
    drawlater();
    plotter = gca();
    plotter.title.font_size = 5;
    plotter.axes_bounds = [1/3,0,2/3,1];
    //plotter.auto_clear = 'on';
    xtitle('Ejercicio 4 (Angulo: 45)') ;
    plot2d(x, y, style=color("red"), frameflag=6);
    plot2d(x2, y2, style=color("blue"), frameflag=6);
	drawnow();
endfunction

function ax=ax7(i, x, y)
    ax= (-G * mt * x(i)) / (sqrt(x(i)^2 + y(i)^2))^3;
endfunction

function ay=ay7(i, x, y)
    ay= (-G * mt * y(i)) / (sqrt(x(i)^2 + y(i)^2))^3;;
endfunction

function [vectorX, vectorY]=ballPositionWithG(funAx, funAy, vx0, vy0, x0, y0, dt)
    i = 1
    x(1) = x0;
    y(1) = y0;
    vx(1) = vx0;
    vy(1) = vy0;
    
    vr = r + 1; // Un valor apenas mas grande solo para comenzar la iteracion
    
    while vr > r
        ax(i)   = funAx(i, x);
        ay(i)   = funAy(i, y);
        vx(i+1) = vx(i) + ax(i) * dt;
        vy(i+1) = vy(i) + ay(i) * dt;
        x(i+1)  = x(i) + vx(i) * dt;
        y(i+1)  = y(i) + vy(i) * dt;
        
        vr = sqrt(x(i)^2 + y(i)^2);
        i= i+1;        
    end
    
    vectorX = x;
    vectorY = y;    
endfunction

function ejercicio7()
    v1Txt = findobj('tag','v1');
    v2Txt = findobj('tag', 'v2');
    v3Txt = findobj('tag','v3');
    v4Txt = findobj('tag', 'v4');
    
    v1x = evstr(v1Txt.string);
    v2x = evstr(v2Txt.string);
    v3x = evstr(v3Txt.string);
    v4x = evstr(v4Txt.string);    
    
    voy = 0;
    xo = 0;
    yo = 500 * 1000 + r;
    dt = 1;
    
    [x, y] = ballPositionWithG(ax7, ay7, v1x, voy, xo, yo, dt);
    [x2, y2] = ballPositionWithG(ax7, ay7, v2x, voy, xo, yo, dt);
    [x3, y3] = ballPositionWithG(ax7, ay7, v3x, voy, xo, yo, dt);
    [x4, y4] = ballPositionWithG(ax7, ay7, v4x, voy, xo, yo, dt);
    
    disp(x);
    disp(y);
    
    // Redraw window
    drawlater();
    plotter = gca();
    plotter.title.font_size = 5;
    plotter.axes_bounds = [1/3,0,2/3,1];
    //plotter.auto_clear = 'on';
    xtitle('Ejercicio 7') ;
    plotEarth();
    plot2d(x, y, style=color("red"), frameflag=5);
    plot2d(x2, y2, style=color("blue"), frameflag=5);
    plot2d(x3, y3, style=color("yellow"), frameflag=5);
    plot2d(x4, y4, style=color("grey"), frameflag=5);
    drawnow();   
endfunction

function ejercicio8()
endfunction
