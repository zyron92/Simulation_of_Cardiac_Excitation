function[x]=fonct(t,u)
    x=-0.1*t*u
endfunction
//ou comme ceci
//deff('[x] = fonct(t,u)','x=-0.1*t*u')

exec('exo1_euler1.sci',-1)

//-- L'Exemple --//
u0=1
t0=0
T=10
dt=0.01
euler1(fonct,t0,u0,T,dt)

