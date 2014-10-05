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

// Ejercicio 1

function theta=askForTheta()
    theta = evstr(x_dialog('Angulo de lanzamiento? (En grados)','45'));    
endfunction

function theta=askForVo()
    theta = evstr(x_dialog('Velocidad de lanzamiento? (En m/s)','10'));    
endfunction

function ax=ax1(i)
    ax=0;
endfunction

function ay=ay1(i)
    ay=-g;
endfunction

theta = askForTheta();
if theta < 0 | theta > 90
    messagebox('El angulo debe estar entre 0 y 90 grados', 'Error', 'error', ['Aceptar'], 'modal');
    theta = askForTheta();
end

vo = askForVo();
if vo < 0
    messagebox('La velocidad debe ser mayor que 0', 'Error', 'error', ['Aceptar'], 'modal');
    vo = askForVo();
end

vox = vo * cos(theta);
voy = vo * sin(theta);
xo = 0;
yo = 1;
dt = 0.001;

[x, y] = ballPosition(ax1, ay1, vox, voy, xo, yo, dt);
xtitle('Ejercicio 1 (Velocidad inicial: ' + string(vo) + ', Angulo: ' + string(theta) + ')') ;
plot2d(x, y, style=color("red"));
