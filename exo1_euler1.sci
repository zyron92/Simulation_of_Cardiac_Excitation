function[sim_u]=euler1(f,t0,u0,T,dt)
    u=u0
    t=t0
    res=0
    nt=(T/dt)-1 	//nombre d'intervalles de T
    k0=round(t0/dt) 	//k initial
    
    //initialisation du graphe pour u(t)
    sim_t = t0
    sim_u = u0

    for k=k0:1:(nt+1)	//k-ième itération
        res=u+dt*f(t,u)
        u=res
        t=(k+1)*dt

	//Accumulation des données de u(t)
	sim_t = [ sim_t , t ]
	sim_u = [ sim_u , u ]
    end

    //Graphe pour u(t)
    plot2d(sim_t,sim_u,style=5)  //tracé rouge

endfunction

//-- L'Exemple --//
//deff('[x] = f(t,u)','x=-0.1*t*u')
//u0=1
//t0=0
//T=20
//dt=0.001
//y=euler1(f,t0,u0,T,dt)
